---
title: "Monte Carlo Simulation with Python and Fantasy Football"
type: blog
description: "Using simulation (Monte Carlo analysis) on fantasy football player distributions, with Python"
rss: true
date: "2024-07-29"
toc: true
math: true
---

# Monte Carlo Simulation with Python and Fantasy Football

In this notebook, we'll apply **simulation** (aka **Monte Carlo** analysis) to fantasy football. Hopefully this gives you a sense of how simulation techniques are used and why they're so powerful.

Don't hestate to reach out with any feedback or questions, I'm on twitter/x at [@nathanbraun](https://x.com/nathanbraun) and my email is [nate@nathanbraun.com](mailto:nate@nathanbraun.com).

## How to think about fantasy football

1. Every week, **a player's fantasy score is a random draw from some *distribution*.**

2. The shape of **this distribution is different for every player, every week.**

   What factors go into it? Anything that might affect performance (talent, opportunity, quality of the opposing defense, how good the player's offensive line is, weather, etc).

3. Your job as a fantasy football player is to **assemble a lineup of guys with distributions as far to the right as you can.** This is what maximizes your probability of winning.

Make sense? If you're skeptical or that's unclear check out the appendix at the end of this notebook. We build up the intuition behind it there.

## Working with fantasy distributions
So we want to maximize our probability of winning by picking the guys with the best distributions. How might we do that?

### Option 1 for working with distributions: math

The first way to work with distributions is by manipulating certain mathematical equations that — when plotted with X, Y coordinates — make curves.

For example, given some numbers for average <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>μ</mi></mrow><annotation encoding="application/x-tex">\mu</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.625em;vertical-align:-0.1944em;"></span><span class="mord mathnormal">μ</span></span></span></span> and standard deviation <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>σ</mi></mrow><annotation encoding="application/x-tex">\sigma</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.4306em;"></span><span class="mord mathnormal" style="margin-right:0.0359em;">σ</span></span></span></span>, you could draw a Normal distribution by plotting this equation:


<div class="math-display"><span class="katex-display"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block"><semantics><mrow><mi>f</mi><mo stretchy="false">(</mo><mi>x</mi><mo stretchy="false">)</mo><mo>=</mo><mfrac><mn>1</mn><msqrt><mrow><mn>2</mn><mi>π</mi><msup><mi>σ</mi><mn>2</mn></msup></mrow></msqrt></mfrac><msup><mi>e</mi><mrow><mo>−</mo><mfrac><mrow><mo stretchy="false">(</mo><mi>x</mi><mo>−</mo><mi>μ</mi><msup><mo stretchy="false">)</mo><mn>2</mn></msup></mrow><mrow><mn>2</mn><msup><mi>σ</mi><mn>2</mn></msup></mrow></mfrac></mrow></msup></mrow><annotation encoding="application/x-tex">
f(x) = \frac{1}{\sqrt{2 \pi \sigma^2}} e^{-\frac{(x - \mu)^2}{2 \sigma^2}}
</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:1em;vertical-align:-0.25em;"></span><span class="mord mathnormal" style="margin-right:0.1076em;">f</span><span class="mopen">(</span><span class="mord mathnormal">x</span><span class="mclose">)</span><span class="mspace" style="margin-right:0.2778em;"></span><span class="mrel">=</span><span class="mspace" style="margin-right:0.2778em;"></span></span><span class="katex-base"><span class="katex-strut" style="height:2.2591em;vertical-align:-0.93em;"></span><span class="mord"><span class="mopen nulldelimiter"></span><span class="mfrac"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height:1.3214em;"><span style="top:-2.1549em;"><span class="pstrut" style="height:3em;"></span><span class="mord"><span class="mord sqrt"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height:0.9551em;"><span class="svg-align" style="top:-3em;"><span class="pstrut" style="height:3em;"></span><span class="mord" style="padding-left:0.833em;"><span class="mord">2</span><span class="mord mathnormal" style="margin-right:0.0359em;">π</span><span class="mord"><span class="mord mathnormal" style="margin-right:0.0359em;">σ</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:0.7401em;"><span style="top:-2.989em;margin-right:0.05em;"><span class="pstrut" style="height:2.7em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mtight">2</span></span></span></span></span></span></span></span></span></span><span style="top:-2.9151em;"><span class="pstrut" style="height:3em;"></span><span class="hide-tail" style="min-width:0.853em;height:1.08em;"><svg xmlns="http://www.w3.org/2000/svg" width="400em" height="1.08em" viewBox="0 0 400000 1080" preserveAspectRatio="xMinYMin slice"><path d="M95,702
c-2.7,0,-7.17,-2.7,-13.5,-8c-5.8,-5.3,-9.5,-10,-9.5,-14
c0,-2,0.3,-3.3,1,-4c1.3,-2.7,23.83,-20.7,67.5,-54
c44.2,-33.3,65.8,-50.3,66.5,-51c1.3,-1.3,3,-2,5,-2c4.7,0,8.7,3.3,12,10
s173,378,173,378c0.7,0,35.3,-71,104,-213c68.7,-142,137.5,-285,206.5,-429
c69,-144,104.5,-217.7,106.5,-221
l0 -0
c5.3,-9.3,12,-14,20,-14
H400000v40H845.2724
s-225.272,467,-225.272,467s-235,486,-235,486c-2.7,4.7,-9,7,-19,7
c-6,0,-10,-1,-12,-3s-194,-422,-194,-422s-65,47,-65,47z
M834 80h400000v40h-400000z"/></svg></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height:0.0849em;"><span></span></span></span></span></span></span></span><span style="top:-3.23em;"><span class="pstrut" style="height:3em;"></span><span class="frac-line" style="border-bottom-width:0.04em;"></span></span><span style="top:-3.677em;"><span class="pstrut" style="height:3em;"></span><span class="mord"><span class="mord">1</span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height:0.93em;"><span></span></span></span></span></span><span class="mclose nulldelimiter"></span></span><span class="mord"><span class="mord mathnormal">e</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:1.3291em;"><span style="top:-3.4534em;margin-right:0.05em;"><span class="pstrut" style="height:3em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mtight"><span class="mord mtight">−</span><span class="mord mtight"><span class="mopen nulldelimiter katex-sizing reset-size3 size6"></span><span class="mfrac"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height:1.251em;"><span style="top:-2.5062em;"><span class="pstrut" style="height:3em;"></span><span class="katex-sizing reset-size3 size1 mtight"><span class="mord mtight"><span class="mord mtight">2</span><span class="mord mtight"><span class="mord mathnormal mtight" style="margin-right:0.0359em;">σ</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:0.9384em;"><span style="top:-2.9384em;margin-right:0.1em;"><span class="pstrut" style="height:2.6444em;"></span><span class="mord mtight">2</span></span></span></span></span></span></span></span></span></span><span style="top:-3.2255em;"><span class="pstrut" style="height:3em;"></span><span class="frac-line mtight" style="border-bottom-width:0.049em;"></span></span><span style="top:-3.5021em;"><span class="pstrut" style="height:3em;"></span><span class="katex-sizing reset-size3 size1 mtight"><span class="mord mtight"><span class="mopen mtight">(</span><span class="mord mathnormal mtight">x</span><span class="mbin mtight">−</span><span class="mord mathnormal mtight">μ</span><span class="mclose mtight"><span class="mclose mtight">)</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:1.0484em;"><span style="top:-3.0484em;margin-right:0.1em;"><span class="pstrut" style="height:2.6444em;"></span><span class="mord mtight">2</span></span></span></span></span></span></span></span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height:0.4938em;"><span></span></span></span></span></span><span class="mclose nulldelimiter katex-sizing reset-size3 size6"></span></span></span></span></span></span></span></span></span></span></span></span></span></span></div>


But there are some issues:

- One is that it restricts you to certain types of curves and shapes. This equation is for a Normal distribution. Other equations have other names. Gamma, Poisson, Weibull, etc. There are a lot of curves, but even so, not all data follows these shapes.
- An even bigger bigger problem is that working with the math involved is tedious and difficult at best and literally impossible at worse.

Say I told you Justin Herbert and Patrick Mahomes's projections this week are both normally distributed ~N(18,6) and ~N(20.5,7) respectively.

Quick, using the equation above, tell me — what's the probability Justin Herbert scores more than Patrick Mahomes? Hopefully you paid attention in calculus.

### Option 2 for working with distributions: simulations
Simulations are a much easier way of working with distributions. Analysis that works with simulations is also called **Monte Carlo** analysis.

Technically, simulations are a bunch of draws from some data generating process. Often that process is a mathematical distribution like a Normal or Gamma distribution. But we can also work with data generating processes that are difficult or impossible to describe mathematically. In that case simulations are our only option.

In practice, most simulation analysis involves:

1. **Generating data** according to some process that reflects the aspects of reality you care about. Sometimes this means finding the right distribution, other times it means combining distributions or generating data according to other rules.
2. **Asking questions** and analyzing this simulated data via summary statistics or plots.

Here, I've taken care of (1) for you by modeling thousands of simulated fantasy scores for each player.  In this notebook, we'll go through some cool examples of (2) using this simulation data to ask different questions.

## A note on this document
This is a Jupyter notebook, which is a way to show a mixture of text, tables and Python code.

You don't have to worry about the code (the parts with `In [ ]` next to them) if you don't want. What's important is the code's *output* (the parts next to `Out[ ]`), which are usually interesting numbers, data tables or graphs that I'll reference in the text.

Note if you *are* interested in the code (awesome!) you can still read through the document as is, and I'd recommend starting there. Eventually if you want play around with this yourself and change any of the code you have two options:

1. If you have some basic familiarity with Python, Jupyter and Github, you can clone the [repository](https://github.com/nathanbraun/fantasy-monte-carlo) and run it on your local machine. Or
2. You can run the notebook in [binder](https://mybinder.org/v2/gh/nathanbraun/fantasy-monte-carlo/main?filepath=fantasy-monte-carlo.ipynb) (a free, interactive Jupyter notebook viewer) by clicking on the following link:
   
   [https://mybinder.org/v2/gh/nathanbraun/fantasy-monte-carlo/main?filepath=fantasy-monte-carlo.ipynb](https://mybinder.org/v2/gh/nathanbraun/fantasy-monte-carlo/main?filepath=fantasy-monte-carlo.ipynb)

   Note binder is creating a mini computer environment takes a few minutes to get set up.

## Monte Carlo Analysis for Week 3, 2023
### Loading the data
Let's look at some player simulations from Week 3, 2023.

<div class="nb-input">

```python
import pandas as pd
pd.options.mode.chained_assignment = None

nsims = pd.read_csv('./data/nsims.csv')
nsims
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>patrick-mahomes</th>
      <th>jalen-hurts</th>
      <th>josh-allen</th>
      <th>joshua-dobbs</th>
      <th>zach-wilson</th>
      <th>lamar-jackson</th>
      <th>justin-herbert</th>
      <th>tua-tagovailoa</th>
      <th>trevor-lawrence</th>
      <th>kirk-cousins</th>
      <th>...</th>
      <th>no</th>
      <th>tb</th>
      <th>jax</th>
      <th>was</th>
      <th>den</th>
      <th>det</th>
      <th>pit</th>
      <th>sf</th>
      <th>atl</th>
      <th>lv</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>31.373173</td>
      <td>22.943242</td>
      <td>31.278690</td>
      <td>5.930377</td>
      <td>28.441495</td>
      <td>14.373618</td>
      <td>24.889975</td>
      <td>15.949190</td>
      <td>21.141992</td>
      <td>36.369677</td>
      <td>...</td>
      <td>12.254481</td>
      <td>1.352437</td>
      <td>11.359663</td>
      <td>3.107871</td>
      <td>3.792302</td>
      <td>8.339201</td>
      <td>13.518176</td>
      <td>11.165673</td>
      <td>16.655954</td>
      <td>0.079218</td>
    </tr>
    <tr>
      <th>1</th>
      <td>15.580346</td>
      <td>21.278506</td>
      <td>18.328942</td>
      <td>19.028315</td>
      <td>8.589043</td>
      <td>24.928424</td>
      <td>19.695595</td>
      <td>27.723994</td>
      <td>7.001144</td>
      <td>20.165356</td>
      <td>...</td>
      <td>9.880197</td>
      <td>7.885957</td>
      <td>5.417069</td>
      <td>6.630614</td>
      <td>0.234699</td>
      <td>14.633196</td>
      <td>14.348552</td>
      <td>13.227680</td>
      <td>14.725048</td>
      <td>7.598453</td>
    </tr>
    <tr>
      <th>2</th>
      <td>19.305332</td>
      <td>20.131436</td>
      <td>26.930733</td>
      <td>12.247553</td>
      <td>10.167820</td>
      <td>21.200463</td>
      <td>25.814006</td>
      <td>23.920744</td>
      <td>14.738819</td>
      <td>30.615639</td>
      <td>...</td>
      <td>9.225533</td>
      <td>3.289643</td>
      <td>27.502175</td>
      <td>1.235033</td>
      <td>14.118362</td>
      <td>6.083915</td>
      <td>1.695059</td>
      <td>0.826584</td>
      <td>0.677490</td>
      <td>11.846076</td>
    </tr>
    <tr>
      <th>3</th>
      <td>5.358195</td>
      <td>32.302340</td>
      <td>24.790600</td>
      <td>9.920325</td>
      <td>12.176310</td>
      <td>14.476399</td>
      <td>14.212815</td>
      <td>21.219843</td>
      <td>25.647645</td>
      <td>12.746029</td>
      <td>...</td>
      <td>8.700703</td>
      <td>6.431883</td>
      <td>3.332168</td>
      <td>6.274708</td>
      <td>4.677788</td>
      <td>5.958758</td>
      <td>2.251701</td>
      <td>15.044705</td>
      <td>15.128840</td>
      <td>9.830206</td>
    </tr>
    <tr>
      <th>4</th>
      <td>19.384985</td>
      <td>39.341403</td>
      <td>21.696812</td>
      <td>0.924227</td>
      <td>17.978923</td>
      <td>22.401451</td>
      <td>22.572415</td>
      <td>27.873269</td>
      <td>19.385690</td>
      <td>9.148723</td>
      <td>...</td>
      <td>0.969503</td>
      <td>0.879348</td>
      <td>1.998910</td>
      <td>3.879241</td>
      <td>2.155402</td>
      <td>1.202186</td>
      <td>5.606427</td>
      <td>2.144904</td>
      <td>12.699372</td>
      <td>13.258936</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>495</th>
      <td>29.309151</td>
      <td>8.610684</td>
      <td>25.650817</td>
      <td>25.681485</td>
      <td>15.598120</td>
      <td>23.251073</td>
      <td>18.466861</td>
      <td>30.887997</td>
      <td>9.937433</td>
      <td>28.256653</td>
      <td>...</td>
      <td>7.856577</td>
      <td>8.067598</td>
      <td>12.974184</td>
      <td>9.499197</td>
      <td>1.688407</td>
      <td>12.076029</td>
      <td>9.860445</td>
      <td>10.466341</td>
      <td>8.506554</td>
      <td>0.583851</td>
    </tr>
    <tr>
      <th>496</th>
      <td>22.003163</td>
      <td>12.419327</td>
      <td>19.515395</td>
      <td>5.165373</td>
      <td>3.792943</td>
      <td>25.437858</td>
      <td>24.468821</td>
      <td>30.496252</td>
      <td>19.506345</td>
      <td>15.723808</td>
      <td>...</td>
      <td>13.065573</td>
      <td>4.228264</td>
      <td>21.554995</td>
      <td>2.240510</td>
      <td>0.835478</td>
      <td>7.838885</td>
      <td>0.051396</td>
      <td>21.270722</td>
      <td>6.544969</td>
      <td>33.984122</td>
    </tr>
    <tr>
      <th>497</th>
      <td>36.987431</td>
      <td>33.933994</td>
      <td>9.371574</td>
      <td>13.204348</td>
      <td>8.259211</td>
      <td>17.447672</td>
      <td>29.982914</td>
      <td>30.707705</td>
      <td>11.213160</td>
      <td>33.280860</td>
      <td>...</td>
      <td>9.763586</td>
      <td>0.066865</td>
      <td>12.461045</td>
      <td>19.515229</td>
      <td>0.805873</td>
      <td>29.486924</td>
      <td>18.315689</td>
      <td>7.870380</td>
      <td>12.991355</td>
      <td>10.551414</td>
    </tr>
    <tr>
      <th>498</th>
      <td>36.255033</td>
      <td>27.546682</td>
      <td>21.582154</td>
      <td>5.769464</td>
      <td>6.548873</td>
      <td>25.852185</td>
      <td>18.005356</td>
      <td>19.560092</td>
      <td>21.850911</td>
      <td>16.285168</td>
      <td>...</td>
      <td>0.272662</td>
      <td>1.120690</td>
      <td>18.483037</td>
      <td>1.635620</td>
      <td>4.197196</td>
      <td>1.376383</td>
      <td>0.430669</td>
      <td>0.428591</td>
      <td>4.276003</td>
      <td>16.353748</td>
    </tr>
    <tr>
      <th>499</th>
      <td>19.389948</td>
      <td>7.167897</td>
      <td>15.029804</td>
      <td>1.312190</td>
      <td>0.808112</td>
      <td>1.428399</td>
      <td>21.476163</td>
      <td>25.916025</td>
      <td>27.177536</td>
      <td>27.330606</td>
      <td>...</td>
      <td>9.510551</td>
      <td>2.594103</td>
      <td>3.499939</td>
      <td>5.174932</td>
      <td>1.263133</td>
      <td>3.921430</td>
      <td>7.067016</td>
      <td>9.664141</td>
      <td>4.373769</td>
      <td>16.553160</td>
    </tr>
  </tbody>
</table>
<p>500 rows × 283 columns</p>
</div>
</div>

This is our simulation data. Each column holds draws from a players distribution, which are numbered (on the side) 0, 1, ... 499. In theory, we could draw as many simulations as we want. To keep things loading fast I've limited each player to 500 simulations.

More info on the players we're simulating — including position, team, and the number of points they actually ended up scoring in week 3, 2023 is here:

<div class="nb-input">

```python
players = (pd.read_csv('./data/players.csv')
           .assign(player_id=lambda df: df['player_id'].astype(str))
           .set_index('player_id'))
players.head()
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>pos</th>
      <th>team</th>
      <th>actual</th>
    </tr>
    <tr>
      <th>player_id</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1091</th>
      <td>Patrick Mahomes</td>
      <td>QB</td>
      <td>KC</td>
      <td>25.68</td>
    </tr>
    <tr>
      <th>498</th>
      <td>Jalen Hurts</td>
      <td>QB</td>
      <td>PHI</td>
      <td>19.88</td>
    </tr>
    <tr>
      <th>889</th>
      <td>Josh Allen</td>
      <td>QB</td>
      <td>BUF</td>
      <td>21.32</td>
    </tr>
    <tr>
      <th>1094</th>
      <td>Joshua Dobbs</td>
      <td>QB</td>
      <td>ARI</td>
      <td>17.06</td>
    </tr>
    <tr>
      <th>329</th>
      <td>Zach Wilson</td>
      <td>QB</td>
      <td>NYJ</td>
      <td>6.38</td>
    </tr>
  </tbody>
</table>
</div>
</div>

### Descriptive statistics
So it's week 3, 2023 and we have our data.

Let's take a player, say Justin Herbert. 500 simulations. What can we do with this?

Well, if we're interested in projecting how many points he'll score we could take the average value of our simulations:

<div class="nb-input">

```python
print(nsims['justin-herbert'].mean())
```

</div>

<div class="nb-output">
<pre>21.976058849476672</pre>
</div>

Or we can look at the median:

<div class="nb-input">

```python
print(nsims['justin-herbert'].median())
```

</div>

<div class="nb-output">
<pre>21.55108079040353</pre>
</div>

But the real benefit of simulations is how they let you work with distributions. We can get a sense of the distribution with summary statistics:

<div class="nb-input">

```python
print(nsims['justin-herbert'].describe(percentiles=[0.05, .25, .5, .75, .95]))
```

</div>

<div class="nb-output">
<pre>count    500.000000
mean      21.976059
std        8.513235
min        0.606958
5%         9.045559
25%       15.900111
50%       21.551081
75%       27.480257
95%       36.132164
max       49.746482
Name: justin-herbert, dtype: float64</pre>
</div>

Or by visualizing it:

<div class="nb-input">

```python
import seaborn as sns
g = sns.FacetGrid(nsims, aspect=2)
g = g.map(sns.kdeplot, 'justin-herbert', fill=True)
g.fig.subplots_adjust(top=0.9)
g.fig.suptitle("Justin Herbert's Fantasy Points Distribution - Wk 3, 2023")
```

</div>

<div class="nb-output">
<img src="/images/fantasy-monte-carlo/output-1.png" alt="" />
</div>

### Will Herbert outscore Mahomes?
Remember above, when I asked for the probability Justin Herbert outscores Mahomes? 

With our data, figuring this out is easy. We have:

<div class="nb-input">

```python
nsims[['justin-herbert', 'patrick-mahomes']]
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>justin-herbert</th>
      <th>patrick-mahomes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>24.889975</td>
      <td>31.373173</td>
    </tr>
    <tr>
      <th>1</th>
      <td>19.695595</td>
      <td>15.580346</td>
    </tr>
    <tr>
      <th>2</th>
      <td>25.814006</td>
      <td>19.305332</td>
    </tr>
    <tr>
      <th>3</th>
      <td>14.212815</td>
      <td>5.358195</td>
    </tr>
    <tr>
      <th>4</th>
      <td>22.572415</td>
      <td>19.384985</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>495</th>
      <td>18.466861</td>
      <td>29.309151</td>
    </tr>
    <tr>
      <th>496</th>
      <td>24.468821</td>
      <td>22.003163</td>
    </tr>
    <tr>
      <th>497</th>
      <td>29.982914</td>
      <td>36.987431</td>
    </tr>
    <tr>
      <th>498</th>
      <td>18.005356</td>
      <td>36.255033</td>
    </tr>
    <tr>
      <th>499</th>
      <td>21.476163</td>
      <td>19.389948</td>
    </tr>
  </tbody>
</table>
<p>500 rows × 2 columns</p>
</div>
</div>

Then it's just a matter of — did Herbert outscore Mahomes in our simulations? True or False:

<div class="nb-input">

```python
(nsims['justin-herbert'] > nsims['patrick-mahomes'])
```

</div>

<div class="nb-output">
<pre>0      False
1       True
2       True
3       True
4       True
       ...  
495    False
496     True
497    False
498    False
499     True
Length: 500, dtype: bool</pre>
</div>

And taking the average (True is 1, False is 0):

<div class="nb-input">

```python
print((nsims['justin-herbert'] > nsims['patrick-mahomes']).mean())
```

</div>

<div class="nb-output">
<pre>0.426</pre>
</div>

So Herbert is projected to outscore Mahomes 42.6% of the time.

This means Mahomes distribution is further to the right. If we want to see what that looks like:

<div class="nb-input">

```python
nsims_long = nsims[['justin-herbert', 'patrick-mahomes']].stack().reset_index()
nsims_long.columns = ['sim_n', 'player', 'pts']

g = sns.FacetGrid(nsims_long, hue='player', aspect=2)
g.map(sns.kdeplot, 'pts', fill=True)
g.add_legend()
```

</div>

<div class="nb-output">
<img src="/images/fantasy-monte-carlo/output-2.png" alt="" />
</div>

## Other Monte Carlo Applications

What else can we ask?

When working with simulations, you're really only limited by your imagination. For example, what's the probability Justin Herbert outscores both Matt Stafford AND Justin Fields by at least 11.5 points?

Can you imagine working with the probability distribution equations above to figure that out mathematically? But, again, with our `nsims` data it's easy:

<div class="nb-input">

```python
print((nsims['justin-herbert'] >
         nsims[['matthew-stafford', 'justin-fields']].max(axis=1) + 11.5).mean())
```

</div>

<div class="nb-output">
<pre>0.158</pre>
</div>

So about a 16% chance Herbert outscores both Stafford and Fields by at least 11.5 points.

The other benefit: Monte Carlo analysis is flexible. You can take into account whatever you want, as long as you figure out how to build it into the data generating process.

### Projecting best ball distributions
For example, say we're interested in projecting QB points for our best ball team, where we have both Herbert and Matthew Stafford.

This is something that's impossible to figure out numerically, but easy to build into your simulation: 

1. Take a draw from each player, then —
2. Use the higher of the two scores for your QB spot .
3. Analyze that QB score with some basic summary stats.

In this case our data generating process isn't just approximating reality, it's describing it exactly. This is how best ball leagues work.

<div class="nb-input">

```python
nsims['bb_qb'] = nsims[['justin-herbert', 'matthew-stafford']].max(axis=1)

nsims[['bb_qb', 'justin-herbert', 'matthew-stafford']].describe()
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>bb_qb</th>
      <th>justin-herbert</th>
      <th>matthew-stafford</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>500.000000</td>
      <td>500.000000</td>
      <td>500.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>24.183287</td>
      <td>21.976059</td>
      <td>15.842432</td>
    </tr>
    <tr>
      <th>std</th>
      <td>7.519747</td>
      <td>8.513235</td>
      <td>8.145466</td>
    </tr>
    <tr>
      <th>min</th>
      <td>4.254415</td>
      <td>0.606958</td>
      <td>0.027773</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>19.197732</td>
      <td>15.900111</td>
      <td>9.984359</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>23.801324</td>
      <td>21.551081</td>
      <td>15.836984</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>28.720037</td>
      <td>27.480257</td>
      <td>21.395072</td>
    </tr>
    <tr>
      <th>max</th>
      <td>49.746482</td>
      <td>49.746482</td>
      <td>40.711039</td>
    </tr>
  </tbody>
</table>
</div>
</div>

So on average, we'd expect a best ball duo of Herbert and Stafford to score about 24.18 points, vs 21.98 and 15.84 for Herbert and Stafford individually.

What if we want to see how much adding Kirk Cousins would raise our score?

<div class="nb-input">

```python
nsims['bb_qb2'] = nsims[['justin-herbert', 'matthew-stafford', 'kirk-cousins']].max(axis=1)

nsims[['bb_qb2', 'bb_qb', 'justin-herbert', 'matthew-stafford', 'kirk-cousins']].describe().round(2)
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>bb_qb2</th>
      <th>bb_qb</th>
      <th>justin-herbert</th>
      <th>matthew-stafford</th>
      <th>kirk-cousins</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>500.00</td>
      <td>500.00</td>
      <td>500.00</td>
      <td>500.00</td>
      <td>500.00</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>27.03</td>
      <td>24.18</td>
      <td>21.98</td>
      <td>15.84</td>
      <td>21.64</td>
    </tr>
    <tr>
      <th>std</th>
      <td>7.01</td>
      <td>7.52</td>
      <td>8.51</td>
      <td>8.15</td>
      <td>8.15</td>
    </tr>
    <tr>
      <th>min</th>
      <td>12.35</td>
      <td>4.25</td>
      <td>0.61</td>
      <td>0.03</td>
      <td>0.37</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>22.15</td>
      <td>19.20</td>
      <td>15.90</td>
      <td>9.98</td>
      <td>16.07</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>26.38</td>
      <td>23.80</td>
      <td>21.55</td>
      <td>15.84</td>
      <td>20.99</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>31.69</td>
      <td>28.72</td>
      <td>27.48</td>
      <td>21.40</td>
      <td>26.96</td>
    </tr>
    <tr>
      <th>max</th>
      <td>52.09</td>
      <td>49.75</td>
      <td>49.75</td>
      <td>40.71</td>
      <td>52.09</td>
    </tr>
  </tbody>
</table>
</div>
</div>

That brings the average up 3 points, to 27.

By modifying the data generating process and drawing a bunch of simulations, we're able to answer questions about our data it'd be impossible to figure out any other way.

It's also interesting to plot these distributions:

<div class="nb-input">

```python
nsims_long = nsims[['justin-herbert', 'matthew-stafford', 'kirk-cousins', 'bb_qb', 'bb_qb2']].stack().reset_index()
nsims_long.columns = ['sim_n', 'player', 'pts']

g = sns.FacetGrid(nsims_long, hue='player', aspect=2)
g.map(sns.kdeplot, 'pts', fill=True)
g.add_legend()
```

</div>

<div class="nb-output">
<img src="/images/fantasy-monte-carlo/output-3.png" alt="" />
</div>

## Interlude - how are these simulations calculated anyway?

Good question. For the very first version of these simulations I figured out a good *Gamma* distribution for each player, and took draws from that.

A Gamma distribution is shaped similarly to a Normal distribution, but more skewed. Just like a normal distribution has parameters <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>μ</mi></mrow><annotation encoding="application/x-tex">\mu</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.625em;vertical-align:-0.1944em;"></span><span class="mord mathnormal">μ</span></span></span></span> and <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>σ</mi></mrow><annotation encoding="application/x-tex">\sigma</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.4306em;"></span><span class="mord mathnormal" style="margin-right:0.0359em;">σ</span></span></span></span> for average and standard deviation, a gamma distribution has parameters named <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>α</mi></mrow><annotation encoding="application/x-tex">\alpha</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.4306em;"></span><span class="mord mathnormal" style="margin-right:0.0037em;">α</span></span></span></span> and <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>β</mi></mrow><annotation encoding="application/x-tex">\beta</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.8889em;vertical-align:-0.1944em;"></span><span class="mord mathnormal" style="margin-right:0.0528em;">β</span></span></span></span>. The formula for it is:


<div class="math-display"><span class="katex-display"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block"><semantics><mrow><mi>p</mi><mo stretchy="false">(</mo><mi>x</mi><mo separator="true">;</mo><mi>α</mi><mo separator="true">,</mo><mi>β</mi><mo stretchy="false">)</mo><mo>=</mo><mfrac><mrow><msup><mi>β</mi><mi>α</mi></msup><msup><mi>x</mi><mrow><mi>α</mi><mo>−</mo><mn>1</mn></mrow></msup><msup><mi>e</mi><mrow><mo>−</mo><mi>β</mi><mi>x</mi></mrow></msup></mrow><mrow><mi mathvariant="normal">Γ</mi><mo stretchy="false">(</mo><mi>α</mi><mo stretchy="false">)</mo></mrow></mfrac><mspace width="1em"/><mtext>for</mtext><mtext>  </mtext><mi>x</mi><mo>&gt;</mo><mn>0</mn></mrow><annotation encoding="application/x-tex">p(x; \alpha, \beta) = \frac{\beta^\alpha x^{\alpha-1} e^{-\beta x}}{\Gamma(\alpha)} \quad \text{for} \; x &gt; 0</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:1em;vertical-align:-0.25em;"></span><span class="mord mathnormal">p</span><span class="mopen">(</span><span class="mord mathnormal">x</span><span class="mpunct">;</span><span class="mspace" style="margin-right:0.1667em;"></span><span class="mord mathnormal" style="margin-right:0.0037em;">α</span><span class="mpunct">,</span><span class="mspace" style="margin-right:0.1667em;"></span><span class="mord mathnormal" style="margin-right:0.0528em;">β</span><span class="mclose">)</span><span class="mspace" style="margin-right:0.2778em;"></span><span class="mrel">=</span><span class="mspace" style="margin-right:0.2778em;"></span></span><span class="katex-base"><span class="katex-strut" style="height:2.4621em;vertical-align:-0.936em;"></span><span class="mord"><span class="mopen nulldelimiter"></span><span class="mfrac"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height:1.5261em;"><span style="top:-2.314em;"><span class="pstrut" style="height:3em;"></span><span class="mord"><span class="mord">Γ</span><span class="mopen">(</span><span class="mord mathnormal" style="margin-right:0.0037em;">α</span><span class="mclose">)</span></span></span><span style="top:-3.23em;"><span class="pstrut" style="height:3em;"></span><span class="frac-line" style="border-bottom-width:0.04em;"></span></span><span style="top:-3.677em;"><span class="pstrut" style="height:3em;"></span><span class="mord"><span class="mord"><span class="mord mathnormal" style="margin-right:0.0528em;">β</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:0.6644em;"><span style="top:-3.063em;margin-right:0.05em;"><span class="pstrut" style="height:2.7em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mathnormal mtight" style="margin-right:0.0037em;">α</span></span></span></span></span></span></span></span><span class="mord"><span class="mord mathnormal">x</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:0.8141em;"><span style="top:-3.063em;margin-right:0.05em;"><span class="pstrut" style="height:2.7em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mtight"><span class="mord mathnormal mtight" style="margin-right:0.0037em;">α</span><span class="mbin mtight">−</span><span class="mord mtight">1</span></span></span></span></span></span></span></span></span><span class="mord"><span class="mord mathnormal">e</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:0.8491em;"><span style="top:-3.063em;margin-right:0.05em;"><span class="pstrut" style="height:2.7em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mtight"><span class="mord mtight">−</span><span class="mord mathnormal mtight" style="margin-right:0.0528em;">β</span><span class="mord mathnormal mtight">x</span></span></span></span></span></span></span></span></span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height:0.936em;"><span></span></span></span></span></span><span class="mclose nulldelimiter"></span></span><span class="mspace" style="margin-right:1em;"></span><span class="mord text"><span class="mord">for</span></span><span class="mspace" style="margin-right:0.2778em;"></span><span class="mord mathnormal">x</span><span class="mspace" style="margin-right:0.2778em;"></span><span class="mrel">&gt;</span><span class="mspace" style="margin-right:0.2778em;"></span></span><span class="katex-base"><span class="katex-strut" style="height:0.6444em;"></span><span class="mord">0</span></span></span></span></span></div>


where <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mo stretchy="false">(</mo><mi mathvariant="normal">Γ</mi><mo stretchy="false">(</mo><mi>z</mi><mo stretchy="false">)</mo><mo stretchy="false">)</mo></mrow><annotation encoding="application/x-tex">(\Gamma(z))</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:1em;vertical-align:-0.25em;"></span><span class="mopen">(</span><span class="mord">Γ</span><span class="mopen">(</span><span class="mord mathnormal" style="margin-right:0.044em;">z</span><span class="mclose">))</span></span></span></span> is:


<div class="math-display"><span class="katex-display"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML" display="block"><semantics><mrow><mi mathvariant="normal">Γ</mi><mo stretchy="false">(</mo><mi>z</mi><mo stretchy="false">)</mo><mo>=</mo><msubsup><mo>∫</mo><mn>0</mn><mi mathvariant="normal">∞</mi></msubsup><msup><mi>t</mi><mrow><mi>z</mi><mo>−</mo><mn>1</mn></mrow></msup><msup><mi>e</mi><mrow><mo>−</mo><mi>t</mi></mrow></msup><mtext> </mtext><mi>d</mi><mi>t</mi><mspace width="1em"/><mtext>for</mtext><mtext>  </mtext><mi>z</mi><mo>&gt;</mo><mn>0</mn></mrow><annotation encoding="application/x-tex">\Gamma(z) = \int_0^{\infty} t^{z-1} e^{-t} \, dt \quad \text{for} \; z &gt; 0</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:1em;vertical-align:-0.25em;"></span><span class="mord">Γ</span><span class="mopen">(</span><span class="mord mathnormal" style="margin-right:0.044em;">z</span><span class="mclose">)</span><span class="mspace" style="margin-right:0.2778em;"></span><span class="mrel">=</span><span class="mspace" style="margin-right:0.2778em;"></span></span><span class="katex-base"><span class="katex-strut" style="height:2.3262em;vertical-align:-0.9119em;"></span><span class="mop"><span class="mop op-symbol large-op" style="margin-right:0.4445em;position:relative;top:-0.0011em;">∫</span><span class="msupsub"><span class="vlist-t vlist-t2"><span class="vlist-r"><span class="vlist" style="height:1.4143em;"><span style="top:-1.7881em;margin-left:-0.4445em;margin-right:0.05em;"><span class="pstrut" style="height:2.7em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mtight">0</span></span></span><span style="top:-3.8129em;margin-right:0.05em;"><span class="pstrut" style="height:2.7em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mtight"><span class="mord mtight">∞</span></span></span></span></span><span class="vlist-s">​</span></span><span class="vlist-r"><span class="vlist" style="height:0.9119em;"><span></span></span></span></span></span></span><span class="mspace" style="margin-right:0.1667em;"></span><span class="mord"><span class="mord mathnormal">t</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:0.8641em;"><span style="top:-3.113em;margin-right:0.05em;"><span class="pstrut" style="height:2.7em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mtight"><span class="mord mathnormal mtight" style="margin-right:0.044em;">z</span><span class="mbin mtight">−</span><span class="mord mtight">1</span></span></span></span></span></span></span></span></span><span class="mord"><span class="mord mathnormal">e</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height:0.8436em;"><span style="top:-3.113em;margin-right:0.05em;"><span class="pstrut" style="height:2.7em;"></span><span class="katex-sizing reset-size6 size3 mtight"><span class="mord mtight"><span class="mord mtight">−</span><span class="mord mathnormal mtight">t</span></span></span></span></span></span></span></span></span><span class="mspace" style="margin-right:0.1667em;"></span><span class="mord mathnormal">d</span><span class="mord mathnormal">t</span><span class="mspace" style="margin-right:1em;"></span><span class="mord text"><span class="mord">for</span></span><span class="mspace" style="margin-right:0.2778em;"></span><span class="mord mathnormal" style="margin-right:0.044em;">z</span><span class="mspace" style="margin-right:0.2778em;"></span><span class="mrel">&gt;</span><span class="mspace" style="margin-right:0.2778em;"></span></span><span class="katex-base"><span class="katex-strut" style="height:0.6444em;"></span><span class="mord">0</span></span></span></span></span></div>


So the first version of these simulations involved (a) figuring out the best gamma distribution (i.e. the best values of <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>α</mi></mrow><annotation encoding="application/x-tex">\alpha</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.4306em;"></span><span class="mord mathnormal" style="margin-right:0.0037em;">α</span></span></span></span> and <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>β</mi></mrow><annotation encoding="application/x-tex">\beta</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.8889em;vertical-align:-0.1944em;"></span><span class="mord mathnormal" style="margin-right:0.0528em;">β</span></span></span></span>) for each player, and (b) taking a bunch of random draws (the simulations) from that.

These formulas look intimidating, but in practice this is mostly done with code. You tell the computer to figure out the best values of <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>α</mi></mrow><annotation encoding="application/x-tex">\alpha</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.4306em;"></span><span class="mord mathnormal" style="margin-right:0.0037em;">α</span></span></span></span> and <span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>β</mi></mrow><annotation encoding="application/x-tex">\beta</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="katex-base"><span class="katex-strut" style="height:0.8889em;vertical-align:-0.1944em;"></span><span class="mord mathnormal" style="margin-right:0.0528em;">β</span></span></span></span> to match real world data. The factors that went into it:

1. weekly expert consensus rankings (higher ranked players are better, players who experts are split on have wider ranges of outcomes)
2. betting info, i.e. team totals, opponent totals, and spreads.

That was the first version of these simulations. Since then I've switched to a fancier modeling technique that basically blends a bunch of distributions together. So rather than one gamma curve, it's a bunch of curves. This lets the model be much more flexible.

The two models (gray curves) and how they compare with the distribution of actual points scored (blue curve) are here:
<img src="/images/fantasy-monte-carlo/old.jpg" alt="Old model - gamma distribution" width="500"/>
<img src="/images/fantasy-monte-carlo/new.jpg" alt="New model - blended distributions" width="500"/>

## Actual scores vs projections
Because we're looking at data from last year, we know how many points these players actually scored, it's the `actual` column of our player data:

<div class="nb-input">

```python
players
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>pos</th>
      <th>team</th>
      <th>actual</th>
    </tr>
    <tr>
      <th>player_id</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1091</th>
      <td>Patrick Mahomes</td>
      <td>QB</td>
      <td>KC</td>
      <td>25.68</td>
    </tr>
    <tr>
      <th>498</th>
      <td>Jalen Hurts</td>
      <td>QB</td>
      <td>PHI</td>
      <td>19.88</td>
    </tr>
    <tr>
      <th>889</th>
      <td>Josh Allen</td>
      <td>QB</td>
      <td>BUF</td>
      <td>21.32</td>
    </tr>
    <tr>
      <th>1094</th>
      <td>Joshua Dobbs</td>
      <td>QB</td>
      <td>ARI</td>
      <td>17.06</td>
    </tr>
    <tr>
      <th>329</th>
      <td>Zach Wilson</td>
      <td>QB</td>
      <td>NYJ</td>
      <td>6.38</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>5161</th>
      <td>DET</td>
      <td>DST</td>
      <td>DET</td>
      <td>16.00</td>
    </tr>
    <tr>
      <th>5177</th>
      <td>PIT</td>
      <td>DST</td>
      <td>PIT</td>
      <td>14.00</td>
    </tr>
    <tr>
      <th>5179</th>
      <td>SF</td>
      <td>DST</td>
      <td>SF</td>
      <td>8.00</td>
    </tr>
    <tr>
      <th>5152</th>
      <td>ATL</td>
      <td>DST</td>
      <td>ATL</td>
      <td>3.00</td>
    </tr>
    <tr>
      <th>5169</th>
      <td>LV</td>
      <td>DST</td>
      <td>LV</td>
      <td>2.00</td>
    </tr>
  </tbody>
</table>
<p>283 rows × 4 columns</p>
</div>
</div>

So Mahomes scored 25.68 points in Week 2, 2023. How does that compare with what we simulated for him beforehand?

Well, our median Mahomes simulation was:

<div class="nb-input">

```python
print(nsims['patrick-mahomes'].median())
```

</div>

<div class="nb-output">
<pre>24.493723591765647</pre>
</div>

So it's pretty close.

What about percentile-wise?

<div class="nb-input">

```python
print((25.68 > nsims['patrick-mahomes']).mean())
```

</div>

<div class="nb-output">
<pre>0.56</pre>
</div>

So Mahomes score in Week 3 beat 56% of his simulations, i.e. it was a *56th percentile* score.

Let's get projected score — by taking the average of the simulations — for all the quarterbacks.

(Note to do that I'm loading in another copy of our simulation data `sims` that's exactly the same as `nsims`, but with `player_id` as the column titles instead of `first-last` name.)

<div class="nb-input">

```python
sims = pd.read_csv('./data/sims.csv')

qbs = players.loc[players['pos'] == 'QB']
qbs['proj'] = sims.mean().round(2)

qbs.sort_values('proj', ascending=False).head(15)[['name', 'proj', 'actual']]
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>proj</th>
      <th>actual</th>
    </tr>
    <tr>
      <th>player_id</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1091</th>
      <td>Patrick Mahomes</td>
      <td>24.11</td>
      <td>25.68</td>
    </tr>
    <tr>
      <th>494</th>
      <td>Justin Herbert</td>
      <td>21.98</td>
      <td>29.30</td>
    </tr>
    <tr>
      <th>2085</th>
      <td>Kirk Cousins</td>
      <td>21.64</td>
      <td>25.68</td>
    </tr>
    <tr>
      <th>498</th>
      <td>Jalen Hurts</td>
      <td>21.35</td>
      <td>19.88</td>
    </tr>
    <tr>
      <th>893</th>
      <td>Lamar Jackson</td>
      <td>21.24</td>
      <td>28.18</td>
    </tr>
    <tr>
      <th>889</th>
      <td>Josh Allen</td>
      <td>21.01</td>
      <td>21.32</td>
    </tr>
    <tr>
      <th>493</th>
      <td>Tua Tagovailoa</td>
      <td>19.95</td>
      <td>28.36</td>
    </tr>
    <tr>
      <th>327</th>
      <td>Trevor Lawrence</td>
      <td>19.10</td>
      <td>14.36</td>
    </tr>
    <tr>
      <th>1297</th>
      <td>Dak Prescott</td>
      <td>18.67</td>
      <td>14.36</td>
    </tr>
    <tr>
      <th>1883</th>
      <td>Geno Smith</td>
      <td>17.72</td>
      <td>15.44</td>
    </tr>
    <tr>
      <th>328</th>
      <td>Justin Fields</td>
      <td>17.56</td>
      <td>10.66</td>
    </tr>
    <tr>
      <th>1088</th>
      <td>Deshaun Watson</td>
      <td>17.25</td>
      <td>21.16</td>
    </tr>
    <tr>
      <th>492</th>
      <td>Joe Burrow</td>
      <td>17.24</td>
      <td>8.16</td>
    </tr>
    <tr>
      <th>1288</th>
      <td>Jared Goff</td>
      <td>17.19</td>
      <td>18.02</td>
    </tr>
    <tr>
      <th>156</th>
      <td>Brock Purdy</td>
      <td>16.61</td>
      <td>20.30</td>
    </tr>
  </tbody>
</table>
</div>
</div>

Now let's calculate each quarterback's percentile too:

<div class="nb-input">

```python
def fpts_pctile(row):
    return (row['actual'] > sims[str(row.name)]).mean()

qbs['pctile'] = qbs.apply(fpts_pctile, axis=1)
```

</div>

Here are the top 15 projected QBs and how they did:

<div class="nb-input">

```python
qbs.sort_values('proj', ascending=False).head(15)[['name', 'proj', 'actual', 'pctile']]
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>proj</th>
      <th>actual</th>
      <th>pctile</th>
    </tr>
    <tr>
      <th>player_id</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1091</th>
      <td>Patrick Mahomes</td>
      <td>24.11</td>
      <td>25.68</td>
      <td>0.560</td>
    </tr>
    <tr>
      <th>494</th>
      <td>Justin Herbert</td>
      <td>21.98</td>
      <td>29.30</td>
      <td>0.808</td>
    </tr>
    <tr>
      <th>2085</th>
      <td>Kirk Cousins</td>
      <td>21.64</td>
      <td>25.68</td>
      <td>0.694</td>
    </tr>
    <tr>
      <th>498</th>
      <td>Jalen Hurts</td>
      <td>21.35</td>
      <td>19.88</td>
      <td>0.394</td>
    </tr>
    <tr>
      <th>893</th>
      <td>Lamar Jackson</td>
      <td>21.24</td>
      <td>28.18</td>
      <td>0.808</td>
    </tr>
    <tr>
      <th>889</th>
      <td>Josh Allen</td>
      <td>21.01</td>
      <td>21.32</td>
      <td>0.536</td>
    </tr>
    <tr>
      <th>493</th>
      <td>Tua Tagovailoa</td>
      <td>19.95</td>
      <td>28.36</td>
      <td>0.854</td>
    </tr>
    <tr>
      <th>327</th>
      <td>Trevor Lawrence</td>
      <td>19.10</td>
      <td>14.36</td>
      <td>0.246</td>
    </tr>
    <tr>
      <th>1297</th>
      <td>Dak Prescott</td>
      <td>18.67</td>
      <td>14.36</td>
      <td>0.284</td>
    </tr>
    <tr>
      <th>1883</th>
      <td>Geno Smith</td>
      <td>17.72</td>
      <td>15.44</td>
      <td>0.402</td>
    </tr>
    <tr>
      <th>328</th>
      <td>Justin Fields</td>
      <td>17.56</td>
      <td>10.66</td>
      <td>0.206</td>
    </tr>
    <tr>
      <th>1088</th>
      <td>Deshaun Watson</td>
      <td>17.25</td>
      <td>21.16</td>
      <td>0.706</td>
    </tr>
    <tr>
      <th>492</th>
      <td>Joe Burrow</td>
      <td>17.24</td>
      <td>8.16</td>
      <td>0.136</td>
    </tr>
    <tr>
      <th>1288</th>
      <td>Jared Goff</td>
      <td>17.19</td>
      <td>18.02</td>
      <td>0.558</td>
    </tr>
    <tr>
      <th>156</th>
      <td>Brock Purdy</td>
      <td>16.61</td>
      <td>20.30</td>
      <td>0.688</td>
    </tr>
  </tbody>
</table>
</div>
</div>

So Justin Herbert scored 29.30 points vs his projection of 21.98. About an 80th percentile week.  We'd expect to see an 80th performance about 1 out of every 5 times. And sure enough, if you look at the 15 players above, three of them (Herbert, Lamar Jackson, Deshaun Watson) have a `pctile` > 80.

Similarly, we should expect to see 10% of the players under 10 pctile, 20% under 20, etc. And actually it's pretty close:

<div class="nb-input">

```python
qbs['pctile'].describe(percentiles=[.1, .2, .3, .4, .5, .6, .7, .8, .9]).round(2)
```

</div>

<div class="nb-output">
<pre>count    31.00
mean      0.49
std       0.26
min       0.01
10%       0.14
20%       0.23
30%       0.29
40%       0.39
50%       0.52
60%       0.56
70%       0.69
80%       0.74
90%       0.81
max       0.89
Name: pctile, dtype: float64</pre>
</div>

14% of players had 10th percentile or less draws, 23% of players, 20th percentile, etc.

This is the sign of a good model.

### Percentiles as luck

A player's actual point percentile is one way to quantify "luck".

Good draws from further right in the distrubution have higher percentiles, and are luckier. Worse draws, from further left, are unlucky.

Let's look at the top 10 luckiest fantasy QB performances in Week 3, 2023:

<div class="nb-input">

```python
qbs.sort_values('pctile', ascending=False).head(10)[['name', 'proj', 'actual', 'pctile']]
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>proj</th>
      <th>actual</th>
      <th>pctile</th>
    </tr>
    <tr>
      <th>player_id</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>497</th>
      <td>Jordan Love</td>
      <td>14.49</td>
      <td>24.26</td>
      <td>0.892</td>
    </tr>
    <tr>
      <th>2301</th>
      <td>Andy Dalton</td>
      <td>12.94</td>
      <td>23.54</td>
      <td>0.884</td>
    </tr>
    <tr>
      <th>493</th>
      <td>Tua Tagovailoa</td>
      <td>19.95</td>
      <td>28.36</td>
      <td>0.854</td>
    </tr>
    <tr>
      <th>1094</th>
      <td>Joshua Dobbs</td>
      <td>11.12</td>
      <td>17.06</td>
      <td>0.808</td>
    </tr>
    <tr>
      <th>893</th>
      <td>Lamar Jackson</td>
      <td>21.24</td>
      <td>28.18</td>
      <td>0.808</td>
    </tr>
    <tr>
      <th>494</th>
      <td>Justin Herbert</td>
      <td>21.98</td>
      <td>29.30</td>
      <td>0.808</td>
    </tr>
    <tr>
      <th>150</th>
      <td>Kenny Pickett</td>
      <td>13.83</td>
      <td>18.50</td>
      <td>0.738</td>
    </tr>
    <tr>
      <th>1757</th>
      <td>Jimmy Garoppolo</td>
      <td>13.19</td>
      <td>17.66</td>
      <td>0.716</td>
    </tr>
    <tr>
      <th>1088</th>
      <td>Deshaun Watson</td>
      <td>17.25</td>
      <td>21.16</td>
      <td>0.706</td>
    </tr>
    <tr>
      <th>2085</th>
      <td>Kirk Cousins</td>
      <td>21.64</td>
      <td>25.68</td>
      <td>0.694</td>
    </tr>
  </tbody>
</table>
</div>
</div>

(Aside: remember — this is from week 3, 2023. *Now* in 2024, we know Jordan Love is good (he just became the highest paid QB ever). But these distributions were built using the best information we had in September 2023. Back then opinions about Love were much more up in the air, which meant his projected distribution was further to the left. So while Love might have been good the whole time, and his success isn't "luck" from his POV, you were indeed lucky (or ahead of the fantasy consensus) to get these kind of points out of Love back in early 2023.)

And here are the unluckiest players:

<div class="nb-input">

```python
qbs.sort_values('pctile', ascending=True).head(10)[['name', 'proj', 'actual', 'pctile']]
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>proj</th>
      <th>actual</th>
      <th>pctile</th>
    </tr>
    <tr>
      <th>player_id</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>151</th>
      <td>Sam Howell</td>
      <td>13.30</td>
      <td>0.60</td>
      <td>0.014</td>
    </tr>
    <tr>
      <th>677</th>
      <td>Daniel Jones</td>
      <td>14.63</td>
      <td>3.98</td>
      <td>0.082</td>
    </tr>
    <tr>
      <th>492</th>
      <td>Joe Burrow</td>
      <td>17.24</td>
      <td>8.16</td>
      <td>0.136</td>
    </tr>
    <tr>
      <th>2082</th>
      <td>Ryan Tannehill</td>
      <td>11.63</td>
      <td>4.16</td>
      <td>0.140</td>
    </tr>
    <tr>
      <th>328</th>
      <td>Justin Fields</td>
      <td>17.56</td>
      <td>10.66</td>
      <td>0.206</td>
    </tr>
    <tr>
      <th>155</th>
      <td>Desmond Ridder</td>
      <td>12.83</td>
      <td>6.34</td>
      <td>0.216</td>
    </tr>
    <tr>
      <th>1689</th>
      <td>Derek Carr</td>
      <td>14.40</td>
      <td>8.12</td>
      <td>0.232</td>
    </tr>
    <tr>
      <th>327</th>
      <td>Trevor Lawrence</td>
      <td>19.10</td>
      <td>14.36</td>
      <td>0.246</td>
    </tr>
    <tr>
      <th>1297</th>
      <td>Dak Prescott</td>
      <td>18.67</td>
      <td>14.36</td>
      <td>0.284</td>
    </tr>
    <tr>
      <th>890</th>
      <td>Baker Mayfield</td>
      <td>14.47</td>
      <td>10.04</td>
      <td>0.290</td>
    </tr>
  </tbody>
</table>
</div>
</div>

(Note you could reverse what we Love above and apply it to someone like Fields or Lawrence)

### Would you rather be lucky or good?
Would you rather be lucky or good? Well it depends.

Patrick Mahomes is good. He has a very rightward projected point distribution.

He wasn't particularly lucky in week 3, with a 56th percentile draw.

But because he's good, that still meant 25.68 points. Meanwhile, Andy Dalton was very lucky in week 3 (88th percentile draw), but since he's not that good (the median of his distribution is about 13 points) he still scored less than Mahomes.

So really, the best performing players are usually lucky *and* good. We can see that by looking at the top performers:

<div class="nb-input">

```python
qbs.sort_values('actual', ascending=False).head(10)[['name', 'proj', 'actual', 'pctile']]
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>proj</th>
      <th>actual</th>
      <th>pctile</th>
    </tr>
    <tr>
      <th>player_id</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>494</th>
      <td>Justin Herbert</td>
      <td>21.98</td>
      <td>29.30</td>
      <td>0.808</td>
    </tr>
    <tr>
      <th>493</th>
      <td>Tua Tagovailoa</td>
      <td>19.95</td>
      <td>28.36</td>
      <td>0.854</td>
    </tr>
    <tr>
      <th>893</th>
      <td>Lamar Jackson</td>
      <td>21.24</td>
      <td>28.18</td>
      <td>0.808</td>
    </tr>
    <tr>
      <th>1091</th>
      <td>Patrick Mahomes</td>
      <td>24.11</td>
      <td>25.68</td>
      <td>0.560</td>
    </tr>
    <tr>
      <th>2085</th>
      <td>Kirk Cousins</td>
      <td>21.64</td>
      <td>25.68</td>
      <td>0.694</td>
    </tr>
    <tr>
      <th>497</th>
      <td>Jordan Love</td>
      <td>14.49</td>
      <td>24.26</td>
      <td>0.892</td>
    </tr>
    <tr>
      <th>2301</th>
      <td>Andy Dalton</td>
      <td>12.94</td>
      <td>23.54</td>
      <td>0.884</td>
    </tr>
    <tr>
      <th>889</th>
      <td>Josh Allen</td>
      <td>21.01</td>
      <td>21.32</td>
      <td>0.536</td>
    </tr>
    <tr>
      <th>1088</th>
      <td>Deshaun Watson</td>
      <td>17.25</td>
      <td>21.16</td>
      <td>0.706</td>
    </tr>
    <tr>
      <th>156</th>
      <td>Brock Purdy</td>
      <td>16.61</td>
      <td>20.30</td>
      <td>0.688</td>
    </tr>
  </tbody>
</table>
</div>
</div>

Two of the top three are good QBs (Herbert and Lamar) who got fairly lucky (80th percentile) draws. There's also Tua, who is a bit less good but got an even luckier draw (85th percentile). Then there's Mahomes.

In reality, high score are a combo of luck *and* skill. But, since you can't predict luck, you should just focus on the skill part, which is what you do when you start players with the best distributions.

## Correlations
One of the most useful things about these simulations is that they're correlated.

Correlation summarizes the tendency of numbers to move together. The usual way of calculating correlation (Pearson's) summarizes this tendency by giving you a number between -1 and 1.

Variables with a -1 correlation move perfectly in opposite directions; variables that move in the same direction have a correlation of 1. A correlation of 0 means the variables have no relationship.

For example, the correlation between a QB and his WR1 is about 0.40. As quarterbacks tend to score more, their WR1's tend to score more too. It's not a sure thing — it's possible the QB had a big game by throwing to his WR2 or his TE — but their scores tend to move together.

You can see here that the projections for Herbert and Keenan Allen — though the data is purely simulated — have a correlation around 0.40, just like it'd be in real life.

<div class="nb-input">

```python
nsims[['justin-herbert', 'keenan-allen']].corr()
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>justin-herbert</th>
      <th>keenan-allen</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>justin-herbert</th>
      <td>1.000000</td>
      <td>0.400943</td>
    </tr>
    <tr>
      <th>keenan-allen</th>
      <td>0.400943</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>
</div>

Same with Herbert and the DST he was playing against (Vikings this week) — except the correlation between a QB and the DST he's playing against is even stronger, and negative:

<div class="nb-input">

```python
nsims[['justin-herbert', 'min']].corr()
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>justin-herbert</th>
      <th>min</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>justin-herbert</th>
      <td>1.000000</td>
      <td>-0.547627</td>
    </tr>
    <tr>
      <th>min</th>
      <td>-0.547627</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>
</div>

Note: these correlated projections definitely aren't an accident or something that just happened. It took a lot of work behind the scenes to (a) figure out what these historical correlations between players in the same game were, (b) come up with a way to simulate draws from players while preserving them, and (c) make sure the distributions were accurate overall.

It's turned out well. We ran these separately above, but what's great about these projections is that they're all correlated *simultaneously*, that is — Herbert is positively correlated with Keenan Allen (and Ekeler, Mike Williams and his K etc) and negatively correlated with the Vikings DST, *all at the same time.*

<div class="nb-input">

```python
nsims[['justin-herbert', 'keenan-allen', 'min']].corr()
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>justin-herbert</th>
      <th>keenan-allen</th>
      <th>min</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>justin-herbert</th>
      <td>1.000000</td>
      <td>0.400943</td>
      <td>-0.547627</td>
    </tr>
    <tr>
      <th>keenan-allen</th>
      <td>0.400943</td>
      <td>1.000000</td>
      <td>-0.236117</td>
    </tr>
    <tr>
      <th>min</th>
      <td>-0.547627</td>
      <td>-0.236117</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>
</div>

You can see Keenan is also negatively correlated with the Minnesota D, but not as much as Herbert.

Let's add a few more:

<div class="nb-input">

```python
nsims[['justin-herbert', 'kirk-cousins', 'keenan-allen', 'justin-jefferson', 'min', 'jordan-love']].corr().round(2)
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>justin-herbert</th>
      <th>kirk-cousins</th>
      <th>keenan-allen</th>
      <th>justin-jefferson</th>
      <th>min</th>
      <th>jordan-love</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>justin-herbert</th>
      <td>1.00</td>
      <td>0.22</td>
      <td>0.40</td>
      <td>0.10</td>
      <td>-0.55</td>
      <td>-0.01</td>
    </tr>
    <tr>
      <th>kirk-cousins</th>
      <td>0.22</td>
      <td>1.00</td>
      <td>0.09</td>
      <td>0.27</td>
      <td>-0.07</td>
      <td>-0.03</td>
    </tr>
    <tr>
      <th>keenan-allen</th>
      <td>0.40</td>
      <td>0.09</td>
      <td>1.00</td>
      <td>0.11</td>
      <td>-0.24</td>
      <td>-0.01</td>
    </tr>
    <tr>
      <th>justin-jefferson</th>
      <td>0.10</td>
      <td>0.27</td>
      <td>0.11</td>
      <td>1.00</td>
      <td>-0.08</td>
      <td>-0.04</td>
    </tr>
    <tr>
      <th>min</th>
      <td>-0.55</td>
      <td>-0.07</td>
      <td>-0.24</td>
      <td>-0.08</td>
      <td>1.00</td>
      <td>-0.04</td>
    </tr>
    <tr>
      <th>jordan-love</th>
      <td>-0.01</td>
      <td>-0.03</td>
      <td>-0.01</td>
      <td>-0.04</td>
      <td>-0.04</td>
      <td>1.00</td>
    </tr>
  </tbody>
</table>
</div>
</div>

We can see Herbert and Cousins — opposing QBs — are positively correlated. Many times (not every time, otherwise the correlation would be 1) gameflow leads to QBs either both doing well (e.g. a shootout) or poorly (e.g. a grind out game).

I also added Jordan Love (who was playing the Saints) so you can see he's not correlated with anyone at all. His correlations with all the LAC-LV players are around around 0 (they're not perfectly 0 since there's noise in the data). This makes sense, since he's playing hundreds of miles away.

### Conditional Probabilities
Another way of seeing how these correlations affect players scores is by looking at *conditional* probabilities. For example, with PPR scoring in week 3, 2023, Keenan Allen's regular, unconditional projected points distribution looked like this:

<div class="nb-input">

```python
nsims['keenan-allen'].describe().round(2)
```

</div>

<div class="nb-output">
<pre>count    500.00
mean      17.49
std        9.45
min        0.10
25%       10.33
50%       16.81
75%       24.96
max       44.55
Name: keenan-allen, dtype: float64</pre>
</div>

But what if we want to know Allen's range of outcomes, *conditional* on Herbert scoring at least 30 points, an then again when Herbert scores 12 or less.

The fact that their simulations are positively correlated means these distributions will be higher and lower respectively:

<div class="nb-input">

```python
pd.concat([
    nsims.loc[nsims['justin-herbert'] > 30, 'keenan-allen'].describe(),
    nsims.loc[nsims['justin-herbert'] < 12, 'keenan-allen'].describe()], axis=1)
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>keenan-allen</th>
      <th>keenan-allen</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>83.000000</td>
      <td>57.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>24.816760</td>
      <td>11.357782</td>
    </tr>
    <tr>
      <th>std</th>
      <td>9.114331</td>
      <td>7.474711</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0.425437</td>
      <td>0.330261</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>19.976145</td>
      <td>4.729811</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>25.946795</td>
      <td>11.630839</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>30.683469</td>
      <td>16.518819</td>
    </tr>
    <tr>
      <th>max</th>
      <td>42.979666</td>
      <td>29.838108</td>
    </tr>
  </tbody>
</table>
</div>
</div>

### Who should I start Monday night?
Factoring in these correlations (along with the shape of a players point distribution generally) allows us to be more precise with the type of questions we want to answer.

For example, say I was going into MNF week 3, 2023 wondering who should I start: Mike Evans or Tee Higgins?

In terms of a simple, "who will score more points?" the simulations say Evans.

<div class="nb-input">

```python
print((nsims['mike-evans'] > nsims['tee-higgins']).mean())
```

</div>

<div class="nb-output">
<pre>0.564</pre>
</div>

And that's fine. But again, it's Monday night, so most guys have played. What if I'm down 40 points and I also have Joe Burrow?

<div class="nb-input">

```python
print((nsims[['joe-burrow', 'mike-evans']].sum(axis=1) > 50).mean())
```

</div>

<div class="nb-output">
<pre>0.064</pre>
</div>

<div class="nb-input">

```python
print((nsims[['joe-burrow', 'tee-higgins']].sum(axis=1) > 50).mean())
```

</div>

<div class="nb-output">
<pre>0.09</pre>
</div>

My chances with Higgens (9%) and Burrow much better than my chances with Mike Evans (6%) and Burrow, even though Evans usually scores more. This is what taking positional correlations into account allows you to do.

### Playing "offense" or "defense" as the underdog or favorite
Let's look at a simplified fantasy matchup. Say we're in a 1 QB, 1 DST league. Our opponent this week is good, with Justin Herbert (2nd ranked QB) and the Cowboys Defense (3rd ranked DST).  Our QB is the solidly average (10th ranked QB) Geno Smith, and our DST options aren't great either. We're trying to decide whether to start the Steelers (ranked 16) or Minnesota (ranked 19).

Pittsburgh DST averages more points than the Vikings DST:

<div class="nb-input">

```python
nsims[['min', 'pit']].describe()
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>min</th>
      <th>pit</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>500.000000</td>
      <td>500.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>7.078593</td>
      <td>7.657250</td>
    </tr>
    <tr>
      <th>std</th>
      <td>5.308242</td>
      <td>6.036458</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0.008882</td>
      <td>0.026179</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>2.772932</td>
      <td>2.548929</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>6.077938</td>
      <td>6.454133</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>10.293269</td>
      <td>11.583480</td>
    </tr>
    <tr>
      <th>max</th>
      <td>27.438368</td>
      <td>31.974950</td>
    </tr>
  </tbody>
</table>
</div>
</div>

In a vacuum, we'd definitely start them. But the Vikings D is playing against Herbert this week, so their scores are negatively correlated. If Herbert has a bad game, the Vikings D is more likely to have a *good* game, and vis versa. Pittsburgh (who is playing the Raiders) is uncorrelated (the ~0.03 correlation is noise).

<div class="nb-input">

```python
nsims[['justin-herbert', 'min', 'pit']].corr()
```

</div>

<div class="nb-output">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>justin-herbert</th>
      <th>min</th>
      <th>pit</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>justin-herbert</th>
      <td>1.000000</td>
      <td>-0.547627</td>
      <td>0.034049</td>
    </tr>
    <tr>
      <th>min</th>
      <td>-0.547627</td>
      <td>1.000000</td>
      <td>-0.030473</td>
    </tr>
    <tr>
      <th>pit</th>
      <td>0.034049</td>
      <td>-0.030473</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>
</div>

Because we're the heavy underdog (Geno and a not great D vs Herbert and the top ranked D), the negative correlation between MIN and Herbert helps us. Basically, we're down so much that we need two things to go "right" for us to win: a bad Herbert game for our opponent, *and* a good DST game from us. Both of those together are more likely to happen when we start the Vikings. And we can see it in the data:

<div class="nb-input">

```python
print((nsims[['geno-smith', 'pit']].sum(axis=1) > nsims[['justin-herbert', 'dal']].sum(axis=1)).mean())
```

</div>

<div class="nb-output">
<pre>0.312</pre>
</div>

<div class="nb-input">

```python
print((nsims[['geno-smith', 'min']].sum(axis=1) > nsims[['justin-herbert', 'ne']].sum(axis=1)).mean())
```

</div>

<div class="nb-output">
<pre>0.324</pre>
</div>

Starting the Vikings gives us slightly better odds, even though Pittsburgh is the better D.

Again, this is only because we're a heavy underdog. What happens if we replace Geno with Mahomes?

<div class="nb-input">

```python
print((nsims[['patrick-mahomes', 'pit']].sum(axis=1) > nsims[['justin-herbert', 'dal']].sum(axis=1)).mean())
```

</div>

<div class="nb-output">
<pre>0.49</pre>
</div>

<div class="nb-input">

```python
print((nsims[['patrick-mahomes', 'min']].sum(axis=1) > nsims[['justin-herbert', 'dal']].sum(axis=1)).mean())
```

</div>

<div class="nb-output">
<pre>0.454</pre>
</div>

Now we can see the Vikings are the much worse option, lowering our odds almost 4 percentage points.

## Simulating your entire lineup
Of course, the natural extension to this is simulating our entire matchup: looking at all our players vs all our opponents players, simulating team scores and figuring out the probability we win.

Really the main thing we care about in fantasy football. And we need to do it going forward, for *this week* and players who haven't played yet. It's not useful to figure out who we should have started last year.

### fantasymath.com Web App
I built a web app that does this.  I make the correlated simulations for every player for the upcoming week (updated automatically a few times a day to reflect e.g. injury news), then you can you put in your matchup and get back the projected scores and probability you win.
You can also put in different guys, and it'll run the scenarios and tell you who best maximizes your chances.

Other differences:
- more scoring systems (PPR, non PPR, half PPR, 6 point passing TDs, etc) — and more correlations since e.g. the correlation between a QB and his WR1 are different in PPR vs standard scoring
- more simulations. 10000 instead of 500. This helps detect every possible edge/squeeze out any noise.
- I'm working on getting it up and running for 2024, if you want get notified when it's ready you can check it out here:

[https://fantasymath.com](https://fantasymath.com)

I'm also contemplating making the raw simulations (e.g. the `sims` and `nsims` data we've been working with above) more widely available, either as CSVs or via an API. Let me know if that's something you'd be interested in.

### Some screenshots from last year's app:

<img src="/images/fantasy-monte-carlo/results_wdis.jpg" alt="WDIS Results" width="500"/>
<img src="/images/fantasy-monte-carlo/team_vs_opp.jpg" alt="Team vs Opp" width="500"/>
<img src="/images/fantasy-monte-carlo/wdis_players.jpg" alt="WDIS Player Options" width="500"/>
<img src="/images/fantasy-monte-carlo/player_toggle.jpg" alt="Player Distributions" width="500"/>

# Appendix - Fantasy points as distributions
Here’s a quick set of numbers –

17... 24...  8...  4... 13... 12...  0... 15... 14... 13... 11...  7... 0...
8... 17... 23...  2... 15...  9...  4... 28...  5...  9...  5... 17...

These are 25 randomly selected weekly RB performances from 2019. The first is
Todd Gurley's 17 point performance in week 16, the second is Derrick Henry's 24
point performance week 14, etc.

Ok. Now let’s arrange these from smallest (0) to largest (28), marking each
with an **x** and stacking **x**‘s when a score shows up multiple times. Make
sense? That gives us something like this:

<img src="/images/fantasy-monte-carlo/rb_25.png" alt="25 Random RB performances in 2019" width="500"/>

Interesting, but why should we limit ourselves to just 25 games? Let’s see
what it looks like when we plot ALL the RB’s over ALL their games:

<img src="/images/fantasy-monte-carlo/rb_all.png" alt="All RB performances in 2019" width="500"/>

This is the first key to thinking probabilistically about fantasy football:

**For any given week, when you start a player you’re picking out one of these
little x's at random.**

Each `x` is equally likely to get picked. Each *score*, however, is not.
There are a lot more `x`'s between 0-10 points than there are between 20 and
30.

### Distributions: Smoothed Out X's
Now let's switch from stacked x's to curves, which are easier to deal with
mathematically.

<img src="/images/fantasy-monte-carlo/rb_curve.png" alt="All RB performances in 2019 - Curves" width="500"/>

The curve above is called a *distribution*. For our purposes, they're a way to
smooth things out. We're replacing the stacked x's with a fuzzier, smoothed
out curve. You can continue to imagine the area under these curves as filled
up with little, stacked up x's if you want.

The horizontal axis on this curve still represents fantasy points. The
vertical axis is less intuitive, but it ensures the area under the curve
equals 1.  Don't worry about it this if it's confusing.

So you’re heading into the Monday night game up by 10 points. Your team is
done and the guy you’re playing only has one RB left — how likely is it you
come out with a win?

The answer — assuming your opponent is starting a random RB — is about 50/50.
Half of the area under the distribution (half of the little x's in Figure 2)
is at 11 points or higher, half is below.

That's if your opponent is starting a random running back. What if he's
starting Ezekiel Elliot?

Zeke is not some random RB. His score is, on average, higher than average,
which means his distribution is further to the right. Something like the red
one below. 

<img src="/images/fantasy-monte-carlo/rb_curve_w2.jpg" alt="All RB performances in 2019 - Curves w/ Zeke" width="500"/>

In that case, Zeke will score more than 10 points 90% of the time and things
aren't looking good for Monday night.

This is important: **the shape of probability distribution changes for any
given player and week**.

A lot goes into these distributions: offensive line, quality of the defense,
number of touches, whether the RB is in a committee, etc.

Your job as a fantasy player: assemble a lineup of guys with distributions far
to the right.

This maximizes your chances of winning. Does this mean you'll always win or
start the right guy?

Of course not. Even above, a draw from a random RB's distribution (the blue
line) will be higher than a draw from Zeke's about 20% of the time. But it
will put you in the best position to maximize your odds.

The key is changing how you view player-performances. They're not taken out of
thin air, or something to be rationalized and fit into a narrative (I KNEW
this [guy who performed poorly] was bad, never again!). That's a recipe for
frustration and chasing points.

Instead, view performances as random draws from some range of outcomes.
This captures the randomness inherent in Fantasy Football, is a good model for
what's actually happening behind the scenes, and is a way to stay sane.
