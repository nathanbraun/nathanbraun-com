---
title: EU Carbon Market Thesis Writeup
description: thesis
type: page
rss: true
published: "2020-01-01"
---

# Permit Prices in the EU Carbon Market
I got my Masters degree in Applied Economics from Montana State in 2011. For my
[thesis](http://etd.lib.montana.edu/etd/2011/braun/BraunN1211.pdf) I looked at
a minor, surface-level puzzle related to permit prices in the European Union carbon market.

Some background:

- the EU emmissions trading scheme required firms to submit one permit for every ton of carbon they emitted
- there were two types of permits: EU supplied permits (EUAs), and offsets; both allowed firms to emit one ton of carbon
- offsets traded at about a 20% discount to EUAs
- the number of offsets firms could use was capped, however the cap was *not binding in aggregate*

I wanted to explore how the simultaneous EUA-offset price difference and
non-binding cap could persist.

## Transaction Costs & Firm Level Cap
The answer was a combination of transaction costs and the fact the offset cap
applied at the *firm* — not market — level.

This individual level cap was key to resolving the puzzle. Think about it: if
even a single firm (for whatever reason) didn't surrender up to their limit in
offsets, then the cap wasn't binding in aggregate. Firms (over half of them)
didn't, and it wasn't.

The natural next step was to figure out *why* firms weren't using offsets.  To
look at that I modeled each firm's cost function, including a term for
transaction costs. By manipulating the cost function — was able derive some
predictions about when a firm might use offsets and how many they would use. I
was also able to speculate about the nature of these transaction costs.

## Navigating Regulations was Difficult
The takeaway is that navigating the regulatory process — even just getting
ahold of basic information (like the amount of offsets they were allowed to
use) was a real problem.

Firms were more likely to use offsets when they:
- had more emissions (and therefore stood to benefit more financially)
- were in a country with a larger cap (ditto)
- were short (i.e. not allocated enough permits to cover their emissions and as a result had to buy them on the open market)
- and if they had used offsets in the past

When firms did use offsets they almost always used them up to their cap. Or,
what they *believed* was their cap, which wasn't always the same thing.

One example: offset caps were set by country and typically given as a percent,
say 20% for Germany. But that 20% applied to *allocations*, NOT emissions —
that is, firms were allowed to use 0.20\*n permits they initially received, as
opposed to 0.20\*n emissions.  But when I looked through the data, there were
many firms doing it both ways. It was obvious they were confused and no one was
really checking.

There were other, similar examples. Every rule that could plausibly be
misinterpreted had at least some firms misinterpreting it, though they did seem
to be getting better (and more accurate) over time.

Naturally, given what a cluster this seemed, some grad school friends and I
decided the market was ripe for our advice and spent a few weeks calling
companies that hadn't yet used offsets to try to pitch them on it. I might save
that story for another write up, but it largely proved unsuccessful.
