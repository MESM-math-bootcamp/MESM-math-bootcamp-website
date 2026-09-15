---
name: lecture-slide-conventions
description: Conventions for building/editing the revealjs lecture slide decks (lecture-*.qmd, or dayN/dayN-slides.qmd assembled from shared topic partials) in this workshop — slide structure, the exercise → space-to-solve → answer sequence, color/emoji labels, a pandoc gotcha that creates invisible blank slides, cross-folder image path breakage, and unclosed-div warnings that silently swallow every later slide. Use when creating, restructuring, or adding practice problems to any day's lecture slides, or when a render fails/warns or an image doesn't show.
---

# Lecture slide conventions

These apply to every `notes/dayN_*/lecture-*.qmd` deck (revealjs, theme `ucsb-media.scss`, `chalkboard: true`).

The site is mid-restructure: some days are being split into shared, reusable topic partials — e.g. `notes/_linear-functions/_linear-functions-slides.qmd`, `notes/_exp-and-log/_slides-exp-and-log.qmd` — pulled into a per-day entry point (e.g. `notes/day3/day3-slides.qmd`) with `{{< include ../_topic/_partial.qmd >}}`, or pasted in directly. All the slide-structure conventions and gotchas below apply equally to these partials.

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

## `\cancel{}` needs an explicit MathJax extension — check this whenever a deck uses it

Revealjs decks render math via reveal.js's bundled math plugin, which loads **MathJax v2** with the combined config `TeX-AMS_HTML-full`. That config does *not* autoload the `cancel` extension, so `\cancel{80}` (or `\bcancel`, `\xcancel`, `\cancelto`) shows up as literal red text reading `\cancel` instead of a struck-through term — this is silent (no build warning/error), so it only shows up on visual inspection.

**Fix:** any deck that uses `\cancel` (e.g. showing terms cancelling out in an algebra/unit-conversion step) needs this in its own `format.revealjs` front matter (this is per-file, not inherited from `_quarto.yml` — revealjs format options aren't set at the project level in this repo):

```yaml
format:
  revealjs:
    ...
    include-in-header:
      text: |
        <script>
        (function loadCancelExtension(){
          if (window.MathJax && window.MathJax.Hub) {
            MathJax.Hub.Config({ TeX: { extensions: ["cancel.js"] } });
          } else {
            setTimeout(loadCancelExtension, 20);
          }
        })();
        </script>
```

This polls until reveal.js's async-loaded MathJax v2 instance exists, then registers the extension — a plain `MathJax.Hub.Config(...)` call placed too early (before the dynamically-injected MathJax script has run) fails silently because `window.MathJax` doesn't exist yet.

**Whenever you add or edit a lecture deck:**
1. `grep -n '\\cancel' notes/dayN_*/lecture-*.qmd` (or check the specific file you're editing) — if it uses `\cancel` and doesn't already have `cancel.js` in its `include-in-header`, add the block above.
2. After rendering (`quarto render <file> --to revealjs`), verify visually — open the slide, or check the rendered HTML for `menclose notation="updiagonalstrike"` nodes and confirm there's no literal `\cancel` text rendered in red (search the rendered `.html` for `mathcolor="red"` near a `\cancel` string — that pattern means the extension isn't loading).
3. Currently `notes/day1_algebra/lecture-algebra.qmd` and `notes/day2_functions_graphs/lecture-functions-graphs.qmd` use `\cancel` and both have the fix — keep this list current if you add `\cancel` elsewhere.

## Gotcha: image paths break when content moves between day-folders or is included as a partial

Images live in per-day `images/` subfolders (`notes/dayN_.../images/`). A relative path like `images/foo.png` (in `knitr::include_graphics("images/foo.png")` or Markdown `![](images/foo.png)`) resolves differently depending on how the file reaches the final render:

- A file rendered directly (e.g. `notes/day3/day3-slides.qmd`) resolves `images/...` relative to **its own** directory.
- A file pulled in via `{{< include ../_topic/_partial.qmd >}}` has its relative paths resolved relative to the **including file's** directory, not its own — `{{< include >}}` is a textual substitution done before Pandoc ever parses the file.

**Symptom:** `knitr::include_graphics()` fails the render outright (`Cannot find the file(s)`); a Markdown `![]()` image instead renders silently as a broken `<img>` tag with no build error at all — only visible on inspection.

This has bitten this repo repeatedly during the shared-topic-partial restructuring: `_linear-functions-slides.qmd`, `_slides-exp-and-log.qmd`, and a plain `![]()` on day3's `#break` slide all had `images/foo.png` paths left over from before the file was moved or wired into an include, pointing nowhere from the new location.

**Fix:** whenever a slide file is moved, newly included via `{{< include >}}`, or copy-pasted from another day's deck, grep it for image references and verify each path resolves from the *including* file's location (not the source file's own folder):
```
grep -n 'images/\|include_graphics\|!\[.*\](' path/to/file.qmd
```
Point the path at wherever the image actually lives — often another day's folder, e.g. `../day2_functions_graphs/images/foo.png` — then render the real entry-point file (not the partial in isolation) to confirm the fix, since rendering the partial alone can't reproduce the including document's working directory.

## Gotcha: a missing or under-counted closing `:::` silently swallows every slide after it

Pandoc closes a fenced div (`:::` / `::::`) with a fence that has **at least as many colons** as the one that opened it — not with an exact match. Two mistakes both cascade the same way:

1. A `:::{...}` is opened and never closed before the next `##` heading or `---`.
2. A `:::: {.columns}` (4 colons) is "closed" with only `:::` (3 colons) — this does **not** close it, since the closing fence needs ≥4 colons.

Either way, Pandoc keeps the div open and folds every subsequent heading/slide into it until it finally hits a fence with enough colons to close it — usually the end of the file. The only symptom is one terminal warning:
```
[WARNING] Div at line X column 1 unclosed at line Y column 1, closing implicitly.
```
**The line numbers in this warning are not reliable for finding the actual bug** — X is frequently not where the problem is, and Y is usually just wherever Pandoc gave up (often end of file), not the location of the bad fence.

**Debugging technique:** don't chase the warning's line numbers — list every fence in the file in document order and check the nesting balances by eye:
```
awk '{line=$0; gsub(/^[ \t]+/,"",line); if (line ~ /^::::/) print NR, "::::"; else if (line ~ /^:::[^:]/ || line == ":::") print NR, ":::"}' path/to/file.qmd
```
Walk the output top to bottom like a stack: every `::::` needs a later `::::` before the file ends; every `:::` needs a later `:::` (or `::::`) before its enclosing div closes. The first point where the stack doesn't balance is the real bug.

**Verify the fix** by re-rendering and confirming every slide after the fix point is still its own top-level `<section id="...">` in the output HTML, not nested inside a leftover `<div class="columns">`:
```
grep -n '<section id="\|class="columns"' docs/path/to/file.html
```

## Fitting content without shrinking prose

If a slide's content doesn't fit, prefer splitting into more slides over shrinking exercise/explanation text. The one accepted exception is combining several *already-worked* solutions onto one slide, where wrapping each LaTeX block in `\small` inside a `.columns` grid avoids leaving a slide mostly blank — check with the instructor before assuming more than ~4 short solutions will fit on one slide together.
