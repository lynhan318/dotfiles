import { Toast, closeMainWindow, getPreferenceValues, showToast } from "@vicinae/api";
import { execFile, spawn } from "node:child_process";
import { homedir } from "node:os";

export type Session = {
	name: string;
	running: boolean;
	default: boolean;
	session_dir: string;
	socket_path: string;
};

type Preferences = {
	herdrPath?: string;
	terminal?: string;
};

export function preferences(): { herdr: string; term: string } {
	const { herdrPath, terminal } = getPreferenceValues<Preferences>();
	return {
		herdr: herdrPath?.trim() || "herdr",
		term: terminal?.trim() || "ghostty",
	};
}

/**
 * Vicinae's server is started from niri's spawn-at-startup, which does not
 * necessarily have ~/.local/bin on PATH — and that is where herdr installs
 * itself. Add it back for both the listing call and the spawned terminal.
 */
export function envWithLocalBin(): NodeJS.ProcessEnv {
	const localBin = `${homedir()}/.local/bin`;
	const path = process.env.PATH ?? "";
	return path.split(":").includes(localBin)
		? process.env
		: { ...process.env, PATH: `${path}:${localBin}` };
}

export function listSessions(herdr: string): Promise<Session[]> {
	return new Promise((resolve, reject) => {
		execFile(
			herdr,
			["session", "list", "--json"],
			{ env: envWithLocalBin(), timeout: 5000 },
			(error, stdout) => {
				if (error) {
					reject(error);
					return;
				}
				try {
					const parsed = JSON.parse(stdout) as { sessions?: Session[] };
					resolve(parsed.sessions ?? []);
				} catch (cause) {
					reject(new Error(`could not parse 'herdr session list --json': ${cause}`));
				}
			},
		);
	});
}

/**
 * The default session is not addressable by name: `herdr --session default`
 * would create a *new* named session under ~/.config/herdr/sessions/default,
 * next to the real default at ~/.config/herdr. Bare `herdr` is the only way to
 * reach it.
 */
export function herdrArgs(session: { name: string; default: boolean }): string[] {
	return session.default ? [] : ["--session", session.name];
}

export function attachCommand(herdr: string, session: { name: string; default: boolean }): string {
	return [herdr, ...herdrArgs(session)].join(" ");
}

/**
 * Open a session in its own terminal window. `herdr --session <name>` both
 * creates and attaches, so this is the same call for a new and an existing
 * session.
 */
export async function openSession(
	session: { name: string; default: boolean },
	options: { directory?: string } = {},
): Promise<void> {
	const { herdr, term } = preferences();
	// Ghostty's flags, not kitty's. Three differences that all fail quietly if
	// you get them wrong:
	//   - values attach with `=`; a space-separated `--class herdr` is not parsed
	//   - the cwd flag is --working-directory, not --directory
	//   - the class goes straight to GTK, which only accepts reverse-DNS
	//     application IDs. A bare "herdr" is dropped with `invalid 'class' in
	//     config, ignoring` and the window silently falls back to the default
	//     app-id, which would break any window rule matching on it.
	const args = [
		// `local.<behaviour>.<name>` is the opt-in convention in niri/config.kdl:
		// a prefix rule maximizes anything under local.maximized.*, so this gets
		// a full-width window without needing a herdr-specific window rule. Same
		// app-id the bar button uses, so both entry points open identically.
		"--class=local.maximized.herdr",
		`--title=herdr: ${session.name}`,
		...(options.directory ? [`--working-directory=${options.directory}`] : []),
		"-e",
		herdr,
		...herdrArgs(session),
	];

	try {
		const child = spawn(term, args, {
			detached: true,
			stdio: "ignore",
			env: envWithLocalBin(),
		});
		child.on("error", (cause) => {
			void showToast({
				style: Toast.Style.Failure,
				title: `Could not start ${term}`,
				message: cause.message,
			});
		});
		child.unref();
		await closeMainWindow();
	} catch (cause) {
		await showToast({
			style: Toast.Style.Failure,
			title: "Could not open session",
			message: cause instanceof Error ? cause.message : String(cause),
		});
	}
}

/**
 * Session names become directory names under ~/.config/herdr/sessions, so keep
 * them to characters that survive a path unambiguously.
 */
export function validateSessionName(name: string, existing: Session[]): string | undefined {
	const trimmed = name.trim();

	if (!trimmed) return "Give the session a name";
	if (trimmed === "default")
		return "Reserved: 'default' would create a second session shadowing the real default";
	if (!/^[A-Za-z0-9][A-Za-z0-9._-]*$/.test(trimmed))
		return "Use letters, digits, dot, dash or underscore; must start alphanumeric";
	if (existing.some((session) => session.name === trimmed)) return "A session with that name already exists";

	return undefined;
}
