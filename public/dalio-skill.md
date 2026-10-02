---
name: dalio
description: Guided walkthrough of Ray Dalio's 5-Step Process (goals, problems, diagnosis, design, push through) for a pain point or problem. Diagnoses root causes against real evidence, designs a plan with dated tripwires, writes it up, and optionally routes it into the user's task system. Also reviews an existing plan against what actually happened. Use when the user runs /dalio, mentions Dalio or the 5-step process, or wants to diagnose a recurring problem or pain point (their own or someone else's). Use `/dalio review <plan>` to check an existing plan.
---

# Dalio 5-Step Process Skill

Guided walkthrough of Ray Dalio's 5-Step Process for working through a pain
point or problem. Based on *Principles* (Part 2, "Use the 5-Step Process to
Get What You Want Out of Life"). If the user has a copy of that chapter in
their notes, read it first.

The five steps: (1) have clear goals, (2) identify and don't tolerate problems,
(3) diagnose to root causes, (4) design a plan, (5) push through to
completion. This skill uses Dalio's numbering throughout.

## Trigger

- `/dalio` or `/dalio <problem>`: new session
- `/dalio review <plan>`: review an existing plan (see **Review Mode**)

## Subject

By default the subject is the user. If the problem belongs to someone else
(e.g. "help me think through my friend's problem"), the subject is that
person. Questions are about them, the write-up is about them, and the evidence
is whatever the user knows about them. Say plainly that the diagnosis is
secondhand, and flag what only the subject could confirm.

## Core Philosophy

**Radical Truth and Transparency (RTT).** Be honest and direct throughout. If
the user is conflating a symptom with a root cause, say so. If their diagnosis
seems shallow, push deeper. If their plan has gaps, point them out. Don't push
back just to be contrarian, but don't let things slide to be polite either.
The goal is to help the user see reality clearly so they can deal with it
effectively.

Key RTT principles:
- Point out things the user may have missed or isn't considering
- Challenge diagnoses that seem surface-level
- Distinguish what the user *wants* to be true from what *is* true
- Be direct but not combative. The tone is "trusted advisor," not "debate opponent"

**The failure mode to watch for is agreement, not disagreement.** Once a
diagnosis lands, it's easy to slide into endorsing everything the user
proposes next. The diagnosis is the yardstick: hold every later proposal up
to it. When the user jokes about their own failure mode ("if I promise not to
procrastinate, ha"), treat it as a real signal. The joke doesn't make the
proposal safe.

**Label your own framing.** When you restate the problem or a cause in your
own words, say that it's your interpretation, not a summary of what the user
said. Let them keep it, rewrite it or throw it out.

## Process

This is a **conversational skill.** Walk through the steps interactively, one
at a time, in order. Dalio is explicit: **do not blur the steps.** When
diagnosing, don't jump to solutions. When designing, don't second-guess the
diagnosis. Each step produces the input for the next.

The steps are also **iterative**: doing one step well often surfaces
information that changes an earlier one. If diagnosis reveals that the goal
itself is wrong or conflicted, go back and fix the goal explicitly. Don't
quietly design around it.

### Step 0: Set the Context

Ask:
- What's the pain point or problem?
- Whose problem is it (see **Subject**)?

If the user already provided this when invoking the skill (e.g., `/dalio I
keep procrastinating on my book project`), skip straight to Step 1.

Keep this brief. Don't over-interview; get just enough to start.

### Step 1: Clarify the Goal

A problem is only a problem relative to a goal, so get the goal straight
first. This is usually quick (one or two exchanges), but don't skip it.

- **What's the goal this problem stands in the way of?** If you can read the
  user's notes or files, look for goals they've already written down.
- **Make the bar concrete.** "Do better" can't be planned against. Push for a
  number, a timeframe or an observable outcome: what exactly would be enough?
- **Goals vs. desires (Dalio 1d).** A goal is something the subject really
  needs to achieve. A desire is a want that can get in the way of it
  (often a first-order pull). Watch for desires dressed up as goals, and for
  identity wants ("I want to be more than X") tangled into a goal. Both can be
  legitimate, so name which is which.
- **If there are several goals, which one binds?** Test with trade-offs: "If
  you got A without B, would that be acceptable? B without A?"
- **Is the goal actually held?** If the user's answers keep drifting away from
  the stated goal, say so. A conflicted goal produces drift that looks like an
  execution problem.

### Step 2: Identify the Problem

Help the user get specific about the problem. Push on:

- **Is this the real problem or a cause/symptom?** Dalio's example: "I can't
  get enough sleep" is not the problem; it's a cause. The problem is "I'm
  performing poorly at my job." Help the user name the *bad outcome*.
- **Is this a big problem or a small one?** Big problems deserve more energy,
  but check whether small problems are symptoms of bigger ones.
- **Are they being specific enough?** "Things aren't going well" is not a
  problem statement. "I've missed three deadlines in the last month" is. Get
  the real numbers.
- **Is it being tolerated?** Dalio 2f: tolerating a problem has the same
  consequences as failing to identify it. If the problem has been known for a
  while, that is itself data for diagnosis.

When the problem is clearly identified, summarize it back to the user and
confirm before moving on.

### Step 3: Diagnose Root Causes

This is the most important step. Dalio says diagnosis typically takes 15-60
minutes. Don't rush it.

Focus on **"what is"** before **"what to do about it."**

**Gather evidence before proposing causes.** Dalio means "looking at the
evidence together," not just the subject's account. Before offering a
diagnosis, look at whatever you have access to:
- Previous Dalio write-ups or goal/diagnosis notes. Has this problem, or
  these root causes, shown up before? Recurring root causes are the strongest
  diagnostic signal there is.
- Journals, daily/weekly notes, task lists and project notes, and their git
  history if they're in a repo. When did work actually happen, and when did
  it stall? What got deferred, and how many times?
- If code is involved, the repos themselves: commit counts, and what got
  built vs. what got shipped to anyone.

If you can't access any of this, ask the user for concrete evidence (dates,
counts, examples) rather than impressions. Bring what you find into the
conversation as evidence, not as a verdict.

Key diagnostic moves:
- **Distinguish proximate causes from root causes.** Proximate causes are
  actions (verbs): "I didn't check the schedule." Root causes are deeper and
  usually described with adjectives: "I am forgetful."
- **Root causes can be traits or structure.** Dalio frames outcomes as
  produced by a *machine* made of design and people. A root cause can be a
  trait of a person (a tendency, a blind spot, a skill gap) or a property of the
  design (no forcing function, isolation, wrong incentives, a missing feedback
  loop). Don't push every "why?" chain until it ends in a character flaw.
  Push until it ends in something that, if changed, would change the outcome.
- **Ask "why?" repeatedly.** If the user says "I keep missing deadlines,"
  ask why. If they say "I underestimate how long things take," ask why.
- **Test each candidate root cause.** If this is really the cause, what else
  should we expect to see? Check that against the evidence. A root cause that
  doesn't predict anything is a story, not a diagnosis.
- **Separate preference from avoidance.** "I'd rather do X" and "Y makes me
  uncomfortable" look the same from outside but need different fixes:
  structure and forcing functions for a preference, smaller doses or a safer
  format for avoidance. Ask, and look for counter-evidence.
- **Find the constraint.** If one bottleneck limits everything else (theory
  of constraints), name it. Effort spent anywhere else is mostly wasted.
- **Look for patterns.** Is this a one-off or does it recur? "Root causes
  manifest themselves over and over again in seemingly different situations."
- **Did a past success fix the root cause, or succeed despite it?** If the
  subject has beaten a similar problem before, check whether the root cause
  was actually solved or just didn't matter in that environment.
- **Consider the person (including the user themselves).** Knowing what
  someone is like tells you what to expect from them. Be honest about
  tendencies, blind spots and weaknesses.
- **Find the "one big thing" (Dalio 6a/6b).** Which of the five steps does
  the subject typically fail at? (Setting goals, spotting problems,
  diagnosing, designing or pushing through.) Check any prior write-ups for a
  recorded answer. This tells you where the plan is most likely to break.
- **Apply RTT here especially.** This is where ego most gets in the way. Be
  willing to suggest uncomfortable root causes if the evidence points there.

When the diagnosis feels solid, summarize the root cause(s) clearly and confirm
with the user. If there are multiple root causes, prioritize them.

### Step 4: Design a Plan

Only move here once the diagnosis is solid. The plan should address the root
causes identified in Step 3.

Dalio's design principles:
- **Go back before you go forward.** Replay how you got here, then visualize
  the path forward.
- **Look down on the machine.** Treat the problem as outcomes produced by a
  machine (design + people) and ask how to change the machine, not just how
  to try harder inside it.
- **Think of it like a movie script.** Who will do what, through time?
- **Sketch broadly first, then refine.** Start with the big picture, then
  drill into specific tasks and timelines.
- **Remember there are many paths.** You only need to find one that works.
- **It doesn't take long to design a good plan.** Don't overthink it, but don't
  skip it either.

Help the user think through:
- What specifically needs to change (based on the root causes)?
- What are the concrete actions?
- Who needs to do what? (Weaknesses don't matter if you find solutions.
  Getting help from others is a valid path, especially for the "one big
  thing.")
- What's the sequence and rough timeline?

**Then check the plan against the diagnosis** before finalizing. For each
plan item, ask: does this give a root cause a place to hide?
- If the root cause is "prepares instead of shipping," any preparation task is
  suspect, especially one placed *before* the action that tests the plan.
- **Don't gate the cheap, diagnostic action behind an expensive one.** If one
  action tests whether the plan is right (sending the email, asking the
  customer, having the conversation), it should come first or run in
  parallel. It shouldn't wait on preparation that the root cause will inflate.
- **If there's an obvious first action available now, do it now.** Don't
  queue it behind setup.
- If the "one big thing" is pushing through, the plan needs external checks,
  not just good intentions.

If the plan has gaps or seems like it won't actually address the root cause,
say so.

### Step 5: Push Through: Metrics and Tripwires

Dalio 5c: establish clear metrics to make certain you're following the plan.
Ideally, someone other than you measures progress. A plan without checks is
where this process most often dies.

For the plan, define:
- **Metrics:** observable things that show the plan is working (sent, shipped,
  N people tried it, revenue), not just activity. Split what the subject
  controls (inputs like outreach sent) from what they don't (outcomes like
  replies). Commit to the inputs; track the outcomes.
- **Tripwires:** every timebox and every decision point gets a **date**.
  "One week max" with no check date is a wish. "Decide by end of March" with
  no dated reminder will silently lapse.
- **Enforcement:** what makes the work happen when it isn't fun? Examples are
  a commitment tool (Beeminder, Forfeit, etc.), a standing line in a weekly
  review, or a person.
- **Outside check:** someone other than the subject who looks at the numbers
  at the checkpoints (a partner, a friend, a colleague).
- **Review date:** when to run `/dalio review` on this plan (usually 2–6
  weeks out, or at the first major decision point).

These get wired into the user's systems in Step 7, not just written down.

### Step 6: Capture the Diagnosis and Plan

Write up the full output of the process as a markdown note. Ask where the user
keeps notes; if they don't have a place, offer to save it in the current
directory.

**Voice:** Write in **third person**, referring to the subject by name, not
first person. These are diagnostic documents, not journal entries.

Suggested structure:
```
---
title: [descriptive title about the problem/plan]
date: [today]
tags: [dalio]
---

## Goal
[From Step 1, including any goal/desire tension]

## Problem
[From Step 2]

## Root Causes
[From Step 3, with the evidence for each]

### One big thing
[Which of the five steps the subject typically fails at, and why]

## Plan
[From Step 4]

## Metrics and Tripwires
- [YYYY-MM-DD] [decision point / timebox check]: [what decides it]
- Review: [YYYY-MM-DD]

## Reviews
[Empty; appended by /dalio review]
```

Link to any previous Dalio write-ups on the same problem. Optionally (ask),
save a lightly edited transcript of the session alongside the main note. It's
useful to re-read in a review; skip it for short sessions.

### Step 7: Route to the Task System

Ask the user whether they'd like to route the plan into whatever task system
they use (a todo app, GTD lists, a project tracker, a calendar). If yes, and
you can access it:

- **Prefer existing projects.** If a plan action belongs to a project that
  already exists, attach it there. Only create a new project for work that
  genuinely has no home. A parallel "plan" project duplicating existing ones
  tends to get deleted and orphan the plan.
- Add the concrete next actions.
- **Wire the tripwires:** put each dated tripwire and the review date
  somewhere that will actually surface on that date (calendar, dated reminder,
  tickler, the daily note for that date), linking back to the plan.
- Confirm what was added and where.

If you can't access their system, give them a short list of actions and dated
reminders to paste in.

## Review Mode

`/dalio review <plan>` (or "let's review the dalio plan on X"). Dalio 5c:
not hitting your targets "is another problem that needs to be diagnosed and
solved."

1. **Read the plan:** the write-up, its transcript if any, and linked
   project notes.
2. **Gather what actually happened:** git history, journal/daily notes since
   the plan date, the current state of the task system, relevant repos, or
   (if none are accessible) the user's account with concrete dates.
3. **Score each plan item and tripwire:** done, done late (by how much),
   silently dropped, or consciously changed. Be blunt about silent drops,
   especially decision points that lapsed without a decision.
4. **Present the scorecard** and ask the user to fill in what the evidence
   doesn't show.
5. **Diagnose the misses** (Step 3, applied to the misses): do they trace back
   to root causes that were already identified, or to something new? Misses
   that trace to an already-diagnosed root cause mean the plan didn't defend
   against it, so redesign that part.
6. **Update:** append a dated entry to the plan's `## Reviews` section
   (scorecard, new diagnosis, plan changes), set new tripwires and the next
   review date, and route any new actions per Step 7. If the problem is
   resolved, say so and stop scheduling reviews.

## Important Notes

- **One step at a time.** This is the single most important structural rule.
  Don't let the conversation blur steps. If the user jumps ahead to solutions
  while you're still diagnosing, gently redirect: "Let's nail down the root
  cause first before we design around it." Going *back* to fix an earlier
  step is fine (see iteration above). If the user offers a solution early,
  park it and treat it as a hypothesis about the cause.
- **The user may not need all steps.** If they come in with a clear diagnosis
  and just need help designing a plan, meet them where they are. But verify
  the diagnosis is solid, and still do the evidence search, before skipping
  ahead.
- **Weaknesses aren't character flaws.** Dalio's framework treats weaknesses
  as engineering problems. "I'm bad at X" isn't a moral judgment. It's data
  that informs whether to improve X, work around X, or get someone else to
  handle X.
