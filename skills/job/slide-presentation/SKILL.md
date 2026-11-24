---
name: slide-presentation
description: >-
  Builds a story-driven slide deck about a theme. Use when the user explicitly
  asks for slides, a presentation, a talk, a pitch, a workshop deck, or a
  storyline/outline for a deck. Produces an outline first, then a Marp
  Markdown deck (optional HTML or outline-only). Language follows the request
  (pt-BR or en-US). Explicit invocation only.
disable-model-invocation: true
argument-hint: "<theme> [audience, duration, format]"
---

# Slide presentation

Turn one theme into a deck the audience can follow by reading the titles alone. One job: the storyline and the slides. Do not send, publish, or export to PPTX unless the user asks.

Write in the language of the request (or `--lang`). If the language is unclear, ask once and wait.

Never use an em-dash (Unicode U+2014) in slides, notes, filenames, or chat. Use a comma, colon, semicolon, or parentheses. An en-dash (Unicode U+2013) is allowed only in date or number ranges.

## When to run

Only on explicit invoke (`disable-model-invocation: true`). Typical asks: "slides about X", "presentation for the client", "deck for this talk", "outline a presentation on Y".

Do not use this skill to edit an existing `.pptx` binary, build a video, or write a memo. If the user only wants a native PowerPoint file and already has a PPTX skill, say so and offer a Marp or outline deliverable here.

## Steps

### 1. Intake

Ask only for what is still missing. Ask together, in one message, then wait.

| Input | Required | Notes |
| --- | --- | --- |
| Theme and raw material | Yes | Topic, notes, doc, data, or "from scratch" |
| Audience | Yes | Who is in the room, what they already know, what they care about |
| Goal / ask | Yes | What they should think, decide, or do afterwards |
| Duration or length | No | Default: 10 minutes, about 8 to 12 slides including title and close |
| Format | No | Default: `marp` (see Output). Also: `outline`, `html` |
| Constraints | No | Brand colors, must-include facts, things to avoid, presenter name, date |

If the theme is only a heading and there are no facts, ask for key findings before outlining.

Done when theme, audience, and goal are clear.

### 2. Choose the storyline

Write these before any slide body:

- **Big idea:** one sentence the whole talk supports. A claim someone could disagree with, not a topic label.
- **Structure:** pick one and say why in one line:
  - **Pyramid (answer first):** recommendation, then 3 to 5 supporting arguments, then evidence. Default for executives, decisions, and time-pressed audiences.
  - **SCQA:** Situation (shared context), Complication (what changed), Question it raises, Answer. Use when the audience does not yet feel the problem.
  - **Problem, options, recommendation, plan:** when they will want to see alternatives you rejected.
  - **Chronological or process:** only for training, walkthroughs, or project history where time order really helps.

Size the deck: about one content slide per 1 to 2 minutes, plus a title slide, plus a close that states the ask. Leave a little time as buffer. Put backup detail in an appendix list, not in the main flow.

### 3. Ghost deck, then pause

Show a numbered outline and wait for confirmation before writing the full deck (unless the user already said "just build it").

For each slide, list:

1. **Action title:** a complete-sentence claim (at most 12 to 15 words), not a label. Bad: `Q3 Results`. Good: `Q3 pipeline missed the target because inbound dropped`.
2. **Job of the slide:** the one idea it proves.
3. **Visual:** one line (for example: `bar chart, monthly churn, price change marked`, `three-step flow`, `single metric`).
4. **Evidence still needed:** mark gaps as `[data needed: ...]`.

Then do the **title read-through:** paste the titles in order as a short paragraph. If a title does not follow from the one before, fix the outline. If a slide needs two titles, split it. If a slide adds no step in the argument, cut it or move it to the appendix.

Open with a hook that matters to this audience (a number, a consequence, or a sharp question). Close on the goal: the decision, the next steps, owners, and dates. Do not end the substance on a generic "Questions?" slide. A thanks or Q&A slide may follow the real close.

Done when the user confirms the outline, or when they already waived the pause.

### 4. Build the slides

For every approved slide, write:

- Action title (the conclusion of that slide)
- Body that proves only that title
- Speaker notes
- A visual that is not the same layout as the slide before it

**One idea per slide.** At most 3 short bullets, or one big number, or one quote, or one diagram. Prefer numbers over vague adjectives. If a bullet needs a second verb, it is a second slide.

**Do not invent facts or figures.** Every number must come from the user or a named source. If a number is missing, put `[data needed: ...]` on the slide itself, never a realistic placeholder.

**Vary the layout.** Do not ship a deck of title-plus-bullets slides. Rotate among:

| Layout | Use when |
| --- | --- |
| Title / hook | Opening claim and context |
| Statement | One sentence, large type (speaker-led) |
| Big number | A single metric and its meaning |
| Comparison | Two or three options, before/after, or trade-offs |
| Process or timeline | Ordered steps, a journey, a plan |
| Diagram or map | How the pieces relate |
| Evidence | Chart, table, or short proof points (3 max) |
| Quote or example | A concrete story that makes the claim real |
| Section divider | A new supporting argument in a longer talk |
| Close / ask | Decision, owners, dates |

**Density:** default is speaker-led (large type, 1 to 3 short lines, more slides). Use reading-first (denser grids or tables) only if the user said the deck must stand alone without a presenter. Keep margins generous. Do not crowd the canvas. Do not split a word or a figure from its unit across lines.

**Speaker notes** (required unless the user declines): 2 to 4 speakable sentences. Include the point to stress, a brief explanation of the visual, and a transition to the next slide. Add a likely objection and a short reply when it matters. Notes must add what the speaker says, not repeat the slide text.

Style details and a Marp starter: [STYLE.md](STYLE.md).

### 5. Write the output and check

Default path: `./presentations/<slug>/`. Create the folder if needed. `slug` is a short kebab-case name from the theme.

| Format | Files | When |
| --- | --- | --- |
| `outline` | `outline.md` | Storyline only, or the user is not ready for slides |
| `marp` (default) | `outline.md` and `deck.md` | Versionable Markdown the user can edit and export |
| `html` | those plus `deck.html` | The user asked to open a browser deck |

`deck.md` is one Marp file: YAML frontmatter (`marp: true`, `paginate: true`, `size: 16:9`), slides split by a line that is only `---`, speaker notes in an HTML comment that is not a Marp directive. See [STYLE.md](STYLE.md).

Export is optional and only if the user asks:

```bash
npx --yes @marp-team/marp-cli presentations/<slug>/deck.md --html --allow-local-files -o presentations/<slug>/deck.html
# PDF:  add --pdf
# PPTX: add --pptx   (often one image per slide; say this before exporting)
```

If a browser is missing, say so and leave the Markdown in place. Do not install system packages. Do not invent a heavy PPTX toolchain in this skill.

**Quality check before handing over:**

- [ ] Titles alone tell the argument (read them in order)
- [ ] One idea per slide; at most 3 bullets
- [ ] Layouts vary; not every slide is title plus bullets
- [ ] No invented numbers; gaps marked `[data needed]`
- [ ] Close states a clear ask
- [ ] Speaker notes exist and do not copy the slide
- [ ] Language matches the request
- [ ] No em-dash (U+2014) anywhere in the deliverable

Reply with the big idea, the structure you chose, the file path, the slide count, and any `[data needed]` items.