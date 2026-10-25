# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-10-24

### Added
- **Multi-platform install** — skills now install on Codex, Antigravity, Gemini CLI, and any agent supported by `npx skills`
- `install.sh` — copies (or symlinks) skills into each agent's user or project skills folder; works from a checkout or piped from curl
- Codex plugin manifest (`.codex-plugin/plugin.json`) and marketplace (`.agents/plugins/marketplace.json`)
- `scripts/validate-skills.sh` — checks frontmatter, strict-YAML safety, symlinks, and shared template sync

### Changed
- Skill instructions no longer reference Claude-only tools or a hardcoded Claude co-author trailer
- `rca/references/TEMPLATES.md` is now a real copy instead of a symlink

### Fixed
- `raise-pr` frontmatter was invalid YAML (unquoted `: ` in description), so strict parsers skipped the skill

## [1.1.0] - 2026-05-31

### Added
- **raise-pr skill** — New skill for raising GitHub PRs with zero friction. Automatically creates descriptive branches, writes meaningful commits, and opens PRs with comprehensive descriptions. Includes cherry-pick support and conflict resolution.

### Changed
- Updated installation instructions to reflect simplified skill naming (slash commands instead of namespaced)
- Added update instructions for users to get new skills

## [1.0.0] - 2026-05-31

### Added
- **html-render skill** — Converts content to self-contained interactive HTML files
- **rca skill** — Writes Root Cause Analysis documents as HTML with update history
- Initial plugin release
