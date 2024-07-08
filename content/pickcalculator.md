---
title: Draft Pick Trade Calculator Writeup — Nathan Braun 
description: draft pick trade calculator
type: page
date: "2020-01-01"
---

# Draft Pick Trade Calculator

The Draft Pick Trade Calculator  was a tool a built in 2015 in order to (1)
help me with pre-draft pick trades and (2) learn React.

I still think the method behind it is theoretically sound and I might dust it
off again someday, although there were a few issues I'd want to sort out.

## Putting a Value on Each Pick
Pretend you're in an auction league — think of how much of an advantage would
it be to start with $250 when everyone else has $200. All else equal, you'd
likely be the favorite heading into the season, no?

Or consider a head-to-head match up between two teams, one with a starting line
up of players who go (on average) for $137, the other $97. You'd expect the
team with more value would win more often, right?

In a nutshell, this is how the pick calculator worked. Estimating the value of
draft picks is easy, all you need to do is think about the value of the player
you'll be able to pick there. Estimating the value of players is easy too, we
have the perfect metric in Average Auction Values (AAV).

AAV is a great proxy for the value of each pick for the same reason that index
funds are good investments. Efficient markets. Average Auction Values are
prices. They have everything we need (upside, injury risk, scarcity at
position, etc) baked in.

Valuing picks this way, and making trades that increase it, is a way to
effectively start off your season with a higher budget than anyone else.

## Translating Auction Values to Picks
But how do we actually translate AAV values to picks? On the surface it seems
like we'd just want to sort AAV in descending order (e.g. CMC - $55, Saquon
Barkley - $53, ...), slap those values on picks (1st OVR - $55, 2nd $53, ...) and call it a day.

This is close, but not exactly right.

Instead, we can rely on the fact that — in every individual league — SOME
players will drop. We don't know who these will be ahead of time, but — as
long as we commit to drafting value, whoever it is — we can plan on it and
value our picks accordingly.

The question is then, on average, what AAV can we expect at each pick? To
figure this out, I queried the MFL public API for results from more than 6000
auction and snake draft leagues to calculate what type of value we can expect
on average at each pick.

Here are the results:

![Pick Value Curves](images/pick_value.png)

Note the different colored curves denote percentiles. The light blue line
(P50) indicates the midpoint best-player AAV (normalized to a full 12 team,
$200 budget league) you can expect available at any given pick. We can
interpret these lines as varying levels of league competitiveness. For
example, assuming every pick is very near (99 percentile) the best player
available gives us a value chart equal to the dark blue line above.

## League Competitiveness Plays a Role
One thing this chart makes clear is the expected value of a draft pick is based
on how competitive your league is. Early picks are worth relatively more in
competitive leagues.

This is intuitive: the tougher a league, the quicker good players go off the
board, making later picks worth less than they’d be if no one knew what they
were doing and bargains were prevalent.

I thought it was a reasonable assumption that that leagues where draft pick
trading is prevalent are generally more competitive, so the calculator
assigned picks based on the 90% percentile.

## Caveats and Limitations
Following this calculator helps increase the auction value of your *entire
roster*. I've noticed the calculator tends to be more in favor of trading down
that most fantasy players, and I think this is why.

Having a valuable whole roster is a good thing overall, but it's possible it
might lower your probability of winning — especially early in the season — by
effectively recommending you swap high caliber starters for depth. Whether
this helps you in the long depends on how you can turn that depth into
starting lineup power.

In leagues without a lot of trading, it might be more appropriate to judge the
impact in terms of auction amounts on your starting lineup. If I dust this off
I might add in that feature.

I also think the MFL auction value data might be a bit thin. Higher quality
(e.g. recent, with known scoring systems) average auction value data would
make this tool more useful.

## Tech
This was my first project in React. I think I also used Redux. If I were to
revive it today I'd use Elm.
