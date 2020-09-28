---
title: Nathan Braun - Current Pain Points
type: page
---

# Current Pain Points
Last updated **2020-09-23**

This page is for an up to date list of professional, technical, knowledge etc
type issues I'm currently grappling with.

Note: the point isn't to complain. Instead it's part reflection, part
invitation (definitely interested in any thoughts or resources, 
[nate@nathanbraun.com](mailto:nate@nathanbraun.com)).

Also, as someone always on the lookout for new software ideas, I think it's
interesting (and often valuable) to hear people talk about pain points too.

### Update 2020-09-28.
Putting these in writing (in public) for a few days has already made them seem
more solvable, in a good way. My higher agency self is already saying:

*These are your pain points? These are enough of a problem for you that you
created a separate page to list them on your site? Creating a good plan to
solve these (with contigencies etc) might take a day, at most.*

## 1. Getting Started with A/B Testing
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
o
</test>
<test id="0002-header-size" version="B" name="h2">
## Learn Coding + Data Science Fundamentals with Fantasy Football
</test>
```

Great. But I'm a little unsure how to go about getting started testing in
a systematic way. In particular when it comes to copy, which is something I'd
always like to test.

I.e., I took an initial stab at my sales site and think it looks OK. Now do
I just take another, independent crack at it and wee which version does better?

Or is it better to start by picking out buttons on what I have and change their
color?

I'm sure there's information out there on this, and it's definitely on my to
do list to find it (or just start expirimenting and flesh out my thoughts on
this).

### Preliminary thoughts on solution
I could see it actually being sort of haphazard, especially when you first
start out. I wouldn't be surprised if indeed, I am supposed to take a few
different cracks at copy (or rearrange the order of what I have) and see what
works.

Either way, will figure it out and perhaps report back.

## 2. Dealing with Moderators on Reddit
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
version. I did an initial post on r/baseball, which for a few hours was on
a similar trajectory to my initial r/fantasyfootball post. Then the mods took
it down, despite the upvote rate (95%), positive comments etc.

I understand reddit moderators have to put up with a lot of dcrap, and user
experience would suffer if 80% of posts were people trying to sell things. But
it was definitely frustrating to have a positive, highly upvoted, seemingly
win-win post removed, especially as a critical traction channel.

### Preliminary thoughts on solutions
I've actually thought about testing out reddit ads. I (and most people I'd
guess) usually ignore them, but I've usually had good responses to my posts,
so it's probably worth trying.

If not I guess I'd either have to ingratiate myself with moderators (not nec
always possible) or find another traction channel. I suppose traction isn't
always (or usually) fair, and if making a promising traction channel work
means sucking up to reddit moderators or making more of an effort to comment
in order to become more visible, so be it.
