---
name: chrome-extension-prompter
description: Turns rough Chrome extension ideas into polished, copy-paste-ready Claude Code build prompts — with the right Manifest V3 constraints baked in and a strong design-direction section so the result looks premium, not like a hobby project. Use this skill WHENEVER the user mentions building, prototyping, or ideating a Chrome extension or browser extension — including phrases like 'chrome extension for...', 'browser extension that...', 'extension idea', 'write a prompt for an extension', 'improve this extension prompt', or when they describe a browser-based tool/workflow and wants to build it with Claude Code. Also use when they ask to review, refine, or debug an extension build prompt, or asks what's feasible for an extension. Do NOT use for desktop apps, web apps, mobile apps, or VS Code extensions.
---

# Chrome Extension Prompter

Convert a vague extension idea into a build prompt that Claude Code can one-shot into something functional AND premium-looking. The core insight from past builds: output quality tracks the prompt's ratio of design intent to implementation detail. Spend most words on what the product should feel like; spend technical words ONLY on the handful of MV3 constraints that cause painful rework if discovered mid-build.

## Workflow

1. **Understand the idea.** If it's vague, ask at most 1-2 sharp questions (what's the core action? who triggers it — a click, a shortcut, automatic?). If the idea is clear enough, just proceed — don't interrogate.
2. **Check feasibility first.** Before writing anything, verify the idea is actually extension-territory (see "Feasibility checks" below). If it isn't, say so plainly and suggest the closest thing that IS feasible. A great prompt for an impossible extension wastes an afternoon.
3. **Classify the extension type(s)** and pull the matching constraints from `references/mv3-playbook.md`. Read that file whenever you're about to write a prompt — it contains the hard-won gotchas per extension type.
4. **Write the prompt** using the template below.
5. **Hand it over** in a code block with 1-2 short notes on choices you made (name, scoping) — never a long explanation.

## The prompt template

Structure every build prompt like this:

```
Build me a Chrome extension (Manifest V3) called "<Name>" — <one-line product identity: what it is and who it's for, in first person>.

CORE FUNCTIONALITY:
- <5-8 bullets: user-facing behaviors, keyboard shortcuts, the main flow>
- <ONLY the technical constraints that prevent rework — from the playbook>

DESIGN DIRECTION — this matters as much as the functionality:
This should feel like a premium, purpose-built professional tool — the polish of a Linear, Arc, or Raycast product. Not a hobby project, not a default-styled extension.
- <identify the "heart" UI surface (toolbar/popup/side panel/new-tab page) and describe how it should feel: frosted glass, soft shadows, refined line icons, micro-interactions>
- <2-4 product-specific craft details: what should feel tactile, what should animate, cursor behavior, etc.>
- One accent color used with discipline; cohesive typography; generous spacing.
- Dark-mode aware.

Prioritize craft. Internals can cut invisible corners, but nothing user-facing should feel default or unfinished. When done, give me a one-paragraph install instruction for loading it unpacked.
```

Rules that make this template work:

- **Always name the product.** A named product gives Claude Code an identity to design around and measurably improves output. Invent a short, evocative name (one word beats three); tell the user they can swap it.
- **Identify the "heart" of the UI** and lavish design words on it specifically. Every extension has one surface the user lives in — a floating toolbar, a side panel, a popup, a new-tab page. Generic "make it pretty" produces generic results; "the floating toolbar is the heart of the product, make it beautiful: pill-shaped, backdrop-blur..." produces premium ones.
- **Design references stay consistent:** Linear, Arc, Raycast, Vercel. These four anchor a premium, modern-tool aesthetic; if the user names other references, use theirs.
- **No nitty-gritty implementation details** — no file structures, no function names, no CSS specifics beyond feel-words. Exception: the rework-preventing constraints from the playbook (MV3 service worker rules, file:// access, etc.). Those go in as one-liners inside CORE FUNCTIONALITY.
- **Scope to milestones when the idea is multi-feature.** If the idea bundles 2+ distinct features (e.g., a tracker + an AI tool), either prompt for feature one and note that feature two is milestone two, or explicitly structure the prompt as "Milestone 1: ... get this fully working first. Milestone 2: ...". Mixing service-worker debugging with API-call debugging in one pass is where builds get messy.

## Feasibility checks (do these BEFORE writing)

Flag these honestly — they're the difference between a fun afternoon and a frustrated one:

- **Extensions only see Chrome.** Anything needing visibility into other apps (native app time tracking, OS-wide annotation, reading files outside the browser) is desktop-app territory. Say so and offer the browser-only version.
- **Content scripts can't run on** `chrome://` pages, the Chrome Web Store, or Chrome's built-in PDF viewer. If the idea centers on annotating/modifying PDFs or browser UI, warn upfront.
- **Local HTML files work** but need the one-time "Allow access to file URLs" toggle — always bake the graceful-failure handling into the prompt (see playbook).
- **No persistent background processes.** Anything phrased as "constantly monitor X in real time" needs reframing as event-driven + alarms.
- **LLM features need an API key and host permissions** — cheap and easy, but it means the extension isn't zero-setup. Default to Anthropic API with a small/fast model.

## When the user brings an existing prompt to improve

Diagnose against the template: Does it have a product name? Is the design section at least as long as the functionality section? Does it name the heart surface? Does it include the playbook constraints for its type — and nothing more technical than that? Is it scoped to one milestone? Rewrite it, then tell them in 2-3 bullets what you changed and why.

## Voice and delivery

Assume the user is technical enough to follow architecture talk but is not a Chrome APIs expert — explain a constraint in one plain sentence when it affects their decision, skip it otherwise. Keep the surrounding chat tight: the prompt is the deliverable, not an essay about the prompt. Where natural, note when an idea doubles as content ("build X with Claude Code in 30 minutes" workshop/video material) — but only when it genuinely does.
