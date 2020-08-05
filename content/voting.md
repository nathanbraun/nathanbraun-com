---
title: Quadratic Voting App — Nathan Braun
type: page
---

# Vote Squared - Quadratic Voting App

Built April-May 2020 (mostly during naps) while at home with kids due to
COVID-19.

[www.votequared.com](https://votesquared.com)

## Deciding in Groups
Voting is the obvious way to decide something as a group.

When most people think about voting, they probably envision "first past the
post", where everyone votes for one of two or more options, and the highest
vote-getter wins.

But with more than two options, it's not at all guaranteed that a majority of
people will prefer the winning option.

One option to deal with this is [ranked-choice](https://en.wikipedia.org/wiki/Ranked_voting) 
voting, where voters rank options by order of preference and an algorithm uses
that data to pick a winner. It's becoming [popular in the US](https://en.wikipedia.org/wiki/Ranked_voting) (definitely a good thing!),
and NYC is set to adopt it in 2021.

While ranked-choice voting is a big improvement over first past the post,
quadratic voting does it one better by allowing people to vote not only on
their rank order of preference (Amash, Biden, Trump) but also the intensity of
that rank (super high, meh, none).

It also penalizes extreme, inflexible preferences but giving you less votes
overall.

## votesquared.com
My friends will occasionally vote on stuff (a good weekend to get together,
new rule changes in our fantasy football league, etc).

In the past we've always done first past the post voting, which isn't ideal.
I wanted to work on my web app skills and figured I'd bring us into a more
enlightened era while I was at it.

The result is [www.votequared.com](https://votesquared.com). How it works:
- Everyone gets a budget of $25.
- The more you vote for an option, the more it counts against your budget.  Your first vote for any option costs $1, the next $3 ($4 total), etc.  
- If you want to use all your votes (5) on one option it'll cost you your whole budget and you won't be able to vote for anything else.

## Best Fruit
So say we're voting on best fruit. And have the options: apple, banana, pear,
grape.

My first vote for apple costs $1, after which I have $24 left to use on banana,
pear, grape or more votes for apple.

From there, I can spend another $1 on my first vote for one of the other
fruits, or $3 for my second vote for apple. A third vote for apple costs an
additional $5.

So more votes for an option eat up more of your budget. The end result might
be something like this:

```
apple   4 votes ($16 total)

banana  2 votes  ($4 total)

pear    2 votes  ($4 total)

grape   1 vote   ($1 total)
```

So while a ranked order ballet would reflect the order of my preferences
(apple, banana/pear, grape) OK, quadratic voting is better because it *really*
gets across how much better apples are.

## Technology
I built the site using Elm for the front end and a simple Graphql api (using
[ariadne](https://ariadnegraphql.org/), which I like a lot) for the backend.

I host both on my hobby $5 a month DigitalOcean droplet.

I send transaction emails using mailjet's free tier, which is OK, though I've
had some issues with gmails spam filter so far.
