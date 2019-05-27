# DITA-OT Translate Plug-in

[![license](https://img.shields.io/github/license/jason-fox/fox.jason.translate.xliff.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![DITA-OT 3.3](https://img.shields.io/badge/DITA--OT-3.3-blue.svg)](http://www.dita-ot.org/3.3/) <br/>

DITA-OT Translate Plug-in is a plug-in to create, auto-translate and re-merge
XLIFF files, generating documentation in the translated language.

# Table of Contents

-   [Install](#install)
    -   [Installing DITA-OT](#installing-dita-ot)
    -   [Installing the Plug-in](#installing-the-plug-in)
-   [Usage](#usage)
    -   [Invocation from the command line](#invocation-from-the-command-line)
        -   [Result](#result)
    -   [Customizing the output](#customizing-the-output)
        -   [Extending to other languages](#extending-to-other-languages)
        -   [Altering the static HTML look and feel](#altering-the-static-html-look-and-feel)
        -   [Altering the PDF look and feel](#altering-the-pdf-look-and-feel)
-   [License](#license)


# Install

The DITA-OT Translate Plug-in has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). It is
recommended that you upgrade to the latest version.

## Installing DITA-OT

The DITA-OT Translate Plug-in is a plug-in for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/3.3/topics/installing-client.html).

    1.  Download the `dita-ot-3.3.zip` package from the project website at [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable.

    This defines the necessary environment variable to run the `dita` command from the command line.

```console
curl -LO https://github.com/dita-ot/dita-ot/releases/download/3.3/dita-ot-3.3.zip
unzip -q dita-ot-3.3.zip
rm dita-ot-3.3.zip
```

## Installing the Plug-in

-   Run the plug-in installation command:

```console
dita -install https://github.com/jason-fox/fox.jason.translate.xliff/archive/master.zip
```

The `dita` command line tool requires no additional configuration.

# Usage

Work in progress:

## Invocation from the command line

-   to create an XLIFF File and associated skeletons with run:

```console
PATH-TO-DITA-OT/bin/dita -f xliff-create -i document.ditamap  -o out
```

#### Result

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
            example, which of us ever undertakes laborious physical exercise,
            except to obtain some advantage from it? But who has any right to
            find fault with a man who chooses to enjoy a pleasure that has no
            annoying consequences, or one who avoids a pain that produces no
            resultant pleasure?
          </source>
          <target xml:lang="la"/>
        </trans-unit>
        ... etc
      </body>
   </file>
...etc
```


-   to populate an exisiting XLIFF File with auto-translated text

```console
PATH-TO-DITA-OT/bin/dita -f xliff-translate -i translate.xlf --translate.service=[bing|watson] --translate.apikey=<api-key>
```

#### Result

The XLIFF File is auto-translated in place, with translated text as shown:

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
            example, which of us ever undertakes laborious physical exercise,
            except to obtain some advantage from it? But who has any right to
            find fault with a man who chooses to enjoy a pleasure that has no
            annoying consequences, or one who avoids a pain that produces no
            resultant pleasure?
          </source>
          <target xml:lang="la">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
            enim ad minim veniam, quis nostrud exercitation ullamco laboris
            nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
            reprehenderit in voluptate velit esse cillum dolore eu fugiat
            nulla pariatur. Excepteur sint occaecat cupidatat non proident,
            sunt in culpa qui officia deserunt mollit anim id est laborum.
          </target>
        </trans-unit>
        ...etc
      </body>
   </file>
...etc
```

-   recreate `*.dita` files using an XLIFF File and its associated skeletons with run:

```console
PATH-TO-DITA-OT/bin/dita -f xliff2dita -i translate.xlf -o out
```

#### Result

The translated `*.dita` files are generated into the `out` directory.


### Parameter Reference

-   `translate.service` - Decides which translation service to use:
    -   `dummy` - Avoids accessing a translation service, copies sources
        to target langauge directly without amendment.
    -   `custom` - Sends the translate to an arbitrary URL using POST - use this to connect to proxies for Google Cloud
        [Translate](https://cloud.google.com/translate/)
    -   `watson` - Connects to the IBM Cloud Translation service
    -   `bing` - Connects to the Microsoft Translation service
-   `translate.authentication.url` - URL for creating an OAuth token if needed for a service. Defaults to the value in
    `configuration.properties.
-   `translate.apikey` - API Key for the Translation service. Defaults to the value in `configuration.properties`
-   `translate.url` - URL for a Translation service. Defaults to the value in `configuration.properties`


# License

[Apache 2.0](LICENSE) © 2019 Jason Fox

The Program includes the following additional software components which were obtained under license:

-   xmltask.jar - http://www.oopsconsultancy.com/software/xmltask/ - **Apache 1.1 license**
