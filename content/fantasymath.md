---
title: Fantasy Math Writeup — Nathan Braun
type: page
---

# Fantasy Math
Fantasy Math is my active site for weekly start-sit Fantasy Football advice.
Subscribers enter in their matchup info and the players they're deciding
between, and get back optimal player and the probability they win.

Many sites (Yahoo, ESPN, Fleaflicker) give team win probabilities, but — as
far as I know — Fantasy Math is the only one modeling player projections as
explicit probability distributions.

## Projections as Probability Distributions
The fundamental problem in fantasy football isn't maximizing your expected
points, but maximizing the probability you score more than whoever you're
playing that week.

Projecting distributions for a player's score (as opposed to point estimates or
rankings) helps in two ways. It lets you take into account:

1. **Variance**, how boom-or-bust a player is (1).
2. **Correlation**, the tendency of players' scores to move together(2).

Both can account for scenarios where starting the guy who's ranked *higher* (i.e.
gets the most points on average) isn't necessarily the guy who *maximizes the
probability of winning*.

I'm obviously biased, but because it takes correlations and player variance
into account, I think Fantasy Math is the best start-sit advice you can get.

## The Second Best "Who Do I Start Advice" You Can Get
It's easier to understand why Fantasy Math is the best start-sit advice you can
get by considering the *second* best start-sit advice you can get.

Fantasy Pros [Expert Consensus
Rankings](https://www.fantasypros.com/nfl/rankings/consensus-cheatsheets.php).

I have an economics background, and I've always been a big believer in
efficient markets and the wisdom of crowds. I draft by [selecting the biggest
bargain according to
ADP](https://lifehacker.com/use-the-wisdom-of-crowds-to-draft-the-best-fantasy-foot-1617837803.), and my investments are in index funds.

ECR is clearly the fantasy football equivalent of all that. And so if the goal
is maximizing point totals, efficient markets would suggest — just as index
funds beat stock picking —  that's the best most of us (even experts) can
expect to do.

Fantasy Math is essentially ECR with correlations and player variance added on
top. Because the goal in fantasy is beat your opponent rather than maximizing
your total points, this gives Fantasy Math a slight edge.

## The Fantasy Math Edge
While real, I think the Fantasy Math edge is small.

The main reason is that optimal start-sit decisions are mainly driven by the
scale parameter (i.e. start the guy whose distribution is furthest to the
right), which traditional rankings and point estimates get at fine(3).
Correlations and shape (aka variance aka boom or bust) are secondary.

I'm not even sure — compared to just using
[ECR](https://www.fantasypros.com/nfl/rankings/consensus-cheatsheets.php) or
[Boris Chen](https://www.borischen.com) (also based off of ECR) — the impact on
expected wins/share of league winnings is worth what I charge, just as a pure
expected value calculation. Probably depends on your entry fee.

But some people won't rest until they've uncovered every possible edge, and
Fantasy Math is for them.

## How It Works
The are two parts to making the model: (1) fitting the distributions, and (2)
figuring out the historical correlations between same and opposing QB, RB1,
RB2, WR1-WR3, TE, K, DST.

I did (1) by fitting a Gamma distribution (both the scale and shape parameters)
to historical Expert Consensus Rankings (via the weekly mean and standard
deviation). For (2) it's just a giant correlation matrix.

Then I can use (2) to take generate random, uniformly distributed sets of
numbers with the appropriate correlation. Then I feed those correlated 0-1
pairs through the Gamma distribution and end up with correlated simulations.

Then when someone puts in their matchup info on Fantasy Math, it queries all
those simulations, figures out the percentage of time they win, and returns it.

## Technology and Stack
The modeling is done using the Python data stack, and the API is in flask.

I did the  first version of the front end in React using HP's Grommet framework.
This worked OK, but doing this on the side, I wasn't constantly doing front end
programming and didn't look at it much in the offseason.

When I went to pick it back up and wanted to make a few tweaks, I found that
a bunch of the React API and frameworks I had been using were out of date.
Around the same time I saw an [article on
Elm](https://blog.realkinetic.com/elm-changed-my-mind-about-unpopular-languages-190a23f4a834), and started playing round with
that.

I liked it enough that — when I had hernia surgery and had to lay around for a
week — I took the opportunity to recode the entire site in Elm, which is what
it's been the past two season.

I like Elm a lot and might do a separate writeup on it at some point. I do
sometimes wonder whether it's [not boring
enough](http://boringtechnology.club/) though.

## Challenges
### Traction
Fantasy Math hasn't seen wide adoption and remains fairly unknown. I think there
are a couple reasons:

- The fantasy space is very noisy and competitive, with plenty of quality free material.
- I'm a lot better at building models than I am marketing them (working on this).
- It's a challenge to concisely and effectively convey how the model works and why it's good.
- People are interested in buying WDIS fantasy advice for a few weeks out of the year, which makes it difficult to design and test marketing strategies.

### Modeling
One of big drawbacks to Bayesian Fantasy Football was fixed shape parameter
didn't allow for boom/bust guys. That's more flexible in Fantasy Math, but not
to the extent I would like. This is one of the reasons I'm redoing the
distribution fitting using more advanced techniques.

### UX
I want the site to work better on mobile. Ideally people would be able to
import roster and matchup information too.

### Pricing
I'm not sure on pricing. While I'd love for it to be reasonably priced and
widely adopted, that's not happening currently. I like running the site and
have learned a lot doing it, but now that I'm out on my own I may need to focus
on things that are profitable.

It's possible the only way that'll happen with Fantasy Math is if I jack up the
price and focus on the much smaller set of users who recognize the value.
They're out there (I've had people write saying they'd pay hundreds of dollars
for it), and one of my goals this offseason is to figure out whether it makes
sense to focus solely on them.

----

### Footnotes
1 — Say you're down by 45 points going into a Monday night CLE-HOU game, would
you rather start Will Fuller or Jarvis Landry? What if you were down 10 points?

2 — Imagine you have a close call — say Tyler Lockett vs Stefon Diggs — and
your opponent is starting Russel Wilson. The fact Wilson and Lockett's points
are positively correlated (about 0.44) might affect your optimal decision.
  
Precisely HOW it affects your decision depends on the rest of your matchup:
    
- if you're heavily favored, the correlation might mean you should start Lockett as a hedge against Wilson blowing up
- if you're the underdog, maybe you need Wilson to underperform AND Diggs do really well, and so Diggs maximizes your probably of winning

By modeling performance as correlated distributions, FM takes this into
account.  And not only this, but every pair of simultaneous correlations (e.g.
the Lockett and Wilson are correlated, but they're also both correlated with
Chris Carson and the QB Seattle is playing against) — between same and opposing
QB, RB, WR, TE, K, DST.

3 — No matter what the correlations are, Fantasy Math is never going to tell
you to bench Christian McCaffrey.

