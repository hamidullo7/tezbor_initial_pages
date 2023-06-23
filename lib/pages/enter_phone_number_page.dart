import 'package:flutter/material.dart';

class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage({
    Key? key,
    this.platform = 3,
    this.phoneNumberFocus,
    this.phoneNumberController,
    this.PendingDynamicLinkData,
    this.lang_enter_mobile_number = 'enter mobile number',
    this.lang_mobile_number = 'mobile number',
    required this.onSubmit,
    this.formKey,
  }) : super(key: key);

  final int platform;
  final dynamic phoneNumberFocus;
  final dynamic phoneNumberController;
  final dynamic PendingDynamicLinkData;
  final String lang_enter_mobile_number;
  final String lang_mobile_number;
  final Function onSubmit;
  final dynamic formKey;

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: ExactAssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                fixedTitle(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                      key: Key("phone_input_field"),
                      autofocus: true,
                      focusNode: widget.phoneNumberFocus,
                      controller: widget.phoneNumberController,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: IconButton(
                            onPressed: () {
                             
                                widget.onSubmit(
                                    widget.phoneNumberController.text ?? '');
                              
                            },
                            icon: Icon(
                              Icons.arrow_right_alt,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        prefixText: "+998 ",
                        labelText: widget.lang_enter_mobile_number,
                        counterText: '',
                        labelStyle: new TextStyle(
                            color: Theme.of(context).primaryColor),
                        border: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor)),
                      ),
                      maxLength: 9,
                      keyboardType: TextInputType.number,
                      onSubmitted: (String number) => widget.onSubmit(number),
                      onChanged: (String number) => widget.onSubmit(number)),
                ),
              ],
            ),
          )),
    );
  }

  Container fixedTitle(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: <Widget>[
          Text(
            widget.lang_mobile_number,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).primaryColor),
          ),
        ]),
      ),
    );
  }
}
