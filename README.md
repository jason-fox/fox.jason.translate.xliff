# DITA-OT Translate Plug-in [<img src="https://jason-fox.github.io/fox.jason.translate.xliff/xliff.png" align="right" width="300">](https://xliffdita-ot.rtfd.io/)

[![license](https://img.shields.io/github/license/jason-fox/fox.jason.translate.xliff.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![DITA-OT 3.3](https://img.shields.io/badge/DITA--OT-3.3-blue.svg)](http://www.dita-ot.org/3.3/)
[![Build Status](https://travis-ci.org/jason-fox/fox.jason.translate.xliff.svg?branch=master)](https://travis-ci.org/jason-fox/fox.jason.translate.xliff)
[![Coverage Status](https://coveralls.io/repos/github/jason-fox/fox.jason.translate.xliff/badge.svg?branch=master)](https://coveralls.io/github/jason-fox/fox.jason.translate.xliff?branch=master)
[![Documentation Status](https://readthedocs.org/projects/xliffdita-ot/badge/?version=latest)](https://xliffdita-ot.readthedocs.io/en/latest/?badge=latest)

DITA-OT Translate Plug-in is a [DITA-OT Plug-in](https://www.dita-ot.org/plugins) to create, auto-translate and re-merge XLIFF files, generating translated
documentation in a targeted foreign language.

This plug-in consists of three DITA-OT transforms

-   The `xliff-create` transform creates XLIFF and skeleton files from the `*.dita` files.
-   The `xliff-translate` transform populates the `<target>` texts using an automatic translation service.
-   The `xliff2dita` transform recreates the DITA project using the translated texts.

<details>
<summary><strong>Table of Contents</strong></summary>

-   [Install](#install)
    -   [Installing DITA-OT](#installing-dita-ot)
    -   [Installing the Plug-in](#installing-the-plug-in)
    -   [Signing up for an Automatic Translation Service](#signing-up-for-an-automatic-translation-service)
        -   [IBM Cloud Services](#ibm-cloud-services)
        -   [Microsoft Azure](#microsoft-azure)
        -   [Yandex Translate](#yandex-translate)
        -   [DeepL API](#deepl-api)
-   [Usage](#usage)
    -   [Invocation from the command line](#invocation-from-the-command-line)
        -   [Parameter Reference](#parameter-reference)
       
</details>

## Install

The DITA-OT Translate Plug-in has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). It is recommended
that you upgrade to the latest version.

### Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" height="55"></a>

The DITA-OT Translate Plug-in is a plug-in for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/3.3/topics/installing-client.html).

    1.  Download the `dita-ot-3.3.4.zip` package from the project website at
        [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable.

    This defines the necessary environment variable to run the `dita` command from the command line.

```console
curl -LO https://github.com/dita-ot/dita-ot/releases/download/3.3.4/dita-ot-3.3.4.zip
unzip -q dita-ot-3.3.4.zip
rm dita-ot-3.3.4.zip
```

### Installing the Plug-in

-   Run the plug-in installation commands:

```console
dita --install https://github.com/doctales/org.doctales.xmltask/archive/master.zip
dita -install https://github.com/jason-fox/fox.jason.translate.xliff/archive/master.zip
```

The `dita` command line tool requires no additional configuration.

---

### Signing up for an Automatic Translation Service

Several publically available **automatic translation** cloud services are available for use, they typically offer a
_try-before-you-buy_ option and generally offer sample access to the service for without cost. Upgrading to a paid
version will be necessary when transforming larger documents.

#### IBM Cloud Services

[<img src="https://www.nasuni.com/wp-content/uploads/2017/06/ibm-cloud.png" align="right" height="85">](https://cloud.ibm.com/docs/services/language-translator?topic=language-translator-gettingstarted)

The IBM Language Translator allows you to translate text programmatically from one language into another language

Introduction:
[Getting Started](https://cloud.ibm.com/docs/services/language-translator?topic=language-translator-gettingstarted)

Create an instance of the service:

1.  Go to the [Language Translator](https://cloud.ibm.com/catalog/services/language-translator) External link icon page
    in the IBM Cloud Catalog.
2.  Sign up for a free IBM Cloud account or log in.
3.  Click Create.

Copy the credentials to authenticate to your service instance:

1.  From the [IBM Cloud dashboard](https://cloud.ibm.com/dashboard/apps) External link icon, click on your **Language
    Translator** service instance to go to the **Language Translator** service dashboard page.
2.  On the Manage page, click Show to view your credentials.
3.  Copy the `API Key` and `URL` values.
4.  Within the plug-in alter the file `cfg/configuration.properties` to hold your `API Key` and `URL`.

---

#### Microsoft Azure

[<img src="https://www.confluent.io/wp-content/uploads/MS-Azure_logo_stacked_c-gray_rgb.png" align="right" height="85">](https://docs.microsoft.com/en-us/azure/cognitive-services/translator/translator-info-overview)


Microsoft Translator provides multi-language support for translation, transliteration, language detection, and
dictionaries.

Introduction: [Overview](https://docs.microsoft.com/en-us/azure/cognitive-services/translator/translator-info-overview)

Create an instance of the service:

1.  Go to Try [Cognitive Services](https://azure.microsoft.com/try/cognitive-services/)
2.  Select the Translator Text APIs tab.
3.  Under Translator Text, select the Get API Key button.
4.  Agree to the terms and select your locale from the drop-down menu.
5.  Sign in by using your Microsoft, Facebook, LinkedIn, or GitHub account.

You can sign up for a free Microsoft account at the Microsoft account portal. To get started, click Sign in with
Microsoft and then, when asked to sign in, click Create one. Follow the steps to create and verify your new Microsoft
account.

After you sign in to Try Cognitive Services, your free trial begins. The displayed webpage lists all the Azure Cognitive
Services services for which you currently have trial subscriptions. Two subscription keys are listed beside Speech
Services. You can use either key in your applications.

Copy the credentials to authenticate to your service instance:

1.  Copy each of the `API Key` and `Endpoint` values.
2.  Within the plug-in alter the file `cfg/configuration.properties` to hold your `API Key` and `URL`.

---

#### Yandex Translate

[<img src="http://www.companieshistory.com/wp-content/uploads/2014/05/Yandex-NV.png" align="right" height="55">](https://tech.yandex.com/translate/)


The API provides access to the Yandex online machine translation service. It supports more than 90 languages and can
translate separate words or complete texts.

Introduction: [Overview](https://tech.yandex.com/translate/)

To sign-up to the service:

1.  Review the [user agreement](http://legal.yandex.com/translate_api/) and rules for
    [formatting translation results](https://tech.yandex.com/translate/doc/dg/concepts/design-requirements-docpage).
2.  Get a free [API key](https://translate.yandex.com/developers/keys).
3.  Read the [documentation](https://tech.yandex.com/translate/doc/dg/concepts/About-docpage), where you will find
    instructions on enabling the API and detailed descriptions of its features.

After you sign in to your account select API Keys and create a new key as necessary. The latest endpoint can be found in
the [documentation](https://tech.yandex.com/translate/doc/dg/reference/translate-docpage/#XML)

```text
https://translate.yandex.net/api/v1.5/tr/translate
```

Copy the credentials to authenticate to your service instance:

1.  Copy each of the `API Key` and `Endpoint` values.
2.  Within the plug-in alter the file `cfg/configuration.properties` to hold your `API Key` and `URL`.

---

#### DeepL API

[<img src="https://www.deepl.com/img/logo/DeepL_LogoAndText_darkBlue.svg" align="right" height="40">](https://www.deepl.com)

The DeepL API is accessible with a [DeepL Pro subscription (DeepL API plan)](https://www.deepl.com/pro.html#developer)
only. The API is an interface that allows other computer programs to send texts to the DeepL servers and receive
high-quality translations.

Introduction: [Overview](https://www.deepl.com)

To sign-up to the service:

1.  Open a [DeepL API](https://www.deepl.com/pro.html#developer) **developers** account. Note that not all accounts
    offer access to the DeepL API. It is **essential** that the account type includes REST API access.
2.  Fill out the application details and add a credit card. No payments are required for the first 30 days. You can
    cancel the card and still maintain free access for the trial period.
3.  Read the [documentation](https://www.deepl.com/docs-api.html), where you will find instructions on enabling the API
    and detailed descriptions of its features.

After you sign in to your account select API Keys and create a new key as necessary. The latest endpoint can be found in
the [documentation](https://www.deepl.com/docs-api.html?part=translating_text)

```text
https://api.deepl.com/v2/translate
```

Copy the credentials to authenticate to your service instance:

1.  Copy each of the `API Key` and `Endpoint` values.
2.  Within the plug-in alter the file `cfg/configuration.properties` to hold your `API Key` and `URL`.

---

## Usage

### Invocation from the command line

1.  to create an XLIFF File and associated skeletons with run:

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

> **Note:** if the `translate.cachefile` parameter is used, unchanged text with previously approved translations will be
> copied over to the `<target>` elements.

2.  to populate an exisiting XLIFF File with auto-translated text

```console
PATH-TO-DITA-OT/bin/dita -f xliff-translate \
    -i translate.xlf --translate.service=[bing|deepl|watson|yandex] \
    --translate.apikey=<api-key>
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

> **Note:** only `<trans-unit>` elements which are `approved="no"` will be auto-translated.

3.  recreate `*.dita` files using an XLIFF File and its associated skeletons with run:

```console
PATH-TO-DITA-OT/bin/dita -f xliff2dita -i translate.xlf -o out
```

#### Result

The translated `*.dita` files are generated into the `out` directory.

> **Note:** Any machine translation is by definition imperfect. A typical translation workflow would send the generated
> XLIFF files to the translation agency (known also as "localisation service provider"), and receive back verified
> translated content from the translation agency integrated into to the XLIFF. Each `<trans-unit>` should be marked
> `approved="yes"` when the `<target>` element has been verified.

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

## License

[Apache 2.0](LICENSE) © 2019 Jason Fox

The Program includes the following additional software components which were obtained under license:

-   xmltask.jar - http://www.oopsconsultancy.com/software/xmltask/ - **Apache 1.1 license** (within `org.doctales.xmltask` plug-in)
