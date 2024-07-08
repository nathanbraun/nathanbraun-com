---
title: Keeper + Draft Pick Trade Calculator Writeup
description: writeup of keepertradecalculator.com
type: page
date: "2020-09-22"
rss: true
---

# Keeper Trade Calculator

The Keeper Trade Calculator was a tool I built along with the [Draft Pick
Trade Calculator](pickcalculator) in 2015.

See that write up for more on the method.

The TLDR: use past average auction values (AAV) to see the expected AAV at
each pick, use that.

## Adding in Keepers
Once you do that, adding keepers is a natural extension, just use the player's
average auction value and compare it to the value in draft picks.

Of course, keeping players makes draft picks less valuable (they're
effectively later) but that's easily adjustable. Just have the calculator
effectively move the picks back depending on who's kept. This meant anyone
using the calculator to enter in all the league's keepers.

## Extensions
In my main league we just keep one player and that's it, but I know a lot of
teams lose the pick in the round the keeper was picked in.

In theory, AAV makes it easy to evaluate these trades too, and you could
actually hack the calculator to do decent job at it.

## Caveats
Same as the [Draft Pick Trade Calculator](pickcalculator) version. The biggest
problem is the MFL auction data is so thin. I'd really like to figure out
a good way to get updated, flexible average auction values.

## Tech
This was one of my first projects in React. I hosted it in a $5 droplet on
Digital Ocean using Dokku. In hindsight that was completely unnecessary since
everything was stored client side, but I didn't know much about web
development then.
