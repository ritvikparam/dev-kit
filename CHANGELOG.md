# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-10-23

### Added
- MIT LICENSE, `examples/` with sample input/output per skill, and README screenshots in `assets/`
- **chrome-extension-prompter skill** — Converts Chrome extension ideas into polished build prompts, with feasibility checks and an MV3 playbook of per-type constraints (trackers, overlays, LLM tools, new-tab, capture, nudges).

### Changed
- README rewritten for public release: proof, per-skill install, skill-authoring recipe
- Removed internal tool references and private URLs from skills, templates, and evaluations
- chrome-extension-prompter and raise-pr generalized for any user (no hardcoded names or model versions)
- html-render git-commit eval now matches the skill's "summarize, don't reproduce the diff" rule
- Synced marketplace.json version with plugin.json; added author and license to plugin.json

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
