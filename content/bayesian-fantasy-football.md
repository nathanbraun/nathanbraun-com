---
title: Bayesian Fantasy Football Writeup
description: writeup of Bayesian Fantasy Football
type: page
published: "2020-07-15"
rss: true
---

# Bayesian Fantasy Football
Starting in 2013, I sold weekly fantasy projections from a Bayesian model I
built. The model used preseason draft rankings as priors, then incorporated
weekly results for an updated posterior. I ran the site for four seasons before
switching to an improved, non-Bayesian model and relaunching as [Fantasy
Math](https://fantasymath.com) in 2017.

Motivation for site grew out of the (still held) belief that fantasy markets
were mostly efficient, and that — with obvious exceptions for suspended guys
and handcuffs — ADP probably did as well or better than anything else for WDIS
decisions in week 1

But ADP is built on the best knowledge available preseason, and new information
(mainly how guys actually performed) comes in weekly. I wanted a way to
reconcile those prior beliefs with new data, and figured a Bayesian model was
the natural way to do that.

What I did:

- Got historical ADP data from [myfantasyleague.com](https://myfantasyleague.com) and fit it to a Gamma distribution, where ADP and ADP^2 entered linearly into the alpha (scale) parameter and beta (shape) was the same for all players in a given position and scoring system.

- Wrote the Bayesian portion of the model in R with Jags, setting the prior so alpha would start at the ADP-fit model, then update as we added game results.

The model also controlled for home/away, strength of opponent, (via how many
points they had given up to that position the previous 5 weeks), and (roughly)
whether a player was a starter.

I didn't know anything but Stata at the time, which I used to fit the original,
pre-season gamma as a function of ADP portion. I learned R in order to build
the Bayesian piece.

In hindsight, and after revisiting probabilistic and Bayesian models again
recently, I'm not I understood the math and techniques behind what I was doing
that well, but I willed it into existence, and it worked OK.

Even now, I don't think anyone else is projecting performance distributions so
in many ways it was a trailblazer.

## Assumptions and Issues
The model basically assumed players had some fixed, hidden (but approximated
by ADP) and unchanging distribution that we slowly uncovered via weekly draws
over time.

That fit the bill for some (even a lot) of players, but not everyone, and the
biggest problem with the model is it didn't do well on those players. It wasn't
designed to handle large changes in players situation (a handcuff with new
opportunity, a WR who's QB got injured, etc), and in that way probably would
have worked better as a ancillary, supplemental model.

Another problem was the fixed beta parameter of the gamma meant rankings were
monotonic and all dependent on the alpha parameter. This wasn't the end of the
world (everyone else's rankings are like that too), but it meant missing out on
some of the main benefits to projecting distributions, namely the ability to
take into account the boom-bust ness of different players.

## Technology
My front end knowledge was limited at the time, so Bayesian Fantasy Football
was a Wordpress site with one plugin that took care of membership and another
that served csv's as tables.

Every Monday night I'd kick off some code to grab the latest results
(eventually I learned Python to do this it), ran everything through model,
saved a new csv and uploaded it to the site.

As a teaser, I offered the top 5 guys at each position for free, but I'm not
sure that was ever useful to anyone.

## Bayesian Fantasy Football vs Matthew Berry (Moderated by Keith Olbermann)
To complement the paid, weekly in-season advice, I wrote up a free draft
article, where I basically advocated drafting based on ADP, which I made sound
more exciting by calling it drafting according to the wisdom of crowds (1).

In it, I included an analysis of — within any single position — how the
difference between ADP and Matthew Berry (whose was well known and whose
historical rankings happened to be online) was related to end of season points

For example, if Berry had Aaron Rodgers as the 5th best QB, and ADP had him 3,
would that difference (5-3 = 2) be associated with more or less points (via a
basic regression) at the end of the year? In other words, who was better, Berry
or the crowd?

I did it over a couple years (I think three) and positions (four — QB, RB, WR,
TE) and found for most of them the difference was statistically insignificant,
but for the ones that weren't, the crowd beat Berry 4-1.

I got this [article published on
Lifehacker](http://lifehacker.com/use-the-wisdom-of-crowds-to-draft-the-best-fantasy-foot-1617837803),
whose sister site Deadspin had it up for a bit too. That night Berry was on
Keith Olbermann's show on ESPN and Olbermann asked him about it, which was funny
(Berry said he read it, but thought it was silly).

## Bottom Line
I still like the idea of ADP as priors and weekly results as data and think
the Bayesian Fantasy Football model was ahead of its time in a lot of ways.
But it was restrictive enough that, when I developed a better approach (the
current Fantasy Math model), it made sense to scrap it.

### Footnotes
1 — This article was
[well](https://www.reddit.com/r/fantasyfootball/comments/1pvy2t/would_like_to_take_time_to_credit_my_1st_place_72/)-
("changed my perspective on drafting") [recieved](https://www.reddit.com/r/fantasyfootball/comments/3dgfug/last_year_someone_led_me_to_a_great_drafting/) 
("made my draft significantly less stressful... went from last place ... to first") —
and I'd still generally advocate drafting this way.

<comments/>

