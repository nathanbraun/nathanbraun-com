---
title: Learn to Code with Sports
type: blog
description: Writeup of Learn to Code with Sports
rss: true
date: "2026-10-22"
---

# Learn to Code with Sports

Learn to Code with Fantasy Football, Baseball, Hockey, Soccer, and Basketball
are a series of books I wrote between 2019 and 2022. I followed it up with a
book on AI and tooling in 2024.

At a high level, this is the story:

- In 2019 I went down to 80% at my day job to work on my own projects.
- Learn to Code with Fantasy Football was my first project.
- I released it in 2019 and made > 20% of my salary.
- I quit my job and over the next few years wrote four other versions.

Eventually I:

- Grew through Facebook and Instagram marketing
- Built a 70k person email list.
- Sold more than $1M worth.
- Watched AI make the books obsolete, and ultimately made them free.

## Contents
All the books covered basically the same thing: Python, Pandas (Python's main
data analysis library), SQL, web scraping, public APIs, data visualization,
summary stats and modeling, all applied to sports and sports data.

I also wrote a tooling based companion book (Tech Tools) which covers the
terminal, Vim, Git, servers (and later AI tools like Claude Code).

<div class="flex flex-wrap gap-3 my-6">
  <div class="w-20 sm:w-24"><img src="/images/code-books/football.jpg" alt="Learn to Code with Fantasy Football cover" class="shadow" /></div>
  <div class="w-20 sm:w-24"><img src="/images/code-books/baseball.jpg" alt="Learn to Code with Baseball cover" class="shadow" /></div>
  <div class="w-20 sm:w-24"><img src="/images/code-books/hockey.jpg" alt="Learn to Code with Hockey cover" class="shadow" /></div>
  <div class="w-20 sm:w-24"><img src="/images/code-books/soccer.jpg" alt="Learn to Code with Soccer cover" class="shadow" /></div>
  <div class="w-20 sm:w-24"><img src="/images/code-books/basketball.jpg" alt="Learn to Code with Basketball cover" class="shadow" /></div>
  <div class="w-20 sm:w-24"><img src="/images/code-books/tooling.jpg" alt="Tech Tools cover" class="shadow" /></div>
</div>

## Background

I had been building side projects and playing around with selling products (and
earlier consulting) on nights and weekends since grad school. Once we had our
second kid in 2018 night and weekend time got pretty scarce.

Around that time I also read Principles by Ray Dalio, which I've talked about
[elsewhere](/books/principles). It's not magic, or nec anything that different
from common sense, but clicked with me.

Three relevant parts:

### 5 step process to get what you want out of life
First was Dalio's 5 step process, which is:
1. have clear goals
2. identify, and don't tolerate problems that stand in your way
3. accurately diagnose problems to get at root cause
4. design plans that will get you around them
5. do what's necessary to push designs through to results

I went through this exercise with the goal "work for myself" and decided the
root cause was I a) didn't have enough products available for people to buy and
b) going down a level, I didn't have a ton of time to work on them. Separately,
I had a tendancy to build vs thinking about distribution or 'just shipping'.

(Note I still find this process valuable, and created a [Claude
skill](/dalio-skill) for it.)

### Designer vs worker level you
The second part of Principles I really liked was Dalio's idea re: designer vs
worker level you.

He recommends thinking of yourself as a worker operating in a machine that
you’ve designed, and says it’s important to distinguish between you as the
designer of your machine, and you as a worker within your machine.

> "It’s much more important that you are a good designer/manager of your life
> than a good worker in it."

So, in what I viewed as a 'designer of my life' move, I decided to go down to
80% at my day job in order to work on my own stuff/work for myself.

My plan was to start with the coding books and move on to something else if that
didn't work.

(Note for those counting that's two Dalio inspired lessons, the third is the
[navigating levels](#navigating-levels) part below.)

## Audience
The main target for the books ended up being people who are:
- into sports data
- have done a bit of their own analysis in something like Excel
- don't necessarily have much background in coding
- are interested in learning more
- unsure where to start

Which was basically me in ~2013 ish.

The books are based on the assumption (and my experience) that data science type
tasks are pretty universal across domains. Once you learn how to query a
database or scrape some data or spin up a regression model in one domain, it's
straightforward to apply it to others.

They were definitely more about teaching these concepts than getting into
advanced analytics or stats. It wasn't like if you read it you'd be able to go
work for the Brewers or something. Though these coding skills would also prob be
prerequisites, and did have readers from the industry too.

## Writing Process and Experience
Writing the book wasn't that difficult. That's probably mainly due to the topic
— I'd spent a lot of time thinking about fantasy football and a lot of time
doing data science type tasks at my day job — but I also read a lot and am
decent at writing.

I also enjoy teaching and believe I'm pretty good at:

- synthesizing/summarizing and finding themes/commonalities among large amounts of information 
- picking out a path to knowledge and introducing things at the right time
- getting in the mind of the reader and finding and avoiding potentially confusing spots they might trip up on
  
At first I tried to write in prose form, but found that was way too slow,
mostly because it was too hard to keep from trying to edit/rewrite/make
perfect sentences as I went.

It was much easier for me to write out bullet points of the concepts I wanted
to get across, even down to the sentence level (I do these writeups on my site
the same way).

So I bulleted out the whole book, then rewrote it as prose.

### Navigating Levels
Another Dalio concept I often thought about while writing and bullet pointing
was the idea of *levels*.

  > *Reality exists at different levels and each of them gives you different
  but valuable perspectives. ... We are constantly seeing things at different
  levels and navigating between them, whether we know it or not, whether we do
  it well or not... For example, you can navigate levels to move from your
  values to what you do to realize them on a day-to-day basis.*
  
  > \> *I want meaningful work that's full of learning.* \
  \>\> *I want to be a doctor.* \
  \>\>\> *I need to go to medical school.* \
  \>\>\>\> *I need to get good grades in the sciences.* \
  \>\>\>\>\> *I need to stay home tonight and study.* 

When a line of reason has gotten jumbled, it's often because the speaker is
jumping around different levels without showing how they connect.

That's why, when conveying information, it's important to:

- Be aware what level you're examining a given subject.
- Consciously navigate levels rather than see subjects as undifferentiated piles of facts that can be browsed randomly.

Of course, I had always known that in theory, but explicitly keeping it in mind
made the book better and led to reactions like these:

> "Your ability to look at complex things and **break them down into their simple parts** in real time is rare." — Taiwo M

> "Wow. Nice work — I mean that. **As a former teacher and once-upon-a-time coder, I really appreciate how you go about this.**"
> — Matt W

## Growth
### Reddit
I wrote football in 2019 on my one day off a week. I wanted to focus on
distribution from the beginning, and spun up a waiting list first. Reception
(mostly via Reddit) was positive, and I had a couple of thousand people on it.
Initially I sold to that.

It was nice, but not really needle moving in terms of income. Actually, I
specifically remember talking to a friend, who said, "it's cool you made 30k or
whatever, but it's not like you're going to quit your job".

As it turns out, 30k for 20% of my time did beat my then day-job salary, and was
helpful in making the leap to working on my own things full time (it was also
nice my wife had a good job).

But it's true that at that point I didn't necessarily see it getting much
bigger, except maybe linearly by doing the same reddit -> waitlist playbook for
other sports.

### Instagram
What changed that was facebook/instagram ads. How they work:

- you upload, say 3k email addresses of book customers to Meta
- Meta (automatically) matches those with Facebook/Instagram profiles
- Meta then (again, automatically) builds a model: "we used all our internal
  Meta data to build a model and rate everyone on Facebook/Instagram in terms of
  how similar they are to the people who bought your book, 0-100"
- "here's 5M 100's"

This is when sales *really* took off. I initially played around with small
amounts of ad spend, then hired someone to manage it. The person I hired mainly
helped by dramatically increasing the spend. That ended up working (and was a
lesson in itself). I eventually managed all the ads (from creating visuals in
Canva to coding up the attribution plumbing and managing the lookalike
audiences) myself.

### Email drip
Part way through also started offering a truncated preview to anyone who entered
their email. I'm glad I did; have something like ~70k emails now.

I followed the free preview request up with a basic drip campaign. My most
interesting email maybe was an explanation of the [Monty Hall
problem](/monty-hall), which I sent in order to prove I was a good teacher (note
I still do think it's a good explanation).

> "Can I just say that **this is the simplest and best explanation I have ever seen**... Awesome!!" - Stu T

## Results
Initially I priced Learn to Code with Fantasy Football at $45 and sold it on
Gumroad. Later I moved to Sendowl and gradually raised the price to $79, $119
with a bundle.

I briefly thought about releasing a physical copy on Amazon, but I didn't
necessarily think people would be willing to spend as much for non-textbook
physical books + it was helpful to have in digital form so you could have it up
in one monitor while you coded alongside it in another.

Both sales and reception were good (related obviously) -- I sold more than $1M
worth of books, and kept track of the feedback (all of it basically unsolicited;
I didn't have a big testimonial collection operation or anything). 

> "The book here was really, really well done." — Bill Connelly, ESPN

> "It helped me way more than my grad school class did." — Glen I

> "The way the learning is framed here is 10x what you'll get someplace else."
> — u/Nick58

You can see some more [here](/code-sports-books/testimonials).

## Follow up books
In addition to the 5 main sports, I also did an annual "fantasy football dev
kit" where we'd walk through building 'real life' projects using a
projection/simulation API I'd built.

The developer kit included access to the API for one year. It was my first real
foray into recurring revenue, which was nice. It mostly functioned as an
upsell/higher priced offering to Learn to Code with Fantasy Football, which was
fine.

I also wrote a book on tooling. For the coding books, I did a simple setup to
get people up and running ASAP. That was good for learning and let people focus
on one thing at a time, but wasn't actually how I coded.

So wrote all that down in 'Tech Tools', and people could start either with that
or the coding books. Again, I think it mostly worked as an upsell; it doesn't
have the same, "take my money" appeal as Learn to Code with Sports.

But it was still valuable, and I did have people go through it and really like
it. Ironically, it's much more relevant now that AI writes most of the code.

## AI and the fall of the books

I've been using AI coding tools since soon after they were invented (basically
just fancy autocomplete).

I was working on the first edition of tech tools when early AI was out. It was
very helpful in setting up configs etc. But was definitely hit or miss and
couldn't reliably one shot code yet.

Still, I did see how AI was getting better and where things were going.

At first (~2023-2024) my thinking was, "wow AI is getting good, I could see it
*changing* how people learn to code -- it's probably going to have implications
for my books".

Then (late 2025, early 2026) it moved to, "wow AI is getting really good, I'm
not even sure people are going to have to *write* code anymore". Which is
basically what happened.

This all showed up as a decline in sales, and in early 2026 I stopped ad spend
completely.

I was still selling some copies, which I had mixed thoughts on. Part of me felt
like I was selling flip phones to people in 2012. But at same time, I am a
better user of AI because I know how to code.

Was learning to code, and *then* learning about AI necessarily the best/most
efficient way to go about things? Prob not. But -- just like smart phones
probably >> flip phones (per revealed preference), there are tradeoffs to smart
phones. I felt like it was something for people to discover on their own
timelines.

But eventually (with Claude Code etc) I basically came to the conclusion that
coding the old way is "solved". It was pretty clear the books were no longer
relevant as the most efficient way to learn for most people.

So I made them free. People still are downloading them. It could be a good move
for some people, depends on how much time you have.

## What I took from the books
I'm proud of these books. They combined my interests (tech, sports) and skills
in a way that worked given the constraints I had. It was fun to go to 'work'
every day. I think they were a genuinely good. I heard from people it helped get
jobs, and others who finally 'got coding' after struggling with it for a while.

It also helped with confidence in my own skills and judgement. I taught myself
to code, and a lot of resources were confusing or presented in weird order. I
thought it could be done better, so I did it. Based on reception and market
reaction, it worked out.

The whole project should also be helpful for future pattern matchin. For
example, product market fit. There's a quote from Patrick McKenzie:

> "With product market fit, you know it if you have it; if you're not sure, you
> don't." - Patio11

The books definitely had it, and right away -- I didn't have to do a bunch of
thrashing or pivoting to find it. That won't always be the case, but I think
it'll make me more effective having experienced it.

### Inside view of AI/trends
From 2023-2026, I watched AI go from smart autocomplete to good but buggy code
to basically superhuman. I used an early "talk to LLM's in Vim"
[plugin](https://github.com/madox2/vim-ai), used that to build my own, "talk to
LLM's in *Neo*vim" [plugin](https://github.com/nathanbraun/nvim-ai), used that
to get AI to write a bunch of code I'd have to test/compile by hand. Eventually
I moved to Claude Code which did all that and more.

I also feel like hobby/passion projects (e.g. with sports) gave me a good, up
close view to cutting edge tech. For example, in 2019 when I [posted on
r/fantasyfootball](https://www.reddit.com/r/fantasyfootball/comments/aizwq8/working_on_a_new_book_learn_to_code_with_fantasy/)
there was a huge response, right away. Now people build way more polished (and
free) stuff with AI, and no one blinks.

I think this perspective might be useful in areas where AI is diffusing more
slowly, e.g. non-consumer/hobby products or messier b2b/physical world stuff.
Industries where people *aren't* coding up really polished products on their own
dime on nights and weekends.

That's why I'm trying to learn and get more exposure to these areas now. If
you'd like to talk, please don't hesitate to [reach out](/meet).

