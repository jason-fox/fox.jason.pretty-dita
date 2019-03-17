<h1>Usage</h1>

Like any other transform, when invoked directly, the DITA prettier requires an input document

### Prettifying DITA files for a document

To prettify DITA files for a document, use the `pretty-dita` transform.

```bash
PATH_TO_DITA_OT/bin/dita -f pretty-dita -i document.ditamap
```

The files will be updated in place.

### Parameter Reference

-   `args.pretty-dita.indent` - How many characters to indent (default `4`)
-   `args.pretty-dita.style` - Whether to indent using tabs or spaces (default `spaces`)
