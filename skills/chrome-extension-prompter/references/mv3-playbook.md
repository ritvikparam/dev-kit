# MV3 Playbook — constraints to inject per extension type

These are the rework-preventing constraints. Each goes into the build prompt as a one-liner (phrasing suggestions included). Only include the sections matching the extension being built. Everything else stays out of the prompt — Claude Code knows how to build extensions; it just needs to be warned about the traps.

## Universal (include in every prompt)

- Manifest V3, minimal permissions — request only what's needed, no broad host permissions unless the feature demands them. (Good privacy story, faster to load unpacked without warnings.)
- End with: "give me a one-paragraph install instruction for loading it unpacked."
- Prompt line for service worker safety when ANY background logic exists: *"Handle Chrome MV3 service worker constraints correctly."*

## Tracking / timer / monitoring extensions

- MV3 service workers are killed after ~30s idle and revived on events. No `setInterval`, no in-memory running timers. Pattern: persist "session started at timestamp X on domain Y" to `chrome.storage.local` on every switch; compute durations from timestamps; use `chrome.alarms` for periodic flushes.
- Track via events: `chrome.tabs.onActivated`, `chrome.tabs.onUpdated`, `chrome.windows.onFocusChanged` (the last one catches leaving Chrome entirely — without it, background time gets counted).
- Idle detection via `chrome.idle` with a ~60s threshold — the difference between numbers you trust and numbers you ignore.
- Aggregate by domain, not full URL, or data becomes noise. Daily buckets: `{"YYYY-MM-DD": {"domain": seconds}}`.
- Permissions: `tabs`, `storage`, `idle`, `alarms`.
- Prompt line: *"Track time per domain using tab/window focus events and chrome.idle; persist timestamps to chrome.storage.local and compute durations from them — no setInterval (service workers get suspended)."*

## Page-overlay extensions (annotators, spotlights, on-page UI)

- Full-viewport transparent `<canvas>`, `position: fixed`, high z-index. The mode toggle is `pointer-events: none` vs `auto` — that one property flips between "drawing on glass" and "using the page."
- Store strokes as an array of paths → free undo (pop last).
- Fixed canvas = annotations don't scroll with content. Fine for live teaching; document-anchored annotations are a v2 (absolutely-positioned canvas at document height).
- Content scripts die on navigation/reload — drawings vanish. Frame as auto-clear, not a bug.
- Smooth strokes: interpolate pointer points so fast drawing isn't jagged.
- Permissions: `activeTab`, `scripting` — often nothing else.
- Doesn't work on: `chrome://` pages, Web Store, built-in PDF viewer.

## Local-file support (whenever the user opens local HTML files)

- Match patterns must include `file:///*` explicitly.
- Chrome disables file access by default; the user flips "Allow access to file URLs" once in `chrome://extensions`. No code can enable it.
- Prompt line: *"Must work on local HTML files (include file:/// in match patterns); if file URL access isn't enabled, detect it and show a friendly popup message explaining the one-time toggle, with a link to chrome://extensions."*

## LLM-powered extensions (refiners, summarizers, rewriters, drafters)

- API key stored in `chrome.storage`; API calls made from the service worker (not content scripts); `host_permissions` for the API endpoint.
- Default to the Anthropic API with a small fast model — a few hundred tokens per call costs effectively nothing.
- Prefer `chrome.sidePanel` over popup for results (popup closes on focus loss; side panel stays open).
- Entry points that work: selection + keyboard shortcut (`chrome.commands`), or right-click via `chrome.contextMenus`.
- The reusable architecture: **LLM + selected text + one keyboard shortcut**. Same skeleton re-skins into translator, summarizer, de-jargonizer, reply drafter — a "modes" dropdown turns one extension into a toolkit. Worth suggesting when the idea is one instance of this pattern.

## New-tab / dashboard extensions

- `chrome_url_overrides.newtab` in the manifest replaces the new tab page.
- Reads from `chrome.storage.local` written by other components — pairs naturally with trackers and libraries.
- This surface IS the heart of the UI when present — direct the design budget here.

## Capture / screenshot features

- `chrome.tabs.captureVisibleTab` for visible-viewport PNG. Requires `activeTab` (as a permission grant from user gesture) or `<all_urls>`.
- Full-page capture requires scroll-and-stitch — call it v2 unless central to the idea.

## Behavioral nudge features (limits, interstitials, focus modes)

- Interstitials/overlays are content-script injections gated on domain + accumulated time from storage.
- Badge text (`chrome.action.setBadgeText`) is the cheapest always-visible nudge — e.g., today's total on the icon.
- Friction is the feature: type-your-reason gates outperform hard blocks for personal use.
