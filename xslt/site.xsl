<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="yes"/>

  <!-- Parameter for view (home, about, blog, post-YYYYMMDD) -->
  <xsl:param name="view" select="'home'"/>

  <!-- Global data sources -->
  <xsl:variable name="nav" select="document('/content/pages.xml')/nav"/>
  <xsl:variable name="feedItems" select="document('/content/posts.xml')/rss/channel/item"/>

  <xsl:key name="posts-by-year" 
           match="item" 
           use="substring(guid, 6, 4)"/>

<!-- Unique categories (case-insensitive, trimmed) -->
<xsl:key name="cats-by-name"
         match="category"
         use="translate(normalize-space(.),
                        'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                        'abcdefghijklmnopqrstuvwxyz')"/>

<!-- Lookup: from a normalized category label -> its <category> nodes -->
<xsl:key name="cat-nodes-by-name"
         match="category"
         use="normalize-space(.)"/>


<xsl:template match="/">
  <xsl:variable name="view">
    <xsl:choose>
      <!-- if the document root is <site>, trust the incoming $view param -->
      <xsl:when test="name(/*) = 'site'">
        <xsl:value-of select="$view"/>
      </xsl:when>
      <!-- otherwise (a direct page or blogpost), grab its @id -->
      <xsl:otherwise>
        <xsl:value-of select="/*/@id"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
    <xsl:variable name="current" 
                select="
                  $nav/page[@id    = $view]
                  |
                  $feedItems[guid = $view]
                "/>

  <html lang="en">

    <head>
        <!--  metadata CHANGEME  -->
        <!--  og:sitename        -->
        <!--  og:image           -->
        <!--  og:video           -->
        <!--  image              -->
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="robots" content="index,follow,max-snippet:-1,max-image-preview:large,max-video-preview:-1" />        
        <meta property="og:locale" content="en_US"/>
        <meta property="og:site_name" content="VGR Garbage Web Framework Demo"/>
        <meta property="og:type" content="website" />
        <meta property="og:image" content="https://demo.vgrsec.com/content/assets/metadata/metadata.gif" />
        <meta property="og:image:type" content="image/gif" />
        <meta property="og:image:width" content="225" />
        <meta property="og:image:height" content="127" />
        <meta property="og:video" content="https://demo.vgrsec.com/content/assets/metadata/metadata.mp4" />
        <meta property="og:video:type" content="video/mp4" />
        <meta property="og:video:width" content="225" />
        <meta property="og:video:height" content="127" />  

        <!-- Dynamic Metadata -->

        <meta name="description">
          <xsl:attribute name="content">
            <xsl:value-of select="$current/description"/>
          </xsl:attribute>
        </meta>      
        <link rel="canonical">
          <xsl:attribute name="href">
            <xsl:value-of select="$current/link"/>
          </xsl:attribute>
        </link>
        <meta name="robots" content="index,follow" />                
        <title>
          <xsl:value-of select="$current/title"/>
        </title>
        <meta property="og:title">
          <xsl:attribute name="content">
            <xsl:value-of select="$current/description"/>
          </xsl:attribute>
        </meta>
        <meta property="og:description">
          <xsl:attribute name="content">
            <xsl:value-of select="$current/description"/>
          </xsl:attribute>
        </meta>
        <meta property="og:url">
          <xsl:attribute name="content">
            <xsl:value-of select="$current/link"/>
          </xsl:attribute>
        </meta>
        <!-- Twitter cards not included. Fuck ᣯ᜵⎚᠒. -->
        <!--  ld+json CHANGEME  -->
        <!--  @type             -->
        <!--  publisher         -->
        <!--  image             -->
        <script type="application/ld+json">
        {
          "@context": "https://schema.org",
          "@type": "TechArticle",
          "mainEntityOfPage": {
            "@type": "WebPage",
            "@id": "<xsl:value-of select='$current/link'/>"
          },
          "url": "<xsl:value-of select='$current/link'/>",
          "headline": "<xsl:value-of select='$current/title'/>",
          "description": "<xsl:value-of select='$current/description'/>",
          "image": "https://demo.vgrsec.com/content/assets/metadata/metadata.png",
          "datePublished": "<xsl:value-of select='normalize-space($current/pubDate)'/>",
          "dateModified": "<xsl:value-of select='normalize-space($current/modifiedDate)'/>",
          "author": {
            "@type": "Person",
            "name": "<xsl:value-of select='$current/author'/>",
            "url": "https://demo.vgrsec.com/authors/<xsl:value-of select='$current/authorId'/>"
          },
          "publisher": {
            "@type": "VGR GBF",
            "name": "VGR Garbage Web Framework Demo",
            "logo": {
              "@type": "ImageObject",
              "url": "https://demo.vgrsec.com/content/assets/logo.png"
            }
          },
          "breadcrumb": {
            "@type": "BreadcrumbList",
            "itemListElement": [
              {
                "@type": "ListItem",
                "position": 1,
                "name": "Home",
                "item": "/"
              },
              {
                "@type": "ListItem",
                "position": 2,
                "name": "Blog",
                "item": "/blog/"
              },
              {
                "@type": "ListItem",
                "position": 3,
                "name": "<xsl:value-of select='$current/section'/>",
                "item": "<xsl:value-of select='$current/sectionLink'/>"
              },
              {
                "@type": "ListItem",
                "position": 4,
                "name": "<xsl:value-of select='$current/title'/>",
                "item": "<xsl:value-of select='$current/link'/>"
              }
            ]
          },
          "keywords": [
            "VGR GBF",
            "garbage blog framework",
            "XSLT 1.0",
            "zero-JavaScript",
            "ultra-lightweight",
            "responsive design",
            "mobile-first",
            "modular components",
            "themeable",
            "semantic markup",
            "high performance",
            "SEO-friendly",
            "no dependencies",
            "pure XML/CSS",
            "easy customization",
            "rapid prototyping",
            "cross-browser",
            "clean code",
            "accessibility-ready",
            "grid system",
            "fluid layouts",
            "custom templates",
            "developer-friendly",
            "open-source",
            "XML pipeline",
            "build-time rendering",
            "low maintenance",
            "scalable architecture",
            "micro-framework"
          ]
        }
        </script>

    <xsl:call-template name="render-css">
      <xsl:with-param name="view" select="$view"/>
    </xsl:call-template>
    </head>

    <body>
      <xsl:call-template name="render">
        <xsl:with-param name="view" select="$view"/>
      </xsl:call-template>
    </body>

  </html>
</xsl:template>


<xsl:template name="render-css">

  <style>
      :root {
        /* alignment metrics */

        --base-indent: 1.5em;
        --border-width: 4px;
        --cell-padding-y: 1em;
        --cell-padding-x: 1.5em;  
        --address-font-size:   0.95em;
        --address-font-style:  normal;
        --address-margin:      1em 0;
        --time-font-size:      0.95em;
        --time-font-style:     italic;
        --time-font-weight:    normal;
        --time-margin:         0.5em 0;
        --font-family-base:   "Input Mono Reg", monospace;
        --font-size:          0.5em;
        --kbd-padding:        0.2em 0.4em;
        --kbd-radius:         3px;
        --samp-padding:       var(--kbd-padding);
        --samp-radius:        var(--kbd-radius);  
        --sidebar-width:      260px;
        --output-padding:     var(--kbd-padding);
        --data-padding:       var(--kbd-padding);



        /* Theme variables (light mode defaults) */
        --abbr-border:        var(--link);
        --address-color:       var(--text-secondary);
        --backdrop:           rgba(0, 0, 0, 0.8);
        --bg:                 #C0C0C0;
        --code-block-bg:      rgba(0, 0, 0, 0.1);
        --cite-color:         var(--text-secondary, #666);
        --container-bg:       #FFFFFF;
        --data-bg:            var(--inline-code-bg);
        --del-color:          rgba(255, 0, 0, 0.8);
        --dfn-color:          var(--link-hover);
        --figure-border:      var(--nav-border);
        --figure-bg:          #F5F5F5;
        --inline-code-bg:     rgba(0, 0, 0, 0.05);
        --ins-color:          rgba(0, 128, 0, 0.8);
        --kbd-bg:             var(--inline-code-bg);
        --kbd-border:         var(--nav-border);
        --lightbox-shadow:    rgba(0, 0, 0, 0.5);
        --link:               #0000FF;
        --link-hover:         #800080;
        --nav-border:         #888;
        --output-bg:          var(--code-block-bg);
        --output-border:      1px solid var(--nav-border);
        --shadow:             rgba(0, 0, 0, 0.3);
        --samp-bg:            var(--inline-code-bg);
        --strong-color:       var(--text);
        --text:               #000000;
        --text-secondary:     #666;
        --time-color:          var(--text-secondary);

      }


      /* Dark mode overrides via CSS variables */
      body.dark {
        --abbr-border:        var(--link);
        --address-color:       var(--text-secondary);
        --backdrop:           rgba(0, 0, 0, 0.8);
        --bg:                 #1e1e1e;
        --code-block-bg:      rgba(255, 255, 255, 0.05);
        --container-bg:       #2e2e2e;
        --cite-color:         var(--text-secondary, #666);
        --data-bg:            var(--inline-code-bg);
        --del-color:          rgba(255,  80,  80,  0.8);
        --dfn-color:          var(--link-hover);
        --figure-border:      var(--nav-border);
        --figure-bg:          #353535;
        --font-family-base:   "Input Mono Reg", monospace;
        --inline-code-bg:     rgba(155, 251, 105, 0.1);
        --ins-color:          rgba( 80, 255,  80,  0.8);
        --kbd-bg:             var(--inline-code-bg); 
        --kbd-border:         var(--nav-border);
        --kbd-radius:         3px;
        --lightbox-shadow:    rgba(0, 0, 0, 0.5);
        --link:               #FFFFFF;
        --link-hover:         #B44CE0;
        --nav-border:         #888;
        --output-bg:          var(--code-block-bg);
        --output-border:      1px solid var(--nav-border);
        --output-padding:     var(--kbd-padding);
        --shadow:             rgba(0, 0, 0, 0.3);
        --sidebar-width:      260px;
        --samp-bg:            var(--inline-code-bg);
        --strong-color:       var(--text);
        --text:               #9BFB69;
        --text-secondary:     #bbb;
        --time-color:         var(--text-secondary);

      }

      /* OMGPony Theme */
      body.pony {
        --abbr-border:        var(--link);
        --address-color:       var(--text-secondary);
        --backdrop:           rgba(46, 26, 71, 0.85);
        --bg:                 #2E1A47;
        --code-block-bg:      rgba(131, 199, 248, 0.08);
        --container-bg:       #331E5A;
        --cite-color:         var(--text-secondary, #666);
        --data-bg:            var(--inline-code-bg);
        --del-color:          rgba(250, 182, 193, 0.8);
        --dfn-color:          var(--link-hover);
        --figure-border:      var(--nav-border);
        --figure-bg:          #3D2B60;
        --font-family-base:   "Input Mono Reg", monospace;
        --inline-code-bg:     rgba(250, 214, 232, 0.1);
        --ins-color:          rgba(173, 255,   47, 0.8);
        --kbd-bg:             var(--inline-code-bg);
        --kbd-border:         var(--nav-border);
        --lightbox-shadow:    rgba(33, 30, 90, 0.5);
        --link:               #83C7F8; 
        --link-hover:         #FFF175; 
        --nav-border:         #C8A2C8; 
        --output-bg:          var(--code-block-bg);
        --output-border:      1px solid var(--nav-border);
        --shadow:             rgba(46, 26, 71, 0.3); 
        --sidebar-width:      260px;
        --samp-bg:            var(--inline-code-bg);
        --strong-color:       var(--text);
        --text:               #FAD6E8;     
        --text-secondary:     #EEDCEE;
        --time-color:          var(--text-secondary);

      }

      /* HotDog Stand Theme */
      body.hotdog {
        --abbr-border:        var(--link);
        --address-color:       var(--text-secondary);
        --backdrop:           rgba(0, 0, 0, 0.85);
        --bg:                 red;
        --code-block-bg:      rgba(186, 213, 141, 0.5);
        --container-bg:       yellow;
        --cite-color:         var(--text-secondary, #666);
        --data-bg:            var(--inline-code-bg);
        --del-color:          rgba(139, 0, 0, 0.8);
        --dfn-color:          var(--link-hover);
        --figure-border:      var(--nav-border);
        --figure-bg:          red;
        --font-family-base:   "Input Mono Reg", monospace;
        --inline-code-bg:     rgba(186, 213, 141, 0.5);
        --ins-color:          rgba(0, 100, 0, 0.8);
        --kbd-bg:             var(--inline-code-bg);
        --kbd-border:         var(--nav-border);
        --lightbox-shadow:    rgba(60, 60, 60, 0.5);
        --link:               red;
        --link-hover:         white;
        --nav-border:         #BC8F8F;
        --output-bg:          var(--code-block-bg);
        --output-border:      1px solid var(--nav-border);
        --samp-bg:            var(--inline-code-bg);
        --shadow:             rgba(0, 0, 0, 0.4);
        --sidebar-width:      260px;
        --strong-color:       var(--text);
        --text:               #3E2723;
        --text-secondary:     red;
        --time-color:         var(--text-secondary);

      }

      *, *::before, *::after {
        box-sizing: border-box;
      }


      body {
        margin:       0;
        padding:      0;
        background:   var(--bg);
        color:        var(--text);
        font-family:  var(--font-family-base);
        font-size:    var(--font-family-base);
        line-height:  1.4;
        overflow-x:   hidden;
        transition:   background 0.3s, color 0.3s;
      }

      /* Links */
      a {
        text-decoration: underline;
        color: var(--link);
        transition: color 0.3s;
      }
      a:hover {
        color: var(--link-hover);
      }

      /* Sidebar (off-canvas) */
      .sidebar {
        position: fixed;
        top: 0;
        left: calc(-1 * var(--sidebar-width));
        width: var(--sidebar-width);
        height: 100%;
        background: var(--container-bg);
        box-shadow: 2px 0 6px var(--shadow);
        overflow-y: auto;
        padding: 1em;
        transition: left 0.3s ease, width 0.3s ease;
        z-index: 1000;
      }

      /* Container */
      .container {
        background: var(--container-bg);
        width: 100%;
        max-width: 1000px;
        margin: auto;
        padding: 1em;
        transition: width 0.3s ease, margin-left 0.3s ease;
      }

      .headfoot_container {
        background: var(--bg);
        text-align: center;  
        min-height: 4em;
        width: 70%;
        max-width: 1000px;
        margin: auto;
        padding: 1em;
        transition: width 0.3s ease, margin-left 0.3s ease;
      }

      /* Sidebar toggle icons */
      .sidebar-icon {
        position: fixed;
        top: 0.5em;
        left: 0.5em;
        z-index: 2000;
        cursor: pointer;
        font-size: 1.5em;
        background: inherit;
        padding: 0.2em 0.4em;
        border-radius: 4px;
        color: currentColor;
      }
      .sidebar-icon.expanded { display: none; }
      input#blog-toggle:checked ~ .sidebar-icon.collapsed { display: none; }
      input#blog-toggle:checked ~ .sidebar-icon.expanded { display: inline; }

      #theme-toggle,
      input[type="checkbox"] { display: none; }

      /* Nav bar */
      nav {
        position: relative;
        z-index: 1000;
        background: var(--container-bg);
        border-bottom: 1px solid var(--nav-border);
        padding: 2.5em 4em;
        transition: background 0.3s;
      }

      /* Menu links */
      .menu {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        align-items: center;
      }
      .menu > li { margin-right: 1em; }
      .menu a {
        color: var(--link);
        text-decoration: none;
      }
      .menu a:hover { color: var(--link-hover); }

      /* Year-list (collapsible) */
      .year-list { list-style: none; margin: 0; padding: 0; }
      .year-list details { margin-bottom: 0.5em; }
      .year-list summary {
        cursor: pointer;
        list-style: none;
        padding: 0.2em 0;
        position: relative;
      }
      .year-list summary::before {
        content: "▶";
        display: inline-block;
        margin-right: 0.5em;
        transition: transform 0.2s ease;
      }
      .year-list details[open] summary::before { transform: rotate(90deg); }
      .year-list ul {
        list-style: none;
        margin: 0.5em 0 0.5em 1.5em;
        padding: 0;
      }
      .year-list a {
        color: var(--link);
        text-decoration: underline;
      }
      .year-list a:hover { color: var(--link-hover); }

      /* Top-level topics */
      ul.top-level { list-style: none; margin: 1em 0; padding: 0; }
      ul.top-level li { margin-bottom: 0.5em; }
      ul.top-level a {
        color: var(--link);
        text-decoration: none;
      }

      /* Responsive */
      @media (max-width: 768px) {
        .sidebar { width: 90vw; left: -90vw; }
        input#blog-toggle:checked ~ .sidebar { left: 0; }
        input#blog-toggle:checked ~ .container { width: calc(100% - 90vw); margin-left: 90vw; }
        input#blog-toggle:checked ~ .headfoot_container { width: calc(100% - 90vw); margin-left: 90vw; }

      }

      /* Sidebar open */
      input#blog-toggle:checked ~ .sidebar { left: 0; }
      input#blog-toggle:checked ~ .container {
        width: calc(100% - var(--sidebar-width));
        margin-left: var(--sidebar-width);

      }
      input#blog-toggle:checked ~ .headfoot_container {
        width: calc(100% - var(--sidebar-width));
        margin-left: var(--sidebar-width);

      }
      .spacer {
        display: block;     
        height: 2em;
        width: 100%;  
        margin: 0;
        padding: 0;
      }

      /* Images and lightbox */
      img {
        max-width: 100%;
        height: auto;
        cursor: pointer;
        transition: transform 0.3s ease;
      }
      body.lightbox::before {
        content: "";
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: var(--backdrop);
        z-index: 999;
      }
      body:not(.lightbox)::before { display: none; }
      img.lightbox-img {
        position: fixed;
        top: 50%; left: 50%;
        transform: translate(-50%, -50%);
        max-width: 90%;
        max-height: 90%;
        z-index: 1000;
        box-shadow: 0 0 10px var(--lightbox-shadow);
      }

      details img {
        /* kill the extra indent */
        margin-left: 0;
        /* keep the original responsive behaviour */
        max-width: 90%;
        height: auto;
        display: block;   /* avoids inline-gap under the image */
      }

      /* Main nav */
      .main-nav {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 1em 4em;
        background: var(--container-bg);
        transition: background 0.3s;
      }

      .nav-title-centered {
        margin: 0;
        font-size: 1.5rem;
        font-weight: normal;
        text-align: center;
      }

      blockquote {
        margin: 1.5em 0;
        padding: 1em 1.5em;
        border-left: 4px solid var(--link);
        background: var(--container-bg);
        color: var(--text);
        font-style: italic;
      }

      /* Inline code */
      code {
        font-family: var(--font-family-base);
        font-size: 0.95em;
        background: var(--inline-code-bg);
        padding: 0.1em 0.1em;
        border-radius: 3px;
      }

      /* Code blocks */
      pre {
        background: var(--code-block-bg);
        padding: 1em;
        overflow-x: auto;
        border-radius: 4px;
        margin: 1.5em 0;
      }
      pre code {
        display: block;
        background: transparent;
        padding: 0;
        font-family: var(--font-family-base);
        font-size: 0.9em;
        line-height: 1.5;
        white-space: pre-wrap;
        overflow-wrap: anywhere;
        word-break: break-word;   
      }

      /* Unordered Ordered Lists */
      ul, ol {
        margin: 1em 0;
        padding-left: var(--base-indent);    /* uniform indent */
        color: var(--text);
        list-style-position: outside;         /* markers inside the indent */
      }

      /* Unordered (disc, circle, square…) */
      ul {
        list-style-type: disc;
      }
      ul ul {
        list-style-type: circle;
      }
      ul ul ul {
        list-style-type: square;
      }
      ul ul ul ul {
        list-style-type: disc;
      }

      /* Ordered (decimal, alpha, roman…) */
      ol {
        list-style-type: decimal;
      }
      ol ol {
        list-style-type: lower-alpha;
      }
      ol ol ol {
        list-style-type: lower-roman;
      }
      ol ol ol ol {
        list-style-type: decimal;
      }

      ul li,
      ol li {
        margin-bottom: 0.5em;
      }

      /* base DL styling (level 1) */
      dl {
        margin: 1em 0;
        color: var(--text);
      }

      /* term blocks (level 1) */
      dl dt {
        margin-top: 1em;
        padding-left: calc(var(--base-indent) - var(--border-width));
        font-weight: bold;
        border-left: var(--border-width) solid var(--link);
      }

      /* definitions (level 1) */
      dl dd {
        margin: 0.25em 0 0.75em var(--base-indent);
        line-height: 1.4;
      }

      /* nested DL (level 2) */
      dl dd dl {
        margin-left: var(--base-indent);
      }

      /* sub-terms (level 2) */
      dl dd dl dt {
        padding-left: calc(var(--base-indent) * 2 - var(--border-width));
        border-left: var(--border-width) solid var(--link-hover);
      }

      /* sub-definitions (level 2) */
      dl dd dl dd {
        margin: 0.25em 0 0.75em calc(var(--base-indent) * 2);
      }

      /* Hover Link Overrides */
      ul a,
      ol a,
      dl a {
        color: var(--link);
        text-decoration: underline;
        transition: color 0.3s;
      }
      ul a:hover,
      ol a:hover,
      dl a:hover {
        color: var(--link-hover);
      }


      /* Full Table Styling */
      table {
        display: block;
        position: relative;
        width: 100%;
        overflow-x: auto;  
        overflow-y: visible;  
        scrollbar-gutter: stable;  

        width: 100%;
        border-collapse: separate;           /* separate so outer border shows */
        border-spacing: 0;                   /* no gaps between cells */
        border: 1px solid var(--nav-border); /* outer frame in same theme color */
        margin: 1em 0;
        background: var(--container-bg);
        color: var(--text);
        width: 100%;
        overflow-x: auto;        
      }

      table th,
      table td {
        padding: var(--cell-padding-y) var(--cell-padding-x);
        border: 1px solid var(--nav-border); /* cell borders match frame */
        text-align: left;
      }

      table thead th {
        background: var(--link);
        color: var(--container-bg);
      }

      /* Optional zebra-striping */
      table tbody tr:nth-child(even) {
        background: var(--inline-code-bg);
      }

      /* Hover state */
      table tbody tr:hover {
        background: var(--code-block-bg);
      }

      /* Figures */
      figure {
        display: block;
        margin: 2em auto;                     /* vertical spacing + center */
        padding: 1em;                         /* inner padding */
        border: 1px solid var(--figure-border);  
        background: var(--figure-bg);      /* theme container bg */
        border: 1px solid var(--nav-border);  /* thin frame in theme color */
        max-width: 100%;                      /* don’t exceed container */
        text-align: center;                   /* center contents caption */
      }

      /* Caption */
      figure figcaption {
        margin-top: 0.5em;
        font-size: 0.9em;
        color: var(--text);
      }

      /* Picture */
      figure picture,
      figure img {
        display: block;
        margin: 0 auto;
        max-width: 100%;
        max-height: 75vh;                     /* no taller than 75% of viewport */
        width: auto;
        height: auto;
      }

      /* Video */

      video {
        display: block;
        width: 100%;
        max-width: 100%;
        height: auto;
        max-height: 75vh;
        margin: 0 auto;
        box-shadow: 0 0 10px var(--lightbox-shadow); 
        outline: none;
      }

      video::-webkit-media-controls-enclosure,
      video::-webkit-media-controls,
      video::-webkit-media-controls-panel,
      video::-moz-media-controls {
        display: block !important;
        visibility: visible !important;
        opacity: 1 !important;
      }

      table video {
        width: 100% !important;
        height: auto !important;
        max-width: 100% !important;
      }

      table video::-webkit-media-controls-enclosure,
      table video::-webkit-media-controls,
      table video::-webkit-media-controls-panel {
        display: block !important;
        visibility: visible !important;
        opacity: 1 !important;
      }

      table video::-moz-media-controls {
        display: block !important;
        visibility: visible !important;
        opacity: 1 !important;
      }

      /* Audio */

      audio {
        display: block;
        width: 100%; 
        max-width: 600px;  
        margin: 1em auto;
        outline: none;
      }

      audio::-webkit-media-controls-panel,
      audio::-webkit-media-controls {
        display: block !important;
        visibility: visible !important;
        opacity: 1 !important;
      }

      /* Container */
      details {
        margin: 1em 0;
        padding: 0.5em 1em;
        background: var(--container-bg);
        border: 1px solid var(--nav-border);
        border-radius: 4px;
        box-shadow: 0 2px 4px var(--shadow);
        transition: background 0.3s, box-shadow 0.3s;
        overflow-x: auto;
        scrollbar-gutter: stable;
      }

      /* Summary header */
      details summary {
        list-style: none;                      /* remove default marker */
        cursor: pointer;
        display: block;
        position: relative;
        padding: var(--cell-padding-y) var(--cell-padding-x);
        font-weight: bold;
        color: var(--link);
        transition: color 0.3s;
      }

      details table {
        width: 100%;
        max-width: 100%;
        box-sizing: border-box; 
        table-layout: fixed; 
      }

      /* Hide native marker */
      details summary::-webkit-details-marker {
        display: none;
      }

      /* Custom arrow indicator */
      details summary::before {
        content: "▶";
        display: inline-block;
        margin-right: 0.5em;
        transition: transform 0.2s ease;
        color: var(--link);
      }

      /* Rotate when open */
      details[open] summary::before {
        transform: rotate(90deg);
      }

      /* Change summary color on open/hover */
      details summary:hover,
      details[open] summary {
        color: var(--link-hover);
      }

      /* Content inside details */
      details > *:not(summary) {
        margin: 0.5em 0 0 calc(var(--base-indent) + 0.5em);
        color: var(--text);
        line-height: 1.5;
      }

      /* Optional: smooth transition for reveal */
      details > *:not(summary) {
        transition: opacity 0.3s ease, max-height 0.3s ease;
        overflow: hidden;
      }
      details:not([open]) > *:not(summary) {
        opacity: 0;
        max-height: 0;
      }
      details[open] > *:not(summary) {
        opacity: 1;
      }

      /* Compact, borderless tag menu */
      aside.sidebar .topic-list ,
      aside.sidebar .topic-list details,
      aside.sidebar .topic-list summary,
      aside.sidebar .topic-list ul,
      aside.sidebar .topic-list li {
        margin: 0 !important;
        padding: 0.1em 0 !important;
        border: none !important;
        border-radius: 0 !important;
        box-shadow: none !important;
      }

      /* Compact, borderless blog year list */
      aside.sidebar .year-list,
      aside.sidebar .year-list details,
      aside.sidebar .year-list summary,
      aside.sidebar .year-list ul,
      aside.sidebar .year-list li {
        margin: 0 !important;
        padding: 0.1em 0 !important;
        border: none !important;
        border-radius: 0 !important;
        box-shadow: none !important;
      }

      /* semantic/inline element styles */
      strong {
        color: var(--strong-color);
        font-weight: bold;
      }

      abbr[title] {
        text-decoration: none;
        border-bottom: 1px dotted var(--abbr-border);
        cursor: help;
      }

      cite {
        font-style: italic;
        color: var(--cite-color);
      }

      dfn {
        font-style: italic;
        color: var(--dfn-color);
      }

      kbd {
        font-family: var(--font-family-base);
        background: var(--kbd-bg);
        border: 1px solid var(--kbd-border);
        padding: var(--kbd-padding);
        border-radius: var(--kbd-radius);
        white-space: nowrap;
      }

      samp {
        font-family: var(--font-family-base);
        background: var(--samp-bg);
        padding: var(--samp-padding);
        border-radius: var(--samp-radius);
      }

      var {
        font-style: italic;
        background: var(--inline-code-bg);
        padding: 0.1em;
        border-radius: 3px;
      }

      del {
        text-decoration: line-through;
        color: var(--del-color);
      }

      ins {
        text-decoration: underline;
        color: var(--ins-color);
      }

      data {
        display: inline-block;
        background: var(--data-bg);
        padding: var(--data-padding);
        border-radius: 3px;
      }

      output {
        display: inline-block;
        background: var(--output-bg);
        padding: var(--output-padding);
        border: var(--output-border);
        border-radius: 3px;
      }

      address {
        display: block;
        color:            var(--address-color);
        font-size:        var(--address-font-size);
        font-style:       var(--address-font-style);
        margin:           var(--address-margin);
      }

      time[datetime] {
        display: inline-block;
        color:            var(--time-color);
        font-size:        var(--time-font-size);
        font-style:       var(--time-font-style);
        font-weight:      var(--time-font-weight);
        margin:           var(--time-margin);
      }

      iframe {
        display: block;
        width: 100%;
        max-width: 100%;
        height: auto;
        overflow-x: auto;
        overflow-y: hidden;      
        scrollbar-gutter: stable;
        border: 0;
      }

  </style>

</xsl:template>


<!-- This section is for organizing tags -->


<!-- END TAG SORTING -->


<xsl:template name="render">

  <xsl:param name="view"/>
      <body>
        <!-- Sidebar toggle -->
        <input type="checkbox" id="blog-toggle" />
        <label for="blog-toggle" class="sidebar-icon collapsed">☰</label>
        <label for="blog-toggle" class="sidebar-icon expanded">☰ Menu</label>    
        <header class="headfoot_container"> </header>

        <!-- Pages -->  
          <!-- Sidebar: top-level pages -->
          <aside class="sidebar">
            <div class="spacer" aria-hidden="true"></div>                    
            <section>
              <ul>
                <xsl:for-each select="$nav/page">
                  <li>
                      <a href="{concat('/content/pages/', substring-after(@id, 'page-'), '.xml')}">
                      <xsl:value-of select="title"/>
                    </a>
                  </li>
                </xsl:for-each>
              </ul>
            </section>


            <!-- Chronological posts list (newest first) -->
            <section>
              <strong>Blog</strong>

              <ul class="year-list">
                <!-- pick one representative item per year -->
                <xsl:for-each 
                  select="$feedItems
                          [generate-id() = 
                           generate-id(key('posts-by-year', substring(guid,6,4))[1])]"
                >

                  <!-- sort the years descending -->
                  <xsl:sort select="number(substring(guid,6,4))" 
                            order="descending"/>
                  <details>
                    <summary>
                      <xsl:value-of select="substring(guid,6,4)"/>
                    </summary>
                    <ul>
                      <!-- now list all items in that year -->
                      <xsl:for-each 
                        select="key('posts-by-year', substring(guid,6,4))"
                      >
                        <!-- sort posts within the year by full GUID (i.e. YYYYMMDD) desc -->
                        <xsl:sort select="guid" order="descending" data-type="text"/>
                        <li>
                          <a href="{ concat('/content/posts/', substring(guid,6,13), '.xml') }">
                            <!-- “YYYYMMDD – Title” -->
                            <xsl:value-of 
                              select="concat(substring(guid,6,13), ' – ', title)"
                            />
                          </a>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </details>
                </xsl:for-each>
              </ul>              

            </section>

            <section>
              <strong>Topics</strong>
              <ul class="topic-list">
                <!-- iterate unique categories (dedup via key) -->
                <xsl:for-each
                  select="$feedItems/category
                          [normalize-space(.)!='']
                          [generate-id()
                           =
                           generate-id(
                             key('cats-by-name',
                                 translate(normalize-space(.),
                                           'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                           'abcdefghijklmnopqrstuvwxyz'))[1]
                           )]">

                  <!-- stable, case-insensitive sort -->
                  <xsl:sort select="translate(normalize-space(.),
                                              'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                              'abcdefghijklmnopqrstuvwxyz')"
                            data-type="text" order="ascending"/>

                  <xsl:variable name="catName" select="normalize-space(.)"/>
                  <xsl:variable name="slug"
                    select="translate($catName,
                                      'ABCDEFGHIJKLMNOPQRSTUVWXYZ ',
                                      'abcdefghijklmnopqrstuvwxyz-')"/>

                  <details>
                    <summary>
                      <!-- summary text links to topics page anchor as well -->
                      <a href="{concat('/content/pages/topics.xml#', $slug)}">
                        <xsl:value-of select="$catName"/>
                      </a>
                    </summary>

                    <ul>
                      <!-- All posts for this category, newest first -->
                      <xsl:for-each select="key('cat-nodes-by-name', $catName)/parent::item">
                        <xsl:sort select="guid" order="descending" data-type="text"/>
                        <li>
                          <a href="{concat('/content/posts/', substring(guid,6,13), '.xml')}">
                            <xsl:value-of select="title"/>
                          </a>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </details>
                </xsl:for-each>
              </ul>
            </section>


            <div style="display:flex; gap:1em; align-items:center;">
              <!-- Dark‐mode toggle icon: black background, green icon -->
              <a href="#" id="btn-dark"  title="Enable dark mode"
                 style="display:inline-block; background:#000000; padding:0.2em; border-radius:4px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                     viewBox="0 0 16 16"
                     style="color:#9BFB69; fill:currentColor; display:block;">
                  <path d="M6 9a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3A.5.5 0 0 1 6 9"/>
                  <path d="M3.854 4.146a.5.5 0 1 0-.708.708L4.793 6.5
                           3.146 8.146a.5.5 0 1 0 .708.708l2-2a.5.5 0 0
                           0 0-.708z"/>
                  <path fill-rule="evenodd"
                        d="M2 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2
                           2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2H2zM1
                           3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v10a1
                           1 0 0 1-1 1H2a1 1 0 0 1-1-1V3z"/>
                </svg>
              </a>

              <!-- Pony-Mode toggle icon -->
              <a href="#" id="btn-pony"  title="Enable pony mode"
                 style="display:inline-block; background:#331E5A; padding:0.2em; border-radius:4px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                     viewBox="0 0 16 16"
                     style="color:#331E5A; fill:#FAD6E8; display:block;">
                  <path d="M6 9a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3A.5.5 0 0 1 6 9"/>
                  <path d="M3.854 4.146a.5.5 0 1 0-.708.708L4.793 6.5
                           3.146 8.146a.5.5 0 1 0 .708.708l2-2a.5.5 0 0
                           0 0-.708z"/>
                  <path fill-rule="evenodd"
                        d="M2 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2
                           2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2H2zM1
                           3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v10a1
                           1 0 0 1-1 1H2a1 1 0 0 1-1-1V3z"/>
                </svg>
              </a>
              <!-- Hotdog-Mode toggle icon -->
              <a href="#" id="btn-hotdog"  title="Enable hotdog mode"
                 style="display:inline-block; background:yellow; padding:0.2em; border-radius:4px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                     viewBox="0 0 16 16"
                     style="color:red; fill:red; display:block;">
                  <path d="M6 9a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3A.5.5 0 0 1 6 9"/>
                  <path d="M3.854 4.146a.5.5 0 1 0-.708.708L4.793 6.5
                           3.146 8.146a.5.5 0 1 0 .708.708l2-2a.5.5 0 0
                           0 0-.708z"/>
                  <path fill-rule="evenodd"
                        d="M2 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2
                           2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2H2zM1
                           3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v10a1
                           1 0 0 1-1 1H2a1 1 0 0 1-1-1V3z"/>
                </svg>
              </a>


              <!-- Light‐mode toggle icon: white background, blue icon -->
              <a href="#" id="btn-light" title="Enable light mode"
                 style="display:inline-block; background:#FFFFFF; padding:0.2em; border-radius:4px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                     viewBox="0 0 16 16"
                     style="color:#0000FF; fill:currentColor; display:block;">
                  <path d="M6 9a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3A.5.5 0 0 1 6 9"/>
                  <path d="M3.854 4.146a.5.5 0 1 0-.708.708L4.793 6.5
                           3.146 8.146a.5.5 0 1 0 .708.708l2-2a.5.5 0 0
                           0 0-.708z"/>
                  <path fill-rule="evenodd"
                        d="M2 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2
                           2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2H2zM1
                           3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v10a1
                           1 0 0 1-1 1H2a1 1 0 0 1-1-1V3z"/>
                </svg>
              </a>
            </div>   

          </aside>
        <div class="container">

          <!-- Main content area -->
          <main id="content">
            <xsl:choose>

              <!-- Static pages: home, about, blog -->


              <xsl:when test="substring($view,1,5) = 'page-'">
                <xsl:variable name="pageid"
                              select="substring($view,6)"/>
                <xsl:choose>
                  <xsl:when test="$pageid = 'blog'">
                    <xsl:variable name="feedItems"
                                  select="document('/content/posts.xml')/rss/channel/item"/>
                    <div class="blog-listing">
                      <xsl:for-each select="$feedItems">
                        <xsl:sort
                          select="number(
                                    substring-before(
                                      substring-after(link, '/blog/'),
                                      '-'
                                    )
                                 )"
                          data-type="number"
                          order="descending"/>

                        <article>
                          <h2>
                            <a href="{link}">
                              <xsl:value-of select="title"/>
                            </a>
                          </h2>
                          <div class="excerpt">
                            <xsl:copy-of select="description"/>
                          </div>
                          <time>
                            <xsl:value-of
                              select="normalize-space(
                                       substring-before(pubDate, '+')
                                     )"/>
                          </time>
                        </article>
                      </xsl:for-each>
                    </div>
                  </xsl:when>

                  <xsl:when test="$pageid = 'topics'">
                    <div class="topics-index">
                      <h1>Topics</h1>

                      <!-- Alphabetized, de-duplicated list of topic sections -->
                      <xsl:for-each
                        select="$feedItems/category
                                [normalize-space(.)!='']
                                [generate-id()
                                 =
                                 generate-id(
                                   key('cats-by-name',
                                       translate(normalize-space(.),
                                                 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                                 'abcdefghijklmnopqrstuvwxyz'))[1]
                                 )]">

                        <!-- case-insensitive alphabetical sort -->
                        <xsl:sort select="translate(normalize-space(.),
                                                    'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                                    'abcdefghijklmnopqrstuvwxyz')"
                                  data-type="text" order="ascending"/>

                        <xsl:variable name="catName" select="normalize-space(.)"/>
                        <xsl:variable name="slug"
                                      select="translate($catName,
                                                        'ABCDEFGHIJKLMNOPQRSTUVWXYZ ',
                                                        'abcdefghijklmnopqrstuvwxyz-')"/>

                        <!-- One section per topic -->
                        <section class="topic" id="{$slug}">
                          <details>
                            <summary>
                              <span class="topic-name">
                                <xsl:value-of select="$catName"/>
                              </span>
                              <span class="count">
                                (<xsl:value-of select="count($feedItems[category[normalize-space(.)=$catName]])"/>)
                              </span>
                            </summary>

                            <ul>
                              <!-- Posts in this topic, newest first -->
                              <xsl:for-each select="key('cat-nodes-by-name', $catName)/parent::item">
                                <xsl:sort select="guid" order="descending" data-type="text"/>
                                <li>
                                  <a href="{concat('/content/posts/', substring(guid,6,13), '.xml')}">
                                    <xsl:value-of select="concat(substring(guid,6,8), ' – ', title)"/>
                                  </a>
                                </li>
                              </xsl:for-each>
                            </ul>
                          </details>
                        </section>
                      </xsl:for-each>
                    </div>
                  </xsl:when>
           
                  <xsl:otherwise>
                    <xsl:variable name="pageDoc"
                                  select="document(concat('/content/pages/', $pageid, '.xml'))"/>
                    <xsl:copy-of select="$pageDoc/page/*"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>

              <xsl:when test="starts-with($view,'post-')">

                <xsl:variable name="guid" select="$view"/>

                <xsl:variable name="pid"
                select="substring-after($view,'post-')"/>

                <xsl:variable name="postItem"
                select="$feedItems[string(guid) = $guid]"/>

                <xsl:variable name="postTitle"
                              select="$postItem/title"/>
                <h1><xsl:value-of select="$postTitle"/></h1>

                <xsl:variable name="postDescription"
                              select="$postItem/description"/>
                <h2><xsl:value-of select="$postDescription"/></h2>

                <xsl:variable name="postDate"
                              select="$postItem/pubDate"/>
                <h3>
                  <xsl:value-of
                    select="normalize-space(
                             substring-before($postDate, '+')
                           )"/>
                </h3>

                <xsl:variable name="postDoc"
                select="document(concat('/content/posts/', $pid, '.xml'))"/>
                <xsl:copy-of select="$postDoc/blogpost/*"/>
              </xsl:when>

              <!-- Fallback: unknown view -->
              <xsl:otherwise>
                <h2>Page Not Found</h2>
                <p>Unknown view: <xsl:value-of select="$view"/></p>
              </xsl:otherwise>

            </xsl:choose>
          </main>
        </div>
          <footer class="headfoot_container">
            <p>Authored by <a href="https://www.vgrsec.com" target="_blank">vgr<br/></a> Published under <a href="https://mit-license.org/" target="_blank">MIT License</a> <br/>
              <a href="../posts.xml" target="_blank" title="Subscribe via RSS" aria-label="RSS feed" 
              style="display: 
              inline-flex; 
              align-items: center;
              justify-content: center;
              width: 2em;
              height: 2em;
              background-color: #ffffff;
              color: #ff6600;
              border-radius: 0.25rem;
              text-decoration: none;">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-rss" viewBox="0 0 16 16">
                <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
                <path d="M5.5 12a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0m-3-8.5a1 1 0 0 1 1-1c5.523 0 10 4.477 10 10a1 1 0 1 1-2 0 8 8 0 0 0-8-8 1 1 0 0 1-1-1m0 4a1 1 0 0 1 1-1 6 6 0 0 1 6 6 1 1 0 1 1-2 0 4 4 0 0 0-4-4 1 1 0 0 1-1-1"/>
              </svg>
              <span class="visually-hidden">RSS</span>
            </a><br/>
            <citation>Powered by <a href="https://github.com/vgrsec/vgr-xslt-garbage-blog-framework" target="_blank">vgr's garbage blog framework 1.2</a></citation>
            </p>
          </footer>

        <script type="text/javascript">
          console.log("Theme Script");
          (function(){
            const themes = ["dark", "pony", "hotdog", "light"];
            const saved = localStorage.getItem("theme");
            if (themes.includes(saved) <![CDATA[&&]]>  saved !== "light") {
              document.body.classList.add(saved);
              console.log(`Restored ${saved} mode from last visit`);
            } else {
              console.log("No saved theme, using light mode");
            }
          })();

          window.addEventListener("load", () => {
            console.log("window.load fired, wiring buttons");
            const themes = ["dark", "pony", "hotdog", "light"];
            const body = document.body;
            themes.forEach(theme => {
              const btn = document.getElementById(`btn-${theme}`);
              if (!btn) {
                console.warn(`Toggle button #btn-${theme} not found`);
                return;
              }
              btn.addEventListener("click", e => {
                e.preventDefault();
                themes.forEach(t => body.classList.remove(t));
                if (theme !== "light") {
                  body.classList.add(theme);
                }
                localStorage.setItem("theme", theme);
                console.log(`${theme.charAt(0).toUpperCase() + theme.slice(1)} mode ENABLED and saved`);
              });
            });
          });
        </script>

        <script type="text/javascript">
        console.log("Image Lightbox Loaded");
        ;(function(){
          document.body.addEventListener('click', e => {
            const tgt = e.target;
            if (tgt.tagName === 'IMG') {
              if (tgt.classList.contains('lightbox-img')) {
                tgt.classList.remove('lightbox-img');
                document.body.classList.remove('lightbox');
              }
              else {
                const prev = document.querySelector('img.lightbox-img');
                if (prev) prev.classList.remove('lightbox-img');

                tgt.classList.add('lightbox-img');
                document.body.classList.add('lightbox');
              }
            }
            else if (document.body.classList.contains('lightbox')) {
              const prev = document.querySelector('img.lightbox-img');
              if (prev) prev.classList.remove('lightbox-img');
              document.body.classList.remove('lightbox');
            }
          });
        })();
        </script>

      
      </body>
  </xsl:template>

</xsl:stylesheet>