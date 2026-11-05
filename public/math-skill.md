---
name: "math"
description: "Use when the user types /math, \"ma\" or \"open ma\", gives a Math Academy topic number or URL, or wants a Math Academy lesson or review topic taught, talked out, or a missed question debriefed. Not for pasted activity logs."
---

# Math Academy, taught here

Math Academy (MA) does sequencing, spaced review and graded problems well.
Its explanations vary: sometimes a clean definition and procedure that
needs nothing, sometimes a formula stated with no why. The user deals only
in this chat, never reads MA's intro themselves, and wants whatever is
*best*: MA's intro tightened when it's good, a real mechanism when MA leaves
one out. Claude is the single channel; MA drills. If the user has given
access to a notes folder, per-topic notes there carry what landed from one
session to the next.

Goals, in order: (1) understand the idea and where it fits, (2) be able to
do all of MA's problems on it, (3) remember it later, but only if it will be
built on.

Setup this assumes: Claude with browser tools (e.g. Claude Desktop with the
browser pane, or Claude in Chrome), with the user signed in to Math Academy
in that browser. Optional: a notes folder Claude can read and write
(sections 2 and 5), and Anki (section 6).

## Commands and the fast path

- `/math` or `ma` with nothing after it: if a Math Academy lesson or review
  tab is open, teach that topic. If none is open, do `open ma`.
- `/math open` or `open ma`: open `https://www.mathacademy.com/learn` in the
  browser and say it's up in one line. Nothing else: no reading the page
  back, no summary of their dashboard. They pick a task.
- `/math <id>`, `ma <id>` or a Math Academy URL: teach that topic.
- `log it` or `make the note`: write the topic note now (section 5).

Keep the start fast. Don't read memory files or search past chats before
acting; the notes lookup (section 2) is the only one. Load the browser
tools in one ToolSearch call, not one at a time.

**Always use the `www.` host.** `https://mathacademy.com/...` without `www`
shows the user as logged out ("session expired" or the login page) even
when they are signed in. Rewrite any Math Academy URL to
`https://www.mathacademy.com/...` before opening it. If a page shows a login
prompt, check the host first. If it really is logged out on `www`, ask them
to sign in themselves; never enter credentials.

## Message layout: text before a tool call can be invisible

In Claude Desktop, prose written before a tool call in the same turn
(including a visual's call) gets folded into the collapsed "Used the
browser" summary, and the user never sees it. This once hid an entire
lesson intro. So:

- Do all reading, the notes lookup and any visual first. Write no teaching
  text before them.
- If there is a visual, make it the **last** tool call, then write all
  teaching text after it, in the final message. Refer to it as "above".
- Short status lines between tool calls ("Reading it in a separate tab")
  don't matter either way; nothing they need goes there.

**White space.** Short paragraphs, one idea each, a blank line between.
No dense blocks. LaTeX for all math.

## Lessons, reviews and quizzes

The task type is in their tab's URL: `/tasks/<n>/topics/<id>/lesson`,
`.../review`, or a quiz.

- **Lesson:** teach (sections 1 to 4), then write the note (5).
- **Review:** they do it cold by default. If they say they're fuzzy,
  blanked, or never had the intuition (MA's own "review topic to brush up"
  button is the same cue, so re-teaching is within its design), run the
  same loop, scaled to the gap: the one idea and the specific piece they
  lost, a couple of minutes. Then write or update the topic note with a
  dated line saying what was fuzzy and what fixed it. These lines are the
  best evidence for faded prerequisites and for Anki.
- **Quiz:** stay out completely while it's open. Quizzes are MA's test of
  true memory: no reading the page, no hints, no teaching the topic. After
  they submit, debrief any misses (below).

## 1. Read the topic page (silently)

Always read the topic view, not the lesson or review view. The topic view
is `https://www.mathacademy.com/topics/<id>`, which has the whole lesson on
one page, the prerequisite list, and no graded questions.

**Never navigate the tab they're working in.** Their lesson or review tab
holds their place in a graded task. To read the topic view:

1. Find their tab with `tabs_context`, then its URL via `javascript_tool`
   (`location.href`). Take the topic id and task type from the URL. If no
   Math Academy tab is open anywhere, do `open ma` and wait.
2. Open a **new** tab with `tabs_create`, check that its tabId differs from
   their tab's, then `navigate` that new tab to the topic view. Never
   `navigate` without a tabId while their task tab is open: it can replace
   the page they're on.
3. Run the extraction script below with `javascript_tool` on the new tab.
   Formulas come back as `$...$` / `$$...$$`, graphs as `[GRAPH]`.
   `get_page_text` is useless here: it drops every formula.
4. Collect prerequisite ids on the same tab:
   `[...document.querySelectorAll('a[href*="/topics/"]')].map(a => a.href + ' ' + a.textContent.trim())`.
   The prerequisite section links each one.
5. If a section comes back with blank math (it happens), screenshot that
   section instead. A graph only needs a screenshot if the teaching turns
   on it.
6. When done, close the topic tab (`tabs_close`) and make sure their task
   tab is fronted again.

```js
(() => {
  const root = document.body.cloneNode(true);
  root.querySelectorAll('script,style,#mathjaxCommands').forEach(e => e.remove());
  root.querySelectorAll('.mjpage').forEach(sp => {
    const t = sp.querySelector('title');
    const tex = t ? t.textContent.trim() : '';
    const block = sp.classList.contains('mjpage__block');
    sp.replaceWith(document.createTextNode(block ? '\n$$' + tex + '$$\n' : '$' + tex + '$'));
  });
  root.querySelectorAll('img').forEach(i => {
    if (i.src.includes('/graphics/')) i.replaceWith(document.createTextNode('\n[GRAPH]\n'));
  });
  const holder = document.createElement('div');
  holder.style.cssText = 'position:absolute;left:-99999px;top:0;width:800px';
  holder.appendChild(root);
  document.documentElement.appendChild(holder);
  const text = holder.innerText;
  holder.remove();
  return location.href + '\n' + text.replace(/\n{3,}/g, '\n\n');
})()
```

(The page renders math as MathJax SVGs whose `<title>` holds the TeX source;
the script swaps each one for its TeX.)

Use the read for: scope and notation (teach in their notation so the
problems match); the problem variants in the worked examples; the
prerequisite list; what they assert without justifying; and what they
assume the user remembers from other topics (exact trig values, log laws).

The course's unit map is on its progress page
(`https://www.mathacademy.com/courses/<course id>/progress`). Open it only
when the unit position isn't obvious from the prerequisites and notes.

Prefer inline visuals (charts, diagrams, interactive widgets that render
in the chat) over published artifacts, which can open in a side panel and
cover the browser.

**Rules.** Never answer or help with MA's graded questions (lesson
questions, reviews, quizzes); their scheduling depends on unaided answers.
Don't click anything on a lesson, review or quiz page. Read the topic page
they're on and, when a prerequisite has no note, that prerequisite's topic
page; no crawling beyond that.

## 2. Read the prerequisite notes

Skip this section if there's no notes folder; ask instead (below).

Topic notes are plain markdown files in the user's notes folder, one per
MA topic, with `ma: <id>` in the frontmatter. Request access to the folder
if it isn't granted (one request covers the session), then for each
prerequisite id from step 1.4, and for the current topic's own id:

```sh
cd <notes folder> && grep -rl '^ma: <id>$' --include='*.md' .
```

Read every hit in full. If the user already keeps a general note on the
same concept (`grep -ril '^title: <name>$'`), that note is the one to
extend later rather than duplicating.

The hits tell you what framing landed, in whose words, what they blanked
on and when. That is what "where it fits" and any recall check are built
from. A prerequisite with no note predates this workflow: read its MA
topic page (one page, same extraction) so you know what it assumed, and
say you have no history on it.

**Without a notes folder:** there's no history, so for a topic that leans
on prerequisites, ask one line ("how solid is <prereq>?") instead of
guessing, and suggest once, briefly, that a notes folder would let this
carry over between sessions.

## 3. Build the lesson: floor plus earned components

There is no taxonomy and no template; labeling a topic and filling the
matching template produces ceremony around thin content. Two questions
decide everything:

1. What does MA leave out here? (Often nothing. Sometimes the why.)
2. What do the prerequisite notes (or the user) say about their state?

**The floor, always:** MA's own intro at its tightest, in Claude's words,
improved where it can be. For a definition-plus-procedure topic that is
three lines; where MA's intro is longer and good, it may be six. Plus the
one trap, and any value from another topic the problems will assume. Then
"go do the problems." Many topics get exactly this and nothing more; that
is the correct output, not a failure to teach.

**Components, each added only when its gate fires, and only as much as the
gate justifies.** Name to yourself what each one fixes before adding it.

- *Mechanism.* MA states a result without a why, and the why is something
  they'd use again. Give the single idea the rules fall out of, concrete
  case first, then general. Reuse framings that have landed (check the
  notes first). Examples of the kind of framing meant: logs as unit
  conversion; a log graph is an exponential with coordinates swapped; a
  root is the inverse of a power, so it accepts what the power can output;
  $\frac{1}{2}ab\sin C$ is base times height with the height $b \sin C$;
  the sign of a trig ratio is the sign of the coordinate in that quadrant.
  Never a list of rules. Not for definitions.
- *Recall check.* A prerequisite note says it was shaky or blanked, or the
  prerequisite is more than a few weeks old. One question per such
  prerequisite, before anything else. If one has faded, that becomes the
  lesson, because the next several topics assume it too.
- *Anchor method.* Several rules collapse to two or three invariants (log
  transformations: inside $= 0$ gives the asymptote, inside $= 1$ gives
  $y = 0$, inside $=$ base gives $y = 1$). Give the invariants and solve
  from them instead of re-walking the rules. "What's invariant here?" is
  the general move.
- *Picture.* The idea has one and they don't already have it (reference
  angles, the unit circle, transformations, inverses as reflections,
  asymptotes, vectors, domain and range, geometry). Interactive only when
  the point is to move something; otherwise static. Never for algebraic or
  definitional topics.
- *Where it fits.* One line, only when the notes or the course map show a
  connection that isn't obvious. Never "this is a stepping stone."
- *Rebuild move.* The problems need a value from another topic (like
  $\sin 120° = \frac{\sqrt{3}}{2}$). Show how to rebuild it in seconds
  (unit-circle mirroring, the half-equilateral triangle) rather than
  stating it.
- *One aimed question.* One prediction question at the edge where the
  confusion lives (is the asymptote a point or a limit; which
  transformations can move a domain), when there is a mechanism. Not a
  quiz sequence.

Style: mechanistic understanding over memorization. The user drives;
Claude supplies the one idea and aims the questions. Short turns: ask more
than tell, and end each message with something for them to do. When they
explain it back, check it precisely; the imprecise word is usually where
the gap is. When they reason their way to a right answer, say what they
did right, briefly.

Stop when they have it. Past about 15 minutes the back-and-forth costs
more than it adds; the rest comes from doing problems.

## 4. Problem prep and go

Two or three lines: the variants their worked examples cover, the one trap
(sign flip, order of transformations, off-by-one, bracket type in interval
notation, common denominator in radians), and the look-alike topic this
gets confused with. Don't redo worked examples. One problem of Claude's
own only when it goes a step past their examples and their understanding
seems shaky.

Then tell them to click through MA's explanation without reading it and go
straight to the questions; the only thing worth a glance is their answer
format. End with the Anki verdict (section 6).

## 5. Write the topic note (at "go")

Skip this section if there's no notes folder.

Write the note **after** the back-and-forth, at the moment you send them
to the problems, so it captures what actually landed rather than what was
planned. Also on "log it". If the folder already has conventions (file
naming, frontmatter, link style), match them; otherwise use
`<topic-name-slug>.md` and the template below.

Create (new topic):

```markdown
---
title: <ma topic name, lowercase>
date: <today>
ma: <id>
---

prereqs: <prereq title> (<prereq note filename, or "no note yet">), ...

- <the idea, one or two bullets; the user's phrasing when they explained
  it back, marked "(their words)", otherwise Claude's>
- <the test or procedure the problems need>
- <the trap>
- kind: <definition / extension / mechanism / stacked>. <what MA gave vs
  what was added, one line>
- <date> lesson. anki: <verdict>
```

Update (existing note; review, debrief, second pass): append dated bullets
at the end, never rewrite earlier ones:

- `- <date> review: fuzzy on <what>; fixed by <framing>`
- `- <date> missed <question type>: <idea that broke>`

If a general note on the same concept already exists, add `ma: <id>` to it
and append the bullets there instead of creating a new file.

## 6. Anki verdict

One line at the end: **covered / deep / index / skip**, with the reason.
Default is skip; Anki is not a checklist item. Tests:

- Will later topics build inside it (deep) or merely use it (index)?
- Is it a "why" they can't rebuild in five seconds?
- Is it a distinction that's easy to confuse with a neighbor?
- Did they blank on it in a review, or have to look it up mid-problem? The
  topic note's dated review lines are the record; two fuzzy lines bias up.

Formulas they can rederive fail. The rules of an extension fail. The
mechanism, the anchor method, or the rebuild move for a value they keep
looking up passes. "Covered" means a card for it already exists.

### Drafting cards

Only if cards are warranted (or they ask). If the user has their own card
setup (an Anki skill, a card file, an Anki connector), follow it and check
it for existing coverage first. Otherwise draft from this conversation's
framings and the user's own phrasings, and hand them over as text they can
import or paste: one card per line, `front<TAB>back` for basic cards, or
`{{c1::...}}` cloze text, in a code block. Deep topics get several cards;
index topics one to three. Don't add them to Anki yourself unless asked.

The quality bar is Andy Matuschak's "How to write good prompts"
(<https://andymatuschak.org/prompts/>). The parts that matter most for
math:

- **Pair a fact or formula with a why card** ("$\log_b 1 =$?" → $0$;
  sibling: "Why is $\log_b 1 = 0$?" → "$b^0 = 1$"), unless it can be
  rederived in five seconds, in which case it may not need a card at all.
- **Cloze the operative piece, not the whole formula.** The point of a
  log-law card is the $+$. Keep clozes outside `\( \)` math, or wrap a
  whole math unit; a cloze inside math breaks MathJax.
- **Concepts need several lenses, not a definition card:** what's always
  true of it, how it differs from its neighbor, why it works, what it does.
- **Never a numbered step-list card for a procedure.** Card the key move,
  the condition for using it, and why it works, each separately. A
  recognition card ("what kind of problem is this?" → the move) is often
  the most useful one.
- **For values they keep looking up, card the rebuild move, not the
  value.**

Pre-flight check for every card:

1. Does it ask for exactly one thing?
2. Is there exactly one right answer, in a stated form?
3. Will they have to retrieve it, rather than infer it from the question?
4. Is it short enough that it can't be answered by its shape?
5. Is it open-ended (not yes/no)?
6. If it's a fact or formula, does it have a why sibling (or is it
   trivial)?
7. If it's a procedure, is it the key move / condition / why, not a list?
8. For a concept, do the cards together cover more than one lens?
9. Is the answer terse, and in the user's words where they had them?

## Post-miss debrief

If they come back with a question they got wrong (lesson, review or quiz,
after they've submitted): have them paste or describe the question, their
answer and MA's explanation, or read the page if they've already answered.
Find which idea broke, not which step, connect it back to the mechanism,
and check whether it's a faded prerequisite (look up its note). If the
same idea breaks twice, bias the Anki verdict up. Debriefs count for the
picture gate too: if the miss is about a graph, domain or range, draw it.
Append a dated miss line to the topic note.
