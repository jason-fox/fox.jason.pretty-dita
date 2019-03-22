<h1>Usage</h1>

Like any other transform, when invoked directly, the prettier requires an input document

### Prettifying DITA files for a document

To prettify DITA files for a document, use the `pretty-dita` transform.

```bash
PATH_TO_DITA_OT/bin/dita -f pretty-dita -i document.ditamap
```

The files will be updated in place.

### Parameter Reference

-   `args.pretty-dita.indent` - How many characters to indent (default `4`)
-   `args.pretty-dita.style` - Whether to indent using tabs or spaces (default `spaces`)

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