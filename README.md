# Pretty DITA for DITA-OT [<img src="https://jason-fox.github.io/fox.jason.pretty-dita/pretty-dita.png" align="right" width="300">](https://pretty-dita-ot.rtfd.io/)

[![license](https://img.shields.io/github/license/jason-fox/fox.jason.pretty-dita.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![DITA-OT 4.0](https://img.shields.io/badge/DITA--OT-4.0-green.svg)](http://www.dita-ot.org/4.0)
[![CI](https://github.com/jason-fox/fox.jason.pretty-dita/workflows/CI/badge.svg)](https://github.com/jason-fox/fox.jason.pretty-dita/actions?query=workflow%3ACI)
[![Coverage Status](https://coveralls.io/repos/github/jason-fox/fox.jason.pretty-dita/badge.svg?branch=master)](https://coveralls.io/github/jason-fox/fox.jason.pretty-dita?branch=master)
[![Documentation Status](https://readthedocs.org/projects/pretty-dita-ot/badge/?version=latest)](https://pretty-dita-ot.readthedocs.io/en/latest/?badge=latest)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=fox.jason.pretty-dita&metric=alert_status)](https://sonarcloud.io/dashboard?id=fox.jason.pretty-dita)

This is a DITA prettifier [DITA-OT Plug-in](https://www.dita-ot.org/plugins) which formats DITA XML in an aesthetically
pleasing manner. `<topic>` elements, `<section>` elements, `<p>` elements etc are regularly indented so the raw DITA XML
files can be scanned by humans:

### Unformatted DITA

A typical DITA file can contain long lines, missing carriage returns and un-aligned elements:

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

After running `pretty-dita` the same file will have all its elements aligned, each block element on a new line and text
should not overrun the side of a typical view screen (approx 120 characters)

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
          Prism does its best to encourage good authoring practices.  Therefore,it only
          works with <codeph>&lt;code&gt;</codeph> elements,  since marking upcode
          without a <codeph>&lt;code&gt;</codeph> element is semantically invalid.<xref
          format="html" scope="external"
          href="https://www.w3.org/TR/html52/textlevel-semantics.html#the-code-element">According
          to the HTML5 spec</xref>, the recommended way to define a code language is a <codeph>language-xxxx</codeph>
          class, which is what Prism uses. Alternatively, Prism also supports a shorter version: <codeph>lang-xxxx</codeph>.
        </p>
        <p>
          To make things easier however, Prism assumes that this language definition is
          inherited. Therefore, if multiple <codeph>&lt;code&gt;</codeph> elements have
          the same language, you can add the <codeph>language-xxxx</codeph> class on one
          of their common ancestors. This way, you can also define a document-wide
          default language, by adding a <codeph>language-xxxx</codeph> class on the <codeph>&lt;body&gt;</codeph>
          or <codeph>&lt;html&gt;</codeph> element.
        </p>
        <p>
          If you want to opt-out of highlighting for a <codeph>&lt;code&gt;</codeph>
          element that is a descendant of an element with a declared code language, you
          can add the class <codeph>language-none</codeph> to it (or any non-existing
          language, really).
        </p>
        <p>
          The <xref format="html" scope="external"
          href="https://www.w3.org/TR/html5/grouping-content.html#the-pre-element">recommended
          way to mark up a code block</xref> (both for semantics and for Prism) is a <codeph>&lt;pre&gt;</codeph>
          element with a <codeph>&lt;code&gt;</codeph> element inside, like so:
        </p>
        <codeblock>&lt;pre&gt;&lt;code class="language-css"&gt;p { color: red }&lt;/code&gt;&lt;/pre&gt;</codeblock>
        <p>
          If you use that pattern, the <codeph>&lt;pre&gt;</codeph> will automatically get
          the <codeph>language-xxxx</codeph> class (if it doesn’t already have it) and
          will be styled as a code block.
        </p>
        <p>
          If you want to prevent any elements from being automatically highlighted, you
          can use the attribute <codeph>data-manual</codeph> on the <codeph>&lt;script&gt;</codeph>
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
              You can then <codeph outputclass="language-js">import</codeph> into your bundle
            </p>
            <codeblock outputclass="language-js">import Prism from 'prismjs';</codeblock>
            <p>
              To make it easy to configure your Prism instance with only thelanguages and
              plugins you need, use the babel plugin, <xref format="html" scope="external"
              href="https://github.com/mAAdhaTTah/babel-plugin-prismjs">babel-plugin-prismjs</xref>.
              This will allow you to load the minimum number of languages and plugins to
              satisfy your needs. See that plugin's documentation for configuration details
            </p>
        </section>
    </body>
</topic>
```

:arrow_forward: [Video from DITA-OT Day 2019](https://youtu.be/vobY_ha5nd0)

[![](https://jason-fox.github.io/fox.jason.pretty-dita/javascript-video.png)](https://youtu.be/vobY_ha5nd0)

<details>
<summary><strong>Table of Contents</strong></summary>

-   [Install](#install)
    -   [Installing DITA-OT](#installing-dita-ot)
    -   [Installing the Plug-in](#installing-the-plug-in)
-   [Usage](#usage)
    -   [Prettifying DITA files for a document](#prettifying-dita-files-for-a-document)
    -   [Prettifying a single DITA file](#prettifying-a-single-dita-file)
    -   [Parameter Reference](#parameter-reference)
    -   [Ignoring DITA files](#ignoring-dita-files)
-   [Formatting Rules](#formatting-rules)
    -   [Basic Block Elements](#basic-block-elements)
    -   [Indented Block Elements](#indented-block-elements)
    -   [Inline Elements](#inline-elements)
    -   [Text Elements](#text-elements)
    -   [Whitespace sensitive elements](#whitespace-sensitive-elements)
-   [Contribute](#contribute)
-   [License](#license)

</details>

## Install

The Pretty DITA for DITA-OT has been tested against [DITA-OT 4.x](http://www.dita-ot.org/download). It is recommended
that you upgrade to the latest version.

### Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" height="55"></a>

The Pretty DITA for DITA-OT is a plug-in for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/4.0/topics/installing-client.html).

    1.  Download the `dita-ot-4.0.zip` package from the project website at
        [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable. This defines the
        necessary environment variable to run the `dita` command from the command line.

```console
curl -LO https://github.com/dita-ot/dita-ot/releases/download/4.0/dita-ot-4.0.zip
unzip -q dita-ot-4.0.zip
rm dita-ot-4.0.zip
```

### Installing the Plug-in

-   Run the plug-in installation command:

```console
dita install https://github.com/jason-fox/fox.jason.pretty-dita/archive/master.zip
```

The `dita` command line tool requires no additional configuration.

## Usage

Like any other transform, when invoked directly, the prettier requires an input document

### Prettifying DITA files for a document

To prettify DITA files for a document, use the `pretty-dita` transform, set the `--input` parameter to point to a
`*.ditamap` file:

```console
PATH_TO_DITA_OT/bin/dita -f pretty-dita -i document.ditamap
```

All `*.dita` and `*.ditamap` files **under that directory** will be updated in place.

### Prettifying DITA files under a directory

To prettify DITA files within a directory, use the `pretty-dita` transform, set the `--input` parameter to point to the
directory :

```console
PATH_TO_DITA_OT/bin/dita -f pretty-dita -i /path-to-directory
```

All `*.dita` and `*.ditamap` files **under that directory** will be updated in place.

### Prettifying a single DITA file

Alternatively, to prettify a single DITA file, set the `--input` parameter to point to a `*.dita` file:

```console
PATH_TO_DITA_OT/bin/dita -f pretty-dita -i topic.dita
```

The specified file will be updated in place.

### Parameter Reference

-   `args.indent` - How many characters to indent (default `4`)
-   `args.style` - Whether to indent using tabs or spaces (default `spaces`)
-   `args.print-width` - Specify the line length that the printer will wrap on (default `80`)
-   `args.require-pragma` - Restrict the plug-in to only format files that contain a special comment, called a pragma,
    at the top of the file (default `false`)

    This is very useful when gradually transitioning large, unformatted codebases to pretty-dita.

    For example, a file containing either of the following comments will be formatted when `args.require-pragma` is
    supplied:

```xml
<!-- @prettier -->
```

```xml
<!-- @format -->
```

-   `args.insert-pragma` - Insert a special `@format` marker at the top of files specifying that the file has been
    formatted with the plugin (default `false`)

### Ignoring DITA files

The prettifier will ignore any DITA file containing a comment starting `prettier-ignore` - the file will not be updated.

```xml
...
<topic id="basic-usage">
    <!-- prettier-ignore -->
    <title>Basic usage</title>
    <body outputclass="language-markup">
<lines>
This file really doesn't need formatting
    We want it to look this way.
</lines>
        <p>This will also be left alone.</p>
            <p>This will be left as well
        </p>
    </body>
</topic>
```

## Formatting Rules

The pretty-dita DITA-OT Plug-in is an **opinionated** code formatter, DITA files are formatted to according to a
well-defined set of rules.

### Basic Block Elements

By default all DITA elements (not listed in the categories below) are indented one level further than the containing
DITA element

#### Example

```xml
<topic id="basic-usage">
    <title>Basic usage</title>
    <body outputclass="language-markup">
        ...etc
    </body>
</topic>
```

### Indented Block Elements

The following elements frequently contain a large body of text within them. The opening and closing tags are therefore
always placed on a separate line before displaying the text found within them:

-   Topic elements: `<abstract>`, `<shortdesc>`
-   Body elements: `<p>`, `<li>`, `<note>`, `<lq>`

#### Example

```xml
<ul>
    <li>
      This is an item in an unordered list.
    </li>
    <li>
      To separate it from other items in the list, the formatter puts a bullet beside it.
    </li>
    <li>
      The following paragraph, contained in the list item element, is part of the list
      item which contains it.
        <p>
          This is the contained paragraph.
        </p>
    </li>
    <li>
      This is the last list item in our unordered list.
    </li>
</ul>
```

### Inline Elements

The following elements are treated as inline elements, they do not warrant an additional line and are kept within the
surrounding text

-   Body elements: `<ph>`, `<codeph>`, `<synph>`, `<term>`, `<xref>`, `<cite>`, `<q>`, `<boolean>`, `<state>`, `<keyword>`, `<option>`, `<tm>`,
    `<fn>`, `<xref>`
-   Programming elements: `<parmname>`, `<apiname>`
-   Typographic elements: `<b>`, `<i>`, `<sup>`, `<sub>`, `<tt>`, `<u>`
-   Software elements: `<filepath>`, `<msgph>`, `<userinput>`, `<systemoutput>`, `<cmdname>`, `<msgnum>`, `<varname>`
-   Userinteface elements: `<uicontrol>`, `<menucascade>`, `<wintitle>`
-   XML Mention Domain: `<numcharref>`, `<parameterentity>`, `<textentity>`, `<xmlatt>`, `<xmlelement>`, `<xmlnsname>`, `<xmlpi>`

#### Example

```xml
<p>
  <b>STOP!</b> This is <b>very</b> important! Unplug the unit <i>before</i> placing the
  metal screwdriver against the terminal screw.
</p>
```

### Text Elements

Text elements on a single line are kept within the containing element Text element on multiple lines are indented one
level further than the surrounding text. Long lines of text are truncated to approximately 80 characters length by
default before adding a carriage return. Carriage returns are usually placed so as not to split inline elements, but
this is sometimes not feasable within the line limits, so a line break may occur before an inline attribute.

#### Example

```xml
<p>
  The <xref format="html" scope="external"
  href="https://www.w3.org/TR/html5/grouping-content.html#the-pre-element">recommended
  way to mark up a code block</xref> (both for semantics and for Prism) is a <codeph>&lt;pre&gt;</codeph>
  element with a <codeph>&lt;code&gt;</codeph> element inside, like so:
</p>
```

### Whitespace sensitive elements

The following elements are whitespace sensitive and require special processing:

-   `<codeblock>`, `<lines>`, `<msgblock>`, `<pre>`, `<foreign>`

The opening tag of a `<codeblock>` is indented normally, the text within a `<codeblock>` (if any) is not indented

```xml
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
        ...etc
```

`<codeblock>` elements containing `<coderef>` elements are indented as shown:

```xml
<codeblock outputclass="language-markup">
    <coderef href="../src/logo.svg"/>
</codeblock>
```

Other white-space sensitive elements such as `<lines>` are supported in a similar manner. If processing is found to be
incorrect due to embedded elements, it is suggested that the author uses the `pretty-ignore` directive to maintain
whitespace.

## Contribute

PRs accepted.

## License

[Apache 2.0](LICENSE) © 2019 - 2022 Jason Fox
