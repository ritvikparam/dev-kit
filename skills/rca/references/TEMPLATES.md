# HTML Render — Template Patterns

Reference templates for each content category. Use these as starting points, adapting structure and styles to the actual content. All styles follow the  documentation design language.

## Base CSS Variables

All templates share this color system ( docs style — light theme only):

```css
:root {
    --bg: #ffffff; --fg: #333333;
    --accent: #1a7fad; --accent-hover: #155d80;
    --surface: #f5f5f5; --border: #e0e0e0;
    --code-bg: #f5f5f5;
    --note-bg: #e8f4f8; --note-border: #1a7fad;
    --success: #28a745; --warning: #e67e22; --danger: #dc3545;
}
```

## Category 1: Exploration & Planning

### Side-by-Side Option Cards

```html
<section class="options-grid">
    <article class="option-card">
        <h3>Option A</h3>
        <p class="description">Description here</p>
        <div class="pros"><h4>Pros</h4><ul><li>Fast</li></ul></div>
        <div class="cons"><h4>Cons</h4><ul><li>Complex</li></ul></div>
    </article>
    <!-- More cards -->
</section>
```

```css
.options-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; }
.option-card { background: var(--bg); border: 1px solid var(--border); padding: 1.5rem; }
.pros h4 { color: var(--success); } .cons h4 { color: var(--danger); }
```

### Timeline

```html
<ol class="timeline">
    <li class="timeline-item" data-status="done">
        <time>2024-01-15</time>
        <h4>Milestone 1</h4>
        <p>Description</p>
    </li>
</ol>
```

```css
.timeline { list-style: none; border-left: 3px solid var(--border); padding-left: 2rem; }
.timeline-item { position: relative; margin-bottom: 2rem; }
.timeline-item::before { content: ''; position: absolute; left: -2.45rem; top: 0.5rem; width: 12px; height: 12px; border-radius: 50%; background: var(--accent); }
.timeline-item[data-status="done"]::before { background: var(--success); }
```

## Category 2: Code Review & Understanding

### Annotated Diff View

```html
<div class="diff-file">
    <header class="diff-header">src/auth.ts</header>
    <table class="diff-table">
        <tr class="diff-remove"><td class="line-num">12</td><td class="code">- const token = getToken();</td></tr>
        <tr class="diff-add"><td class="line-num">12</td><td class="code">+ const token = await getTokenAsync();</td></tr>
        <tr class="diff-context"><td class="line-num">13</td><td class="code">  return validate(token);</td></tr>
    </table>
</div>
```

```css
.diff-file { border: 1px solid var(--border); overflow: hidden; margin: 1rem 0; }
.diff-header { background: var(--surface); padding: 0.5rem 1rem; font-family: 'Source Code Pro', Menlo, monospace; font-weight: 600; }
.diff-table { width: 100%; border-collapse: collapse; font-family: 'Source Code Pro', Menlo, monospace; font-size: 0.875rem; }
.diff-table td { padding: 0.25rem 0.75rem; white-space: pre; }
.line-num { width: 3rem; color: var(--fg); opacity: 0.5; text-align: right; user-select: none; }
.diff-remove { background: rgba(239,68,68,0.1); }
.diff-add { background: rgba(16,185,129,0.1); }
```

### Syntax Highlighting (Minimal)

```css
.kw { color: #7c3aed; } /* keywords */
.str { color: #059669; } /* strings */
.num { color: #d97706; } /* numbers */
.cm { color: #6b7280; font-style: italic; } /* comments */
.fn { color: #2563eb; } /* function names */
```

## Category 3: Design Systems

### Token Swatch Grid

```html
<div class="token-grid">
    <div class="token-swatch" style="--swatch-color: #4361ee">
        <div class="swatch-preview"></div>
        <code>#4361ee</code>
        <span>Primary</span>
    </div>
</div>
```

```css
.token-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 1rem; }
.swatch-preview { width: 100%; aspect-ratio: 1; background: var(--swatch-color); }
.token-swatch code { font-size: 0.75rem; }
```

## Category 4: Prototyping

### Animation Sandbox

```html
<div class="sandbox">
    <div class="preview">
        <div class="animated-box" style="--duration: 0.3s; --easing: ease-out;"></div>
    </div>
    <div class="controls">
        <label>Duration: <input type="range" min="0.1" max="2" step="0.1" value="0.3" id="duration"></label>
        <label>Easing: <select id="easing">
            <option>ease-out</option><option>ease-in</option><option>linear</option>
        </select></label>
    </div>
</div>
```

```js
document.getElementById('duration').addEventListener('input', e => {
    document.querySelector('.animated-box').style.setProperty('--duration', e.target.value + 's');
});
document.getElementById('easing').addEventListener('change', e => {
    document.querySelector('.animated-box').style.setProperty('--easing', e.target.value);
});
```

## Category 5: Diagrams & Flowcharts

### Inline SVG Flowchart

```html
<svg viewBox="0 0 600 400" class="diagram" role="img" aria-label="Flow diagram">
    <!-- Nodes -->
    <rect x="50" y="50" width="140" height="50" rx="8" class="node"/>
    <text x="120" y="80" text-anchor="middle">Start</text>

    <rect x="250" y="50" width="140" height="50" rx="8" class="node"/>
    <text x="320" y="80" text-anchor="middle">Process</text>

    <!-- Connections -->
    <path d="M190 75 L250 75" class="edge" marker-end="url(#arrow)"/>

    <!-- Arrow marker -->
    <defs>
        <marker id="arrow" viewBox="0 0 10 10" refX="10" refY="5" markerWidth="6" markerHeight="6" orient="auto">
            <path d="M 0 0 L 10 5 L 0 10 z" fill="var(--accent)"/>
        </marker>
    </defs>
</svg>
```

```css
.diagram { width: 100%; height: auto; max-height: 500px; }
.node { fill: var(--surface); stroke: var(--accent); stroke-width: 2; }
.edge { fill: none; stroke: var(--accent); stroke-width: 2; }
.diagram text { fill: var(--fg); font-size: 14px; font-family: inherit; }
```

## Category 6: Presentations

### Slide Deck

```html
<div class="deck">
    <div class="progress-bar"><div class="progress-fill"></div></div>
    <section class="slide active">
        <h1>Title Slide</h1>
        <p>Subtitle or description</p>
    </section>
    <section class="slide">
        <h2>Slide 2</h2>
        <ul><li>Point 1</li><li>Point 2</li></ul>
    </section>
    <nav class="slide-nav">
        <button id="prev">Previous</button>
        <span class="counter">1 / 2</span>
        <button id="next">Next</button>
    </nav>
</div>
```

```js
const slides = document.querySelectorAll('.slide');
let current = 0;
function show(n) {
    slides[current].classList.remove('active');
    current = (n + slides.length) % slides.length;
    slides[current].classList.add('active');
    document.querySelector('.counter').textContent = `${current + 1} / ${slides.length}`;
    document.querySelector('.progress-fill').style.width = `${((current + 1) / slides.length) * 100}%`;
}
document.getElementById('next').onclick = () => show(current + 1);
document.getElementById('prev').onclick = () => show(current - 1);
document.addEventListener('keydown', e => {
    if (e.key === 'ArrowRight') show(current + 1);
    if (e.key === 'ArrowLeft') show(current - 1);
});
```

```css
.slide { display: none; min-height: 60vh; padding: 3rem; }
.slide.active { display: flex; flex-direction: column; justify-content: center; }
.progress-bar { position: fixed; top: 0; left: 0; width: 100%; height: 4px; background: var(--border); }
.progress-fill { height: 100%; background: var(--accent); transition: width 0.3s; }
.slide-nav { position: fixed; bottom: 1rem; left: 50%; transform: translateX(-50%); display: flex; gap: 1rem; align-items: center; }
```

## Category 7: Research & Learning

### Collapsible Sections with TOC

```html
<nav class="toc">
    <h2>Contents</h2>
    <ol>
        <li><a href="#section-1">Section 1</a></li>
        <li><a href="#section-2">Section 2</a></li>
    </ol>
</nav>
<article>
    <details open id="section-1">
        <summary><h2>Section 1</h2></summary>
        <p>Content here...</p>
    </details>
    <details id="section-2">
        <summary><h2>Section 2</h2></summary>
        <p>More content...</p>
    </details>
</article>
```

### Tabbed Code Blocks

```html
<div class="tabs">
    <div class="tab-buttons">
        <button class="tab-btn active" data-tab="js">JavaScript</button>
        <button class="tab-btn" data-tab="py">Python</button>
    </div>
    <div class="tab-content active" id="tab-js"><pre><code>console.log('hello');</code></pre></div>
    <div class="tab-content" id="tab-py"><pre><code>print('hello')</code></pre></div>
</div>
```

```js
document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        const parent = btn.closest('.tabs');
        parent.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        parent.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
        btn.classList.add('active');
        parent.querySelector(`#tab-${btn.dataset.tab}`).classList.add('active');
    });
});
```

```css
.tab-buttons { display: flex; border-bottom: 2px solid var(--border); }
.tab-btn { padding: 0.5rem 1rem; border: none; background: none; cursor: pointer; color: var(--fg); opacity: 0.6; }
.tab-btn.active { opacity: 1; border-bottom: 2px solid var(--accent); margin-bottom: -2px; }
.tab-content { display: none; padding: 1rem; }
.tab-content.active { display: block; }
```

## Category 8: Reports & Status

### Status Cards

```html
<div class="status-grid">
    <div class="status-card">
        <span class="metric-value">98%</span>
        <span class="metric-label">Uptime</span>
        <span class="badge badge-success">Healthy</span>
    </div>
    <div class="status-card">
        <span class="metric-value">23ms</span>
        <span class="metric-label">Avg Latency</span>
        <span class="badge badge-success">Normal</span>
    </div>
</div>
```

```css
.status-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 1rem; margin: 1.5rem 0; }
.status-card { background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 1.5rem; text-align: center; }
.metric-value { display: block; font-size: 2rem; font-weight: 700; color: var(--accent); }
.metric-label { display: block; font-size: 0.875rem; opacity: 0.7; margin: 0.25rem 0 0.75rem; }
.badge { font-size: 0.75rem; padding: 0.15rem 0.5rem; border-radius: 3px; font-weight: 600; }
.badge-success { background: #d4edda; color: #155724; }
.badge-warning { background: #fff3cd; color: #856404; }
.badge-danger { background: #f8d7da; color: #721c24; }
```

### Sortable Table

```js
document.querySelectorAll('th[data-sortable]').forEach(th => {
    th.style.cursor = 'pointer';
    th.addEventListener('click', () => {
        const table = th.closest('table');
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.rows);
        const col = th.cellIndex;
        const asc = th.dataset.sort !== 'asc';
        rows.sort((a, b) => {
            const av = a.cells[col].textContent.trim();
            const bv = b.cells[col].textContent.trim();
            return asc ? av.localeCompare(bv, undefined, {numeric: true}) : bv.localeCompare(av, undefined, {numeric: true});
        });
        rows.forEach(r => tbody.appendChild(r));
        table.querySelectorAll('th').forEach(h => delete h.dataset.sort);
        th.dataset.sort = asc ? 'asc' : 'desc';
    });
});
```

## Category 9: Custom Editing Interfaces

### Drag-and-Drop Reorderable List

```html
<div class="editor-container">
    <h2>Priority Ordering</h2>
    <ul class="drag-list" id="sortable">
        <li class="drag-item" draggable="true" data-id="1"><span class="drag-handle">⠿</span> High-priority item</li>
        <li class="drag-item" draggable="true" data-id="2"><span class="drag-handle">⠿</span> Medium-priority item</li>
        <li class="drag-item" draggable="true" data-id="3"><span class="drag-handle">⠿</span> Low-priority item</li>
    </ul>
    <button class="export-btn" onclick="exportState()">Export as JSON</button>
    <pre class="export-output" id="export-output"></pre>
</div>
```

```js
const list = document.getElementById('sortable');
let draggedItem = null;

list.addEventListener('dragstart', e => {
    draggedItem = e.target.closest('.drag-item');
    draggedItem.classList.add('dragging');
});

list.addEventListener('dragend', e => {
    draggedItem.classList.remove('dragging');
    draggedItem = null;
});

list.addEventListener('dragover', e => {
    e.preventDefault();
    const afterElement = getDragAfterElement(list, e.clientY);
    if (afterElement) list.insertBefore(draggedItem, afterElement);
    else list.appendChild(draggedItem);
});

function getDragAfterElement(container, y) {
    const items = [...container.querySelectorAll('.drag-item:not(.dragging)')];
    return items.reduce((closest, child) => {
        const box = child.getBoundingClientRect();
        const offset = y - box.top - box.height / 2;
        if (offset < 0 && offset > closest.offset) return { offset, element: child };
        return closest;
    }, { offset: Number.NEGATIVE_INFINITY }).element;
}

function exportState() {
    const items = [...document.querySelectorAll('.drag-item')].map((el, i) => ({
        id: el.dataset.id, position: i + 1, text: el.textContent.trim()
    }));
    document.getElementById('export-output').textContent = JSON.stringify(items, null, 2);
}
```

```css
.editor-container { border: 1px solid var(--border); padding: 1.5rem; margin: 1rem 0; }
.drag-list { list-style: none; padding: 0; }
.drag-item { padding: 0.75rem 1rem; margin: 0.5rem 0; background: var(--surface); border: 1px solid var(--border); cursor: grab; display: flex; align-items: center; gap: 0.75rem; }
.drag-item.dragging { opacity: 0.4; }
.drag-handle { color: var(--accent); font-size: 1.2rem; }
.export-btn { margin-top: 1rem; padding: 0.5rem 1rem; background: var(--accent); color: white; border: none; cursor: pointer; }
.export-btn:hover { background: var(--accent-hover); }
.export-output { margin-top: 0.75rem; font-size: 0.8rem; max-height: 200px; overflow: auto; }
```

### Live Preview Editor

```html
<div class="preview-editor">
    <div class="editor-panel">
        <h3>Template Variables</h3>
        <label>Name: <input type="text" data-var="name" value="World" oninput="updatePreview()"></label>
        <label>Color: <input type="color" data-var="color" value="#1a7fad" oninput="updatePreview()"></label>
        <label>Size: <input type="range" data-var="size" min="12" max="48" value="24" oninput="updatePreview()"></label>
    </div>
    <div class="preview-panel" id="live-preview">
        <p style="color: #1a7fad; font-size: 24px;">Hello, World!</p>
    </div>
    <button class="export-btn" onclick="exportTemplate()">Export Template</button>
</div>
```

```js
function updatePreview() {
    const name = document.querySelector('[data-var="name"]').value;
    const color = document.querySelector('[data-var="color"]').value;
    const size = document.querySelector('[data-var="size"]').value;
    document.getElementById('live-preview').innerHTML =
        `<p style="color: ${color}; font-size: ${size}px;">Hello, ${name}!</p>`;
}
function exportTemplate() {
    const vars = {};
    document.querySelectorAll('[data-var]').forEach(el => { vars[el.dataset.var] = el.value; });
    const blob = new Blob([JSON.stringify(vars, null, 2)], { type: 'application/json' });
    const a = document.createElement('a'); a.href = URL.createObjectURL(blob);
    a.download = 'template-vars.json'; a.click();
}
```

```css
.preview-editor { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; border: 1px solid var(--border); padding: 1.5rem; margin: 1rem 0; }
.editor-panel label { display: block; margin-bottom: 0.75rem; font-size: 0.875rem; }
.editor-panel input[type="text"] { width: 100%; padding: 0.4rem; border: 1px solid var(--border); margin-top: 0.25rem; }
.preview-panel { background: var(--surface); border: 1px solid var(--border); padding: 1.5rem; display: flex; align-items: center; justify-content: center; min-height: 150px; }
```

### Validation with Dependency Warnings

```html
<div class="config-editor">
    <div class="config-field">
        <label>Replicas: <input type="number" id="replicas" min="1" max="10" value="3" oninput="validate()"></label>
        <span class="validation-msg" id="replicas-msg"></span>
    </div>
    <div class="config-field">
        <label>Memory (GB): <input type="number" id="memory" min="1" max="64" value="4" oninput="validate()"></label>
        <span class="validation-msg" id="memory-msg"></span>
    </div>
    <div class="validation-summary" id="summary"></div>
</div>
```

```js
function validate() {
    const replicas = parseInt(document.getElementById('replicas').value);
    const memory = parseInt(document.getElementById('memory').value);
    const total = replicas * memory;
    const replicasMsg = document.getElementById('replicas-msg');
    const memoryMsg = document.getElementById('memory-msg');
    const summary = document.getElementById('summary');

    replicasMsg.textContent = replicas > 5 ? '⚠️ High replica count increases cost' : '';
    replicasMsg.className = 'validation-msg' + (replicas > 5 ? ' warn' : '');
    memoryMsg.textContent = memory > 32 ? '⚠️ Exceeds typical node capacity' : '';
    memoryMsg.className = 'validation-msg' + (memory > 32 ? ' warn' : '');

    if (total > 48) {
        summary.textContent = `❌ Total memory (${total}GB) exceeds cluster quota (48GB)`;
        summary.className = 'validation-summary error';
    } else {
        summary.textContent = `✓ Total: ${total}GB of 48GB quota`;
        summary.className = 'validation-summary ok';
    }
}
validate();
```

```css
.config-editor { border: 1px solid var(--border); padding: 1.5rem; margin: 1rem 0; }
.config-field { margin-bottom: 1rem; }
.config-field label { font-weight: 500; }
.config-field input { width: 80px; padding: 0.3rem; margin-left: 0.5rem; }
.validation-msg { font-size: 0.8rem; margin-left: 0.5rem; }
.validation-msg.warn { color: var(--warning); }
.validation-summary { margin-top: 1rem; padding: 0.75rem; border-radius: 4px; font-weight: 500; }
.validation-summary.error { background: #f8d7da; color: #721c24; }
.validation-summary.ok { background: #d4edda; color: #155724; }
```

## Category 10: Chat & Conversation Summary

### Overview Card + Decision Table

```html
<header class="chat-header">
    <h1>Conversation Summary</h1>
    <p class="chat-meta">Topic: <strong>HTML Effectiveness Skill</strong> | Messages: 12 | Duration: 25 min</p>
</header>

<section class="overview-card">
    <h2>Overview</h2>
    <p>Created an HTML effectiveness skill that converts various content types into interactive, self-contained HTML files.</p>
</section>

<section class="decisions">
    <h2>Decisions & Outcomes</h2>
    <table>
        <thead><tr><th>Decision</th><th>Rationale</th><th>Status</th></tr></thead>
        <tbody>
            <tr><td>Agent-generated HTML</td><td>More flexible than template-filling</td><td><span class="badge badge-success">Decided</span></td></tr>
            <tr><td>Output to /tmp/</td><td>Keeps project clean, gitignore-friendly</td><td><span class="badge badge-success">Decided</span></td></tr>
        </tbody>
    </table>
</section>
```

```css
.chat-header { border-bottom: 2px solid var(--accent); padding-bottom: 1rem; margin-bottom: 2rem; }
.chat-meta { font-size: 0.875rem; opacity: 0.7; margin-top: 0.5rem; }
.overview-card { background: var(--note-bg); border-left: 4px solid var(--accent); padding: 1.5rem; margin-bottom: 2rem; border-radius: 0 4px 4px 0; }
.decisions table { width: 100%; border-collapse: collapse; }
.decisions th, .decisions td { padding: 0.75rem; border: 1px solid var(--border); }
.decisions th { background: var(--surface); }
```

### Code References Section

```html
<section class="code-refs">
    <h2>Code References</h2>
    <details>
        <summary><code>skills/html-effectiveness/SKILL.md</code> — Main skill file</summary>
        <pre><code>---
name: cai-html-effectiveness
description: Convert files, markdown...
---</code></pre>
    </details>
    <details>
        <summary><code>AGENTS.md</code> — Project guidelines</summary>
        <pre><code># Skill Structure
skills/descriptive-name/
├── SKILL.md
├── references/
...</code></pre>
    </details>
</section>
```

```css
.code-refs details { margin-bottom: 0.75rem; border: 1px solid var(--border); }
.code-refs summary { padding: 0.75rem 1rem; cursor: pointer; font-size: 0.875rem; }
.code-refs pre { margin: 0; border-top: 1px solid var(--border); border-radius: 0; }
```

### Action Items

```html
<section class="action-items">
    <h2>Action Items</h2>
    <ul class="action-list">
        <li class="action done"><span class="action-status">Done</span> Create SKILL.md with content categories</li>
        <li class="action done"><span class="action-status">Done</span> Add TEMPLATES.md reference patterns</li>
        <li class="action pending"><span class="action-status">Pending</span> Validate with Google Doc conversion</li>
    </ul>
</section>
```

```css
.action-list { list-style: none; }
.action { padding: 0.5rem 0; border-bottom: 1px solid var(--border); display: flex; align-items: center; gap: 0.75rem; }
.action-status { font-size: 0.7rem; padding: 0.15rem 0.5rem; border-radius: 999px; font-weight: 600; text-transform: uppercase; }
.action.done .action-status { background: rgba(16,185,129,0.15); color: var(--success); }
.action.pending .action-status { background: rgba(245,158,11,0.15); color: var(--warning); }
.action.done { opacity: 0.7; }
```

## Category 11: Tasks & Todos

### Interactive Checklist

```html
<div class="tasks-container">
    <div class="tasks-header">
        <progress value="2" max="5"></progress>
        <span class="tasks-count">2 / 5 complete</span>
    </div>
    <div class="filter-bar">
        <button class="filter-btn active" data-filter="all">All</button>
        <button class="filter-btn" data-filter="pending">Pending</button>
        <button class="filter-btn" data-filter="done">Done</button>
    </div>
    <ul class="task-list">
        <li class="task-item" data-status="done">
            <label><input type="checkbox" checked> Setup environment</label>
        </li>
        <li class="task-item" data-status="pending">
            <label><input type="checkbox"> Write tests</label>
        </li>
    </ul>
</div>
```

```js
const tasks = document.querySelectorAll('.task-item input');
const progress = document.querySelector('progress');
const count = document.querySelector('.tasks-count');
function updateProgress() {
    const done = document.querySelectorAll('.task-item input:checked').length;
    const total = tasks.length;
    progress.value = done; progress.max = total;
    count.textContent = `${done} / ${total} complete`;
    document.querySelectorAll('.task-item').forEach(li => {
        li.dataset.status = li.querySelector('input').checked ? 'done' : 'pending';
    });
}
tasks.forEach(t => t.addEventListener('change', updateProgress));
document.querySelectorAll('.filter-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const filter = btn.dataset.filter;
        document.querySelectorAll('.task-item').forEach(li => {
            li.style.display = (filter === 'all' || li.dataset.status === filter) ? '' : 'none';
        });
    });
});
```

```css
.tasks-header { display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem; }
progress { flex: 1; height: 8px; border-radius: 4px; }
progress::-webkit-progress-bar { background: var(--surface); border-radius: 4px; }
progress::-webkit-progress-value { background: var(--accent); border-radius: 4px; }
.filter-bar { display: flex; gap: 0.5rem; margin-bottom: 1rem; }
.filter-btn { padding: 0.25rem 0.75rem; border: 1px solid var(--border); border-radius: 999px; background: none; color: var(--fg); cursor: pointer; }
.filter-btn.active { background: var(--accent); color: white; border-color: var(--accent); }
.task-list { list-style: none; }
.task-item { padding: 0.75rem; border-bottom: 1px solid var(--border); }
.task-item[data-status="done"] label { opacity: 0.6; text-decoration: line-through; }
```

## Utility Patterns

### Copy-to-Clipboard Button

```html
<div class="code-block">
    <button class="copy-btn" onclick="copyCode(this)">Copy</button>
    <pre><code>your code here</code></pre>
</div>
```

```js
function copyCode(btn) {
    const code = btn.nextElementSibling.textContent;
    navigator.clipboard.writeText(code).then(() => {
        btn.textContent = 'Copied!';
        setTimeout(() => btn.textContent = 'Copy', 2000);
    });
}
```

### Redacted / Sensitive Information

```html
<!-- Hover to reveal — used for all individual names and sensitive data -->
<p>Approved by <span class="redacted">Ritvik Paramkusham</span> on May 19.</p>
<p>Internal endpoint: <span class="redacted">10.0.42.17:8443</span></p>
```

```css
.redacted {
    background: #333; color: #333;
    padding: 0.1rem 0.3rem; border-radius: 2px;
    cursor: pointer; transition: all 0.2s;
}
.redacted:hover { background: transparent; color: var(--fg); }
@media print { .redacted { background: transparent; color: var(--fg); } }
```

### Search/Filter Input

```html
<input type="search" class="search-input" placeholder="Filter..." oninput="filterItems(this.value)">
```

```js
function filterItems(query) {
    const q = query.toLowerCase();
    document.querySelectorAll('[data-searchable]').forEach(el => {
        el.style.display = el.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
```

### Print Styles

```css
@media print {
    nav, .slide-nav, .filter-bar, .copy-btn, .search-input { display: none; }
    body { max-width: 100%; padding: 0; }
    details { display: block; }
    details > summary { display: none; }
    .slide { display: block !important; page-break-after: always; }
}
```

### Embedded Images & Placeholders

```html
<!-- Embedded image (base64 data URI) -->
<figure class="embedded-img">
    <img src="data:image/png;base64,iVBORw0KGgo..." alt="Architecture diagram">
    <figcaption>Architecture diagram</figcaption>
</figure>

<!-- Placeholder when image can't be fetched -->
<div class="img-placeholder">
    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
        <rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/>
        <path d="M21 15l-5-5L5 21"/>
    </svg>
    <span>Image: Screenshot of upgrade UI</span>
    <small>Could not embed — original URL requires authentication</small>
</div>
```

```css
.embedded-img { margin: 1.5rem 0; text-align: center; }
.embedded-img img { max-width: 100%; height: auto; border-radius: var(--radius); border: 1px solid var(--border); }
.embedded-img figcaption { font-size: 0.8rem; opacity: 0.7; margin-top: 0.5rem; }
.img-placeholder {
    background: var(--surface); border: 2px dashed var(--border);
    border-radius: var(--radius); padding: 2rem; text-align: center;
    color: var(--fg); opacity: 0.7; margin: 1.5rem 0;
}
.img-placeholder svg { opacity: 0.4; margin-bottom: 0.75rem; }
.img-placeholder span { display: block; font-weight: 500; }
.img-placeholder small { display: block; margin-top: 0.5rem; font-size: 0.75rem; opacity: 0.6; }
```

