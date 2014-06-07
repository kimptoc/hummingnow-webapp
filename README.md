# INFO

http://loggr.net/logs/kimptoc

to push env vars to heroku

rake figaro:heroku\[hummingnow-dev\]

# TODO


Thumbnails - currently not getting any via http://www.artviper.net/website-tools/website-thumbnails.php

Thumbnail Ideas
- http://oembed.com/ - url embedding facility
- or http://embed.ly/
http://rumproarious.com/2010/05/12/ruby-oembed-and-embedly-all-that-was-needed-was-a-little-love/
https://github.com/soulim/oembed
https://github.com/judofyr/ruby-oembed
https://github.com/netshade/oembed_links

Probably better via oembed / javascript - https://github.com/starfishmod/jquery-oembed-all


how to proxy twitter gem requests so that charles can spy on them


Don't cache avatar urls - otherwise dont pickup changes


Show own github version version on about/admin page?
http://stackoverflow.com/questions/10973341/heroku-console-show-the-latest-sha-hash-from-git-deployment
https://github.com/heroku/heroku.rb


- search fails :( ( phoenix_search ?? )
RT's entities are inside the RT message, need to dig into that...


# bugs

- https://github.com/ddollar/heroku-autoscale/network

- switch to https cos all sent to/from hummingnow is in the clear

- Sending a tweet seems to have unblocked things... although cant see a successful request ???

- adding multiple accounts not working - redirects back to hummingnow if logged in??
-- Devise upgrade – maybe cause of multi account issue
-- https://github.com/plataformatec/devise/wiki/How-To:-Upgrade-to-Devise-2.0

- When on search page and you switch account – seems to cause issue/log you out

- if get auth issue in tweets/json call, it does endless redirect to public, but main page sits there with nothing

- iphone default/loading image has a test ad in it...

- typing in search field triggers hotkeys - disable for that input box too.

- IE – when losing focus, seems to disable updates

- url with ampersands or something seems to cause issues
-- eg https://twitter.com/#!/OccupyAmplify/status/161122009596698625
-- https://twitter.com/stroughtonsmith/status/161736837818363904
-- https://twitter.com/#!/mattgemmell/status/169391924388696065
-- https://twitter.com/chafic/status/169716218499055617
-- https://twitter.com/#!/nrocy/status/186020978848043008
-- https://twitter.com/#!/jonginn/status/186446590804885504
-- https://twitter.com/#!/thomasfuchs/status/186445746676047872

- IE /chrome frame errors, stops updating, but JS is ok – happen with prod site too – so its an error before that

- If get error/timeout on artviper, use alternate/local image...

- review perf via newrelic.com

- can we detect this upfront? "Refused to display document because display forbidden by X-Frame-Options."
- Make about work on portrait iPad

- getting Request timeouts – bg images/link lookups?
-- http://devcenter.heroku.com/articles/request-timeout

- Check for twitter name case insensitive...
-- https://twitter.com/Bagel_Tech_News/status/158869353884958720

- youtube player embedded links - turn into better embeds
-- https://twitter.com/measured/status/157723757543292930

- Parsing it as youtube?  https://twitter.com/adurdin/status/156721891388817408

- t.co link failed on WOT - https://twitter.com/#!/lbc973/status/156274237542371328

- Su.pr / Stumbleupon does redirect, so exclude from popups

- bugs logged on errorapp - http://errorapp.com/dashboard
- what is twitter promoted content - do anything?

- t.co issue
-- https://twitter.com/#!/OccupyLSX/status/155446494466547712
-- https://twitter.com/#!/NazQatar/status/155758666971222016

- image thumb with colon
-- https://twitter.com/twilightzonebot/status/155574870481190912

- youtube issue
-- https://twitter.com/thrutheblue/status/155805342851272704

- bitly issue
-- http://bit.ly/AEhqwC

- Visited links are not coloured differently
- sometimes get dupe tweets, use tweet id as div id and dont add if existing
- search with a dot in it gives an error, eg flic.kr

- link missing for this status item
-- https://twitter.com/#!/shanselman/status/155367915774935040

- youtube url quirk - eg https://twitter.com/#!/IAmShaMain/status/27503187661426688
- Youtube links to a channel don’t need tweaking...
Eg https://twitter.com/#!/SnoopDogg/status/155184870862237696

- IE better with chrome frame - perhaps add code to prompt for it - http://code.google.com/chrome/chromeframe/
-- IE – updates stop happening quite quickly
-- IE – side gaps half size of top/bottom gaps...
-- Tweets from IE not working, retweets seem ok (maybe) ...
-- IE (only?) – real memory hog if left running for a while...
-- IE search text box is very small...
-- char count on IE seems to be missing

- twitter popup/dialogs not working on mobile :(
- only have retweet button when its valid to do so.
- linkify not working when not logged in??? also on pages via no user(eg /user/kimptoc)
- avatar blank when logged in, but user not specified in url - perhaps blank it?
- col width calcs dont seem to be working on large screen

=== intermittent bugs
- multi accounts does not seem to be working, seems to totally switch user//still 24jan12
- go to other page and then hit back, seems to load lot of old tweets (90 ish)
- if you search for several terms, get no results, seems to crash it - but eventually recovers...
- intermittent error on login
- when switching accounts, get heroku crash error

# ideas

- try wookmark??

- http://bootswatch.com/?utm_source=html5weekly&utm_medium=email
- http://stylebootstrap.info/?utm_source=html5weekly&utm_medium=email

- http://www.favbrowser.com/html5-top-10-css3-animations/?utm_source=html5weekly&utm_medium=email

- http://syddev.com/jquery.shadow/

- Make image thumbnail generator a super user editable config thing

- autocomplete twitter users - http://daniel-zahariev.github.com/jquery-textntags/ -
-- http://andymatthews.net/read/2012/03/27/jQuery-Mobile-Autocomplete-now-available
- game centre/achievements for hidden bits, eg double tap..

- css 3d - http://desandro.github.com/3dtransforms/

- Use thumb controller for all thumbs
-- ESP bitly and Flickr due to lookup

- Eye candy/ways to view mentions/timeline together...
-- http://webcloud.se/code/jQuery-Collapse/

- xlate app blurb to other languages

- post tweet with image (?)
- think about flattr link

- Inapp purch AirPlay

- When issue loading a link, display loading graphic or something...

- http://bloggerspath.com/latest-and-notable-jquery-tutorials-plugins-january-2012/

- For the tweets on the page, List distinct list of users at top of page (maybe hideable), so that you can click on user(s) and highlight or just see their tweets

- Ability to highlight text and right click search twitter for it

- icons - http://www.iconshock.com/icon_sets/

- http://www.tweetvisor.com/ - ideas...

- click on time link, open popup with conversation and follow etc links
- flattr.com - ios/apple issues?
- ggogle xlate
- show some pages as a popup/colorbox, eg conversation tweets
- Funky backgrounds & more...
-- http://johnpolacek.github.com/scrolldeck.js/decks/parallax/
- Maybe - http://www.jscraft.net/plugins/scroller.html
- poyi's comments from forrst
- ui-tabs for different searches, so easier to switch back. Or multi-col/row view, or accordions...
- dave's ideas - conference/premium for large.
- ipad app first - need to support ipad portrait size then.
- wrap page in mac/ipad app and sell it :)
- whats more readable/nicer - packed rows or more evenly lined up, like register
- premium - queued/scheduled tweets?
- put on Chrome store?
- put on Google android/tablet store

- word cloud? - http://www.innovativephp.com/creating-word-cloud-widget-using-google-visualization-api/

-- done pending check
- own/custom favicon

# todo

- Show reviews (via rss feed) on about page

- Show more tweets, or infinite scroll or make it configurable

- put link on about page to iOS app

- Bootstrap2 http://twitter.github.com/bootstrap/upgrading.html

- full screen support - http://hacks.mozilla.org/2012/01/using-the-fullscreen-api-in-web-browsers/?utm_source=html5weekly&utm_medium=email

- Ios / show network activity when loading page
-- https://github.com/jimpick/twitterfon/blob/master/Classes/Controllers/WebViewController.m

- Ios/ load home page option

- stop page updating if mouse/scrolling

- cache less tweets on iphone - ie show them immediately...

- track users - #iphone vs #ipad vs web

- rails 3.2 upgrade

- Make own tweets less bold, should fade into background...

- +1/fb like/tweet buttons
- related tweets
- follow @hummingnow button

- Auto track version I'd on about page

- tooltip on thumbnails of the underlying link

- Option to re-sort page, eg reverse time, by user...

- DMs in another colour? Include mine and theirs...

- twitter login - dont need to go to auth page is already auth'd

- previews for  img.ly, Twitgoo, TweetPhoto and Vimeo

- Option to turn a reply into retweet and vice versa when box is open.
- truncate urls, lose std prefix...
- Include mentions and DMs on the main timeline (setting to turn off/on)
- Reply include all screen names from tweets (or retweet)...
- Button to force fetch tweets
- Ability to move tweet/retweet box around the page
- Ability to see tweets behind popup better
- Autocomplete twitter name (use followers/followed list...or at least users on current page)

- More picture support
-- Path.com

- Readlater/readability – for text links... colorbox popup
-- http://www.readability.com/publishers/rdd

- click on colorbox image opens underlying link page

- gracefully (?) handle missing images...

- I – popup to follow/unfollow a user, home page link, tweets, followers, following, mentioned
- Conversation view, tweets related to a tweet...
- Show my auto retweets on the my timeline
- Show retweets of my stuff on my timeline
- expand t.co urls as per entities entry
- display thumbnail based on media entry
- After tweeting, do a reload
- When introduce tracking of last tweet for mentions/DMs, also do so for main line – no need to hold back some if already shown them

- what if try to add twitter account to WOT account that is linked elsewhere....
- use path style menu - https://github.com/Zikes/circle-menu
- data integrity - users without auths...?
- better error handling
- change retweet image once done to the retweeted version
- heading on the tweet box (enter your update or whatever twitter says)
- native dm/favoriting reply boxes
-- http://paynedigital.com/2011/11/bootbox-js-alert-confirm-dialogs-for-twitter-bootstrap

- in mac app, allow cmd-f searching in page
- for returning users, logon to last used twitter account, not first registered
- saved searches/save a search
- users favourites
- DM - support for reply.
- trends
- notifications of pending replies/DMs (across accounts?)
-- http://wavded.github.com/humane-js/ (also use for flash msgs?)
-- http://opensource.srirangan.net/notifier.js/

- view of all mentions of a specific user
- view of a conversation thread
- if been no tweets for a while, then some, show them asap
- if been sleeping, do fetch asap
- allow ctl-enter to send tweet...
- handle tweet sending failure

- if twitter link is slow, can end up with duped tweets-cache tweet ids on client, throw away dupe responses.
- if get error, deletes all auths - perhaps only delete current...

- ability to pin/unpin tweets they stick to top right of page until unpinned, perhaps in a different
colour/boxed

- use local storage when not logged in...
- show RT between, show original user avatar/link

- remember destination url when logging and send user there after login
- page of images only (the twitter image feed)
- delete account option(?)

- cache DM/replies/links per user to make things quicker

- display tweets by and refering to @hummingnow

- rounded corners on IE
- popup image thing for image links or just show thumbnail...  /iframe
-- http://jobyj.in/adipoli/ - image effects on hover
-- site similar to zootool.com turns link into image (either actual or main of page of page snapshot)
-- http://www.artviper.net/website-tools/website-thumbnails.php
-- http://bitbonsai.com/facybox/
-- https://github.com/visionmedia/screenshot-app - diy site thumbnails

- keyboard shortcuts,http://robertwhurst.github.com/KeyboardJS/ eg
-- switch to mentions/dm/timeline
-- show all pending tweets
-- signout
-- switch settings, eg grid/packed
-- cater for input fields - https://github.com/RobertWHurst/KeyboardJS/issues/18#issuecomment-3606605
-- disable usual space option, maybe https://github.com/RobertWHurst/KeyboardJS/issues/17#issuecomment-3606538

- try isotope again, with sortBy bit
---  .isotope( 'reloadItems' ).isotope({ sortBy: 'original-order' });
--- pin a little profile box about them to the right

- make hover images work on the reply/retweet/favorite images
- colour code tweets, same colour for same people?
- or based on hover, hover user, all user tweets highlighted, hover hashtag, all tagged tweets
- and/or based on mentions or own tweets or retweets

- picture tooltips - http://ipicture.justmybit.com/

- pass through errors to client somehow....

- tune calls, query less for more, adjust to results - 0 responses, then call less frequent
https://dev.twitter.com/docs/rate-limiting

- Themes - background, fonts, etc
--Custom/shareable
--How to switch style? Custom/override classes


# fixed bugs...

- IE, errors NaN with time formatting of main tweet time...
- getting same tweet repeated sometimes, maybe if 0 or 1 new tweet.
- getting error when switching to different user/kimptoc
- IE, errors about no console...
- show links in a popup frame, ala lightbox - NO - breaks no iframe rules for some sites


# CSS

https://github.com/LeaVerou/CSS3-Patterns-Gallery
http://leaverou.github.com/animatable/
http://leaverou.github.com/prefixfree/
http://www.webappers.com/2011/12/29/15-great-examples-of-websites-using-jquery-masonry/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+Webappers+%28WebAppers%29
http://coding.smashingmagazine.com/2011/02/11/the-bright-near-future-of-css/
http://css-tricks.com/
http://www.maclife.com/article/howtos/how_make_web_animations_using_hype#slide-0

# Jasmine Links

- https://github.com/velesin/jasmine-jquery
- http://asciicasts.com/episodes/261-testing-javascript-with-jasmine

# Backbone links

- https://github.com/documentcloud/backbone/wiki/Tutorials%2C-blog-posts-and-example-sites


# iPad app things


ipad app release- to do:

- http://itunes.apple.com/gb/app/humming-now/id491994653?mt=8

- ipad/seems to crash alot - ad issues? Disabled GS and Mill for now, seems better...

- ads - http://www.neilinglis.com/2010/07/20/using-adwhirl-to-achieve-high-fill-rates/
-- https://www.adwhirl.com/apps/apps
-- mobclix - linked to inmobi?

ipad todo later
- screenshots- with (ios/back) menu open
- loading html needs to be better , spinner thing
- check each configured ad network, make sure its all setup payment wise
- on ios show busy status when opening link
- option to go to home screen
- option to inapp purchase, no ads (iCloud store app purchase info)
- icon for final domain name/mar?
- iOS press and hold link, option to open in safari



# iOS

- http://stackoverflow.com/questions/2909807/does-uigesturerecognizer-work-on-a-uiwebview
- http://stackoverflow.com/questions/6377493/gesture-recognition-with-uiwebview
- http://codingandcoffee.wordpress.com/2011/10/19/iphone-tutorial-three-simple-gesture-recognizer-and-storyboard/
- http://stackoverflow.com/questions/4492563/easy-ways-to-crop-out-the-status-bar-when-taking-ios-screenshots
- http://books.google.co.uk/books?id=bwQY3_5FMg8C&pg=PA189&lpg=PA189&dq=how+to+take+ios+retina+display+screenshots+for+app+submission&source=bl&ots=aMut7TaiLe&sig=ldY50bTBLd21F78jYfO8ps_UKTo&hl=en&sa=X&ei=190TT-SeEoHJ8gO6yIHiAw&ved=0CE4Q6AEwBg#v=onepage&q=how%20to%20take%20ios%20retina%20display%20screenshots%20for%20app%20submission&f=false
- http://www.narizvi.com/blog/post/2011/05/26/Screenshots-for-iOS-App-Submission.aspx
- http://maniacdev.com/2012/01/open-source-library-for-elegantly-styled-modal-panels-in-ios-apps/
- http://www.raywenderlich.com/2797/introduction-to-in-app-purchases?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+RayWenderlich+%28Ray+Wenderlich+%7C+iPhone+Developer+and+Gamer%29
