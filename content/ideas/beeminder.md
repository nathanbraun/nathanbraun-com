---
title: Beeminder
type: blog
draft: true
description: Beeminder
published: "2021-02-07"
---

# Idea: Beeminder for digital distraction 

[Beeminder](https://beeminder.com) is a tool that helps you achieve your goals
by charging you an ever-increasing amount money when you don't achieve your
goals. It's very effective for certain types of people, with many calling it
life changing, etc. If it sounds intriguing you should definitely check it out.

I've used Beeminder and mostly like it, but have a few issues (some of these
are with Beeminder, some with myself).

## Beeminder's real achilles heel: fake data
Contrary to [other takes](https://blog.beeminder.com/achilles/), BM's true
Achilles heel is that has no way of knowing when you cheat, either blatantly by
entering fake data or half assing a workout or a blog post or something.

This definitely isn't Beeminder's fault. Many (most?) of their users have
success despite it, and they have [talked
about](https://help.beeminder.com/article/34-cant-you-just-lie-about-your-data)
it and have some [features](https://blog.beeminder.com/legit/) to address it.
But obviously everyone would be better off if entering fake data was literally
impossible.

## Incentive issues: Beeminder keeps the money
Beeminder keeps the money you pay when you don't reach your goals. On the one
hand, this is fine: they have cool tracking tools and integrations that aren't
costless to develop or run. Plus they're friendly, always erring towards not
charging if your data got messed up, automatically pausing your account if you
go inactive, and even paying random users when they don't achieve their own
goals.

This is fine, but it also leads to clear conflicts of interests. One example:
say you want to go the gym more, and you know paying $1 or $5 isn't going to
motivate you. You want pay $20 if you don't go.

Instead of letting you set the penalty at $20, BM requires you first put $5 on
the line, fail, get charged $5, increase the penalty to $10, fail again, where
upon it'll increase to $20 and you can start being motivated.

At first I missed this and increasing penalty amount was some black box
algorithm meant to maximize my chances of achieving my goals. Then read the BM
folks says the reason they do this is because they need to make money on your
smaller, less motivating amounts first.

Another example: [some people](https://blog.beeminder.com/mbork/) are
motivated enough by BM's long term data tracking features that they enjoy
using it without putting *any* money on the line. In that case BM *is* helping
you achieve your goals, but isn't getting any penalty money, so it seems
reasonable to charge something, however this brings us to the last point,
which is...

## Beeminder is expensive
Beeminder is really expensive for what it is, which is a product where you pay
a monthly fee in order to pay them *more* money when you don't achieve your
goals.

There's a free version that's limited to 3 goals, any more than that and it's
$8 a month. Extra features like automatically having weekends off are $16.

If you want to pony up to get your incentives aligned (immediately set your
dollar amount at what motivates you or just use the tracking features without
putting money on the line) it's **$40 a month** (this option also lets you
donate half your goal related losses to charity).

While I'm familiar with [Patio11's law of SAAS
pricing](https://secondbreakfast.co/patio11-s-law), and BM is certainly free
to charge what they cant, this seems like *way* too much money to me, well
beyond the market price.

## Idea
Hence this idea, a BM type like service that:
- **only does digital distraction type goals** (limited time on Instagram, not using phone after 7 pm) that it's impossible to cheat or enter fake data on (vs half assing a workout)
- costs a **low monthly fee**
- donates **all punishment dollars to charity**
