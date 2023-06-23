import 'package:flutter/material.dart';
import '../../widget/text_button.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

class CustomerSignUpScreen extends StatefulWidget {
  CustomerSignUpScreen({
    Key? key,
    this.checkbox,
    this.platform = 3,
    this.apiController,
    this.maskTextInputFormatter,
    this.nameKey = const Key("name"),
    this.lastName = const Key("lastName"),
    this.formKey,
    this.user,
    this.settingsArguments,
    required this.lang_email_incorrect,
    required this.lang_name,
    required this.lang_required,
    required this.lang_last_name,
    required this.lang_next,
    required this.lang_i_agree_to,
    required this.lang_privacy_policy,
    required this.lang_email,
    required this.lang_mobile_number,
    required this.lang_sign_up,
    required this.onPressedNext,
    required this.pop,
    this.context_locale,
    this.phone_number_unabled = false,
  }) : super(key: key);

  final bool? checkbox;
  final int platform;
  final dynamic apiController;
  final dynamic maskTextInputFormatter;
  final Key nameKey;
  final Key lastName;
  final dynamic formKey;
  final dynamic user;
  final dynamic settingsArguments;
  final Future<void> Function(
          dynamic number, dynamic email, dynamic name, dynamic last_name)
      onPressedNext;
  final void Function() pop;
  final String lang_email_incorrect;
  final String lang_name;
  final String lang_required;
  final String lang_last_name;
  final String lang_next;
  final String lang_i_agree_to;
  final String lang_privacy_policy;
  final String lang_email;
  final String lang_mobile_number;
  final String lang_sign_up;
  final dynamic context_locale;
  final bool phone_number_unabled;
  @override
  _CustomerSignUpScreenState createState() => _CustomerSignUpScreenState();
}

class _CustomerSignUpScreenState extends State<CustomerSignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    if (widget.settingsArguments.registered != null &&
        widget.settingsArguments.registered) {
      setState(() {
        phoneNumberController.text = widget.settingsArguments.phoneNumber;
        emailController.text = widget.settingsArguments.email;
        nameController.text = widget.settingsArguments.firstName;
        lastNameController.text = widget.settingsArguments.lastName;
      });
    } else {
      setState(() {
        phoneNumberController.text = widget.user.phoneNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: ExactAssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            top: true,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_backspace),
                      onPressed: widget.pop,
                      iconSize: 30,
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                        key: widget.formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 40,
                          ),
                          child: Column(
                            children: [
                              fixedTitle(context),
                              const SizedBox(height: 10),
                              const SizedBox(height: 20),
                              fixedEmailField(widget.lang_email_incorrect),
                              const SizedBox(height: 20),
                              fixedPhoneNumberField(),
                              const SizedBox(height: 20),
                              fixedTextField(widget.lang_name, nameController,
                                  widget.lang_required, widget.nameKey),
                              const SizedBox(height: 20),
                              fixedTextField(
                                  widget.lang_last_name,
                                  lastNameController,
                                  widget.lang_required,
                                  widget.lastName),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              ListTileTheme(
                                  contentPadding: const EdgeInsets.all(0),
                                  child:
                                      buildCheckboxListTileFormField(context)),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Container(
                                height: 43,
                                width: 332,
                                child: customFlatButton(
                                  key: const Key("submit_sign_up_btn"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  label: widget.lang_next,
                                  onPressed: () async {
                                    widget.onPressedNext(
                                        phoneNumberController.text,
                                        emailController.text,
                                        nameController.text,
                                        lastNameController.text);
                                  },
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  CheckboxListTileFormField buildCheckboxListTileFormField(
      BuildContext context) {
    return CheckboxListTileFormField(
      key: const Key("privacy_policy_checkbox"),
      activeColor: Theme.of(context).primaryColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.lang_i_agree_to,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed('/privacy_policy', arguments: widget.context_locale),
            child: Container(
              child: Text(
                widget.lang_privacy_policy,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          )
        ],
      ),
      validator: (value) {
        if (value != null && value) {
          return null;
        } else {
          return widget.lang_required;
        }
      },
    );
  }

  TextFormField fixedPhoneNumberField() {
    return TextFormField(
      enabled: widget.phone_number_unabled,
      textInputAction: TextInputAction.next,
      controller: phoneNumberController,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return widget.lang_required;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixText: "+998 ",
        labelText: widget.lang_mobile_number,
        labelStyle:
            new TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Theme.of(context).primaryColor)),
      ),
      inputFormatters: [widget.maskTextInputFormatter],
      keyboardType: TextInputType.number,
      //onSubmitted: (){},
    );
  }

  TextFormField fixedTextField(String title, TextEditingController controller,
      String validator, keyName) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value != null && value.isEmpty) {
          return validator;
        }
        return null;
      },
      controller: controller,
      key: keyName,
      decoration: InputDecoration(
        labelText: title,
        labelStyle:
            new TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Theme.of(context).primaryColor)),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField fixedEmailField(String validator) {
    return TextFormField(
      key: Key("email_input_field"),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (val) =>
          val!.isNotEmpty && !val.contains("@") ? validator : null,
      controller: emailController,
      decoration: InputDecoration(
        labelText: widget.lang_email,
        labelStyle:
            new TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Theme.of(context).primaryColor)),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Container fixedTitle(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: <Widget>[
          Text(widget.lang_sign_up,
              style: TextStyle(
                  fontSize: 32, color: Theme.of(context).primaryColor))
        ]),
      ),
    );
  }
}
