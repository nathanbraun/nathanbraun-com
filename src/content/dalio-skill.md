---
title: Ray Dalio's 5 Step Process to Get What You Want Out of Life - Skill
type: page
description: "Ray Dalio's 5 Step Process to Get What You Want Out of Life - Skill"
rss: true
date: "2026-10-02"
---

# Ray Dalio's 5 Step Process Skill

I've [other places](designer-vs-worker) I'm a big fan of Ray Dalio and his book [Principles](books/principles).

Among other things, I like his **Five Step Process to get what you want out of
life**:

1. Have clear goals.
2. Identify, don’t tolerate problems that stand in the way.
3. Accurately diagnose problems to get at root cause.
4. Design plans that will get you around then.
5. Do what’s nec to push designs through to results.

I've gone through the process explicitely a few times in my life, notably when
my goal was to work for myself -- which led directly to my Learn to Code with
Sports books and business -- and again recently to figure out what to do next
after AI killed said books and business.

I recently created a Claude skill to work through it iteratively. You can find
it here: 

[https://nathanbraun.com/dalio-skill.md](https://nathanbraun.com/dalio-skill.md)

To do it: I gave claude the full 5 step chapter and my notes on it, and had it
create it with some back and forth.

Highlights:

```
Core Philosophy: Radical Truth and Transparency (RTT). Be honest and direct
throughout. ... Don't push back just to be contrarian, but don't let things
slide to be polite either. The goal is to help the user see reality clearly
so they can deal with it effectively.

Key RTT principles:
- Point out things the user may have missed or isn't considering
- Challenge diagnoses that seem surface-level
- Distinguish what the user *wants* to be true from what *is* true
- Be direct but not combative. The tone is "trusted advisor," not "debate
  opponent"
```

One thing I tweaked: in Principles, it seems like Dalio tends to push/dig deeper
on problems until he ultimately comes to some character flaw ("The root cause of
this problem is I am forgetful").

That's an option here, I left it open for something more structural too:

```
Root causes can be traits or structure.

Dalio frames outcomes as produced by a *machine* made of design and people.
A root cause can be a trait of a person (a tendency, a blind spot, a skill
gap) or a property of the design (no forcing function, isolation, wrong
incentives, a missing feedback loop).

Don't push every "why?" chain until it ends in a character flaw. Push
until it ends in something that, if changed, would change the outcome.
```

Outputs are a memo (with the goal, problem, root causes, plan, metrics etc) a
cleaned up *transcript* (helpful), and (an optional) integration into a task
system.

E.g. I do Getting Things Done, so it can create projects or update my next
aciton list if applicable.
