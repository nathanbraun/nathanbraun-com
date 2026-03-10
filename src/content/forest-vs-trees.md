---
title: Forest vs Trees and Coding
type: blog
description: Writeup of Learn to Code with Fantasy Football
rss: true
date: "2020-08-01"
---

# Forest vs Trees and Learning to Code
Blogger and beginning programmer Jakob Greenfeld [wrote](http://jakobgreenfeld.com/rails-routes-controllers-views) recently about learning
Ruby on Rails, a popular library (rails)/language (ruby) for building web apps

I've never used Ruby on Rails, but this part resonated with me:

> "Since everyone keeps raving about it, I used [a popular tutorial]. While the
> tutorial was helpful, I felt as if something immensely important was missing
> from it.

> "This approach works to give you a rough idea of how things work in Rails.
> But at the end of it, I had seen a hundred trees but couldn’t see the
> forest."

> "There was just no systematic discussion of the most important concepts. Many
> puzzle pieces that seemed important were mentioned in passing. But how should
> I know as a beginner which of them are truly important?"

### II
Jakob's post reminded me of concept of *levels* Ray Dalio talks about in
[Principles](https://www.nathanbraun.com/books/principles/):

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

When a line of reason (or a programming tutorial) has gotten jumbled, it's
often because the speaker is jumping around different levels without showing
how they connect.

### III

I thought about that *constantly* when writing my books.

At the highest level, data analysis is:

#### **> Getting interesting or useful insights from data.**
####

But that's pretty broad, so let's jump down a level. More specifically, data
analysis is:

#### **>> 1. Collecting Data**
Examples: scraping data, connecting to a public API, downloading some ready made datasets.

#### **>> 2. Storing Data**
Once you have data, you have to put it somewhere. Maybe this is in spreadsheet files in a folder on your desktop, as tabs in an Excel file, or a database.

#### **>> 3. Loading Data**
Once it's stored, you need to be able to retrieve the parts you want. This is
easy for spreadsheets, but if it's in a database then you need to know some SQL
— pronounced "sequel" and short for Structured Query Language — to get it out.  

#### **>> 4. Manipulating Data**
This step is getting your raw data in the right format for analysis. This is
usually the biggest/most time consuming step by far, and is what most of the
book is on.

Common tools for this step: Excel, R, Python, Stata, SPSS, Tableau, SQL, and
Hadoop.

#### **>> 5. Analyzing Data for Insights**
The final model, summary stat or plot that takes you from formatted data to
insight. 

### IV
Though we haven't covered any details, even this very zoomed out level is
useful. For example, it wouldn't be unusual for a total beginner to wonder,
"should I learn Python or SQL?" Knowing at a high level that SQL is primarily
for getting data out of a database (vs scraping, sophisticated manipulation or
analysis) makes the decision easier.

That's why Greenfeld's frusteration with his Rails tutorial ("At the end of it,
I had seen a hundred trees but couldn’t see the forest.") hits home. From the
intro of both books:

"Everything in [this book] falls into one of the five [data analysis] sections
above.  Throughout, I will tie back what you are learning to this section so
you can keep sight of the big picture.

"This is the forest. If you ever find yourself banging your head against a tree
— either confused or wondering *why* we're talking about something — refer back
here and think about where it fits in."

You can check them out here: [fantasycoding.com](https://fantasycoding.com) and [codebaseball.com](https://codebaseball.com) 
