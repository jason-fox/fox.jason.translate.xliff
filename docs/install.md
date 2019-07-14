<h1>Install</h1>

The DITA-OT Translate Plug-in has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). It is recommended
that you upgrade to the latest version.

## Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" width="55" height="55"></a>

The DITA-OT Translate Plug-in is a plug-in for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/3.3/topics/installing-client.html).

    1.  Download the `dita-ot-3.3.zip` package from the project website at
        [dita-ot.org/download](https://www.dita-ot.org/download)
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

## Signing up for an Automatic Translation Service

Several publically available **automatic translation** cloud services are available for use, they typically offer a
_try-before-you-buy_ option and generally offer sample access to the service for without cost. Upgrading to a paid
version will be necessary when transforming larger documents.

### IBM Cloud Services

<a href="https://cloud.ibm.com/docs/services/language-translator?topic=language-translator-gettingstarted"><img src="https://www.nasuni.com/wp-content/uploads/2017/06/ibm-cloud.png" align="right" width="119" height="85"></a>

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

### Microsoft Azure

<a href="https://docs.microsoft.com/en-us/azure/cognitive-services/translator/translator-info-overview"><img src="https://www.confluent.io/wp-content/uploads/MS-Azure_logo_stacked_c-gray_rgb.png" align="right" width="160" height="85"></a>


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

### Yandex Translate

<a href="https://tech.yandex.com/translate/"><img src="http://www.companieshistory.com/wp-content/uploads/2014/05/Yandex-NV.png" align="right" height="55" width="107"></a>


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

### DeepL API

<a href="https://www.deepl.com"><img src="https://www.deepl.com/img/logo/DeepL_LogoAndText_darkBlue.svg" align="right" width="117" height="40"></a>

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
