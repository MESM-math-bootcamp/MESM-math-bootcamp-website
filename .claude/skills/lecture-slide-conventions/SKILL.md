---
name: lecture-slide-conventions
description: Conventions for building/editing the revealjs lecture slide decks (lecture-*.qmd) in this workshop — slide structure, the exercise → space-to-solve → answer sequence, color/emoji labels, and a pandoc gotcha that creates invisible blank slides. Use when creating, restructuring, or adding practice problems to any day's lecture slides.
---

# Lecture slide conventions

These apply to every `notes/dayN_*/lecture-*.qmd` deck (revealjs, theme `ucsb-media.scss`, `chalkboard: true`, MathJax with the `cancel.js` extension for showing cancelled terms in algebra steps).

## Slide structure

- Each slide is a level-2 heading: `## {#slide-id data-menu-title="Short menu label"}`. `slide-id` is a stable kebab-case anchor; `data-menu-title` is what shows in the slide-navigation menu — keep it short and distinct from other slides' menu titles.
- Section divider slides (e.g. "Algebra review", "Rules of exponents") use `background-color="#003660"` and a centered custom subtitle:
  ```
  ## {#section-id data-menu-title="..." background-color="#003660"}
  <div class="page-center">
  <div class="custom-subtitle">Section name</div>
  </div>
  ```
- Regular content slides open with `[Slide Title]{.slide-title}` then `<hr>`, then the content.
- Slides are separated by a `---` line.

**Gotcha:** never put anything — especially an HTML comment — between a `---` separator and the `##` heading that follows it. Pandoc treats the `---` as its own slide boundary, so a comment sitting there (which renders to nothing) becomes an empty slide between the two real slides. If a slide needs a source-attribution comment, put it on the line *after* the `## {#...}` heading, never before it.

## The exercise → space-to-solve → answer sequence

This is the standard pattern for in-class practice (see `#PEMDAS-practice` → `#PEMDAS-practice-solution-1-answer` as the canonical example, or the `#algebra-practice-*` slides in Day 1):

1. **Exercise slide** — states the problem(s) in full (not paraphrased). Labeled with ✏️ and green text: `✏️ [Take a minute to solve this individually.]{style="color:green;"}` (or "...these individually" for multiple problems).
2. **Space-to-solve slide(s)** — one per exercise, restating that exercise's full text (so students don't have to flip back to remember it), leaving room for chalkboard work. Labeled with ✏️ and green text: `✏️ [Let's see a solution!]{style="color:green;"}` — this same label is reused here as the cue that solving is about to start, even though the actual worked answer comes on the next slide.
3. **Answer slide(s)** — full worked solution in LaTeX `aligned` blocks, one step per line, with reasons as `&\text{...}` comments where helpful. When several exercises' solutions can fit together, combine them in a `:::: {.columns}` grid (two per row) rather than spreading one-per-slide — wrap each solution's math in `\small` when doing this.

Never merge the exercise-statement slide and the space-to-solve slide into one — they're always separate slides, even when the answer slides get combined onto a single slide.

## Pulling exercises from the exercise bank

- When a slide exercise is sourced from `exercise_bank_draft.qmd`, note it with an HTML comment on the line *after* the slide's `##` heading (see the gotcha above), e.g. `<!-- Source: ESM 201 Exercise Bank, Exercise 3 -->`. This is for the instructor's own tracking — never visible to students.

## Fitting content without shrinking prose

If a slide's content doesn't fit, prefer splitting into more slides over shrinking exercise/explanation text. The one accepted exception is combining several *already-worked* solutions onto one slide, where wrapping each LaTeX block in `\small` inside a `.columns` grid avoids leaving a slide mostly blank — check with the instructor before assuming more than ~4 short solutions will fit on one slide together.
