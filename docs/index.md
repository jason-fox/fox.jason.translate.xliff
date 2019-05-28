<h1>DITA-OT Translate Plug-in</h1>


DITA-OT Translate Plug-in is a plug-in to create, auto-translate and re-merge XLIFF files, generating documentation in
the translated language.

This plug-in consists of three DITA-OT transforms


* The `xliff-create` transform creates XLIFF and skeleton files from the `*.dita` files.
* The `xliff-translate` transform populates the `<target>` texts using an automatic translation service.
* The `xliff2dita` transform recreates the DITA project using the translated texts.


### DITA File

```xml
<topic id="cicero" xml:lang="en-us">
  <title>Cicero</title>
  <body>
    <p>
      Loves or pursues or desires to obtain pain of itself, because it
      is pain, but occasionally circumstances occur in which toil and
      pain can procure him some great pleasure.
    </p>
    <p>
      To take a trivial example, which of us ever undertakes laborious
      physical exercise, except to obtain some advantage from it?
    </p>
    <p>
      But who has any right to find fault with a man who chooses to
      enjoy a pleasure that has no annoying consequences, or one who
      avoids a pain that produces no resultant pleasure?
    </p>
  </body>
</topic>
```

### Sample XLIFF File (with Latin Translation)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xliff xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <file datatype="xml" original="/cicero.dita" source-language="en" target-language="es">
    <header xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
      <skl>
        <external-file href="./skl/cicero.dita.skl" />
      </skl>
    </header>
    <body xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:dita="http://www.dita-ot.org">
        <trans-unit xmlns="" xmlns:dita="dita-ot.org" approved="no" id="42094" xml:space="preserve">
           <source xml:lang="en">
            Loves or pursues or desires to obtain pain of itself, because it
            is pain, but occasionally circumstances occur in which toil and
            pain can procure him some great pleasure.
          </source>
          <target xml:lang="la">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua.
          </target>
        </trans-unit>
        <trans-unit xmlns="" xmlns:dita="dita-ot.org" approved="no" id="5532" xml:space="preserve">
           <source xml:lang="en">
            To take a trivial example, which of us ever undertakes laborious
            physical exercise, except to obtain some advantage from it?
          </source>
          <target xml:lang="la">
            Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
            nisi ut aliquip ex ea commodo consequat.
          </target>
        </trans-unit>
        <trans-unit xmlns="" xmlns:dita="dita-ot.org" approved="no" id="66134" xml:space="preserve">
           <source xml:lang="en">
            But who has any right to find fault with a man who chooses to
            enjoy a pleasure that has no annoying consequences, or one who
            avoids a pain that produces no resultant pleasure?
          </source>
          <target xml:lang="la">
            Duis aute irure dolor in reprehenderit in voluptate velit esse
            cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
            cupidatat non proident, sunt in culpa qui officia deserunt mollit
            anim id est laborum.
          </target>
        </trans-unit>
        ... etc
      </body>
   </file>
...etc
```


### DITA Skeleton File

```xml
<topic id="cicero" xml:lang="la">
  <title>@@@90122@@@</title>
  <body>
    <p>
      @@@42094@@@
    </p>
    <p>
      @@@5532@@@
    </p>
    <p>
      @@@66134@@@
    </p>
  </body>
</topic>
```