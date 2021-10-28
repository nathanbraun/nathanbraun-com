---
title: A Simple Explanation of the Monty Hall Problem
type: blog
description: A Simple Explanation of the Monty Hall Problem
rss: true
published: "2021-02-01"
---

# A Simple Explanation of the Monty Hall Problem
## Background
The Monty Hall problem — based off of the TV Show "Let's Make a Deal" and named
after the original host, Monty Hall — is a notorious problem in statistics.

### Problem
Monty presents to you three closed doors. Behind one is a prize, behind the
other two are nothing (I think the original formulation says they're goats
— either way, not something you want).

You pick one of the doors.

No matter which you pick, Monty (who knows what's behind every door) opens an
empty door, and offers to let you *switch* your guess to the other, remaining
closed door.

Should you switch? Does it matter?

### Answer, which humans are bad at understanding
You should indeed switch. Your odds of winning are 2/3 if you do, vs 1/3 if
you don't. However, many people find this difficult to grasp at first.

Jeff Kaufman has a [post](https://www.jefftk.com/p/three-doors-problem) where
he talks getting it wrong initially, and how bad humans are at it in general.

> "The person who first showed me this problem failed to convince me that
  I should switch; that took testing it with pennies and cups.  ...

> "Since then, in various conversations with people who were sure switching
  didn't help, I've tried many times to describe how the odds for switching
  can be 2/3. I've come up with many explanations that I think would have
  convinced me, but they don't seem to convince others."

He's not alone:

> "You should switch. However, it is so counterintuitive that I had to write
  a simulation script with 1M iterations... to confirm indeed switching yields
  twice the probability of winning than staying." — [u/creekwise](https://www.reddit.com/r/Bayes/comments/ku100i/the_monty_hall_problem/giqkvd0/?utm_source=reddit&utm_medium=web2x&context=3)

> "I also wrote a simulation script." — [u/Jusque](https://www.reddit.com/r/Bayes/comments/ku100i/the_monty_hall_problem/giqwl50/?utm_source=reddit&utm_medium=web2x&context=3)

## Simple Explanation
Here's the clearest way I've found to think about it.

Say you always switch. Now there are two outcomes:

You originally pick one of the two dud doors (2/3 chance). Then Monty will open
the *other* dud (he has to, the only other option is the prize door and he
can't open that) and so if you switch to the unopened door, you'll win.

You originally pick the prize (1/3 chance). Monty will open one of the two
duds, you'll switch to the other, unopened dud. You won't win.

So: 2/3 of winning if you switch. Don't switch, it all depends on whether you
pick the prize initially, which you'll do 1/3 of the time.
