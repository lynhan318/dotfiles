// Standalone stdio Debug Adapter for Bun, for use with nvim-dap (or any DAP client
// that launches an `executable` adapter and talks DAP over stdin/stdout).
//
// Why this exists: nvim-dap speaks DAP over stdio/TCP, but Bun's debugger speaks the
// WebKit Inspector Protocol over a WebSocket. Bun's official translation layer
// (`bun-debug-adapter-protocol`) is not published to npm and only ships *inlined*
// inside the VS Code extension, where it runs in-process. Here we vendor that package
// (see ./packages) and drive its `WebSocketDebugAdapter` over stdio ourselves, reusing
// `@vscode/debugadapter`'s battle-tested Content-Length framing.
//
// Run with: bun /path/to/adapter.ts
//
// IMPORTANT: stdout must carry ONLY framed DAP messages. Anything the vendored code or
// the debuggee prints to stdout would corrupt the protocol, so we redirect stray
// console.log -> stderr. (The debuggee's own output is captured by the adapter and
// forwarded back as DAP `output` events, so it never reaches this stdout.)
console.log = (...args: unknown[]) => console.error(...args);
console.info = (...args: unknown[]) => console.error(...args);
console.debug = (...args: unknown[]) => console.error(...args);

import { DebugSession } from "@vscode/debugadapter";
import { WebSocketDebugAdapter } from "./packages/bun-debug-adapter-protocol/index.ts";

class BunDebugSession extends DebugSession {
  private adapter: WebSocketDebugAdapter;

  constructor() {
    super();
    // No url -> the adapter picks its own (unix socket on posix, tcp on win) and, on a
    // `launch` request, spawns `bun --inspect=<that url> <program>` and connects to it.
    this.adapter = new WebSocketDebugAdapter();

    // Outgoing DAP: the adapter emits fully-formed DAP responses/events; forward them
    // to the client with proper framing.
    this.adapter.on("Adapter.response", (response: any) => this.sendResponse(response));
    this.adapter.on("Adapter.event", (event: any) => this.sendEvent(event));

    // The adapter may ask the client to do something (e.g. runInTerminal). nvim-dap
    // handles these reverse requests; we just relay and ignore the reply.
    this.adapter.on("Adapter.reverseRequest", ({ command, arguments: args }: any) =>
      this.sendRequest(command, args, 5000, () => {}));

    this.adapter.on("Adapter.error", (error: any) =>
      console.error("[bun-dap] adapter error:", error?.stack ?? error));

    // Optional wire tracing to stderr for debugging the adapter itself (never stdout).
    if (process.env.BUN_DAP_TRACE) {
      const insp: any = (this.adapter as any).getInspector?.();
      if (insp?.on) {
        insp.on("Inspector.request", (r: any) => console.error("[insp>]", JSON.stringify(r).slice(0, 400)));
        insp.on("Inspector.response", (r: any) => console.error("[insp<]", JSON.stringify(r).slice(0, 400)));
        insp.on("Inspector.event", (r: any) => console.error("[insp*]", JSON.stringify(r).slice(0, 400)));
      }
    }
  }

  // ProtocolServer hands every parsed inbound message here. The vendored adapter is a
  // complete DAP request handler, so instead of the usual per-command dispatch we hand
  // requests straight to it via the "Adapter.request" event.
  protected handleMessage(message: any): void {
    if (message?.type === "request") {
      if (message.command === "initialize" && message.arguments) {
        // Bun's adapter runs `configurationDone()` *during* `initialize` — which releases the
        // `--inspect wait` and starts the program — unless the client is VS Code or sets this
        // flag. nvim-dap is neither, so without this the program would run before breakpoints
        // are set and first-run breakpoints would be missed. Forcing it makes the adapter wait
        // for the explicit `configurationDone` that nvim-dap sends after registering breakpoints
        // (it sends it because Bun advertises `supportsConfigurationDoneRequest`).
        message.arguments.supportsConfigurationDoneRequest = true;
      }
      this.adapter.emit("Adapter.request", message);
    }
    // Inbound responses (replies to our reverse requests) are not needed by the adapter.
  }

  dispose() {
    try {
      this.adapter.close();
    } catch {}
  }
}

const session = new BunDebugSession();

const shutdown = () => {
  try {
    session.dispose();
  } catch {}
  process.exit(0);
};
process.on("SIGTERM", shutdown);
process.on("SIGINT", shutdown);

session.start(process.stdin, process.stdout);
