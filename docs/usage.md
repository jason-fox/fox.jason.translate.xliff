<h1>Usage</h1>

### XLIFF 1.2 Invocation from the command line

&nbsp;1.  to create an XLIFF 1.2 File and associated skeletons with run:

```console
PATH-TO-DITA-OT/bin/dita -f xliff-create -i document.ditamap  -o out  --xliff.version=1
```

<h4>Result</h4>

A `translate.xlf` file will appear in the `out` directory along with a series of skeleton files.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xliff xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <file datatype="xml" original="/document.ditamap" source-language="en" target-language="es">
    <header xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
      <skl>
        <external-file href="./skl/document.ditamap.skl" />
      </skl>
    </header>
    <body xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
        <trans-unit xmlns="" xmlns:dita="dita-ot.org" approved="no" id="42094" xml:space="preserve">
          <source xml:lang="en">
            Loves or pursues or desires to obtain pain of itself, because it
            is pain, but occasionally circumstances occur in which toil and
            pain can procure him some great pleasure. To take a trivial
            example,  <x ctype="x-dita-b" id="d3e14">which of us ever undertakes
            laborious physical exercise,</x> except to obtain some advantage from it?
            But who has any right to find fault with a man who chooses to enjoy a pleasure
            that has no annoying consequences, or one who avoids a pain that produces no
            resultant pleasure?
          </source>
          <target xml:lang="la"/>
        </trans-unit>
        ... etc
      </body>
   </file>
...etc
```

> **Note:** if the `translate.cachefile` parameter is used, unchanged text with previously approved translations will be
> copied over to the `<target>` elements.

&nbsp;2.  to populate an exisiting XLIFF 1.2 File with auto-translated text

```console
PATH-TO-DITA-OT/bin/dita -f xliff-translate \
    -i translate.xlf --translate.service=[bing|deepl|watson|yandex] \
    --translate.apikey=<api-key>
    --xliff.version=1
```

<h4>Result</h4>

The XLIFF 1.2 File is auto-translated in place, with translated text as shown:

> **Note:** only `<trans-unit>` elements which are `approved="no"` will be auto-translated.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xliff xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <file datatype="xml" original="/document.ditamap" source-language="en" target-language="es">
    <header xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
      <skl>
        <external-file href="./skl/document.ditamap.skl" />
      </skl>
    </header>
    <body xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
        <trans-unit xmlns="" xmlns:dita="dita-ot.org" approved="no" id="42094" xml:space="preserve">
          <source xml:lang="en">
            Loves or pursues or desires to obtain pain of itself, because it
            is pain, but occasionally circumstances occur in which toil and
            pain can procure him some great pleasure. To take a trivial
            example, <x ctype="x-dita-b" id="d3e14">which of us ever undertakes
            laborious physical exercise,</x> except to obtain some advantage from it?
            But who has any right to find fault with a man who chooses to enjoy a pleasure
            that has no annoying consequences, or one who avoids a pain that produces no
            resultant pleasure?
          </source>
          <target xml:lang="la">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
            enim ad minim veniam, <x ctype="x-dita-b" id="d3e14">quis nostrud exercitation
            ullamco laboris,</x> nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
            in reprehenderit in voluptate velit esse cillum dolore eu fugiat
            nulla pariatur. Excepteur sint occaecat cupidatat non proident,
            sunt in culpa qui officia deserunt mollit anim id est laborum.
          </target>
        </trans-unit>
        ...etc
      </body>
   </file>
...etc
```

### XLIFF 2.1 Invocation from the command line

&nbsp;3.  to create an XLIFF 2.1 File and associated skeletons with run:

```console
PATH-TO-DITA-OT/bin/dita -f xliff-create -i document.ditamap  -o out  --xliff.version=2
```

<h4>Result</h4>

A `translate.xlf` file will appear in the `out` directory along with a series of skeleton files.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xliff srcLang="en" trgLang="la" version="2.0" xmlns="urn:oasis:names:tc:xliff:document:2.0">
  <file id="2" original="/topic.dita">
    <skeleton href="./skl/topic.dita.skl"></skeleton>
    <unit fs:fs="p" id="9962" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
      <originalData>
        <data id="sd4e14">&lt;b&gt;</data>
        <data id="ed4e14">&lt;/b&gt;</data>
      </originalData>
      <segment state="initial">
        <source xml:lang="en" xml:space="preserve">Loves or pursues or desires to obtain pain of
            itself, because it is pain, but occasionally circumstances occur in which toil and pain
            can procure him some  great pleasure. To take a trivial example, <pc dataRefEnd="ed4e14"
            dataRefStart="sd4e14" fs:fs="b" id="d4e14">which of us ever undertakes laborious physical
            exercise,</pc>except to obtain some advantage from it? But who has any right to find fault
            with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids
            a pain that produces no resultant pleasure?
          </source>
          <target xml:lang="la"></target>
      </segment>
    </unit>
    ...etc
  </file>
  ...etc
```

&nbsp;4.  to populate an exisiting XLIFF 2.1 File with auto-translated text

```console
PATH-TO-DITA-OT/bin/dita -f xliff-translate \
    -i translate.xlf --translate.service=[bing|deepl|watson|yandex] \
    --translate.apikey=<api-key>
    --xliff.version=2
```

<h4>Result</h4>

The XLIFF 2.1 File is auto-translated in place, with translated text as shown:

> **Note:** any `<segement>` elements which are `state="final"` will not be re-translated.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xliff srcLang="en" trgLang="la" version="2.0" xmlns="urn:oasis:names:tc:xliff:document:2.0">
  <file id="2" original="/topic.dita">
    <skeleton href="./skl/topic.dita.skl"></skeleton>
    <unit fs:fs="p" id="9962" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
      <originalData>
        <data id="sd4e14">&lt;b&gt;</data>
        <data id="ed4e14">&lt;/b&gt;</data>
      </originalData>
      <segment state="translated">
        <source xml:lang="en" xml:space="preserve">Loves or pursues or desires to obtain pain of
            itself, because it is pain, but occasionally circumstances occur in which toil and pain
            can procure him some  great pleasure. To take a trivial example, <pc dataRefEnd="ed4e14"
            dataRefStart="sd4e14" fs:fs="b" id="d4e14">which of us ever undertakes laborious physical
            exercise</pc>except to obtain some advantage from it? But who has any right to find fault with
            a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain
            that produces no resultant pleasure?
        </source>
        <target xml:lang="la">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
            enim ad minim veniam, <pc dataRefEnd="ed4e14" dataRefStart="sd4e14" fs:fs="b" id="d4e14">
            quis nostrud exercitation ullamco laboris,</pc> nisi ut aliquip ex ea commodo consequat.
            Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat
            nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
            deserunt mollit anim id est laborum.
        </target>
      </segment>
    </unit>
    ...etc
  </file>
  ...etc
```

### Populating Skeletons from the command line

&nbsp;5.  recreate `*.dita` files using an XLIFF File and its associated skeletons with run:

```console
PATH-TO-DITA-OT/bin/dita -f xliff-dita -i translate.xlf -o out --xliff.version=1|2
```

<h4>Result</h4>

The translated `*.dita` files are generated into the `out` directory.

> **Note:** Any machine translation is by definition imperfect. A typical translation workflow would send the generated
> XLIFF files to the translation agency (known also as "localisation service provider"), and receive back verified
> translated content from the translation agency integrated into to the XLIFF. For XLIFF 1.2, each `<trans-unit>` should
> be marked `approved="yes"` when the `<target>` element has been verified. Similarly for XLIFF 2.1 each `<segement>`
> should be marked as `state="final"`.

### Parameter Reference

-   `translate.from` - Source language to use. Defaults to the value in `configuration.properties`
-   `translate.to` - Target language. Defaults to the value in `configuration.properties`
-   `translate.cachefile` - Specifies the location of a previously translated XLIFF file to be used. If the `id` matches
    to a previously translated text snippet in the cache file, the text will be copied over and the snippet marked as
    `approved`.
-   `translate.service` - Decides which translation service to use:
    -   `bing` - Connects to the **Microsoft Azure** Translation service
    -   `custom` - Sends the translate to an arbitrary URL using POST - use this to connect to proxies for
        [Google Cloud Translate](https://cloud.google.com/translate/)
    -   `deepl` - Connects to the **DeepL API** Translation service
    -   `dummy` - Avoids accessing a translation service, copies sources to target langauge directly without amendment.
    -   `watson` - Connects to the **IBM Cloud** Translation service
    -   `yandex` - Connects to the **Yandex** Translation service
-   `translate.authentication.url` - URL for creating an OAuth token if needed for a service. Defaults to the value in
    `configuration.properties.
-   `translate.apikey` - API Key for the Translation service. Defaults to the value in `configuration.properties`
-   `translate.url` - URL for a Translation service. Defaults to the value in `configuration.properties`
-   `xliff.version` - Decides which XLIFF format to use. Defaults to the value in `configuration.properties`:
    -   `1` - XLIFF 1.2 format
    -   `2` - XLIFF 2.1 format
