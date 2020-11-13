---
title: Intermediate Coding with Fantasy Football Writeup — Nathan Braun
type: page
---

# Intermediate Coding with Fantasy Football: A Project Based Guide
Intermediate Coding with Fantasy Football: A Project Based Guide — available
at [fantasycoding.com/next](https://fantasycoding.com/next) — is a follow up
to [Learn to Code with Fantasy Football](ltcwff) I wrote mostly over the Summer
of 2020.

It walks readers (who it assumes already know basic Python and Pandas) through
building three projects:
- Who Do I Start Calculator
- League Analyzer
- Best Ball Projector

All of these projects are built around the Fantasy Math API, access to which
is included in the package (also includes access to the GUI version of Fantasy
Math too).

## Motivation
While the reactions to Learn to Code with Fantasy Football have been
[positive](https://fantasycoding.com/testimonials) and many people have built
[cool](https://twitter.com/HottyMcPlotty/status/1282866113219457025)
[things](https://twitter.com/mfbanalytics/status/1286001348429910016) after
reading it, I had heard from a few people that they weren't quite sure where to
go or what to do next.

In particular LTCWFF didn't go that in depth on the process of developing real
life programs. I figured this was an opportunity to do that.

All three projects are built around GraphQL API access to the newly rebuilt (in
PyMC3) [Fantasy Math](fantasymath) model, which I continue to believe is underrated.

I figured this was an opportunity to expose LTCWFF readers to the Fantasy Math
model, possibly even one they'd be willing to purchase annually.

## Reception
Reception among people who have bought it has been good, there just haven't
been as many buyers as I'd have liked.

One issue is that LTCWFF is pretty comprehensive, and a few former readers I
reached out to about this follow up already considered themselves intermediate
and were lukewarm about the idea ("sounds cool, I'll probably buy it if it's
not too expensive"). So I think it's likely most of an issue of market.

## Reflection
Overall, I'd say this ended up being *not* worth my time to do, but there were
some positives. For one, I ended up hosting the GraphQL API myself (on a
DigitalOcean box) and learned a decent amount about hosting, deploying and dev
op type stuff from doing that.

And now that it's done, it shouldn't be *that* hard to spin up in future years
if I decide to do that.


