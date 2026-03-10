---
title: nathanbraun.com - Tech Tools
internal: Tech Tools
description: Writeup of Tech Tools
type: page
date: "2025-01-16"
rss: true
---

# Tech Tools

[Tech Tools](https://techtoolsbook.com) is book on computer tooling wrote
mostly during 2024.

Unlike my other books (which all team the same concepts and are very similar)
it's not sport related. But I wrote it to complement any of them.

<techtools-cover src="/images/common_tooling.jpg"/>

It's available at [https://techtoolsbook.com](https://techtoolsbook.com)

## Contents
Almost all of the book takes place in the terminal, which (along with maybe a
web browser) is where I spend most of my time on a computer.

I explain this in the book, but I like to think of the terminal as a place
where do three things, broadly:

1. type commands for your computer to run 
2. edit text
3. work with files
4. doing 1-3 on a server

### 1. Commands
(1) includes navigation commands (cd, ls, pwd), running code, starting up a
REPL, ssh'ing into a server, whatever. (If you want to be pedantic it includes
2 and 3 too, since you edit text and work with files by running commands.)

This part of the book covers all the basics (cd, ls, mv, cp, pwd ) but I try to
get people up and running as quicly as possible. It also covers tmux and
opening different terminals, and gets into my more opinionated way of working
on things, which is to work on any project in it's own named (by project) tmux
session.

### 2. Editting Text
This the part that's probably the most fun — I do all my writing (books, this
site, coding, notes to myself and misc planning, everything) inside Vim in the
terminal.

I've written about this [elsewhere](/vim), but the main benefit of vim is that
it's really fast:

Going from hunting and pecking to touch typing is obviously a lot a faster.
Roughly, I think going from typing in Word or Notepad to Vim is a similar jump.

The middle of the book goes over all this. As part of it, I rewrote the classic
interactive Vim tutorial to make it clearer.

I also explain my note taking setup, which is basically a bunch of linked,
plain text notes that I edit, read and navigate in Vim. Some of this is the
classic "second brain"/zettelkasten setup, with "source" notes on books and
linked concepts etc.

But also it's more than that, because, again, I do everything — project
documentation, planning, writeups how to do things I want to remember — in Vim.
 
It also covers how to set things up so you can talk to ChatGPT (or Claude or
whatever) in Vim. This is awesome, and it's part of our note system. We can
save these conversations, link to them in other notes, pick them back up, etc.

The [madox/vim-ai plugin](https://github.com/madox2/vim-ai) takes care of the
chatting with AI inside Vim, but I forked it and added a bunch of stuff to make
it persistent and link up with other notes etc.

### 3. Working with Files
Obviously 1-2 also involve working with files, but by "working with files" I
mostly mean learning Git, which we do in the terminal with
[lazygit](https://github.com/jesseduffield/lazygit).

Here's what one early reader had to say about it:

> Lazygit?! How have I never heard of this. It's incredible. I've used git from
> the command line, GitHub desktop, and within RStudio. This is by far the
> best.

### 4. Servers
The last part of the book is doing all of the above, but on a server. As part
of that we walk through getting a server from digital ocean, setting up a
database and serving a basic API with a web server.

I wrote and included the API code with the book. We don't go over it (the book
isn't about how to write APIs) but I think it's helpful to walk get something
running on a server and walk through the various issues that come up (systemd,
ports, DNS records, Nginx etc).

## Setup
An early and big part of book is getting everyone set up on same page. Macs
mostly work out of the box, while on Windows and Chromebook's we use the built
in linux/ubuntu options.

I use the dot file manager chezmoi to configure everything with minimal messing
around.

Writing all these configs was a decent amount of work. I use a mac, but bought
Chromebook and Windows laptops so I could get the setup the way I wanted. I
think this will be ongoing — I just heard from someone that they were having
issues with the new Microsoft Copilot+ laptop, so maybe I'll have to pickup one
of those.

## Fit with other books
My other, learn Python and data science with sports books start with a
prereqesites tooling chapter. There I have people download Spyder and set it up
so they can code with a split screen editor on the left and REPL they can send
code to on the right

This isn't far off from what I personally do (and what this book does), except
I'm using Vim + a REPL, and doing it all inside the terminal.

So re: how it fit with the others, basically this book swaps the normal,
word-processor like Spyder text editor for Vim, which makes working with text a
lot faster.

So readers interested in learning Python/Data Science can either do that first
(i.e. before starting the coding books), in which case they'll have a
faster/more powerful setup for the reading coding books, but it'll involve some
up front investment. On some level, this effort could be "wasted" if people
don't like coding, though for me personally these tools are very valuable even
apart from coding, and it's worth it either way.

