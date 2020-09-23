---
title: Nathan Braun - Current Pain Points
type: page
---

# Current Pain Points
Last updated 2020-09-23

This page is for an up to date list of professional, technical, knowledge etc
type issues I'm currently grappling with.

Note: the point of this isn't to complain or wallow, more trying to reflect
and be transparent. Also, as someone always on the lookout for new software
ideas, I always enjoy hearing about other people's pain points too.

Always appreciate thoughts or resources on these: [nate@nathanbraun.com](mailto:nate@nathanbraun.com)

## Getting Started with A/B Testing
I'm a big fan of Patrick Mackenzie, Rob Walling and Gabriel Weinberg, all of
whom espouse the many benefits of A/B testing.

Until recently, I didn't have a great way to run A/B tests on my sites, which
are mostly in elm-pages.

Netlify's split testing feature helped, but meant only running one test at
a time, which — at my current traffic levels — would be pretty slow moving.

So, a few weeks ago — partially inspired by Patrick's A/B Bingo — I wrote some
code that makes it easy to run multiple tests in elm-pages.

For example, here's a test I currently have going on
[fantasycoding.com](fantasycoding.com):

```
<test id="0002-header-size" version="A" name="h1">
# Learn Coding + Data Science Fundamentals with Fantasy Football
</test>
<test id="0002-header-size" version="B" name="h2">
## Learn Coding + Data Science Fundamentals with Fantasy Football
</test>
```

Great. But I'm a little unsure how to go about getting started testing in
a systematic way. In particular when it comes to copy, which is something I'd
always unsure about.

I.e., I took an initial stab at my sales site and think it looks OK. Now do
I just take another, independent crack at it and wee which version does better?

Or am I supposed to start by picking out buttons on what I have and change
their color?

I'm sure there's information out there on this, and it's on my to do list to
find it.

### Preliminary thoughts on solution
I could see it actually being sort of haphazard, especially when you first
start out. I wouldn't be surprised if indeed, I am supposed to take a few
different cracks at copy (or rearrange the order of what I have) and see what
works.

Either way, will do more research and perhaps report back.

## Dealing with Moderators on Reddit
The bulk of my initial traction for my book came from Reddit, via a few posts
like this:

[https://www.reddit.com/r/fantasyfootball/comments/aizwq8/working_on_a_new_book_learn_to_code_with_fantasy/](https://www.reddit.com/r/fantasyfootball/comments/aizwq8/working_on_a_new_book_learn_to_code_with_fantasy/)

Each of which got 1k+ upvotes and multiple gold/platinum awards (still not
sure what that means). After two posts like that (an initial one and an update
a few months later) I had over 3k people on an email list.

It seemed like a win-win, it was obviously something people were interested in
(over 97% upvoted) and it gave a promising traction channel, which I needed if
it was going to be worth it for me to do.

After the book was out and doing well, I decided to look at a baseball
version. I did an initial post on r/baseball, which for a few hours took off
before the mods took it down, despite the upvotes (95%), positive comments
etc.

So now my Learn to Code with Baseball book mailing list sits at a few hundred
emails instead of a few thousand. I still might do it, but I guarantee if
I had 3k+ email addresses of people who were interested it'd be out right now.

I understand reddit moderators have to put up with a lot, and user experience
would suffer if 80% of posts were people trying to sell things. But it was
definitely frustrating to have a positive, highly upvoted, seemingly win-win
post removed, especially since it was a highly critical traction channel.

### Preliminary thoughts on solutions
I've actually thought about testing out reddit ads. I (and most people I'd
guess) usually ignore them, but I doubt the content of many ads would get 1k+
upvotes and some platinum icons posted on their own, so it's prob worth at
least trying.

If not I guess I'd either have to ingratiate myself with moderators (not nec
always possible, maybe with r/baseball, probably not with r/nba) or find
another traction channel.
