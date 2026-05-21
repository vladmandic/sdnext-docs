# Where to Start Contributing

New to SD.Next and not sure where to jump in? Click the button below — it fetches open issues from GitHub, then uses Chrome's on-device AI (Gemini Nano) to surface the best first tasks. No data leaves your browser.

---

<div id="ai-summary-wrapper" style="margin: 1.5rem 0;">
  <button id="ai-summary-btn"
    style="
      display: none;
      background: var(--md-primary-fg-color, #6200ee);
      color: var(--md-primary-bg-color, #fff);
      border: none;
      border-radius: 6px;
      padding: 0.6rem 1.2rem;
      font-size: 0.9rem;
      cursor: pointer;
      font-family: inherit;
    ">
    Find my best starting point
  </button>

  <div id="ai-download-box"
    style="
      display: none;
      margin-top: 0.75rem;
      padding: 0.9rem 1.1rem;
      background: #e8f4fd;
      border-left: 4px solid #2196f3;
      border-radius: 0 6px 6px 0;
      font-size: 0.88rem;
    ">
    <p style="margin: 0 0 0.6rem;">This feature uses <strong>Gemini Nano</strong>, Chrome's on-device AI. A one-time download (~1.5 GB) is required — it runs entirely on your device.</p>
    <button id="ai-download-btn"
      style="
        background: #2196f3;
        color: #fff;
        border: none;
        border-radius: 6px;
        padding: 0.5rem 1rem;
        font-size: 0.88rem;
        cursor: pointer;
        font-family: inherit;
      ">
      Download model &amp; find my starting point
    </button>
  </div>

  <div id="ai-status" style="display:none; margin-top: 0.8rem; font-size: 0.85rem; color: var(--md-default-fg-color--light, #666);"></div>

  <div id="ai-progress-bar" style="display:none; margin-top: 0.5rem; background: var(--md-code-bg-color, #f5f5f5); border-radius: 4px; height: 6px; overflow: hidden;">
    <div id="ai-progress-fill" style="height:100%; width:0%; background: var(--md-primary-fg-color, #6200ee); transition: width 0.3s;"></div>
  </div>

  <div id="ai-output"
    style="
      display: none;
      margin-top: 1rem;
      padding: 1rem 1.25rem;
      background: var(--md-code-bg-color, #f5f5f5);
      border-left: 4px solid var(--md-primary-fg-color, #6200ee);
      border-radius: 0 6px 6px 0;
      font-size: 0.9rem;
      line-height: 1.65;
      white-space: pre-wrap;
    ">
  </div>

  <div id="ai-unavailable"
    style="
      display: none;
      margin-top: 0.8rem;
      padding: 0.75rem 1rem;
      background: #fff3e0;
      border-left: 4px solid #ff9800;
      border-radius: 0 6px 6px 0;
      font-size: 0.85rem;
    ">
    Chrome's built-in AI isn't available in your browser. This feature requires <strong>Chrome 138+</strong> with Gemini Nano. You can still read the contribution areas below manually.
  </div>
</div>

---

## Contribution Areas

| Area | Skills | Difficulty |
|---|---|---|
| [Documentation & Wiki](../Dev-Docs/) | Writing, Markdown | Beginner |
| [Localization](../Dev-Locale/) | Non-English fluency | Beginner |
| [User Themes](../Dev-Theme/) | CSS, web design | Beginner–Intermediate |
| [Scripts & Extensions](../Dev-Extensions/) | Python, SD pipelines | Intermediate |
| [UI Development](../Dev-UI/) | JavaScript, HTML, CSS | Intermediate |
| [AI Coding Tools](../Dev-AICoding/) | Python, LLMs | Intermediate |
| [Core Modules](../Dev-Structure/) | Python, deep learning | Intermediate–Advanced |
| Backend & Platform Support | Python, CUDA/ROCm/OpenVINO | Advanced |

*Ready to dive in? Start with [Dev Getting Started](../Dev-GettingStarted/) for the fork and PR workflow.*

<script>
(function () {
  const GITHUB_API = 'https://api.github.com/repos/vladmandic/sdnext/issues?state=open&per_page=30&sort=updated';

  const AREAS_TEXT = `
SD.Next Contribution Areas:

1. Documentation & Wiki — Skills: Writing, Markdown. No coding required. Difficulty: Beginner.
2. Localization — Skills: Fluency in a non-English language. No coding required. Difficulty: Beginner.
3. User Themes — Skills: CSS, basic web design. Difficulty: Beginner–Intermediate.
4. Scripts & Extensions — Skills: Python, SD pipeline basics. Difficulty: Intermediate.
5. UI Development — Skills: JavaScript/TypeScript, HTML, CSS. Difficulty: Intermediate.
6. AI Coding Tools — Skills: Python, LLM/AI tooling experience. Difficulty: Intermediate.
7. Core Modules — Skills: Python, deep learning basics. Difficulty: Intermediate–Advanced.
8. Backend & Platform Support — Skills: Python, CUDA/ROCm/OpenVINO. Difficulty: Advanced.
`;

  const btn = document.getElementById('ai-summary-btn');
  const downloadBox = document.getElementById('ai-download-box');
  const downloadBtn = document.getElementById('ai-download-btn');
  const status = document.getElementById('ai-status');
  const progressBar = document.getElementById('ai-progress-bar');
  const progressFill = document.getElementById('ai-progress-fill');
  const output = document.getElementById('ai-output');
  const unavailable = document.getElementById('ai-unavailable');

  function setStatus(msg) {
    status.style.display = msg ? 'block' : 'none';
    status.textContent = msg;
  }

  async function fetchIssues() {
    const res = await fetch(GITHUB_API, { headers: { 'Accept': 'application/vnd.github+json' } });
    if (!res.ok) throw new Error(`GitHub API error: ${res.status}`);
    const items = await res.json();
    return items.filter(i => !i.pull_request);
  }

  async function summarize(avail) {
    setStatus('Fetching open issues from GitHub…');
    let issues = [];
    try {
      issues = await fetchIssues();
    } catch (err) {
      setStatus('Could not fetch issues — using contribution areas only.');
    }

    const issuesText = issues.length
      ? '\nOpen GitHub Issues (use the exact #NUMBER when referencing):\n' +
        issues.map(i => `Issue #${i.number}: ${i.title}`).join('\n')
      : '';

    const options = {
      type: 'key-points',
      format: 'plain-text',
      length: 'medium',
      outputLanguage: 'en',
      sharedContext:
        'You are helping a new open-source contributor find their first task in SD.Next, ' +
        'a Stable Diffusion image generation platform written in Python. ' +
        'Recommend 2-3 specific starting points by pairing a contribution area with a real open issue. ' +
        'You MUST cite each issue using its exact number in the format #NUMBER (e.g. #4859). ' +
        'Only reference issues that appear in the list provided.',
    };

    if (avail === 'downloadable') {
      progressBar.style.display = 'block';
      options.monitor = (m) => {
        m.addEventListener('downloadprogress', (e) => {
          const pct = Math.round(e.loaded * 100);
          progressFill.style.width = `${pct}%`;
          setStatus(`Downloading Gemini Nano… ${pct}%`);
        });
      };
    } else {
      setStatus('Thinking…');
    }

    const summarizer = await Summarizer.create(options);
    progressBar.style.display = 'none';
    setStatus('Generating…');
    output.style.display = 'block';
    output.textContent = '';

    const stream = summarizer.summarizeStreaming(AREAS_TEXT + issuesText);
    let fullText = '';
    for await (const chunk of stream) {
      fullText += chunk;
      output.textContent = fullText;
    }

    const escaped = fullText
      .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
      .replace(/#(\d+)/g, '<a href="https://github.com/vladmandic/sdnext/issues/$1" target="_blank" style="color:var(--md-primary-fg-color,#2196f3);font-weight:600">#$1</a>');

    const items = escaped.split('\n')
      .filter(l => l.trim().startsWith('*'))
      .map(l => {
        const text = l.replace(/^\s*\*\s*/, '');
        return text.replace(/^([^:]+):/, '<strong>$1</strong>:');
      });

    output.innerHTML = items.length
      ? '<ul style="padding-left:1.2rem;margin:0">' + items.map(i => `<li style="margin-bottom:0.6rem;line-height:1.6">${i}</li>`).join('') + '</ul>'
      : escaped;
    setStatus('');
    summarizer.destroy();
  }

  async function init() {
    if (!('Summarizer' in window)) {
      unavailable.style.display = 'block';
      return;
    }

    const avail = await Summarizer.availability();

    if (avail === 'unavailable') {
      unavailable.style.display = 'block';
      return;
    }

    if (avail === 'downloadable') {
      downloadBox.style.display = 'block';
      downloadBtn.addEventListener('click', async () => {
        downloadBtn.disabled = true;
        downloadBox.querySelector('p').textContent = 'Downloading — this may take a few minutes…';
        try {
          await summarize('downloadable');
        } catch (err) {
          unavailable.innerHTML = `<strong>Error:</strong> ${err.message}`;
          unavailable.style.display = 'block';
        }
      });
      return;
    }

    // available — show main button
    btn.style.display = 'inline-block';
    btn.addEventListener('click', async () => {
      btn.disabled = true;
      btn.style.opacity = '0.6';
      try {
        await summarize('available');
      } catch (err) {
        unavailable.innerHTML = `<strong>Error:</strong> ${err.message}`;
        unavailable.style.display = 'block';
      }
    });
  }

  init();
})();
</script>
