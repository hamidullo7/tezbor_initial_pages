<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This is a packages that can be used on 3 different types of applications of tezbor uz

## Features

Package includes EnterSmS and Enter phone number screens

## Getting started

Simply intstall and use this. Note: Package use sms_autofill: ^2.1.2 and pinput: ^1.2.0 to work in

## Usage

Provide all required fields including functions. Note that there are two screens to use and classes are EnterSmsPage and PhoneNumberPage respectively

```dart
Widget build(BuildContext context) {
    return EnterSmsPage(
      submit: submit,
      didntRecieve: didntRecieve,
      longPressFunction: longPressFunction,
      apiController: apiController,
      arguments: widget.arguments,
      lang_didnt_receive: LocaleKeys.didnt_receive.tr(),
      lang_enter_sms_code: LocaleKeys.enter_sms_code.tr(),
      lang_resend_sms: LocaleKeys.resend_sms.tr(),
      lang_we_will_resend: LocaleKeys.we_will_resend.tr(),
      lang_next: LocaleKeys.next.tr(),
      messaging: messaging,
      platform: platform,
      resendSms: resendSms,
      signatureCode: signatureCode,
      key: Key('sms_s'),
      pinPutController: _pinPutController,
      pinPutFocusNode: _pinPutFocusNode,
    );
  }
}
```

## Additional information

To update you shuold ask for access
