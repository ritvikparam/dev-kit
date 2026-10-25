---
name: chat-report
description: >
  Convert a chat conversation, meeting notes, or any provided context into a
  polished LinkedIn article — written so that anyone who wasn't part of the
  conversation can read it cold and fully understand it. Output is plain text
  formatted for LinkedIn: strong hook, narrative prose, clear sections with
  headings, inline definitions for every technical term, and a closing
  takeaway. Use this skill whenever the user wants to "share this conversation",
  "make a report for my team", "write this up as a LinkedIn post or article",
  "turn this into something I can publish", "summarize this for someone who
  wasn't there", or wants a chat thread or research session turned into a
  readable piece for a broader audience.
---

# Chat → LinkedIn Article

Your job: take a conversation (or any context the user provides) and produce
a polished article that reads like something a thoughtful person would publish
on LinkedIn. The reader did not ask the original questions, may not share the
domain background, and should come away fully informed without needing to ask
follow-up questions.

## What this is not

- Not a summary. A summary re-states. This article *explains*.
- Not a transcript or Q&A. The original question-answer structure disappears
  entirely — the output is organized by concept and insight, not by who asked what.
- Not an HTML file. The output is plain text, formatted for LinkedIn.

## Step 1: Read and understand the source

Before writing anything, identify:

- **The core topic** — what is this really about?
- **The key insight or conclusion** — if someone reads one sentence, what should
  they take away?
- **Technical terms that need explaining** — anything a non-specialist might not
  know should get a one-sentence plain-English definition, either inline or at
  first use.
- **The best analogy** — is there a concrete, everyday comparison that unlocks
  the hardest concept? Find it. Use it.

## Step 2: Plan the structure

Choose the right shape for the content:

- **Explainer** (how does X work?) — walk through concepts in logical order,
  building understanding progressively. Best for technical topics.
- **Breakdown** (what are the different types of X?) — compare and contrast
  multiple models or approaches. Best when there are 2–4 distinct variants.
- **Narrative** (what happened and why does it matter?) — tell a story with a
  beginning, middle, and "so what". Best for decisions, events, or analyses.

Most conversations will be "Explainer" or "Breakdown". Pick whichever fits and
don't mix structures unnecessarily.

## Step 3: Write the article

### Format

Plain text only. Use these conventions:

- Article title on the first line (no # prefix — just the text)
- One blank line after the title
- Section headers: a short line in ALL CAPS or followed by a colon — keep them
  punchy and specific (not "Section 1" or "Background")
- Paragraphs separated by a blank line
- Bold key terms on first use: **like this**
- No bullet points except for the TL;DR. Keep everything else in prose.
- No HTML tags, no markdown headers (##), no emoji unless the topic calls for it

### Structure

**Opening hook (2–4 sentences)**
Start with a concrete, relatable observation or question — not a definition. The
reader should feel oriented and curious by the end of the first paragraph.

Example of a weak hook: "OTT platforms have several content sharing models."
Example of a strong hook: "When you search for a show on Apple TV and it sends
you straight to Prime Video — Apple didn't call Prime. It already had the answer.
Here's why."

**TL;DR (3–4 bullets)**
Right after the hook. Bullet points are allowed here. Each bullet = one concrete
insight, not a restatement of a section header. Someone who only reads the TL;DR
should understand the key point.

**Body sections (2–4 sections)**
Each section has:
1. A specific, interesting header (not generic)
2. Opening sentence that states the main point of the section
3. 2–4 paragraphs of explanation
4. An analogy or concrete example where helpful

Every technical term gets a brief definition at first use. Don't assume the
reader knows what CDN, DRM, API, or any acronym means.

**Closing takeaway (1 paragraph)**
The "so what" — one concrete synthesis of everything above. What does the reader
now understand that they didn't before? Why does it matter?

### Tone

Write like a smart friend who knows the material deeply and explains it clearly
without condescending. The prose should be confident, clear, and occasionally
surprising — give the reader something they didn't expect.

Avoid:
- "In conclusion..." / "In summary..." / "As we can see..."
- Passive voice where active works
- Jargon left unexplained
- Paragraphs longer than 4–5 sentences

## Step 4: Quality check

Re-read the draft and ask:

1. **Hook test**: Does the first paragraph make you want to keep reading?
2. **Cold reader test**: Could someone with no context read this and understand
   every sentence? If any term is undefined or any concept assumed, fix it.
3. **Narrative test**: Does it flow as a piece of writing, or does it feel like a
   list of facts dressed up as prose? If the latter, find the connecting thread.
4. **Header test**: Could you replace every section header with "Part 1", "Part 2"
   and lose nothing? If yes, the headers aren't specific enough — rewrite them.

## Step 5: Save and present

Save as a `.md` file with a descriptive name based on the topic.

Examples:
- `ott-platform-models-linkedin.md`
- `how-streaming-content-sharing-works.md`

After saving, present the file to the user.

---

## Reference: what good looks like

Here's the kind of opening you're aiming for:

> You open Apple TV, search for a show, and it tells you it's available on Prime
> Video. You tap it and land directly on the show's page in Prime — without ever
> typing anything in Prime's search bar.
>
> Apple didn't call Prime. It already knew.
>
> Here's how that works — and why the same-looking experience on Hulu is actually
> built on three completely different foundations.

That's three short paragraphs. It's specific, it raises a question, and it
promises to answer it. That's the target.
