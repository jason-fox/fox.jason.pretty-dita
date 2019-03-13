Pretty DITA for DITA-OT
=========================

[![license](https://img.shields.io/github/license/jason-fox/fox.jason.pretty-dita.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![DITA-OT 3.3](https://img.shields.io/badge/DITA--OT-3.3-blue.svg)](http://www.dita-ot.org/3.3/)
<br/>
[![Build Status](https://travis-ci.org/jason-fox/fox.jason.pretty-dita.svg?branch=master)](https://travis-ci.org/jason-fox/fox.jason.pretty-dita)
[![Coverage Status](https://coveralls.io/repos/github/jason-fox/fox.jason.pretty-dita/badge.svg?branch=master)](https://coveralls.io/github/jason-fox/fox.jason.pretty-dita?branch=master)
[![Documentation Status](https://readthedocs.org/projects/pretty-dita-ot/badge/?version=latest)](https://pretty-dita-ot.readthedocs.io/en/latest/?badge=latest)


This is a DITA prettifier DITA-OT Plug-in which formats DITA XML in an aesthetically pleasing manner. `<topic>` elements, `<section>` elements,
`<p>` elements etc are regularly indented so the raw DITA XML files can be scanned by humans:

### Unformatted DITA

A typical DITA file can contain long lines, missing carriage returns
and un-aligned elements:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "topic.dtd">
<topic id="basic-usage"><title>Basic usage</title><body outputclass="language-markup">
<p>You will need to include the <codeph>prism.css</codeph> and <codeph>prism.js</codeph> files you downloaded in your page. Example:
</p>
<codeblock>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  ...
  &lt;link href="themes/prism.css" rel="stylesheet" /&gt;
  &gt;&lt;/head&gt;
&lt;body&gt;
  ...
  &lt;script src="prism.js"&gt;&lt;/script&gt;
  &lt;/body&gt;
&lt;/html&gt;</codeblock>
   <p>Prism does its best to encourage good authoring practices.  Therefore,it only works with <codeph>&lt;code&gt;</codeph> elements,  since marking upcode without a <codeph>&lt;code&gt;</codeph> element is semantically invalid.<xref format="html" scope="external" href="https://www.w3.org/TR/html52/textlevel-semantics.html#the-code-element">According to the HTML5 spec</xref>, the recommended way to define a code language is a <codeph>language-xxxx</codeph> class, which is what Prism uses. Alternatively, Prism also supports a shorter version: <codeph>lang-xxxx</codeph>.
</p>
    <p> To make things easier however, Prism assumes that this language definition is inherited. Therefore, if multiple <codeph>&lt;code&gt;</codeph> elements have the same language, you can add the <codeph>language-xxxx</codeph> class on one of their common ancestors. This way, you can also define a document-wide default language, by adding a <codeph>language-xxxx</codeph> class on the <codeph>&lt;body&gt;</codeph> or <codeph>&lt;html&gt;</codeph> element.</p>
   <p> If you want to opt-out of highlighting for a <codeph>&lt;code&gt;</codeph> element that is a descendant of an element with a declared code language, you can add the class <codeph>language-none</codeph> to it (or any non-existing language, really).
  </p>
<p> The <xref format="html" scope="external" href="https://www.w3.org/TR/html5/grouping-content.html#the-pre-element">recommended way to mark up a code block</xref> (both for semantics and for Prism) is a <codeph>&lt;pre&gt;</codeph> element with a <codeph>&lt;code&gt;</codeph> element inside, like so:
</p>
<codeblock>&lt;pre&gt;&lt;code class="language-css"&gt;p { color: red }&lt;/code&gt;&lt;/pre&gt;</codeblock>
<p> If you use that pattern, the <codeph>&lt;pre&gt;</codeph> will automatically get the <codeph>language-xxxx</codeph> class (if it doesn’t already have it) and will be styled as a code block.
</p>
  <p> If you want to prevent any elements from being automatically highlighted, you can use the attribute <codeph>data-manual</codeph> on the <codeph>&lt;script&gt;</codeph> element you used for prism and use the <xref format="html" scope="external" href="https://prismjs.com/extending.html#api">API</xref>. Example:
    </p>
<section id="usage-with-webpack"><title>Usage with Webpack, Browserify, &amp; Other Bundlers</title><p>If you want to use Prism with a bundler, install Prism with <codeph>npm</codeph>:</p><codeblock>$ npm install prismjs</codeblock><p>You can then <codeph outputclass="language-js">import</codeph> into your bundle</p><codeblock outputclass="language-js">import Prism from 'prismjs';</codeblock><p>To make it easy to configure your Prism instance with only thelanguages and plugins you need, use the babel plugin, <xref format="html" scope="external" href="https://github.com/mAAdhaTTah/babel-plugin-prismjs">babel-plugin-prismjs</xref>. This will allow you to load the minimum number of languages and plugins to satisfy your needs. See that plugin's documentation for configuration details</p>
</section></body>
</topic>
```


### Formatted DITA

After running `pretty-dita` the same file will have all its elements aligned,
each block element on a new line and text should not overrun the side of a
typical view screen (approx 120 characters)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "topic.dtd">
<topic id="basic-usage">
   <title>Basic usage</title>
   <body outputclass="language-markup">
      <p>
          You will need to include the <codeph>prism.css</codeph> and <codeph>prism.js</codeph>
          files you downloaded in your page. Example:
     </p>
      <codeblock>&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  ...
  &lt;link href="themes/prism.css" rel="stylesheet" /&gt;
  &gt;&lt;/head&gt;
&lt;body&gt;
  ...
  &lt;script src="prism.js"&gt;&lt;/script&gt;
  &lt;/body&gt;
&lt;/html&gt;</codeblock>
      <p>
          Prism does its best to encourage good authoring practices.  Therefore,
          it only works with <codeph>&lt;code&gt;</codeph> elements,  since marking up
          code without a <codeph>&lt;code&gt;</codeph> element is semantically invalid.
          <xref format="html" scope="external"
          href="https://www.w3.org/TR/html52/textlevel-semantics.html#the-code-element">According
          to the HTML5 spec</xref>, the recommended way to define a code language is a <codeph>language-xxxx</codeph>
          class, which is what Prism uses. Alternatively, Prism also supports a shorter
          version: <codeph>lang-xxxx</codeph>.
     </p>
      <p>
          To make things easier however, Prism assumes that this language
          definition is inherited. Therefore, if multiple <codeph>&lt;code&gt;</codeph>
          elements have the same language, you can add the <codeph>language-xxxx</codeph>
          class on one of their common ancestors. This way, you can also define a
          document-wide default language, by adding a <codeph>language-xxxx</codeph>
          class on the <codeph>&lt;body&gt;</codeph> or <codeph>&lt;html&gt;</codeph> element.
     </p>
      <p>
          If you want to opt-out of highlighting for a <codeph>&lt;code&gt;</codeph>
          element that is a descendant of an element with a declared code language, you
          can add the class <codeph>language-none</codeph> to it (or any non-existing language, really).
     </p>
      <p>
          The <xref format="html" scope="external"
          href="https://www.w3.org/TR/html5/grouping-content.html#the-pre-element">recommended
          way to mark up a code block</xref> (both for semantics and for Prism) is a <codeph>&lt;pre&gt;</codeph>
          element with a <codeph>&lt;code&gt;</codeph> element inside, like so:
     </p>
      <codeblock>&lt;pre&gt;&lt;code class="language-css"&gt;p { color: red }&lt;/code&gt;&lt;/pre&gt;</codeblock>
      <p>
          If you use that pattern, the <codeph>&lt;pre&gt;</codeph> will
          automatically get the <codeph>language-xxxx</codeph> class (if it doesn’t
          already have it) and will be styled as a code block.
     </p>
      <p>
          If you want to prevent any elements from being automatically
          highlighted, you can use the attribute <codeph>data-manual</codeph> on the <codeph>&lt;script&gt;</codeph>
          element you used for prism and use the <xref format="html" scope="external"
          href="https://prismjs.com/extending.html#api">API</xref>. Example:
     </p>
      <section id="usage-with-webpack">
         <title>Usage with Webpack, Browserify, &amp; Other Bundlers</title>
         <p>
             If you want to use Prism with a bundler, install Prism with <codeph>npm</codeph>:

        </p>
         <codeblock>$ npm install prismjs</codeblock>
         <p>
             You can then <codeph outputclass="language-js">import</codeph> into your bundle:
        </p>
         <codeblock outputclass="language-js">import Prism from 'prismjs';</codeblock>
         <p>
             To make it easy to configure your Prism instance with only the
             languages and plugins you need, use the babel plugin, <xref format="html"
             scope="external" href="https://github.com/mAAdhaTTah/babel-plugin-prismjs">babel-plugin-prismjs</xref>.
             This will allow you to load the minimum number of languages and plugins to
             satisfy your needs. See that plugin's documentation for configuration details.
        </p>
      </section>
   </body>
</topic>
```



Install
=======

The Pretty DITA for DITA-OT has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). It is recommended that you upgrade to the latest version.

Installing DITA-OT
------------------

The Pretty DITA for DITA-OT is a plug-in for the DITA Open Toolkit.

-  Full installation instructions for downloading DITA-OT can be found [here](https://www.dita-ot.org/3.2/topics/installing-client.html).

    1.  Download the `dita-ot-3.3.zip` package from the project website at [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable. This defines the necessary environment variable to run the `dita` command from the command line.

```console
curl -LO https://github.com/dita-ot/dita-ot/releases/download/3.3/dita-ot-3.3.zip
unzip -q dita-ot-3.3.zip
rm dita-ot-3.3.zip
```

Installing the Plug-in
----------------------

-  Run the plug-in installation command:

```console
dita -install https://github.com/jason-fox/fox.jason.pretty-dita/archive/master.zip
```

The `dita` command line tool requires no additional configuration.


Usage
=====

Like any other transform, when invoked directly, the prettier requires an input document

### Prettifying DITA files for a document

To prettify DITA files for a document, use the `pretty-dita` transform.

```bash
PATH_TO_DITA_OT/bin/dita -f pretty-dita -i document.ditamap
```

The files will be updated in place.

License
=======

[Apache 2.0](LICENSE) © 2019 Jason Fox
