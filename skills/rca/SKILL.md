---
name: rca
description: Write or update a long-lived RCA (Root Cause Analysis) document as a self-contained HTML file. Appends corrections as Update blocks rather than rewriting history. Use when user says "write RCA", "update RCA", "/rca", or wants to document incident root causes.
---

# Write or Update an RCA Document (HTML)

## When to Use This Skill

Use when user wants to:
- Write a new RCA document for an incident
- Add new issues to an existing RCA
- Correct or revise a previous root cause finding
- Mark a fix as temporary/workaround
- Mark a previous finding as a false positive

**Keywords:** RCA, root cause, incident, postmortem, write RCA, update RCA, document issue, false positive, workaround

## Step 1 — Determine the File Path

Check in this order:
1. User-provided path — if specified in their request, use it
2. Conversation context — if an RCA file was already read/written this session, use that path
3. If neither: Create a file at `/tmp/rca-<system-slug>.html`

## Step 2 — Always Read the File First

**Before writing anything, always read the full file** if it exists.

This applies even if you think you know the content from earlier in the conversation — the file may have been edited outside this session. Never overwrite content you haven't read.

## Step 3 — Determine What to Do

After reading the file, ask the user what they want if it isn't clear from context:

- **Add new issues** from the current conversation
- **Correct an existing issue** (false positive, wrong root cause, wrong fix)
- **Mark a fix as temporary** and record what the permanent fix should be
- **Supersede an issue** with a newer, more accurate entry

## Step 4 — Generate HTML

Produce a single self-contained `.html` file. For the base HTML skeleton, CSS variables, and component patterns, see `references/TEMPLATES.md`. Use Category 8 (Reports & Status) as the foundation, adding the RCA-specific classes below.

### RCA-Specific HTML Structure

Map the RCA document structure to these HTML elements:

| RCA Section | HTML Rendering |
|---|---|
| Title + System info | `<header>` with `<h1>` and metadata `<dl>` |
| Issue N | `<article class="issue">` with status badge |
| Status tag | `<span class="badge badge-{status}">` (color-coded) |
| Symptom | `<p class="symptom">` — prominent text |
| Investigation | `<details><summary>Investigation</summary>...</details>` (collapsible) |
| Root Cause | `<div class="root-cause">` — highlighted block |
| Fix | `<pre>` with copy-to-clipboard button |
| Update blocks | `<div class="update">` — indented, with date and revised badge |
| Runbook | `<section class="runbook">` with numbered `<ol>` and `<pre>` for commands |
| Learnings | `<section class="learnings">` grouped by topic |

### RCA-Specific CSS (add to base styles from TEMPLATES.md)

```css
.issue { border: 1px solid var(--border); margin: 1.5rem 0; padding: 1.5rem; border-radius: 4px; }
.issue h2 { margin-top: 0; }
.symptom { font-size: 1.05rem; border-left: 4px solid var(--accent); padding-left: 1rem; margin: 1rem 0; }
.root-cause { background: var(--note-bg); border-left: 4px solid var(--note-border); padding: 1rem 1.25rem; margin: 1rem 0; }
.update { border-left: 3px solid var(--accent); padding: 0.75rem 1rem; margin: 1rem 0; background: #fafafa; }
.runbook ol { margin-left: 1.5rem; }
.runbook li { margin-bottom: 1rem; }
.learnings ul { margin-left: 1.5rem; }
.learnings li { margin-bottom: 0.5rem; }
.badge-muted { background: #e2e3e5; color: #383d41; }
```

### Status Badge Colors

| Status | CSS Class | Color |
|---|---|---|
| Under investigation | `badge-warning` | `#fff3cd` bg, `#856404` text |
| Resolved | `badge-success` | `#d4edda` bg, `#155724` text |
| Workaround | `badge-warning` | `#fff3cd` bg, `#856404` text |
| False positive | `badge-muted` | `#e2e3e5` bg, `#383d41` text |
| Superseded | `badge-muted` | `#e2e3e5` bg, `#383d41` text |

### Interactive Features

- **Collapsible investigation sections** — keep the page scannable, expand for details
- **Copy-to-clipboard** on all code/command blocks (Fix and Runbook sections):
  ```javascript
  document.querySelectorAll('pre').forEach(pre => {
    const btn = document.createElement('button');
    btn.className = 'copy-btn'; btn.textContent = 'Copy';
    btn.onclick = () => { navigator.clipboard.writeText(pre.textContent.replace('Copy','')); btn.textContent = 'Copied!'; setTimeout(() => btn.textContent = 'Copy', 2000); };
    pre.appendChild(btn);
  });
  ```
- **TOC sidebar** — auto-generated from Issue headings (for documents with 3+ issues)
- **Status filter buttons** — show/hide issues by status tag

## How to Handle Each Case

### Adding New Issues

- Append a new `<article class="issue">` after the last existing one (increment the issue number)
- Update Runbook and Learnings sections with anything new and transferable
- Never re-add issues already documented

### Correcting an Existing Issue

Do **not** delete the original content. Append an Update block inside the existing issue article:

```html
<div class="update">
  <strong>Update (YYYY-MM-DD):</strong> <description of what changed>
  <p><strong>Revised Root Cause:</strong> corrected explanation</p>
  <pre><code>Revised fix commands</code></pre>
  <span class="badge badge-success">Resolved</span>
</div>
```

### Marking a Fix as Temporary / Workaround

Append inside the issue article:

```html
<div class="update">
  <strong>Update (YYYY-MM-DD):</strong> Fix above is a <strong>workaround</strong>.
  <p><strong>Known limitation:</strong> why it's not permanent</p>
  <p><strong>Permanent fix (TODO):</strong> what should be done</p>
  <span class="badge badge-warning">Workaround</span>
</div>
```

### Marking a False Positive

Append inside the issue article:

```html
<div class="update">
  <strong>Update (YYYY-MM-DD):</strong> This was a <strong>false positive</strong>.
  <p><strong>Why it appeared to be the cause:</strong> explanation</p>
  <p><strong>Actual cause:</strong> See Issue N.</p>
  <span class="badge badge-muted">False positive</span>
</div>
```

## RCA Document Structure

When creating a new RCA, use this structure (with base styles from `references/TEMPLATES.md`):

```
<header>
  <h1>RCA: [Short title — system + type of issues]</h1>
  <dl>
    <dt>Cluster/System</dt><dd>[name]</dd>
    <dt>Key Identifiers</dt><dd>[IPs, URLs, namespaces, etc.]</dd>
  </dl>
</header>
<main>
  <article class="issue">
    <h2>Issue 1: [Symptom, cause] <span class="badge badge-warning">Under investigation</span></h2>
    <p class="symptom">[Exact error message or observation]</p>
    <details><summary>Investigation</summary><div>[Commands, checks, dead ends]</div></details>
    <div class="root-cause"><h3>Root Cause</h3><p>[Why it broke]</p></div>
    <h3>Fix</h3>
    <pre><code>[Copy-paste commands]</code></pre>
    <p><strong>Result:</strong> [Confirmation]</p>
  </article>

  <section class="runbook"><h2>Runbook</h2><ol>...</ol></section>
  <section class="learnings"><h2>Learnings</h2><ul>...</ul></section>
</main>
```

## Style Rules

- Symptoms before causes — that's the order you experience them
- Every fix must have runnable commands in `<pre>` blocks, not just prose
- Learnings are principles, not incident-specific observations
- Include investigation dead ends — they save time in future incidents
- Dates on all Update blocks so the timeline is clear across sessions
- After generating, tell user the file path and suggest `open /tmp/rca-*.html`

## Related Skills

- **html-render** — Visual standards and HTML generation patterns (shared via `references/TEMPLATES.md`)
