---
title: BP Oil Spill 
type: blog
description: My role calculating damages due to the BP oil spill
date: "2020-08-12"
rss: true
---

# BP Oil Spill

In April, 2010 the Deepwater Horizon drilling rig exploded off the cost of
Louisiana, starting one of the largest environmental disasters in US history
that ultimately leaked 4.9 million barrels of oil into the Gulf of Mexico.

In 2011, I finished grad school with degree in applied economics, and an
interest and [experience](eu-carbon-market) with environmental problems.

It's not that surprising that I soon started working for an environmental
economics consulting company contracted to the government to (among other
things) quantify the value of the lost recreation on Gulf beaches due to the
spill.

## Trips lost due to the spill
The lost recreation value due to the spill basically came down to:

```
lost value = n of trips forgone * value of each trip
```

I worked mostly on quantifying the number of forgone trips. In theory:

```
trips forgone = trips (no spill) - trips (actual)
```

Both numbers on the right hand side involve varying degrees of guessing.

Take the easier one: number of trips that actually took place. How would you
go about calculating that?

"Ideally", maybe you have turnstiles at the entrance to every single beach in
the gulf, then you can just count up the totals and see. In practice,
obviously that's impossible

Instead we did some standard surveying and sampling techniques, dividing the
gulf into segments and flying a plane up and down the coast multiple times
a week snapping aerial photos. The photos were sent back to company
headquarters, where we had a team that would count the people.

But snapshots only tell you the number of people at any particular moment in
time. To go from that to full trips you need to get some sense of how long
people were there.

For example, if everyone at the beach got there early and stayed all day, then
the n of people in your picture == n of trips. Everyone was just there all
day.

If everyone stayed for exactly (and randomly) half the day, then you'd have to
multiply your snapshot count by 2. You counted the people there during the
time you snapped a picture, but each person at the beach that day only had
a .5 probability of being in the picture.

We got these durations (among other information) from a staff of 100+ people
on the ground conducting interviews.

The result is cascading series of multiplying:

`n people in a photo * 1/average length of time people stayed * 1/(how often you took a picture)`

etc.

And that's just to get the actual number of trips taken post spill, which is
the conceptually easier number. More abstract is the hypothetical: how many
*would* people have taken had there been no spill?

## Estimating the counterfactual
A few possible ways to approximate the number of trips people *would have*
taken if there had been oil spill:

1. Figure out how many people took trips in 2009 (right before the spill).
2. Look at how many people took trips to places not affected by the spill, extrapolate based on that.
3. Figure out how many people took trips after things returned to normal.

All of these have issues. No one had the data for (1) — doing all the counting
and interviewing for actual trips in the aftermath of the spill was very
expensive, and no one had been doing anything like it pre spill.

(2) required good, comprehensive data on how the spatial impacts over time,
which was another effort. Also it was possible more people than usual might be
visiting non-affected sites, which would make the true number harder to
calculate.

That left (3), which had its own issues (How do you know when things have
returned to normal? What if things never did? What if people who hadn't been
taking trips went all at once after things got back to normal, overstating the
"baseline" n of trips lost?)

To deal with that, the government (specifically NOAA, who was in charge)
decided we should continue counting people on the beach until the number of
trips leveled off and stayed that way for a year.

To deal with seasonality inherent in recreation trips to the gulf, that
required two years of sampling after things had returned to normal (a year
longer than strictly necessary) in order to figure out what "normal" was.

## Controlling for weather
Another issue with using later, "back to normal" years as a baseline is
potential uncontrolled for differences in other factors that might effect
trips.

For example, imagine the weather in 2010-2011 (when oil was affecting
recreation trips) was unusually cold. Pretend it was freezing, too cold for
anyone to go to the beach

What would have been the impact of the spill on recreation in that case?
Nothing! If the weather was so bad and cold that people wouldn't have taken
any trips anyway, then the spill didn't actually have any effect on recreation.

Obviously in real life, the weather wasn't that bad, but we had to account for
issues (another one was differences in gas prices between years) like it.

Officially, we did so using some fairly basic statistical techniques
(adjusting broadly for good and bad weather days across years), but — as
a check — we also built a more complicated parametric model that gave us more
fine grained control, I helped design and did all of the coding for that,
which was fun.

## Me and BP
When I got there in the fall of 2011, the data collection effort was well
underway, but we hadn't started turning that raw data into counts of overall
trips, much less trips lost.

My role became programming up all processing, multiplying and adding. I did it
in Stata, which I had used a bit previously, but not that much (I haven't used
it in since ~2013).

Since it was for litigation with a lot stake financially, we had
a subcontractor doing the same weighting-up coding, but in SAS.

I have many (fond?) memories of talking through obscure data edge cases with
him, trying to figure out why our trip totals (totaling in the 100s of
millions) differed by 17 trips or whatever.

Aside from the unfortunate circumstances, I enjoyed working on the project. We
had a team of big name academic experts, and it was fun hashing things out
with some of the same people that had written my college textbooks and coding
up their ideas.

Working on it was a big part in me realize I liked programming (and data and
analysis), even more so than working specifically on environmental problems
per se.

<comments/>
