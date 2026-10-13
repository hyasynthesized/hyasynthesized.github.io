+++
title = "Solving Strange Website Behavior Found in the Wild"
date = "2026-10-13"
+++

I was on a first date with another software/cybersec enthusiast named Mona and we had gone to [the Rook Room](https://therookroom.com/), which is a really cool board game cafe in downtown Des Moines. We were looking for a co-op game to play, and we stumbled across a card game by the name of "Supply Chain". Seeing as it was a relatively complex game and there was only one copy of the rules, we decided to go to the website on the box, [supplychaincardgame.com](https://supplychaincardgame.com/) to find a digital copy for one of us to read. The problem was that visiting that website redirected to [mclellandschool.org](https://mcclellandschool.org/).

Of course, we are both immediately [nerd sniped](https://xkcd.com/356/) by this. Neither of us have a laptop with us so we do as much investigating as we can on our phones. We find out the following:
- There are multiple board and card games with titles similar to Supply Chain which might make researching this difficult
- Supply Chain: The Card Game had a kickstarter in 2022 that raised just under 200 dollars from around 40 backers. It was made by a group out of Cedar Rapids IA, has 36 owners and 5 fans on boardgamegeek, and otherwise seems to be a very small project.
- McClelland School is a legitimate accredited K-8 private school in Pueblo, Colorado that traces its history back to a 1906 orphanage and has been a private school since at least 1979
- The IP address associated with Supply Chain's DNS records belongs to GoDaddy, while McClelland School's IP belongs to google.
- McClelland School's site is a WordPress site designed by a Pueblo local web design firm.
- The internet archive shows that at one point, supplychaincardgame.com did show a website for the card game. That website was *not* a wordpress site and didn't appear to have any designer at all.
- Requesting supplychaincardgame.com redirects to mcclellandschool.org, but requesting any subpage does not redirect, instead responding with the content of mcclellandschool's 404 page (but with broken fonts and formatting, which we assumed at the time and then I later confirmed was because of CORS) from the IP of supplychaincardgame.com.
- The SSL cert returned when visiting supplychaincardgame.com, regardless of whether you get redirected, is an SSL cert that is only valid for mcclellandschool.org.

We were at a loss for what to do with this information. The obvious reasoning for a strange redirect is an attack, but the types of attackers that typically compromise a website to redirect to their own are prescription drug scammers, porn bots, phishers, and other outwardly sketchy types of businesses. An accredited K-8 private school in Pueblo, Colorado seemed like a strange progenitor of this attack vector. The next best thing would be some kind of connection between the two businesses: maybe they were ran by the same people and they were reusing servers to save money. But the private school was in colorado and credited a local web design firm, while the card game was from Iowa and did not. Some kind of misconfiguration also seemed plausible, but we were struggling to think of what misconfiguration could cause such bizzare behavior.

At that point our food arrived and we realized that without a laptop we had no way forward. So we dropped it for the time being, ate our food, and played Pandemic instead. We won.

The next morning, this weird website was still in my head. There had to be an explanation for this. Googling around for a bit, I mostly find more of the same "malicious website, your website was compromised" suggestions but those still don't sit right with me. Eventually, I find an old reddit comment explaining the concept of a "virtual host". Essentially, because there aren't that many IPv4 addresses, hosting platforms like GoDaddy have figured out a way to have multiple server share the same IP Addresses. One of the required HTTP Headers is the [Host](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Host) header, which "specifies the host and port number of the server to which the request is being sent." Then a reverse proxy can switch on this and redirect requests to the appropriate server as needed. 

I log this in my head as a potential explanation but it still doesn't quite make sense to me. Why would the reverse proxy send out one of the websites instead of an error page? Why the redirect? Why the redirect to a non-godaddy site? Why no redirect on 404? So I decide to keep digging. I open up python and make a request to supplychaincardgame.org, telling it not to follow redirect. I then examine the headers...

```
X-Redirect-By: WordPress
```

WTF? How is it WordPress? Supply Chain Card Game is not, and has never been, a wordpress site. I am haunted by the ghost of WordPress yet to come. At this point, the virtual host explanation seems ridiculously unlikely but literally no other explanation makes even a remote amount of sense. So I was ready to throw in the towel.
![A discord message from user "synth" sent 10/8/2026 9:45 AM:
i could probably find contact info for someone who worked on the card game
but talking to people is scary
so
this is where im in too deep](igiveup.png)

But I am very bad at giving up. I decide that actually observing the virtual host behavior in the wild might help. So I google "websites hosted on godaddy", and then visit the first one I find, a company that sells boats. Then, I do a DNS lookup, and visit that IP address directly. The 404 page also redirects, and the website that I got redirected to was also a godaddy site with the same IP address, but other than that the behavior I got was very similar. I also realize that since there was a proper HTTP 301 redirect it wouldn't matter where the website was hosted. So the virtual host seems the most likely explanation, but I still have a few questions. Why is the virtual host generating a redirect instead of just showing the wrong content? Why does that redirect say it was from wordpress? I write up my findings, send it to a few people, and then go to take a nap. I had been up late the night before and desperately needed it. 

But before I could even fall asleep, I remembered something. When you visit facebook.com, you get auto-redirected to www.facebook.com. Same for google and youtube. For other sites it's the opposite. I knew I vaguely half-remembered various sites over the years having the same behaviors of taking multiple different domain names and redirecting to a standardized one. I google "wordpress redirect to canonical domain name", and get the `redirect_canonical` function. Everything falls into place.

Here is the final report i sent to Mona. I originally wrote it in a much more informal tone. I tried to clean it up for this article but might have missed something.

> GoDaddy does something called a "virtual host", where an IP address is used for multiple websites. This is done by pointing to a reverse proxy which reads the `Host` header of an HTTP request (which tells the server what domain the user is connecting from) and uses that to determine which actual webserver (or VPS) to connect the user to. In GoDaddy's implementation, there is no error handling when you give one of these virtual host reverse proxies a `Host` header it doesn't recognize. Instead, it falls back to one of the other sites on that virtual host.
> 
> So what happened in our situation is supplychaincardgame.com is a website hosted on GoDaddy. Somehow their server is taken out of the virtual host configuration but its DNS records aren't removed. (How does this happen? the DNS and hosting are both godaddy; you'd think if they stopped paying for one the other would be removed too?) When we visit the supplychaincardgame website, the fall through is triggered and we get the content for mclellandschool.org.
> 
> Why the redirect? Why the DNS records pointing to Google? mclellandschool.org is a website that is for some reason being hosted on GoDaddy and Google, but the DNS records point to Google. WordPress has a function called `request_canonical` that detects if you are making the request from a noncanonical `Host` and autoredirects you if you are. So the mclelland school website is hosted on GoDaddy and Google and the `request_canonical` function automatically redirects you over to the Google one. This also explains why the 404 page doesn't redirect for mcclellandschool.org. Since `request_canonical` isn't a configuration option but instead a regular PHP function, if it's put on your main page instead of your template it won't redirect on 404.

After sending this to the various people I had been ~~bothering~~ consulting, I took a well needed nap. And as for Mona, I am incredibly proud and happy to be able to call myself her girlfriend.

