# Welcome!

This is the dumbest blog framework possible, written in an archaic XML-based language.

Seriously. The [W3C](https://www.w3.org/Style/XSL/) last talked about this technology in 2017. Except we're not using XSLT 3.0. We're using [XSLT 1.0!](https://www.w3.org/TR/xslt-10/) from 1999.

This all started when somebody sent me some cool [code](https://github.com/pacocoursey/xslt). I wanted to update my blog template for years, but couldn't be bothered to figure out what's latest in web development frameworks. I learned about XSLT at about the same time I came up with a few new articles to write. This timing created the perfect environment for [Yak Shaving](https://themindcollection.com/yak-shaving/). Thus, before I publish new blog posts, I need to update my blog framework. Before I publish my blog framework, I need to write the framework so it's reusable... and so forth.

So, this framework probably works just fine. I mostly don't understand the inner workings of this framework because ChatGPT vibed with me for a few days... so I'm logging a bunch to console. Either way, you're welcome, and I'm sorry, for this. `vgr`

- [Blog Writeup - https://vgr.land/content/posts/20250821.xml](https://vgr.land/content/posts/20250821.xml)

- [Demo - https://xsltblogdemo.vgr.land](https://xsltblogdemo.vgr.land)  

- [Code - https://github.com/vgr-land/vgr-xslt-blog-framework](https://github.com/vgr-land/vgr-xslt-blog-framework)

## Overview

For more info see [FAQ](./faq.xml)

To use this framework for blogging:

- Add `.htaccess` to your webserver to prevent clients from caching content. This is so if you update your site, it updates between clicks

- Update the site metadata in `./xslt/site.xsl` to meet your needs 

- Update the rss metadata at the top of `./content/posts.xml`

- Record a blog entry in `./content/posts.xml`
  ```xml
  <item>
    <title>Last Blog Post</title>
    <description>
      I am Jack's XML Parser. I consume unclosed tags I kill jack.
    </description>
    <link>https://xsltblogdemo.vgr.land/content/posts/20250707.xml</link>
    <guid isPermaLink="false">post-20250707</guid>
    <pubDate>Mon, 7 Jul 2025 13:00:00 +0000</pubDate>
    <author>vgr.xsltbf@example.com (vgr)</author>
  </item>
  ```

- These fields populate the blog header. Make sure the date matches both the blog file name and the date inside the file.

- Create a page in the directory `./content/pages/YYYYMMDD.xml`
- Insert the following code:
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <?xml-stylesheet type="text/xsl" href="../../xslt/site.xsl"?>
  <blogpost id="post-YYYYMMDD">
      <content>      
      </content>
  </blogpost>
  ```

- The `id` must match the entry in `content`. From there you can add any HTML code inside `<content>`. (maybe?)

> If you get XML errors wrap the erroring code in [CDATA](https://www.tutorialspoint.com/xml/xml_cdata_sections.htm)

I did some testing. It seems to work. I don't use Chrome or Android so it might work outside Safari, Firefox, and the Mac ecosystem. Feel free to do a pull request if you find issues.

| Engine          | Chrome (Blink) | Firefox (Gecko) | Safari (WebKit) | Edge (Blink) | Android WebView | iOS Safari |
|----------------|----------------|------------------|------------------|--------------|------------------|-------------|
| Support        | 🤷              | ✅               | ✅               | 🤷           | 🤷               | ✅           |

## Customizing

This framework comes equipped with an "easy" to use theme engine. By default it comes with:

1. Light Mode  
2. Dark Mode  
3. Hot Dog Stand  
4. OMG Pony

Add new themes by modifying `./xslt/site.xslt`:

- You'll find options like `body.dark`. To create a new theme, copy and paste a theme block, give your theme a new `body.$name`.
- Then update `console.log("Theme Script")` and add your theme to the array of names.
- Finally add a theme button inside `<aside class="sidebar">` by copying an existing button and modifying `id="btn-$name"`, `background:#`, and `fill:#`.

Oh also I'm using a licensed font. [input mono](https://input.djr.com/) because frankly it's the perfect font and I love it. It's not licensed to you, and probably won't work. So you'll have to rip it out of the CSS...

## Theme Demo

Check out the premade [template](./template.xml) to see all of the different HTML tags in action with the theme. I probably covered everything in a 5 dollar bootstrap theme. Maybe not. who cares.

### Demo Attribution

- Video: [Buzz stepping onto the moon](https://commons.wikimedia.org/wiki/File:Apollo_11._Television_clip_of_Buzz_descending_the_ladder_and_stepping_onto_the_moon,_1094228.ogv)
- Audio: [Lady Gaga sings the anthem](https://commons.wikimedia.org/wiki/File:Lady_Gaga_performs_The_Star-Spangled_Banner_audio.ogg)

![a quiet place](../assets/pages/home/home.png)

## ChangeLog

### 1.2

Added tag support for blog post. 

### 1.1

Typo and CSS fixes

### 1.0

Initial Launch
