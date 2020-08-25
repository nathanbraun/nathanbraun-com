---
title: Scramble Tracker — Nathan Braun
type: page
---

# Scramble Tracker — Keep Track of Shots You Used During a Golf Scramble

Every year I play in a golf scramble with a bunch of friends, and every year
a minor argument erupts over how to make the teams as fair as possible.

The past few years, we've let the market decide — picking out captains,
allocating each $100 fake dollars, and bidding on everyone else.

Because we play for (small amounts of) money, the incentive leading up the
auction is for everyone to pretend to be a lot worse than they are so they go
for less and their captain has more money to spend on other, better players.

## Data: the Sandbagger's Antidote

To cut through all the noise (and work on my app skills) I decided to code up
a data entry scramble tracker app, which the nerdiest member of each team can
use to record the type, distance and who was responsible for each shot.

After a few outings, I can put my [sports](fantasymath) [analytics](ltcwff)
skills to good use and we'll all know once at for all how good everyone is.
Either that or I'll keep the data to myself, and become the Billy Beane of the
annual golf scramble.

## App

The app itself is really simple, with basically two screens:

<custom-image2 src1="images/scramble1.png" alt1="screen 1" src2="images/scramble2.png" alt2="screen 2" width="300"/>

But I did spend some time thinking about how to get the most information with
as few clicks as possible.

## Technology
I built the site using what is quickly becoming my go to stack of Elm for the
front end and a simple Graphql API for the backend.

I host both on my hobby $5 a month DigitalOcean droplet.

For the colors, I used a ready-made palette from [Flat
UI](https://flatuicolors.com/), which helpfully available as a ready-made [elm
package](https://github.com/smucode/elm-flat-colors) and let's you use colors
with names like Alizarin, Nephritis and Belize Hole.


