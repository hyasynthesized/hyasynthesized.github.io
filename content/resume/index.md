+++
title = "Resume"
+++
Laura Willrich | lauraewillrich@gmail.com | [hyasynthesized.github.io](https://hyasynthesized.github.io)

## Portfolio
For an up-to-date look at what I've been working on, check out [my GitHub](https://github.com/hyasynthesized), but here are some projects im particularly proud of.


### [Undertale Ruins Simulator](https://github.com/hyasynthesized/UndertaleRuinsSimulator)
A tool-assisted speedrun is a form of art project in which a TASer uses a harness program like  [libTAS](https://clementgallet.github.io/libTAS) to provide a series of pre-timed inputs to a video game with the goal of beating the game as fast as possible. One necessary part of this is testing different combinations of inputs that change the behavior of the game's pseudorandom number generator in order to cause random events to fall in the player's favor. This tool was written to automatically bruteforce hundreds of millions of possible combinations to find optimal solutions to this problem. For the curious, it's essentially just a paralellized depth first search of a DAG with some pruning ideas copied from chess engines. I've also written various other brute forcer tools for my various TASing projects, though most of these were short one-offs that didn't need posted to GitHub.

### [Timestamp Verify](https://github.com/hyasynthesized/timestamp-verify)
Built for the Undertale speedrunning community to allow leaderboard moderators to verify that segments of co-op runs were actually performed at the same time, timestamp-verify uses HMAC codes to verify that video footage of a speedrun was recorded at the time claimed. The HMAC system allows the code to run as a single Rust binary without needing to maintain a database. This is my only web project that is currently in production.

### [SNES Flappy Bird](https://github.com/hyasynthesized/FlappySnes") 
A working implementation of the video game Flappy Bird, hand coded in 6502 assembly for the Super NES. This was a really fun and challenging project, and I would love to do more ASM/embedded stuff.

### [HTTP Server](https://github.com/hyasynthesized/technically-an-http-server")
This one was fun. An HTTP file server written in C with no external dependencies other than the C standard library. If I would have done this today I would have at least written my own string class, but this was not an exercise in whether I should do it, simply whether I could.

## Skills
### Programming Languages
I daily drive an Arch Linux/Niri system so I am familiar with Linux and Bash. My favorite and primary programming languages are Python and Rust, but I'm also comfortable with C#, Java, HTML/CSS/JS/TS, and enough SQL to be dangerous. In the past I've worked with a much broader range of languages including C, C++, Kotlin, PHP, Visual Basic, x86 and 6502 assembly, and recently very brief experimentation with Golang. I am willing and able to refamiliarize myself with these technologies or learn new ones if necessary.

### Web Frameworks
For web frameworks my preference is to stick with tech that doesn't overcomplicate things - Rust with axum on the server, vanilla JS or maybe typescript on the front end. This website is made with the Zola static site generator. I have worked with more complex frontend and fullstack frameworks in the past - notably React on the frontend and Rails on the backend. 

### Devops
I understand the basics of Docker, NGINX, and GitHub Actions, and have a high-level conceptual understanding of networking and the internet.

### High Performance
My work on bruteforcers for Undertale TASing typically needs to be very high performance as there are often hundreds of millions up to hundreds of billions (not hyperbole) of combinations to check. This requires a baseline understanding of hardware, multithreading allocations, caches, etc. to make sure you're giving the compiler reasonable code that it can optimize. In particular, one brute forcer I wrote tested 137 billion possible sequences of inputs, each of which had to run a fairly complex simulation of game behavior, and ran in roughly 20 minutes.

### Embedded
I would love to break into the embedded space but haven't really had the opportunity to do so. Aside from a high-school engineering class where I wrote the code for a marble sorting robot (less than 20 SLoC), I don't have any direct embedded experience but I do have a baseline of adjacent experience. Some of the skills I picked up writing high-performance code would likely transfer, and I've also written code for the super nintendo, a very resource constrained environment.

### Non-technical
- Undertale Speedrunner with a PB of 56:06, which at time of setting was 50th place out of roughly 350
- Multi-instrument musician, primarily piano and percussion. Also a songwriter and composer
- Former speedcuber (Rubik's cube solver), had a 13 second PB and a consistent sub30 average at my peak, now average 45ish seconds due to rust. 

## Activities
- Des Moines Civic Orchestra 
    - Percussionist, 2023 to present
- First Presbyterian Church in Dallas Center
    - Technology coordinator for livestreaming of Sunday Service during the Covid-19 Pandemic

## Experience

### 2023 - BasePoint Building Automations - HVAC Programmer
My primary job was to program commercial HVAC devices, however I often found myself creating additional tooling around the existing tooling to help make the other programmers' jobs more efficient.

### Spring 2022 - Telligen - Desktop Support Intern
Imaging laptops, doing battery replacements, putting together equipment, boxing it up to be shipped to WFH employees, doing inventory checks,  whatever random tasks the IT department needed

### Summer 2021 - HyVee Helpful Smiles Technology - Programming Intern
We had an ancient completely untested and mostly undocumented VB.net service that ran every night that pushed prices from the central database to various machines in the store that used a variety of protocols. I was solely responsible for modernizing this application to C#. Also our testing environment was completely insufficient so our first integration test was in prod. 

### Summer 2020 - HyVee Helpful Smiles Technology - Programming intern
Worked on a web dashboard for store managers to manage item pricing in their stores. The application had a React frontend, and a .NET backend, and used GraphQL for APIs. I was fullstack on this and built multiple features. 

### Summer 2018 - Blue Frog Dynamic Marketing - Programming intern
Blue Frog Dynamic Marketing is an internet marketing/web design firm. I created tooling for them that automatically analyzed client websites for their performance on various SEO metrics, as well as allowing them to automatically scrape images and other content from client sites.

## Education
In December 2025, I recieved a Liberal Arts AA from Des Moines Area Community College. Previously, I had completed some coursework for a bachelor's in mathematics from the University of Iowa. I plan on returning to finish my bachelor's in fall of 2027.
