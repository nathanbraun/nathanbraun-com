---
title: Install Python
type: page
---

# Installing Python

Here I'll explain how to install and use Python, a free, open source
programming language.

If you're reading this, it's probably because you want to be able to run Python
3 code and install packages. If you can already do that and have a setup that
works for you, great. If you do not, the easiest way to get one is from
Anaconda.

Go to:

[https://www.anaconda.com/distribution/](https://www.anaconda.com/distribution/)

Scroll down and click on the green button to download the 3.x version (3.7 at
time of this writing) for your operating system.

![Python 3.x on the Anaconda site](images/anaconda_site.png)

Then install it. It might ask whether you want to install it for everyone on
your computer or just you. Installing it for just yourself is fine.

One potential downside to a program like Anaconda is that it takes up a lot of
disk space. This shouldn't be a big deal. Most computers have much more hard
disk space than they need and using it will not slow your computer down.  Once
you are more familiar with Python, you may want to explore other, more
minimalistic ways of installing it.

Once you have Anaconda installed, open up Anaconda navigator and launch Spyder.

Then go to View -> Window layouts and click on Horizontal split.

Make sure pane selected (in blue) on the right side is 'IPython console'

Now you should be ready to code. Your editor is on left, and your Python
console is on the right. Let's touch on each of these briefly.

![Editor and REPL in Spyder]({static}/images/spyder.png)

## Code
Most people reading this have probably worked with something like Excel
previously, but not necessarily code. What are the differences?

A spreadsheet lets you manipulate a table of data as you look at. You can
point, click, resize columns, change cells, etc. The coder term for this style
of interaction is "what you see is what you get" (WYSIWYG).

Python code, in contrast, is a set of instructions for working with data. You
tell your program what to do, and Python does (executes) it.

It is possible to tell Python what to do one instruction at a time, but usually
programmers write multiple instructions out at once. These instructions are
called "programs" or "code", and are just plain text files with the extension
.py.

When you tell Python to run some program, it will look at the file and run each
line, starting at the top.

## Editor
Your **editor** is the text editing program you use to write and edit these
files. If you wanted, you could write all your Python programs in Notepad, but
most people don't. An editor like Spyder will do nice things like highlight
special, Python related keywords and alert you if something doesn't look like
proper code.

## Console (REPL)
Your editor is the place to type code. The place where you actually run code is
in what Spyder calls the IPython console. The IPython console is an example of
what programmers call a read-eval(uate)-print-loop, or **REPL**.

A REPL does exactly what the name says, takes in ("reads") some code, evaluates
it, and prints the result. Then it automatically "loops" back to the beginning
and is ready for some new code.

Try typing 1+1 into it. You should see:

~~~ {.python}
In [1]: 1 + 1
Out[1]: 2
~~~

The REPL "reads" `1 + 1`, evaluates it (it equals 2), and prints it. The REPL
is then ready for new input.

A REPL keeps track of what you have done previously. For example if you type:

~~~ {.python}
In [2]: x = 1
~~~

And then later:

~~~ {.python}
In [3]: x + 1
Out[3]: 2
~~~

the REPL prints out `2`. But if you quit and restart Spyder and try typing `x +
1` again it will complain that it doesn't know what `x` is.

~~~ {.python}
In [1]: x + 1
...
NameError: name 'x' is not defined
~~~

By Spyder "complaining" I mean that Python gives you an **error**. An error —
also sometimes called an **exception** —  means something is wrong with your
code. In this case, you tried to use `x` without telling Python what `x` was.

Get used to exceptions, because you'll run into them a lot. If you are working
interactively in a REPL and do something against the rules of Python it will
alert you (in red) that something went wrong, ignore whatever you were trying
to do, and loop back to await further instructions like normal.

Try:

~~~ {.python}
In [2]: x = 9/0
...

ZeroDivisionError: division by zero
~~~

Since dividing by 0 is against the laws of math[^1], Python won't let you do it
and will throw (raise) an error. No big deal — your computer didn't crash and
your data is still there.  If you type `x` in the REPL again you will see
it's still 1.

Python behaves a bit differently if you have an error in a file you are trying
to run all at once. In that case Python will stop executing the file, but
because Python executes code from top to bottom everything above the line with
your error will have run like normal.

[^1]: See [https://www.math.toronto.edu/mathnet/questionCorner/nineoverzero.html](https://www.math.toronto.edu/mathnet/questionCorner/nineoverzero.html) 

## Using Spyder 
When writing programs (or following along with examples other people have
written) you will spend a lot of your time in the editor. You will also often
want to send (run) code — sometimes the entire file, usually just certain
sections — to the REPL. You also should go over to the REPL to examine certain
variables or try out certain code.

At a minimum, I recommend getting comfortable with the following keyboard
shortcuts in Spyder:

Pressing F9 in the editor will send whatever code you have highlighted to the
REPL. If you don't have anything highlighted, it will send the current line.

F5 will send the entire file to the REPL.

control + shift + e moves you to the editor (e.g. if you're in the REPL). On a
Mac, it's command + shift + e.

control + shift + i moves you to the REPL (e.g. if you're in the editor). On a
Mac, it's command + shift + i.
