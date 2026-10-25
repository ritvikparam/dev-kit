---
name: html-render
description: Convert files, markdown, mermaid diagrams, code flows, tasks, chat contexts, Google Docs, concepts, or any content into a self-contained interactive HTML file for better readability and understanding. Use when user says "make this HTML", "visualize this", "render as HTML", "make this readable", "convert to HTML", or wants a visual/interactive representation of any content.
---

# HTML Effectiveness

Transform any content into self-contained, interactive HTML files that are easier to understand, scan, and act on than raw text or markdown.

## When to Use This Skill

Activate when:
- User asks to convert content to HTML ("make this an HTML page", "render as HTML")
- User wants visual/interactive representation ("visualize this", "make this readable")
- User has dense markdown, code, logs, or data that would benefit from structure
- User says "present this better", "make this scannable", "interactive version"
- User provides mermaid diagrams, flowcharts, or architecture descriptions
- User wants to share information in a more digestible format

**Keywords:** HTML, visualize, render, convert, readable, interactive, presentation, visual, scannable, effective, diagram, flowchart

## Content Categories

Classify input into one of these 9 categories to determine the HTML structure:

| # | Category | Use When | Key Elements |
|---|----------|----------|--------------|
| 1 | Exploration & Planning | Options, proposals, timelines | Side-by-side cards, timeline, risk matrix |
| 2 | Code Review | Diffs, PRs, code understanding | Annotated diffs, syntax highlight, call graphs |
| 3 | Design Systems | Tokens, components, styles | Swatch grids, component states, contact sheets |
| 4 | Prototyping | Interactions, animations, flows | Sandboxes with sliders, clickable multi-screen |
| 5 | Diagrams & Flowcharts | Architecture, flows, relationships | Inline SVG, mermaid rendering, node graphs |
| 6 | Presentations | Slide decks, talks, overviews | Section-based slides with JS navigation |
| 7 | Research & Learning | Docs, explainers, tutorials | Collapsible sections, tabs, glossary, TOC |
| 8 | Reports & Status | Updates, post-mortems, metrics | Color-coded cards, mini charts, structured layout |
| 9 | Custom Editing Interfaces | Direct manipulation, export to structured data | Drag-and-drop, export buttons, live preview, validation |
| 10 | Chat & Conversation Summary | Meeting notes, discussion distillation | Decision tables, action items, code references |
| 11 | Tasks & Todos | Checklists, Kanban, progress | Interactive checkboxes, progress bars, filters |

## Core Philosophy

**Add value — don't just reshape.** The purpose of an HTML report is to make content easier to *act on*, not merely easier to *read*. Content that is already visible in its original tool (Jira, GitHub, Confluence) should not be dumped verbatim into a pretty layout.

Instead, the report should:
- **Surface what matters** — Highlight issues, risks, gaps, and key findings.
- **Remove noise** — Omit boilerplate, redundant metadata, and fields that add no insight.
- **Connect information** — When multiple sources exist, synthesize them into a unified narrative organized by topic, not by source.
- **Flag contradictions** — When sources disagree, ask the user for clarification rather than silently including conflicting information.

A good report answers: *"What should I pay attention to?"*
A bad report answers: *"What does the source say?"*

## Privacy & Sensitivity

Individual names must **never appear in plain text** in the generated report. Wrap every person's name in a redacted span that hides the text until hovered:

```html
<span class="redacted">Person Name</span>
```

```css
.redacted {
    background: #333; color: #333; padding: 0.1rem 0.3rem;
    border-radius: 2px; cursor: pointer; transition: all 0.2s;
}
.redacted:hover { background: transparent; color: var(--fg); }
```

This ensures the report's findings don't draw attention to any individual — readers choose to reveal names intentionally. Apply the same treatment to other sensitive information (internal IPs, secrets, account IDs) when present.

## Step-by-Step Workflow

### Step 1: Gather All Sources

Determine what to convert:
- **File path** — Read the file
- **Multiple files** — Read all before proceeding
- **Conversation context** — Use chat history
- **URL/Google Doc** — Fetch content via a Google Drive MCP/connector if available, otherwise your web-fetch tool
- **Jira Issue** — Fetch via MCP tools
- **Concept/idea** — Use the user's description directly
- **Mermaid/diagram** — Parse the diagram syntax
- **Github Pull Request** — Parse the PR message, diffs and commits(Fetch via MCP tools)
- **Screenshot** — Parse the screenshot and extract the text. Do NOT guess metadata that isn't visible (channel names, workspace names, usernames). If not visible, omit it from the Sources section — write "Slack thread, YYYY-MM-DD" rather than inventing a channel name.

**When images are shared:** Embed images in the HTML (base64 data URIs) only when they serve a purpose that text cannot — diagrams, flowcharts, architecture visuals, or UI designs. Skip embedding when the image content is a screenshot of text/data that the report already describes better in structured form.

**When multiple sources are provided**, read *all* of them before generating anything. Do not process sources one at a time.

**Updating an existing report:** If the user references an existing `/tmp/*.html` file and provides a new source (e.g., "add this Slack thread to the report", "update the report with this"), treat it as a re-synthesis:
1. Read the existing HTML report to understand what's already covered.
2. Fetch/read the new source.
3. Re-synthesize the full report incorporating both the original context and the new information.
4. Overwrite the same file path — do NOT create a separate file or append a raw section.
5. Sections may be restructured, findings updated, and statuses changed based on the new source.

Treat the existing HTML as one of your sources (the "current understanding") and apply the same consolidation rules below.

### Step 2: Consolidate and Analyze

**Single source:** Extract the key insights, issues, and actionable information. Strip metadata and boilerplate that doesn't add value.

**Multiple sources:** Produce a unified view:
1. **Cross-reference** — Find connections between sources (which issues relate to which PRs, which messages add context not in the ticket, what timeline emerges).
2. **Deduplicate** — If the same information appears in multiple sources, include it once with attribution.
3. **Detect conflicts** — If sources disagree (e.g., one says "resolved" but another shows it's still open, or two people describe different root causes), **STOP and ask the user** what the correct interpretation is. Do not silently pick one version.
4. **Synthesize** — Organize by *finding* or *topic*, not by *source*.
5. Ask the user if there is any conflicting information and resolve the conflicts.

**When structure is ambiguous:** If the report could be organized in multiple valid ways (timeline vs. root-cause-first vs. comparison vs. per-component), **ask the user** how they want it structured before generating. Only skip this if the structure is obvious from context (e.g., a single bug clearly maps to a findings report).

**Structure the output as:**
- Bad: "Section from Jira" / "Section from Slack" / "Section from PR"
- Good: "Key Findings" / "Timeline" / "Open Questions" / "Risk Areas"

### Step 3: Classify Content

Identify which categories apply. Most real reports use **multiple categories** — pick a primary for overall structure, then pull elements from others as needed:

- Use a **primary category** for the page skeleton (e.g., Category 8 for a status report)
- **Compose in elements** from other categories where they add value (e.g., Category 2 diff view for code changes, Category 11 checklist for follow-ups, Category 1 timeline for chronology)
- Reference the category table and TEMPLATES.md for the HTML patterns of each element

### Step 4: Generate HTML

Produce a single self-contained `.html` file following these rules:

**Mandatory Requirements:**
- Single file, zero external dependencies (no CDN links)
- All CSS in `<style>` tags, all JS in `<script>` tags
- Responsive (mobile + desktop via CSS Grid/Flexbox)
- Light theme only (matches  docs — no dark mode toggle)
- Semantic HTML: `<article>`, `<section>`, `<details>`, `<nav>`, `<main>`
- Print-friendly: `@media print` hides nav, adjusts layout

**Interactive Elements (use as appropriate):**
- `<details>`/`<summary>` for collapsible sections
- Tabbed interfaces via JS for multi-view content
- Search/filter inputs for lists and tables
- Smooth scroll navigation with anchor links
- Copy-to-clipboard buttons for code blocks

**Visual Standards ( Docs style):**
- Font: `Noto Sans, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif`
- Code font: `Source Code Pro, Menlo, Monaco, monospace`
- Max content width: `800px`
- Body text: `#333333`, 16px, line-height 1.7
- Headings: H1 light-weight (400), H2 in accent color `#1a7fad`
- Links: `#1a7fad` ( teal)
- Code blocks: `#f5f5f5` bg, left border `3px solid #e0e0e0`, no border-radius
- Note/callout boxes: `#e8f4f8` bg, left border `4px solid #1a7fad`
- Tables: simple borders, header row in `#f5f5f5`
- White background throughout, no dark mode

**For Diagrams:**
- Render mermaid/flowcharts as inline `<svg>`
- Use `viewBox` for responsive scaling
- Add `aria-label` for accessibility

### Step 5: Save Output

```bash
# Save with descriptive filename
# Convention: /tmp/source-name.html or /tmp/category-description.html
```

**Naming conventions:**
- From file: `README.md` → `/tmp/readme.html`
- From concept: `/tmp/auth-flow-diagram.html`
- From tasks: `/tmp/sprint-tasks.html`
- From chat: `/tmp/discussion-summary.html`

### Step 6: Present to User

After generating:
1. Tell user the file path
2. If browser MCP is available, open the file
3. Mention they can open it directly: `open /tmp/filename.html`

## Source-Specific Workflows

### Google Docs

**Prerequisites:** Google Drive MCP configured (see `cai-document-access` skill)

1. Extract file ID from URL: `https://docs.google.com/document/d/<FILE_ID>/edit...` → take the `<FILE_ID>` segment
2. Fetch content:
   ```
   mcp_gdrive_gdrive_read_file(fileId='<FILE_ID>')
   ```
   If user provides a title instead of URL, search first:
   ```
   mcp_gdrive_gdrive_search(query='document title')
   ```
3. Content arrives as markdown — classify (usually Category 7: Research & Learning)
4. Generate HTML with TOC, collapsible sections, and heading hierarchy preserved
5. Save to `/tmp/<doc-title-slug>.html`

**Note:** If Google Drive MCP is not available, fall back to your web-fetch tool on the published/shared URL (only works for publicly shared docs).

#### Handling Images

Google Doc content often includes images as external URLs (e.g., `lh7-us.googleusercontent.com/...`). Since the HTML must be self-contained:

1. **Detect image references** in the fetched markdown (look for `![...](...)`  or `<img src="...">`)
2. **Download each image** and convert to base64 data URI:
   ```bash
   # Fetch image and encode as base64 data URI
   IMG_DATA=$(curl -sL "<image_url>" | base64)
   # Use in HTML as: <img src="data:image/png;base64,${IMG_DATA}" alt="...">
   ```
3. **Embed as data URIs** in the generated HTML:
   ```html
   <img src="data:image/png;base64,iVBORw0KGgo..." alt="Description" style="max-width:100%; height:auto;">
   ```
4. **If image fetch fails** (auth-gated, expired URL):
   - Show a placeholder box with the alt text:
     ```html
     <div class="img-placeholder">
         <span>Image: [alt text or filename]</span>
         <small>Could not embed — original URL requires authentication</small>
     </div>
     ```
   - Log the failed URL so the user knows which images are missing

**Image CSS:**
```css
.img-placeholder {
    background: var(--surface); border: 2px dashed var(--border);
    border-radius: var(--radius); padding: 2rem; text-align: center;
    color: var(--fg); opacity: 0.7; margin: 1rem 0;
}
.img-placeholder small { display: block; margin-top: 0.5rem; font-size: 0.75rem; }
```

**Size limit:** If a single image exceeds 2MB after base64 encoding, save it as a separate file in `/tmp/assets/` and reference it with a relative path instead of inlining.

### Jira / Issue Trackers

When user provides a Jira issue URL or key:

1. **Fetch via MCP:** `jira_get_issue(issue_key='DSE-12345')`
2. **Do NOT dump all fields into the report.** The user can already see fields in Jira. Instead, extract:
   - The core problem or question the issue describes
   - Steps to reproduce (if a bug)
   - Key findings from comments or linked issues
   - Risk factors (is this blocking? is it recurring? are there related failures?)
   - Open questions that need answers
3. **If the issue links to other sources** (PRs, Confluence pages, related tickets), fetch those too and apply the consolidation logic from Step 2.
4. Classify as Category 8 (Reports & Status) and generate HTML emphasizing:
   - A clear problem statement at the top
   - Findings and analysis (not just a repeat of the description)
   - Open questions or blockers highlighted in callout boxes
   - Timeline of significant events (not every status change)
5. Save to `/tmp/<issue-key-lowercase>.html`

**Anti-pattern to avoid:** Rendering metric cards for Status, Priority, Assignee, Reporter — these are visible at a glance in Jira and add no value in the HTML report.

### Chat History / Conversation Context

When the user asks to convert the current conversation to HTML:

1. **Summarize** the conversation internally — extract:
   - Key decisions made
   - Questions asked and answers given
   - Code snippets or files discussed
   - Action items / next steps
   - Problems identified and solutions proposed
2. **If the chat references external sources** (Jira URLs, PR links, Confluence pages), fetch them via MCP and apply the consolidation logic from Step 2 of the main workflow. The HTML should include relevant context from those sources, not just mention them as links.
3. **Structure** the summary into sections:
   - Overview (1-2 sentence topic summary)
   - Decisions & Outcomes (table: decision | rationale | status)
   - Code References (file paths, snippets with context)
   - Action Items (checklist)
4. Classify as Category 10 (Chat & Conversation Summary)
5. Generate HTML using overview cards, decision tables, code references, action items
6. Save to `/tmp/chat-summary-<topic-slug>.html`

**Important:** Produce a condensed, structured summary — not a raw transcript. Focus on what's actionable and referenceable.

### Git Commits & Pull Requests

When user provides a GitHub commit or PR URL:

1. **Parse the URL** to extract components:
   - `https://<host>/<org>/<repo>/pull/<PR>/commits/<SHA>` → host, org, repo, PR number, SHA
   - `https://<host>/<org>/<repo>/commit/<SHA>` → host, org, repo, SHA
2. **Fetch PR metadata and diff** using `gh pr view <URL> --json ...` and `gh pr diff <URL>`.
3. **Summarize, don't reproduce.** The full diff is already visible in GitHub — don't copy it into the report. Instead:
   - Briefly state what changed and why (1-3 sentences per file or logical change group).
   - Only show a diff snippet inline when it's small (< 5 lines) and directly illustrates a finding or risk in the report's narrative.
   - When in doubt about how much detail to include, ask the user.
4. Save to `/tmp/<repo>-pr-<number>.html`

**Anti-pattern:** Rendering full per-file diffs with line numbers, syntax highlighting, and file tree sidebars. This duplicates what GitHub already shows and adds no analytical value.

## HTML Document Skeleton

Every generated file starts with this structure ( docs style):

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[Descriptive Title]</title>
    <style>
        :root {
            --bg: #ffffff; --fg: #333333;
            --accent: #1a7fad; --accent-hover: #155d80;
            --surface: #f5f5f5; --border: #e0e0e0;
            --code-bg: #f5f5f5;
            --note-bg: #e8f4f8; --note-border: #1a7fad;
            --success: #28a745; --warning: #e67e22; --danger: #dc3545;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Noto Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--bg); color: var(--fg);
            line-height: 1.7; padding: 2rem 3rem;
            max-width: 800px; margin: 0 auto; font-size: 16px;
        }
        h1 { font-size: 2rem; font-weight: 400; margin: 1.5rem 0 1rem; }
        h2 { font-size: 1.5rem; font-weight: 400; color: var(--accent); margin: 2rem 0 0.75rem; }
        h3 { font-size: 1.125rem; font-weight: 600; margin: 1.5rem 0 0.5rem; }
        a { color: var(--accent); text-decoration: none; }
        a:hover { color: var(--accent-hover); text-decoration: underline; }
        p { margin-bottom: 1rem; }
        ul, ol { margin: 0.5rem 0 1rem 1.5rem; }
        li { margin-bottom: 0.4rem; }
        pre { background: var(--code-bg); padding: 1rem 1.25rem; border-left: 3px solid var(--border); overflow-x: auto; margin: 1rem 0; font-family: 'Source Code Pro', Menlo, Monaco, monospace; font-size: 0.875rem; line-height: 1.5; }
        code { font-family: 'Source Code Pro', Menlo, Monaco, monospace; font-size: 0.875em; background: var(--code-bg); padding: 0.1rem 0.3rem; }
        pre code { background: none; padding: 0; }
        table { width: 100%; border-collapse: collapse; margin: 1rem 0; }
        th, td { padding: 0.6rem 0.75rem; border: 1px solid var(--border); text-align: left; }
        th { background: var(--surface); font-weight: 600; }
        .note { background: var(--note-bg); border-left: 4px solid var(--note-border); padding: 1rem 1.25rem; margin: 1.5rem 0; }
        .note strong { display: block; margin-bottom: 0.5rem; }
        details { margin: 1rem 0; border: 1px solid var(--border); }
        summary { padding: 0.75rem 1rem; cursor: pointer; font-weight: 600; background: var(--surface); }
        details[open] summary { border-bottom: 1px solid var(--border); }
        .badge { display: inline-block; padding: 0.15rem 0.5rem; font-size: 0.75rem; font-weight: 600; border-radius: 3px; }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger { background: #f8d7da; color: #721c24; }
        .redacted { background: #333; color: #333; padding: 0.1rem 0.3rem; border-radius: 2px; cursor: pointer; transition: all 0.2s; }
        .redacted:hover { background: transparent; color: var(--fg); }
        @media print { body { max-width: 100%; padding: 1rem; } nav { display: none; } .redacted { background: transparent; color: var(--fg); } }
        /* Category-specific styles below */
    </style>
</head>
<body>
    <main>
        <!-- Generated content here -->
    </main>
    <script>
        // Interactive features here
    </script>
</body>
</html>
```

## Category-Specific Guidance

### 1. Exploration & Planning
- Use CSS Grid for side-by-side option cards
- Add pros/cons with colored indicators (green/red)
- Timeline: vertical `<ol>` with connecting line via `::before`
- Risk matrix: 2D grid with color-coded cells

### 2. Code Review & Understanding
- Syntax highlighting via `<span>` classes (no external lib)
- Diff view: red/green backgrounds for removed/added lines
- Line numbers in `<td>` alongside code
- Collapsible file sections for multi-file diffs

### 3. Design Systems
- CSS Grid for swatch/token display
- Live-preview boxes showing the rendered value
- Component states shown as contact sheet (grid of variants)

### 4. Prototyping
- `<input type="range">` for parameter tuning
- CSS transitions/animations with adjustable `--duration`
- Multi-screen: show/hide sections via JS tab switching

### 5. Diagrams & Flowcharts
- Generate inline SVG with proper `viewBox`
- Use `<path>` for connections, `<rect>`/`<circle>` for nodes
- Add `<text>` labels and tooltips
- For mermaid: convert to SVG structure manually

### 6. Presentations
- Each `<section>` is a slide
- JS navigation: arrow keys, click, swipe
- Progress indicator bar at top
- Slide counter in corner

### 7. Research & Learning
- Sticky table of contents in sidebar (desktop) or top (mobile)
- `<details>` for expandable deep-dives
- Tabbed code examples (JS tab switching)
- `<dfn>` + tooltip for glossary terms

### 8. Reports & Status
- Summary cards at top with key metrics
- Color-coded status badges (green/yellow/red)
- `<table>` with sortable headers (JS click handler)
- Expandable detail rows

### 9. Custom Editing Interfaces
- Drag-and-drop reordering via HTML5 drag API (no external libs)
- Export buttons: output JSON/YAML from UI state for agent consumption
- Live preview: template variables with instant rendering
- Dependency validation: visual warnings when constraints are violated
- Always provide an export mechanism — the HTML is a two-way interface

### 10. Chat & Conversation Summary
- Overview card with topic, message count, duration
- Decision table: decision | rationale | status badge
- Collapsible code references with file paths
- Action items checklist (done/pending)
- Organize by outcome, not chronologically

### 11. Tasks & Todos
- `<input type="checkbox">` with label (purely visual, no persistence)
- Progress bar: `<progress>` element or CSS width
- Filter buttons: All / Done / Pending
- Optional grouping by category/priority

## Examples

### Convert Markdown File to HTML

**User:** "Convert AGENTS.md to HTML"

**Agent workflow:**
1. Read `AGENTS.md`
2. Classify: Category 7 (Research & Learning)
3. Generate HTML with TOC, collapsible sections, code highlighting
4. Save to `/tmp/agents.html`
5. Report path to user

### Visualize a Code Flow

**User:** "Visualize the auth middleware flow as HTML"

**Agent workflow:**
1. Read relevant auth middleware files
2. Classify: Category 5 (Diagrams & Flowcharts)
3. Generate HTML with inline SVG flowchart showing request → middleware → response
4. Save to `/tmp/auth-middleware-flow.html`

### Convert Tasks to Interactive Checklist

**User:** "Make my todos into an HTML page"

**Agent workflow:**
1. Gather tasks from conversation or file
2. Classify: Category 11 (Tasks & Todos)
3. Generate HTML with checkboxes, progress bar, filters
4. Save to `/tmp/tasks.html`

### Consolidate Multiple Sources

**User:** "Here's the Slack thread, the Jira ticket DSE-56789, and the PR — make an HTML report"

**Agent workflow:**
1. Fetch all three sources (read Slack export, fetch Jira via MCP, fetch PR via gh)
2. Cross-reference: PR addresses the bug in the Jira ticket; Slack thread has additional reproduction context from the reporter
3. Detect conflict: Jira says "P2 Important" but Slack says "P1 blocking release" → ask user which priority is correct
4. Synthesize into unified sections:
   - Problem Statement (from Jira description + Slack context)
   - Root Cause (from PR description and commit messages)
   - Timeline (assembled from all three sources)
   - Open Questions (gaps not addressed by any source)
5. Classify: Category 8 (Reports & Status)
6. Generate HTML organized by finding, not by source
7. Save to `/tmp/dse-56789-analysis.html`

## Notes

- Always prefer semantic HTML over `<div>` soup
- Test that the file opens correctly in a browser before reporting done
- If content is very large (>1000 lines of source), consider pagination or search
- For templates and CSS patterns, see `references/TEMPLATES.md`
