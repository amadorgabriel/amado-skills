# Slide presentation style

Keep this file short. The storyline rules live in [SKILL.md](SKILL.md).

## Language and typography

- Follow the language of the request (pt-BR or en-US).
- Never use an em-dash (Unicode U+2014). Use a comma, colon, or parentheses.
- Action titles: a full-sentence claim, sentence case, at most 15 words.
- Bullets: short, concrete, parallel in structure. No period unless the bullet is a full sentence.
- Prefer a plain word over an arrow in running text ("from X to Y", not "X -> Y").

## Marp starter

```markdown
---
marp: true
theme: default
paginate: true
size: 16:9
---

<!--
Notes: hook the audience with why this matters now, then go to the big idea.
-->

# The big idea as a complete sentence

Subtitle or presenter, date, audience

---

<!--
Notes: restate the answer, then preview the three supports you will prove.
-->

# We should do X because Y

- Support one
- Support two
- Support three
```

- Split slides with a line that is only `---`. A stray rule merges or splits slides.
- Speaker notes: an HTML comment that is not a Marp directive (`<!-- notes -->`).
- Local images use a relative path: `![bg left:40%](./images/chart.png)`.
- Fitted headline (speaker-led): `# A short claim` can fill the width; do not use it on dense slides.
- Keep one theme for the whole deck. Do not restyle each slide from scratch.

## Visual guardrails

- One dominant idea, plenty of whitespace, consistent left alignment.
- A "big number" slide should show one metric, its unit, and one line of meaning.
- A comparison slide should label the options and the criterion, not a wall of text.
- If you describe a chart, name the type, the series, and the range (for example: `horizontal bars, lead time in days, last six months`).
- Mark missing evidence as `[data needed: ...]` in the body and in the outline.

## Optional export

From the deck folder, after the user asks:

```bash
npx --yes @marp-team/marp-cli deck.md --html --allow-local-files -o deck.html
```

HTML keeps the clickable deck. PDF is best for email. Default PPTX export is often rasterized; say that plainly if they need an editable PowerPoint file.