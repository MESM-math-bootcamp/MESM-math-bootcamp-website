---
name: exercise-solution-conventions
description: How exercises and their solutions should be numbered, sourced, and formatted across the exercise bank (exercise_bank_draft.qmd), problem sets (problem_set_*.qmd), and their companion solutions documents (solutions_*.qmd). Use when adding, moving, renumbering, or writing solutions for exercises in any of these documents.
---

# Exercise & solution formatting conventions

## The exercise bank (`exercise_bank_draft.qmd`)

- Organized as Topic → Course subsection (ESM 201/202/203/204) → up to three difficulty tiers: **Intro** (~2 min, one direct application), **Medium** (~3–4 min, one extra step), **Hard** (~5 min, multi-step or needs interpretation). A course subsection is skipped entirely for a topic it doesn't genuinely need — don't force one in just to fill a slot.
- Each course subsection opens with a short italicized *Source:* line citing what grounded it (an instructor planning note, or a real problem from `_planning/`). If exercises move into or out of a subsection, update or add the Source line so it still accurately describes what's there.
- **Exercises are numbered continuously across the entire document** — never restart per topic or course. If you move, remove, or insert exercises anywhere in the file, renumber everything from that point forward so the sequence stays gap-free and duplicate-free. After any such edit, verify with something like:
  ```
  grep -oE "Exercise [0-9]+" exercise_bank_draft.qmd | grep -oE "[0-9]+"
  ```
  and confirm the numbers are exactly `1..N` with no gaps or repeats.
- Never delete exercise bank content just because it's being copied elsewhere (into a problem set or into slides) — the bank is the permanent source, and copying from it is non-destructive. Only remove an exercise if explicitly asked to.
- Each exercise: `**Exercise N (Level).** <full problem text>` followed by
  ```
  ::: {.callout-note collapse="true" title="Solution"}
  <worked solution>
  :::
  ```

## Problem sets (`problem_set_algebra.qmd` and siblings)

- Student-facing: **no solutions inline.** Link to a companion solutions document instead — this is deliberate, to reduce the temptation to peek before attempting the problem.
- Exercises are numbered sequentially through the whole document, in the order they actually appear top-to-bottom — this is independent of the exercise bank's own numbering. Whenever exercises are added, removed, or reordered, renumber the rest of the document so there are no gaps, duplicates, or numbers left over from a previous edit.
- When a short set of exercises should be ordered by difficulty rather than by topic/course, use Intro → Medium → Hard subheadings; only group by source course if there are enough items per course to justify a subsection (one or two items per course usually isn't).
- Note which course/exercise-bank entry each exercise came from with an invisible HTML comment directly above it, e.g. `<!-- Source: ESM 203 Exercise Bank, Exercise 7 -->` — never as visible rendered text.

## Solutions documents (`solutions_*.qmd`)

- Must cover **every** exercise in the corresponding problem set, not just a subset — even ones that might already have a solution written somewhere else.
- Mirror the problem set's section headers and order exactly, with matching numbers (1:1 with the problem set — not the exercise bank's numbers).
- Each solution restates the **full exercise text** (not a shortened paraphrase) before the fold-out answer:
  ```
  **N)** <full problem text, copied verbatim from the problem set>

  ::: {.callout-note collapse="true" title="Solution"}
  <worked solution>
  :::
  ```
- If reusing solution content from an older/legacy solutions document, check the math rather than copying it blindly — fix any transcription or sign errors you find (verify by plugging the answer back into the original equation), and flag the fix to the instructor rather than silently propagating a wrong answer forward.

## After any renumbering

Render the affected `.qmd` file(s) with `quarto render <path>` to confirm they build, and re-check the numbering sequence (e.g. with `grep` + a quick count) before considering the edit done.
