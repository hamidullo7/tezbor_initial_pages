import '../services/count_down.dart';
import '../widget/text_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterSmsPage extends StatefulWidget {
  EnterSmsPage(
      {Key? key,
      this.arguments,
      this.resendSms = true,
      this.apiController,
      this.platform = 3,
      this.messaging,
      this.signatureCode,
      this.lang_enter_sms_code = 'enter code',
      this.lang_didnt_receive = "didn't recieve",
      this.lang_we_will_resend = 'we will resend',
      this.lang_resend_sms = 'resend sms',
      this.lang_next = 'resend sms',
      required this.submit,
      required this.didntRecieve,
      required this.longPressFunction,
      this.pinPutFocusNode,
      this.pinPutController})
      : super(key: key);

  final dynamic arguments;
  bool resendSms;
  final dynamic apiController;
  final int platform;
  final dynamic messaging;
  final String? signatureCode;
  final String lang_enter_sms_code;
  final String lang_didnt_receive;
  final String lang_we_will_resend;
  final String lang_resend_sms;
  final String lang_next;
  final dynamic submit;
  final dynamic didntRecieve;
  final dynamic longPressFunction;
  final dynamic pinPutController;
  final dynamic pinPutFocusNode;

  @override
  _EnterCodeFromSmSState createState() => _EnterCodeFromSmSState();
}

class _EnterCodeFromSmSState extends State<EnterSmsPage> with CodeAutoFill {
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.keyboard_backspace),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                iconSize: 30,
              );
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Center(
                      child: Center(
                        child: Text(widget.lang_enter_sms_code,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: PinPut(
                        key: Key("smsCode"),
                        autofocus: true,
                        fieldsCount: 6,
                        onSubmit: (String pin) {
                          if (pin.length == 6) {
                            widget.submit();
                          }
                        },
                        focusNode: widget.pinPutFocusNode,
                        controller: widget.pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Color.fromRGBO(206, 208, 206, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Visibility(
                      child: Column(
                        children: [
                          Text(widget.lang_didnt_receive,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02)
                        ],
                      ),
                      visible: !widget.resendSms,
                    ),
                    widget.resendSms
                        ? CountdownFormatted(
                            onFinish: () {
                              setState(() {
                                widget.resendSms = false;
                              });
                            },
                            duration: new Duration(minutes: 3),
                            builder: (BuildContext ctx, String remaining) {
                              return Text(
                                  widget.lang_we_will_resend + " $remaining ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black));
                            },
                          )
                        : GestureDetector(
                            onTap: () async {
                              widget.didntRecieve();
                              // await apiController
                              //     .newResendSms(widget.arguments.phoneNumber)
                              //     .then((res) {
                              //   if (res != null) {
                              //     setState(() {
                              //       _pinPutController.text = '';
                              //       resendSms = true;
                              //     });
                              //   }
                              // });
                            },
                            onLongPress: () {
                              widget.longPressFunction();
                              // Fluttertoast.showToast(
                              //   timeInSecForIosWeb: 3,
                              //   msg: signatureCode,
                              //   gravity: ToastGravity.BOTTOM,
                              //   toastLength: Toast.LENGTH_SHORT,
                              // );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.grey,
                              child: Text(widget.lang_resend_sms,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Spacer(),
                  ]),
            ),
          ) /* add child content here */,
        ));
  }

  TextButton nextButton() {
    return customFlatButton(
      onPressed: () async {
        widget.submit();
      },
      label: widget.lang_next.toUpperCase(),
      disabledColor: Color.fromRGBO(206, 208, 206, 1),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
    );
  }

  @override
  void codeUpdated() {
    setState(() {
      widget.pinPutController.text = code!;
    });
  }
}
