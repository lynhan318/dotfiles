import {
  Action,
  ActionPanel,
  getPreferenceValues,
  Icon,
  List,
  showToast,
  Toast,
} from "@vicinae/api";
import { execSync } from "node:child_process";
import { useEffect, useState } from "react";

const ORG = "canvize";

/**
 * Resolve a GitHub token. Priority:
 *   1. the extension's "GitHub Token" preference, if set
 *   2. the local GitHub CLI auth (`gh auth token`), so it works out of the box
 *   3. none — unauthenticated (public repos only)
 */
function resolveToken(pref?: string): string | undefined {
  const p = pref?.trim();
  if (p) return p;
  try {
    const t = execSync("gh auth token", {
      encoding: "utf8",
      stdio: ["ignore", "pipe", "ignore"],
    }).trim();
    return t || undefined;
  } catch {
    return undefined;
  }
}

interface Preferences {
  githubToken?: string;
}

type Repo = {
  id: number;
  name: string;
  full_name: string;
  html_url: string;
  description: string | null;
  language: string | null;
  stargazers_count: number;
  forks_count: number;
  open_issues_count: number;
  private: boolean;
  archived: boolean;
  fork: boolean;
  pushed_at: string;
  clone_url: string;
  ssh_url: string;
};

/**
 * Fetch every repository in the org, following pagination (100 per page).
 * A token is optional: without it only public repos are visible and the
 * unauthenticated rate limit (60/h) applies; with it, private repos show up.
 */
async function fetchAllRepos(token?: string, signal?: AbortSignal): Promise<Repo[]> {
  const headers: Record<string, string> = {
    Accept: "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28",
    "User-Agent": "vicinae-canvize",
  };
  if (token) headers.Authorization = `Bearer ${token}`;

  const all: Repo[] = [];
  // Cap at 10 pages (1000 repos) as a safety bound.
  for (let page = 1; page <= 10; page++) {
    const url = `https://api.github.com/orgs/${ORG}/repos?per_page=100&page=${page}&sort=pushed&direction=desc`;
    const res = await fetch(url, { headers, signal });

    if (!res.ok) {
      let detail = "";
      try {
        const body = (await res.json()) as { message?: string };
        detail = body.message ? ` — ${body.message}` : "";
      } catch {
        /* ignore body parse errors */
      }
      if (res.status === 403 && res.headers.get("x-ratelimit-remaining") === "0") {
        throw new Error("GitHub rate limit hit. Add a token in preferences to raise it.");
      }
      throw new Error(`GitHub API ${res.status} ${res.statusText}${detail}`);
    }

    const batch = (await res.json()) as Repo[];
    all.push(...batch);
    if (batch.length < 100) break;
  }
  return all;
}

function relativeTime(iso: string): string {
  const then = new Date(iso).getTime();
  const diff = Date.now() - then;
  const day = 86_400_000;
  if (diff < day) return "today";
  const days = Math.floor(diff / day);
  if (days < 30) return `${days}d ago`;
  const months = Math.floor(days / 30);
  if (months < 12) return `${months}mo ago`;
  return `${Math.floor(months / 12)}y ago`;
}

export default function Command() {
  const { githubToken } = getPreferenceValues<Preferences>();
  const [repos, setRepos] = useState<Repo[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const controller = new AbortController();
    (async () => {
      try {
        setIsLoading(true);
        setError(null);
        const data = await fetchAllRepos(resolveToken(githubToken), controller.signal);
        if (controller.signal.aborted) return;
        data.sort(
          (a, b) => new Date(b.pushed_at).getTime() - new Date(a.pushed_at).getTime(),
        );
        setRepos(data);
      } catch (e) {
        // The view was dismissed while a request was in flight — ignore.
        if (controller.signal.aborted || (e instanceof Error && e.name === "AbortError")) {
          return;
        }
        const message = e instanceof Error ? e.message : String(e);
        setError(message);
        await showToast({
          style: Toast.Style.Failure,
          title: "Failed to load canvize repositories",
          message,
        });
      } finally {
        if (!controller.signal.aborted) setIsLoading(false);
      }
    })();
    return () => {
      controller.abort();
    };
  }, [githubToken]);

  return (
    <List
      isLoading={isLoading}
      searchBarPlaceholder="Search canvize repositories…"
      navigationTitle="Canvize Repositories"
    >
      {error && !isLoading ? (
        <List.EmptyView
          icon={Icon.Warning}
          title="Couldn't load repositories"
          description={error}
        />
      ) : !isLoading && repos.length === 0 ? (
        <List.EmptyView
          icon={Icon.Box}
          title="No repositories found"
          description={`No visible repos in ${ORG}. Its repos are private — run 'gh auth login' or set a GitHub Token in this extension's preferences.`}
        />
      ) : (
        repos.map((repo) => (
          <List.Item
            key={repo.id}
            icon={repo.private ? Icon.Lock : repo.fork ? Icon.Anchor : Icon.Code}
            title={repo.name}
            subtitle={repo.description ?? undefined}
            keywords={[repo.name, repo.full_name, repo.language ?? ""]}
            accessories={[
              ...(repo.archived ? [{ tag: "archived" }] : []),
              ...(repo.language ? [{ text: repo.language }] : []),
              { text: `★ ${repo.stargazers_count}` },
              { text: `⑂ ${repo.forks_count}` },
              { text: relativeTime(repo.pushed_at), tooltip: `Last push: ${repo.pushed_at}` },
            ]}
            actions={
              <ActionPanel>
                <Action.OpenInBrowser title="Open Repository" url={repo.html_url} />
                <Action.CopyToClipboard
                  title="Copy URL"
                  content={repo.html_url}
                  shortcut={{ modifiers: ["ctrl"], key: "c" }}
                />
                <Action.CopyToClipboard
                  title="Copy Clone Command (HTTPS)"
                  content={`git clone ${repo.clone_url}`}
                  shortcut={{ modifiers: ["ctrl", "shift"], key: "c" }}
                />
                <Action.CopyToClipboard
                  title="Copy Clone Command (SSH)"
                  content={`git clone ${repo.ssh_url}`}
                />
                <ActionPanel.Section title="Browse on GitHub">
                  <Action.OpenInBrowser
                    title="Open Issues"
                    url={`${repo.html_url}/issues`}
                    shortcut={{ modifiers: ["ctrl"], key: "i" }}
                  />
                  <Action.OpenInBrowser
                    title="Open Pull Requests"
                    url={`${repo.html_url}/pulls`}
                    shortcut={{ modifiers: ["ctrl"], key: "p" }}
                  />
                </ActionPanel.Section>
              </ActionPanel>
            }
          />
        ))
      )}
    </List>
  );
}
