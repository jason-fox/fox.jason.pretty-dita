<h1>Usage</h1>

Like any other transform, when invoked directly, the prettier requires an input document

### Prettifying DITA files for a document

To prettify DITA files for a document, use the `pretty-dita` transform,  set the `--input` parameter to point to a `*.ditamap` file:

```bash
PATH_TO_DITA_OT/bin/dita -f pretty-dita -i document.ditamap
```

All `*.dita` and `*.ditamap` files under that directory will be updated in place.

### Prettifying a single DITA file

Alternatively, to prettify a single DITA file, set the `--input` parameter to point to a `*.dita` file:

```bash
PATH_TO_DITA_OT/bin/dita -f pretty-dita -i topic.dita
```

The specified file will be updated in place.

### Parameter Reference

-   `args.indent` - How many characters to indent (default `4`)
-   `args.style` - Whether to indent using tabs or spaces (default `spaces`)
-   `args.print-width` - Specify the line length that the printer will wrap on (default `80`)
-   `args.require-pragma` - Restrict the plug-in to only format files that contain a special comment, called
    a pragma, at the top of the file (default `false`)

    This is very useful when gradually transitioning large, unformatted codebases to pretty-dita.

    For example, a file containing the following comment will be formatted when `args.require-pragma`
    is supplied:

```xml
<!-- @prettier -->
```

    or

```xml
<!-- @format -->
```

-   `args.insert-pragma` - Insert a special `@format` marker at the top of files specifying that the file
    has been formatted with the plugin (default `false`)

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