# dev-kit

**Daily-use software engineering skills for AI coding agents.** You install them once, and your agent can then raise PRs, write RCAs, turn notes into HTML pages, and write up conversations for other people. You don't have to re-explain the workflow every time.

Works with **Claude Code**, **Codex**, **Antigravity**, **Gemini CLI**, **Cursor**, **GitHub Copilot**, **OpenCode**, and [~70 other agents](https://github.com/vercel-labs/skills#supported-agents).

[Quick start](#quick-start) · [Skills](#skills) · [Install by agent](#install-by-agent) · [Updating](#updating) · [FAQ](#faq) · [Contributing](#contributing)

---

## What is this?

A **skill** is a folder with a `SKILL.md` file. The file contains instructions an AI agent loads when the task matches the skill. The agent only sees each skill's short description until it needs the skill, so installed skills cost almost no context.

Use this repo to:

- **Skip repetitive prompting.** Say "raise a PR" and the agent branches, commits, pushes, and writes a full PR description in one consistent style.
- **Get consistent output.** RCAs, HTML reports, and write-ups follow the same structure every time.
- **Keep one source for every tool.** The skills use the open [Agent Skills](https://agentskills.io) format, so the same files work in every agent you use. Only the install step differs.

## Quick start

Pick the line for your agent:

```bash
# Claude Code
claude plugin marketplace add ritvikneu/dev-kit   # then: /plugin install devkit@devkit

# Codex
codex plugin marketplace add ritvikneu/dev-kit

# Antigravity
curl -fsSL https://raw.githubusercontent.com/ritvikneu/dev-kit/main/install.sh | sh -s -- --agent antigravity

# Anything else (Cursor, Copilot, OpenCode, Gemini CLI, …)
npx skills add ritvikneu/dev-kit
```

Then ask for what you want ("raise a PR", "write an RCA") or call a skill by name, e.g. `/raise-pr`.

## Skills

| Skill | What it does | Say something like |
| --- | --- | --- |
| [**raise-pr**](skills/raise-pr/SKILL.md) | Branches, commits, pushes, and opens a GitHub PR with a full description | "raise a PR", "cherry-pick this" |
| [**html-render**](skills/html-render/SKILL.md) | Turns any content into a self-contained interactive HTML page | "make this HTML", "visualize this" |
| [**rca**](skills/rca/SKILL.md) | Writes or updates a Root Cause Analysis as an HTML doc | "write RCA", "update RCA" |
| [**blog-me**](skills/blog-me/SKILL.md) | Turns a chat or notes into a LinkedIn article | "blog this", "write this up for LinkedIn" |
| [**chat-report**](skills/chat-report/SKILL.md) | Turns a conversation into a write-up for people who weren't there | "share this conversation", "make a report for my team" |

<details>
<summary><b>raise-pr</b>: ship current changes as a pull request</summary>

<br>

- If you're on `main`/`master`, creates a descriptive branch first
- Stages and commits with a conventional message (`feat(scope): …`)
- Pushes and opens a PR with a summary, motivation, changes, and how to test
- **Cherry-picks:** mirrors the original PR's description and resolves conflicts
- Never force-pushes. If the push is rejected, it stops and asks

Needs `git` and the GitHub CLI (`gh`) to be signed in.

</details>

<details>
<summary><b>html-render</b>: make dense content readable</summary>

<br>

Converts markdown, diffs, code flows, Mermaid diagrams, Jira issues, PRs, Google Docs, screenshots, or chat history into a single HTML file with navigation, collapsible sections, and diagrams. It needs no build step and no external assets.

Inspired by [The unreasonable effectiveness of HTML](https://thariqs.github.io/html-effectiveness/).

</details>

<details>
<summary><b>rca</b>: long-lived root cause analysis</summary>

<br>

Writes an RCA after a debugging session. When findings change later, it adds **Update** blocks instead of rewriting history. You can mark a fix as a workaround or flag an earlier finding as a false positive, and the original reasoning stays visible.

</details>

<details>
<summary><b>blog-me</b> and <b>chat-report</b>: share what you learned</summary>

<br>

Both turn a conversation, meeting notes, or research session into narrative prose that someone who wasn't there can read cold. Each technical term is defined inline, and the piece opens with a strong hook and ends with a clear takeaway.

</details>

## Install by agent

Click your agent to expand its instructions.

<details>
<summary><b>Claude Code</b></summary>

<br>

Install as a plugin:

```bash
claude plugin marketplace add ritvikneu/dev-kit
```

```bash
claude
/plugin install devkit@devkit
```

Try it from a local clone without installing:

```bash
claude --plugin-dir /path/to/dev-kit
```

</details>

<details>
<summary><b>Codex</b> (CLI, IDE extension, app)</summary>

<br>

Install as a Codex plugin:

```bash
codex plugin marketplace add ritvikneu/dev-kit
```

Or copy the skills into `~/.agents/skills`:

```bash
curl -fsSL https://raw.githubusercontent.com/ritvikneu/dev-kit/main/install.sh | sh -s -- --agent codex
```

</details>

<details>
<summary><b>Antigravity</b></summary>

<br>

```bash
curl -fsSL https://raw.githubusercontent.com/ritvikneu/dev-kit/main/install.sh | sh -s -- --agent antigravity
```

This installs to `~/.gemini/antigravity/skills`, which applies to all projects. To install into a single repo's `.agent/skills` instead, add `--project /path/to/repo`.

</details>

<details>
<summary><b>Gemini CLI</b></summary>

<br>

```bash
curl -fsSL https://raw.githubusercontent.com/ritvikneu/dev-kit/main/install.sh | sh -s -- --agent gemini
```

Installs to `~/.gemini/skills`.

</details>

<details>
<summary><b>Cursor, GitHub Copilot, OpenCode, and others</b></summary>

<br>

Use the [`skills`](https://github.com/vercel-labs/skills) CLI. It knows where each agent keeps its skills:

```bash
npx skills add ritvikneu/dev-kit              # choose agents interactively
npx skills add ritvikneu/dev-kit -a cursor    # or name them
npx skills add ritvikneu/dev-kit --skill rca  # or install a single skill
```

</details>

<details>
<summary><b>Manual install</b> (any agent)</summary>

<br>

Copy `skills/<name>/` into your agent's skills folder:

| Agent | This project only | All projects |
| --- | --- | --- |
| Claude Code | `.claude/skills/` | `~/.claude/skills/` |
| Codex | `.agents/skills/` | `~/.agents/skills/` |
| Antigravity | `.agent/skills/` | `~/.gemini/antigravity/skills/` |
| Gemini CLI | `.gemini/skills/` | `~/.gemini/skills/` |

Copy the real files, not symlinks, and leave out the `evals/` and `evaluations/` folders.

</details>

<details>
<summary><b>install.sh options</b></summary>

<br>

Run from a clone, or pipe from `curl` as shown above:

```bash
./install.sh --agent all                    # every supported agent (default)
./install.sh --agent codex --agent claude   # selected agents
./install.sh --project ~/code/app           # one repo instead of your home folder
./install.sh --skill raise-pr --skill rca   # selected skills only
./install.sh --link                         # symlink from this clone (for skill development)
./install.sh --list                         # list available skills
```

Running it again overwrites the installed copy.

</details>

## Updating

| Installed with | Update by |
| --- | --- |
| Claude Code plugin | `/plugin update devkit` |
| Codex plugin | `codex plugin marketplace upgrade devkit` |
| `install.sh` or `npx skills` | Running the same install command again |

## FAQ

<details>
<summary><b>Do I have to type the slash command?</b></summary>

<br>

No. Agents read each skill's description and load the skill when your request matches it. Slash commands such as `/raise-pr` force a particular skill when you want to be explicit.

</details>

<details>
<summary><b>Will installing every skill slow my agent down or fill its context?</b></summary>

<br>

Barely. Until a skill is used, the agent only sees its name and one-paragraph description. The full instructions load only when the skill runs.

</details>

<details>
<summary><b>Can I install just one skill?</b></summary>

<br>

Yes. Use `./install.sh --skill <name>` or `npx skills add ritvikneu/dev-kit --skill <name>`, or copy that single folder by hand.

</details>

<details>
<summary><b>My agent isn't listed. Will it work?</b></summary>

<br>

If your agent supports `SKILL.md` skills, it will. Copy the skill folders into wherever it loads skills from. If it doesn't support skills, you can still paste a `SKILL.md` into its custom instructions or rules file.

</details>

## Contributing

<details>
<summary><b>Adding or changing a skill</b></summary>

<br>

1. Create `skills/<name>/` with `SKILL.md`, `evaluations/`, and optionally `references/`
2. `SKILL.md` needs `name` (matching the folder name) and `description` frontmatter. The description decides when the skill triggers. Wrap long descriptions in `description: >` so strict YAML parsers accept them
3. Keep instructions platform-neutral: describe a capability ("your web-fetch tool") rather than one agent's tool name
4. Add at least one evaluation JSON (see `skills/html-render/evaluations/` for the format)
5. For HTML-rendering skills, copy `references/TEMPLATES.md` from `html-render` as a real file. Symlinks break on Windows and in some installers
6. Run `sh scripts/validate-skills.sh` before opening a PR
7. Branch per skill (`skill/<name>`), PR into `main`

</details>

<details>
<summary><b>Repo layout</b></summary>

<br>

```text
dev-kit/
├── skills/<name>/SKILL.md          # the skills (one folder each)
├── install.sh                      # cross-agent installer
├── scripts/validate-skills.sh      # format checks
├── .claude-plugin/                 # Claude Code plugin + marketplace
├── .codex-plugin/plugin.json       # Codex plugin
└── .agents/plugins/marketplace.json  # Codex marketplace
```

</details>
