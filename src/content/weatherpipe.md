---
title: Weatherpipe
type: blog
description: Writeup on weatherpipe.com
rss: true
date: "2026-11-19"
---


# Weatherpipe

[Weatherpipe](https://www.weatherpipe.com) is a cross-platform, improved version
of the [Weather Strip](https://weatherstrip.app) app that I built over a few
weeks in the spring of 2026.

The main benefit of both apps: **they make understanding/internalizing the
upcoming (like later today-week) weather very fast**, like almost instantaneous.

It's like "piping the weather to your brain", hence the name (that along with
.com domain availability).

## Tutorial
Here's how it works:

**1. Days, and the "now" line**

We start with the empty week. Days and times. Labels just after midnight.

The white line is *now* — we're checking the app Tuesday at 7 am. Left is past;
right is the forecast.

![Three days of strip labeled Tuesday, Wednesday, Thursday, with sun by day and moon by night and a vertical white now-line at Tuesday morning](/images/weatherpipe/strip-01.jpg)

**2. + Temperature**

Next let's add some real info. The orange curve is temperature. Right now it's
43°, climbing to 72° in early afternoon.

Overnight drops back into the low 40s; tomorrow is cooler, peaking at 64°
mid-afternoon.

![Temperature curve overlaid on the sky, from 43 degrees at the now-line up to a 72 degree high and back down overnight](/images/weatherpipe/strip-02.jpg)

**3. + Clouds**

Grey area is percent cloud cover. Tuesday's partly cloudy; Wednesday thickens as
a system rolls in.

![Cloud cover added as grey ridges, partly cloudy on Tuesday and thickening through Wednesday](/images/weatherpipe/strip-03.jpg)

**4. + Precipitation**

Blue is the chance of rain; purple, thunderstorms. Wednesday morning shows a
90%+ rain and 50% chance of storms, peaking late morning.

![Rain probability in blue with thunder in purple, both rising sharply on Wednesday morning](/images/weatherpipe/strip-04.jpg)

**5. Long-press for the details**

Press and drag and more info pops up — projected rainfall, along with overall
rain and thunderstorm probabilities.

![A long-press range from 8 am to 7 pm Wednesday is highlighted; badges below read 64 over 47 degrees, 90 percent and 1.67 inches, 45 percent thunder](/images/weatherpipe/strip-05.jpg)

**6. + Wind**

Arrows at the bottom show wind speed and direction, with the high and low
marked. Dashed lines above mark gusts.

![Wind arrows along the base, growing larger through the storm window, with dashed gust lines above them](/images/weatherpipe/strip-06.jpg)

**7. Zoom out to see the whole forecast**

Below the focus, the entire week is shown in a single band. See the whole week
at a glance — Friday looks great, with snow on Sunday.

![The full week compressed into a single thin strip, with a viewport indicator over the Tuesday-through-Thursday window and a snowy Sunday visible to the right](/images/weatherpipe/strip-07.jpg)

## Differences from Weather Strip

Weather Strip (as far as I know) pioneered the layout. I first heard about it
from [Devon Zuegel](https://devonzuegel.com). It was always iOS/Mac only, which
was unfortunate since I had an Android. I bought it anyway and used it on my
MacBook.

As building became generally easier, I decided it'd be worth making a version
for Android.

The main improvements vs Weather Strip, biggest to smallest:

**1. Cross-platform.**

Works on [Android](https://play.google.com/store/apps/details?id=com.weatherpipe.app), [iOS](https://apps.apple.com/app/id6774139558), and also there's a [web version](https://www.weatherpipe.com/w/).

**2. Long press for more info.**

The strip layout is great for showing probability of precipitation (> 0
accumulation) at any given time.

The only thing Weather Strip is *not* great at is showing how much rain we're
going to get; it does it in bars that overlay the strip/look kind of
cluttered.

So instead I added the ability to press down and drag over an interval to bring
up accumulated amounts.

<img src="/images/weatherpipe/long-press.jpg" alt="Weatherpipe with 5am to 7pm Wednesday selected by long press; badges below show 64 over 42 degrees, 26 mph wind, 90 percent chance of rain with 1.70 inches, and 45 percent chance of thunder" style="width: 360px; max-width: 100%; margin: 0 auto;" />

**3. Swap main line metrics.**

In Weatherpipe, you can tap air quality, wind (sustained and gusts), or UV to
toggle that being the main line instead of temperature. It just makes it easier
to see when there are particular things we care about.

I used it a bunch for air quality when wildfires were bad this summer. Or you
can, say, look at wind if interested in e.g. a golf tournament.

<img src="/images/weatherpipe/air-quality.jpg" alt="Weatherpipe web version for Denver with the AQI badge selected, so the main line shows air quality falling from 115 to 47 instead of temperature" style="width: 360px; max-width: 100%; margin: 0 auto;" />

**4. Horizontal layout toggle.**

You can flip your phone on edge for a larger, horizonal view. In theory this
shows more and larger detail, but I don't find myself using it much in practice.

![Weatherpipe in landscape mode showing all of Tuesday and Wednesday across the full width of the phone](/images/weatherpipe/landscape.jpg)

**5. Better aesthetics.**

This is a matter of taste but I like the look of Weatherpipe better.

## Web version
I've made a free (for now) web version here:

[https://www.weatherpipe.com/w/](https://www.weatherpipe.com/w/)

Also — since one area I think it particularly shines is planning tee times — I
made a golf version here:

[https://www.weatherpipe.com/golf](https://www.weatherpipe.com/golf)

## Development
This was my first iOS and Android app, it was a fine experience. I used Expo and
React Native, and had to do some interesting work to speed up the visuals/SVG
rendering and make everything performant.

Under the hood I'm using some decent paid commercial weather models, with some
custom blending when it comes to merging short and medium/long term forecasts.
It works all over the world.

## Marketing and sales
I've barely marketed it so far, it's been more for learning at this point. But
it's on my list. Feel free to reach out with any feedback.
