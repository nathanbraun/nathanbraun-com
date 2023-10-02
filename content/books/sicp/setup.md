---
title: SICP Setup
type: page
published: "2020-01-01"
description: books
---

# SICP Setup
Before getting started I wanted a lisp REPL that would work with SICP with vi
style keybindings.

Here's what I did to get it:

### 1. Installed Racket
The language the authors use in the book
([MIT-Scheme](https://www.gnu.org/software/mit-scheme/)) has problems running
on Apple Silicon (it's [possible](https://kennethfriedman.org/thoughts/2021/mit-scheme-on-apple-silicon/) but you have run your terminal in emulation
mode), so based on [this reddit
comment](https://www.reddit.com/r/scheme/comments/l90icc/comment/glfujsc/?utm_source=reddit&utm_medium=web2x&context=3) I decided to use Racket with the sicp package.

I got Racket here:

[https://download.racket-lang.org/](https://download.racket-lang.org/)

It comes with GUI, but I wanted to use it in the terminal. To do that I had to
add the Racket directory to my `PATH`. After that typing `racket` in the
terminal opens up a REPL:

```
❯ racket
Welcome to Racket v8.10 [cs].
>
```

### 2. Wrapped the Racket REPL with `rlwrap`

Out of the box, the `racket` REPL doesn't include Vim keybindings. That's a
deal breaker to me, so I wrap it it
[rlwrap](https://github.com/hanslub42/rlwrap) like this:

```
rlwrap --always-readline -S "> " racket
```

This makes it so the Vim style bindings I have setup in `.inputrc` also work
with the `racket` REPL.

### 3. Installed the Racket SICP Package

That reddit comment mentioned a Racket sicp package. We have to install it (in
our main terminal):

```
raco pkg install sicp
```

Then in the Racket REPL we can run:

```
> (require sicp)
```

to load it.

That's fine, but I wanted one command that would start my (wrapped) Racket REPL
and load everything I needed all in one step. Turns out that's this:

In my `.zhrc`:

```
alias sicp="rlwrap --always-readline -S '> ' -- racket -e '(require sicp)' -i"
```

How I can just type `sicp` in the terminal and I'm set:

```
❯ sicp
> Welcome to Racket v8.10 [cs].
>
```

