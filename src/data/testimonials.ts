// Copied from code-books/code-*-site-astro/src/data/testimonials.ts (identical
// across all six sport sites). **double-asterisks** mark emphasis, rendered as
// <strong> on /code-sports-books/testimonials. `featured` ones are highlighted at the top. Curated: generic one-liners dropped.
export interface Testimonial {
  quote: string;
  name: string;
  featured?: boolean;
}

export const testimonials: Testimonial[] = [
  { quote: "The book here was **really, really well done**.", name: "Bill Connelly, ESPN", featured: true },
  { quote: "This is amazingly awesome. I've recently slowly crept into data science driven by a pet passion for fantasy sport analytics. **The way the learning is framed here is 10x what you'll get someplace else.**", name: "u/Nick58", featured: true },
  { quote: "Probably the **best / most complete Pandas walk through I've seen**.", name: "Bill S" },
  { quote: "I really loved your book. You did an amazing job on it. I've been **trying to get my son more into programming, and your book has been perfect** — it really clicked for him.", name: "John M" },
  { quote: "I **picked up more, and at a better pace**, using this than a lot of the free online tools I'd been trying the past few months.", name: "Ryan P" },
  { quote: "I have always wanted to learn a language but always seemed to get discouraged by the 'Hello World' chapters that were never ending. I like that your book cuts out the riff raff and teaches the important things! **I'm flying through the book and feel like I'm learning a ton!** Best wishes from a satisfied customer.", name: "Jason K" },
  { quote: "**I have tons of coding books. Yours is a favorite.**", name: "Craig M" },
  { quote: "Dear Nate, I'd like to thank you for a **brilliant book**. It's distilled, **without extra and unnecessary info, and challenging at the same time**. I'm writing you just to thank you.", name: "Murat S" },
  { quote: "Much more engaging for me personally because it's info I'm interested in. I've taken automate the boring stuff, python for finance, etc and while those courses are great, **I seem to be understanding it better because it's about a subject I like**.", name: "u/financenstuff" },
  { quote: "I **really like your approach to teaching data science!** I usually work with R, and your book is one of the resources I'm using to teach myself Python. **So far it's the best one!**", name: "Hanwei S" },
  { quote: "The only Python course that's kept me **engaged from beginning to end**.", name: "Michael G" },
  { quote: "Been loving your book so far, it progresses at a great pace and has **easily been the best mode I've used to understand coding**. I'm excited to learn more, thank you for creating this book that's **allowing me to have fun learning again**, it's been ages.", name: "Kevin B" },
  { quote: "It **helped me way more than my grad school class did**.", name: "Glen I", featured: true },
  { quote: "Thank you Nathan... You ARE an **amazing teacher!**", name: "Urshita G" },
  { quote: "Can I just say that **this is the simplest and best explanation I have ever seen**... Awesome!!", name: "Stu T" },
  { quote: "I was amazed by how you **broke down complicated concepts** and made them easier to understand.", name: "Ryan C" },
  { quote: "I can't tell you how many times I've tried to get into programming and gave up because it was so dry. **This has been such a nice change of pace** and I'm loving it.", name: "Paval M" },
  { quote: "**Exactly what I needed** to finally get past tutorial hell and apply Python to something I love.", name: "Philip D" },
  { quote: "It's been a great refresher for basic Python... **I appreciate the Anki cards**, they're helping cement the terminology.", name: "u/michaelmanieri" },
  { quote: "It helped me tremendously... **I wouldn't be where I'm at with the Python language today without this book to kick start things.**", name: "u/F1rstxLas7" },
  { quote: "**Very engaging** so far compared to some of the other online resources I've tried to pick this up with.", name: "Tim M" },
  { quote: "I **could not be more satisfied with the content**. It has been great to work through your in-depth examples learning new skills. I had a previous interest in this sort of analysis and intermediate programming experience, but never could tie the two together.", name: "Owen B" },
  { quote: "Incredible work! Bought it right away. Only 3 chapters in and **this book is already better than expected**. Worth every penny. Thank you!", name: "u/TheMotizzle" },
  { quote: "An excellent resource. **I like your writing style and the projects are fun and make it easy to learn**.", name: "James H" },
  { quote: "The book is **very well structured and easy to follow**... I found it very helpful!", name: "Xiaolu Z" },
  { quote: "**Very informative and a good intro to coding**. Additionally, Nate would answer any questions I emailed him within 24 hours. Excellent customer service and pushed new editions to everyone who had already paid. I really appreciate Nate's commitment to his product.", name: "u/ledsdeadbaby" },
  { quote: "I've been fascinated by sports and statistics from a young age. Throughout my college career, **no professor was able to get me excited about a subject matter like the first 20 pages of this book**.", name: "Daniel O", featured: true },
  { quote: "Loving it so far. I don't know if it's because I love basketball, how simple you make it to learn, your approach to teaching, or some combination — but it **will probably be the reason I learn to code**.", name: "Sina K" },
  { quote: "Can definitely recommend it. It's **so much easier** learning coding with a subject that is familiar and one is passionate about. Thank you!", name: "u/scrabas" },
  { quote: "**Very well put together**. I've been needing a good excuse to strengthen my pandas and python skills and this looks like the perfect catalyst for me.", name: "Erik W" },
  { quote: "First, I'd just like to say how much **I love the book** and truly appreciate that something like this exists. I have been working through a variety of materials to build my Python skills and get more into the field, and **this has been tremendously helpful**.", name: "Nick C" },
  { quote: "The course is going well. I like how you bring out patterns in the commands. **Makes it so much easier**.", name: "Glenn M" },
  { quote: "I'm flying through your book and loving every bit of it so far. The way you lay everything out is **incredibly intuitive and easy to follow**.", name: "Charlie P" },
  { quote: "I wanted to take a moment to express my sincere gratitude for your book. I studied electrical and electronic engineering in university, and one area I really struggled with was coding. I made several attempts at courses in Python but struggled, failure becoming an all-too-familiar 'friend'. Your book has changed this! You have done a fantastic job and **helped me tremendously in overcoming a challenge that's been weighing on me for over 15 years**.", name: "Mark D", featured: true },
  { quote: "I'm brand new to coding. I used to be a stock broker and currently a personal trainer. Very excited to take a crack at this. I read your free chapters and felt like my brain could do well with data science. **Thanks for opening a new door.**", name: "Nick M" },
  { quote: "**I really am impressed with how simply you explained it, and how much clearer it made it for me to grasp the concept.** I had come across your book somewhere on the internet and was a little curious, but now seeing how well you explain things, I am seriously considering purchasing it.", name: "Abdulrahman H" },
  { quote: "I bought this for my 18 year old who's playing junior hockey, looking for something to do in his spare time. He's having a good time going through the lessons and playing with hockey stats!", name: "Charles R" },
  { quote: "I happen to be finishing my Sports Management Degree and my final subject is on Data Analytics; I **much prefer the learning style you created in the course**.", name: "Alexander F, host of Daily NBA" },
  { quote: "Your writing style and presentation has been **really intuitive for me**.", name: "Tom H" },
  { quote: "I am going through the first chapter now and **I love how you've explained everything in a simple yet effective way**.", name: "Farheen" },
  { quote: "Blending my outside interests with my tech expertise never felt so fun. I used fantasycoding.com by Nathan Braun to analyze stats — a great way to learn more about scraping data and creating visualizations that matter with Python. Nathan was super great in guiding you through the process.", name: "Alfredo Bernal, CTO M Booth", featured: true },
  { quote: "This is the first time I found a book to **gradually introduce and explain the ideas!!!** It seems that not only do you know the subject, but **you have ways to teach it so it's understood and is pleasant and interesting!!!**", name: "Christos S" },
  { quote: "Your ability to look at complex things and **break them down into their simple parts** in real time is rare.", name: "Taiwo M", featured: true },
  { quote: "I just want to thank you for creating this course — I have enjoyed every part of it. This is **what learning is all about**. Previous academic courses got me so disengaged... I loved this.", name: "Sho D" },
  { quote: "Thank you so much for this offering! I was wandering the proverbial forest trying to get going with advanced stats — **I probably saved myself dozens of hours trying to piece this stuff together myself.**", name: "Adam M" },
  { quote: "I am going through your book and find it **very intuitive versus others**.", name: "Jeff R" },
  { quote: "I thought it was great! I really enjoyed the way you used soccer to teach programming concepts — it made the material much more engaging and relatable. **I would highly recommend it to anyone interested in learning Python or programming in general.** Thank you for writing such a great book!", name: "Dillion A" },
  { quote: "My son is already over 100 pages into the book and **loving the material!**", name: "Carolyn L" },
  { quote: "I bought your book quite some time ago but hadn't dug in until now. Wow. Nice work — I mean that. **As a former teacher and once-upon-a-time coder, I really appreciate how you go about this.**", name: "Matt W", featured: true },
];

export const featuredTestimonials = testimonials.filter((t) => t.featured);
