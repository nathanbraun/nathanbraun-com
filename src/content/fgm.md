---
title: Fantasy God Mode
type: blog
description: Writeup on fantasygodmode.com
rss: true
date: "2026-10-19"
---

# Fantasy God Mode

## Problem
The problem I was solving:

> "Who is the absolute, squeeze out every edge possible, best guy to start in
> fantasy football this week?" 

This was my own problem (I was never satisfied with existing in-season fantasy
content) but -- unlike the problem I was solving for my books -- it's a much
more crowded space.

## Fantasy God Mode
Fantasy God Mode is an extension of [Fantasy Math](/fantasymath) and [Bayesian
Fantasy Football](/bayesian-fantasy-football) before that.

[https://fantasygodmode.com](https://fantasygodmode.com)

It builds on the same weekly, correlated player probability distributions, but:

1. displays them in your browser (like 'God Mode' in a video game)
2. extends them to provide something similar for the rest of season

The ROS model opens up a bunch of new tools, mainly a trade value and free
agent calculator (both priced in wins).

## Luck vs skill
The new model lets us break past results down into component parts. We can see
how much of performance is due to:

- skill: draft, keepers, trades, FA adds, start-sit
- luck: lineup luck (good/bad weekly draws), drift luck (players getting better
  or worse after you got them), schedule luck (getting lucky with opponents
  having byes etc)

One thing that became immediately clear from this exercise is **luck swamps
skill** -- fantasy is really noisy.

## Is the model good?
One way to evaluate how well the model performs is by applying it to past data
and seeing if anyone was able to beat it.

To do this I grabbed data from the NARFFL: ~130 leagues a season, from
2017-2025, 12 teams in each league.

Although NARFFL members don't play for money, it's competitive. There's
promotion/relegation across all the leagues and a waiting list and lottery to
get in.

I was looking for a 'Warren Buffett' of fantasy, someone who could outperform
the lineup/ROS models consistently and by more than chance. This turned out not
to exist. Claude and I found 40 managers who appeared to beat the model at a
significant level, against the 41 we'd expect to see by pure chance.
Outperforming the model one year had no effect a manger's chances of beating it
in other years.

I sincerely believe Fantasy God Mode is the best thing out there, and am proud
of that given how many smart people are working on similar things for fun.

## Why it doesn't sell

Despite this, sales have been disappointing.

Interestingly, I think the skill vs luck attribution analysis that FGM unlocks
shows us what's going on:

- The edge is real, but tiny. Starting the model's lineup every week (vs what
  the average NARFFLer does) gives ~0.25 wins per season. 
- Fantasy is super noisy; this tiny edge is swamped by randomness. Luck is ~1.5
  wins per season.

There are other market factors too:

- most people don't play for much money, so it's not +EV to pay for a tool
- people create fantasy stuff for fun (this worked well for my books, but isn't
  great for selling a product), so there's a ton of free content

## Where that leaves us

I think Fantasy God Mode is a good solution to a not-that-valuable (from a
business POV) problem. I use it and have a few die-hard users, but that's about
the ceiling for now.
