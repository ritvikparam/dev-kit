# chrome-extension-prompter — sample run

## Input

> I want a chrome extension that tracks how much time I spend on each site and nudges me when I'm on Twitter too long

## Output

Feasible as-is: browser-only time tracking is squarely extension territory. Time spent outside Chrome won't count, which is what you want here. The nudge is a second feature, so it's scoped as Milestone 2.

```
Build me a Chrome extension (Manifest V3) called "Hourglass" — a quiet, honest record of where my browsing time actually goes, with a gentle nudge when I'm overdoing one site.

MILESTONE 1 — get this fully working first:
CORE FUNCTIONALITY:
- Tracks active time per domain (not full URL), bucketed by day.
- Only counts time when the tab is focused AND Chrome is the focused window AND I'm not idle.
- Toolbar badge shows today's total (e.g. "3h").
- Popup shows today's top sites with time and a 7-day sparkline per site.
- Track time per domain using tab/window focus events and chrome.idle (~60s threshold); persist timestamps to chrome.storage.local and compute durations from them — no setInterval (service workers get suspended). Use chrome.alarms for periodic flushes.
- Handle Chrome MV3 service worker constraints correctly. Minimal permissions: tabs, storage, idle, alarms.

MILESTONE 2 — after Milestone 1 is solid:
- Per-site daily limits set from the popup (default: x.com, 30 min).
- When a limit is hit, a soft interstitial asks me to type why I'm staying before continuing — friction, not a hard block.

DESIGN DIRECTION — this matters as much as the functionality:
This should feel like a premium, purpose-built professional tool — the polish of a Linear, Arc, or Raycast product. Not a hobby project, not a default-styled extension.
- The popup is the heart of the product. Make it beautiful: compact, frosted-glass card, soft layered shadows, site favicons beside each row, times in tabular figures so columns align.
- Rows animate in with a subtle stagger on open; bars fill smoothly instead of popping.
- The interstitial should feel calm, not punitive: centered card, plenty of whitespace, one sentence, one input, no red.
- One accent color used with discipline; cohesive typography; generous spacing.
- Dark-mode aware.

Prioritize craft. Internals can cut invisible corners, but nothing user-facing should feel default or unfinished. When done, give me a one-paragraph install instruction for loading it unpacked.
```

- **Name:** "Hourglass" is a placeholder; swap it freely.
- **Scoping:** the nudge is Milestone 2 so service-worker timing bugs get fixed before anything is layered on top.
