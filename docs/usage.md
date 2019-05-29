<h1>Usage</h1>

Like any other transform, when invoked directly, the transforms of the
DITA-OT Translate Plug-in require an input document


## Invocation from the command line

1.   To create an XLIFF File and associated skeletons with run:

```bash
PATH-TO-DITA-OT/bin/dita -f xliff-create -i document.ditamap  -o out
```

<h4>Result</h4>

A `translate.xlf` file will appear in the `out` directory along with a series of skeleton files.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xliff xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <file datatype="xml" original="/document.dita" source-language="en" target-language="de">
    <header xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
      <skl>
        <external-file href="./skl/document.dita.skl" />
      </skl>
    </header>
    <body xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
        <trans-unit xmlns="" xmlns:dita="dita-ot.org" approved="no" id="42094" xml:space="preserve">
          <source xml:lang="en">Sample Text</source>
          <target xml:lang="de"/>
        </trans-unit>
        ... etc
      </body>
   </file>
...etc
```


> **Note:** if the `translate.cachefile` parameter is used, unchanged text with previously approved translations will be
> copied over to the `<target>` elements.

2.   To populate an exisiting XLIFF File with auto-translated text

```bash
PATH-TO-DITA-OT/bin/dita -f xliff-translate \
  -i translate.xlf --translate.service=[bing|watson] \
  --translate.apikey=<api-key>
```

<h4>Result</h4>

The XLIFF File is auto-translated in place, with translated text included.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xliff xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <file datatype="xml" original="/document.ditamap" source-language="en" target-language="de">
    <header xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
      <skl>
        <external-file href="./skl/document.ditamap.skl" />
      </skl>
    </header>
    <body xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
        <trans-unit xmlns="" xmlns:dita="dita-ot.org" approved="no" id="42094" xml:space="preserve">
          <source xml:lang="en">Sample Text</source>
          <target xml:lang="de">Beispieltext</target>
        </trans-unit>
        ... etc
      </body>
   </file>
...etc
```

> **Note:** only `<trans-unit>` elements which are `approved="no"` will be auto-translated.

3.   To recreate `*.dita` files using an XLIFF File and its associated skeletons with run:

```bash
PATH-TO-DITA-OT/bin/dita -f xliff2dita -i translate.xlf -o out
```

<h4>Result</h4>

The translated `*.dita` files are generated into the `out` directory.

> **Note:** Any machine translation is by definition imperfect. A typical translation workflow would send the generated
> XLIFF files to the translation agency (known also as "localisation service provider"), and receieve back verified 
> translated content from the translation agency integrated into to the XLIFF. Each `<trans-unit>` should be marked
> `approved=yes` when the `<target>` element has been verified.

### Parameter Reference

-   `translate.from` - Source language to use. Defaults to the value in `configuration.properties`
-   `translate.to` - Target language. Defaults to the value in `configuration.properties`
-   `translate.cachefile` - Specifies the location of a previously translated XLIFF file to be used. If the `id` matches
    to a previously translated text snippet in the cache file, the text will be copied over and the snippet marked as
    `approved`.
-   `translate.service` - Decides which translation service to use:
    -   `dummy` - Avoids accessing a translation service, copies sources to target langauge directly without amendment.
    -   `custom` - Sends the translate to an arbitrary URL using POST - use this to connect to proxies for Google Cloud
        [Translate](https://cloud.google.com/translate/)
    -   `watson` - Connects to the IBM Cloud Translation service
    -   `bing` - Connects to the Microsoft Translation service
-   `translate.authentication.url` - URL for creating an OAuth token if needed for a service. Defaults to the value in
    `configuration.properties.
-   `translate.apikey` - API Key for the Translation service. Defaults to the value in `configuration.properties`
-   `translate.url` - URL for a Translation service. Defaults to the value in `configuration.properties`

