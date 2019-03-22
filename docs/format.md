<h1>Formatting Rules</h1>

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

-   `abstract`, `p`, `shortdesc`, `li`, `note`, `lq`

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

-   Body elements: `ph`,`codeph`,`synph`,`term`,`xref`,`cite`,`q`,`boolean`,`state`,`keyword`,`option`, `tm`,`fn`,`xref`
-   Programming elements: `parmname`,`apiname`
-   Typographic elements: `b`,`i`,`sup`,`sub`,`tt`,`u`
-   Software elements: `filepath`,`msgph`,`userinput`,`systemoutput`,`cmdname`,`msgnum`,`varname`
-   Userinteface elements: `uicontrol`,`menucascade`,`wintitle`
-   XML Mention Domain: `numcharref`, `parameterentity`, `textentity`, `xmlatt`, `xmlelement`, `xmlnsname`, `xmlpi`

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

-   `codeblock`, `lines`, `msgblock`, `pre`

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

Other white-space sensitive elements (such as `<lines>` are supported in a similar manner. If processing is found to be
incorrect due to embedded elements, it is suggested that the author uses the `pretty-ignore` directive to maintain
whitespace.