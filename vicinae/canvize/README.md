# Canvize (Vicinae extension)

Type **`canvize`** in Vicinae to list every repository in the
[canvize](https://github.com/canvize) GitHub organization.

## Features

- Lists all org repos (paginated), sorted by most recently pushed
- Fuzzy search by name / language in the list
- Per repo: language, ⭐ stars, ⑂ forks, last-push time, private/archived markers
- Actions: open in browser, copy URL, copy HTTPS/SSH clone command, open Issues / Pull Requests

## Authentication

The `canvize` org's repositories are **private**, so a GitHub token is required
to list them. The extension resolves one automatically, in priority order:

1. The **GitHub Token** preference, if set (Vicinae → extension preferences).
2. Your **GitHub CLI** auth — it runs `gh auth token` — so if you've run
   `gh auth login`, it just works with no configuration.
3. Otherwise it's unauthenticated (public repos only; 60 requests/hour).

A token needs `repo` + `read:org` scopes to see private repositories.

## Develop / build

```bash
cd ~/.dotfiles/vicinae/canvize
npm install
npm run build      # vici build — compiles and installs into Vicinae
# or, for live-reload while editing:
npm run dev        # vici develop
```

Source lives in `~/.dotfiles/vicinae/canvize` (version-controlled); `vici build`
installs a compiled copy into Vicinae's data directory.
