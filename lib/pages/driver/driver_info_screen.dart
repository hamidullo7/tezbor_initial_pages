import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import '../../widget/text_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class DriverInfoPage extends StatefulWidget {
  const DriverInfoPage({
    Key? key,
    this.driverInfo,
    this.phoneNumberController,
    this.referrerNumberController,
    this.emailController,
    this.nameController,
    this.lastNameController,
    required this.onPressed,
    this.contextLocale,
    this.phoneNumberEnabled = false,
    // ignore: non_constant_identifier_names
    this.lang_driver_info = 'lang_driver_info',
    // ignore: non_constant_identifier_names
    this.lang_name = 'lang_name',
    // ignore: non_constant_identifier_names
    this.lang_required = 'lang_required',
    // ignore: non_constant_identifier_names
    this.lang_last_name = 'lang_last_name',
    // ignore: non_constant_identifier_names
    this.lang_next = 'lang_next',
    // ignore: non_constant_identifier_names
    this.lang_i_agree_to = 'lang_i_agree_to',
    // ignore: non_constant_identifier_names
    this.lang_privacy_policy = 'lang_privacy_policy',
    // ignore: non_constant_identifier_names
    this.lang_mobile_number = 'lang_mobile_number',
    // ignore: non_constant_identifier_names
    this.lang_referrer_phone = 'lang_referrer_phone',
    // ignore: non_constant_identifier_names
    this.lang_enter_valid_email = 'lang_enter_valid_email',
    // ignore: non_constant_identifier_names
    this.lang_email = 'lang_email',
  }) : super(key: key);
  final dynamic driverInfo;
  final dynamic phoneNumberController;
  final dynamic referrerNumberController;
  final dynamic emailController;
  final dynamic nameController;
  final dynamic lastNameController;
  final void Function() onPressed;
  final dynamic contextLocale;
  final bool phoneNumberEnabled;

  // ignore: non_constant_identifier_names
  final String lang_driver_info;
  // ignore: non_constant_identifier_names
  final String lang_name;
  // ignore: non_constant_identifier_names
  final String lang_required;
  // ignore: non_constant_identifier_names
  final String lang_last_name;
  // ignore: non_constant_identifier_names
  final String lang_next;
  // ignore: non_constant_identifier_names
  final String lang_i_agree_to;
  // ignore: non_constant_identifier_names
  final String lang_privacy_policy;
  // ignore: non_constant_identifier_names
  final String lang_mobile_number;
  // ignore: non_constant_identifier_names
  final String lang_referrer_phone;
  // ignore: non_constant_identifier_names
  final String lang_enter_valid_email;
  // ignore: non_constant_identifier_names
  final String lang_email;
  @override
  // ignore: library_private_types_in_public_api
  _DriverInfoPageState createState() => _DriverInfoPageState();
}

class _DriverInfoPageState extends State<DriverInfoPage> {
  bool? checkBox;
  Key nameKey = const Key("name");
  Key lastName = const Key("lastName");
  final _formKey = GlobalKey<FormState>();
  int stepNum = 1;
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    // driverInfo = ModalRoute.of(context).settings.arguments;
    if (widget.driverInfo.isRegistered) {
      setState(() {
        widget.phoneNumberController.text = widget.driverInfo.phoneNumber;
        widget.emailController.text = widget.driverInfo.email;
        widget.nameController.text = widget.driverInfo.firstName;
        widget.lastNameController.text = widget.driverInfo.lastName;
        _enabled = true;
      });
    } else if (widget.driverInfo.isRegistered == null) {
      setState(() {
        widget.referrerNumberController.text =
            widget.driverInfo.referrerPhoneNumber;
      });
    } else {
      setState(() {
        widget.phoneNumberController.text = widget.driverInfo.phoneNumber;
      });
    }
    // ignore: prefer_typing_uninitialized_variables
    var onPressed;
    if (_enabled) {
      onPressed = () {
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          widget.onPressed();
        }
      };
    }

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
          appBar: AppBar(
            title: Text(
              widget.lang_driver_info,
              style: const TextStyle(
                  color: Color.fromRGBO(82, 173, 68, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.keyboard_backspace),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                  iconSize: 30,
                );
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 1; i <= 3; i++)
                      Flexible(
                        child: SvgPicture.asset("assets/icons/line_big.svg",
                            color: stepNum >= i
                                ? const Color.fromRGBO(251, 171, 14, 1)
                                : Theme.of(context).colorScheme.secondary),
                      ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 40,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            fixedTextField(
                                widget.lang_name,
                                widget.nameController,
                                nameKey,
                                widget.lang_required,
                                widget.driverInfo.isRegistered != null &&
                                        widget.driverInfo.isRegistered
                                    ? false
                                    : true),
                            const SizedBox(height: 20),
                            fixedTextField(
                                widget.lang_last_name,
                                widget.lastNameController,
                                lastName,
                                widget.lang_required,
                                false),
                            const SizedBox(height: 20),
                            fixedEmailField(),
                            const SizedBox(height: 20),
                            fixedPhoneNumberField(),
                            const SizedBox(height: 20),
                            fixedReferrerPhoneNumberField(),
                            const SizedBox(height: 20),
                            ListTileTheme(
                              contentPadding: const EdgeInsets.all(0),
                              child: buildCheckboxListTileFormField(context),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 43,
                              width: 332,
                              child: nextButton1(onPressed),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          )),
    );
  }

  TextButton nextButton1(onPressed) {
    return customFlatButton(
      key: const Key("next"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      label: widget.lang_next.toUpperCase(),
      disabledColor: const Color.fromRGBO(206, 208, 206, 1),
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
    );
  }

  CheckboxListTileFormField buildCheckboxListTileFormField(
      BuildContext context) {
    return CheckboxListTileFormField(
      key: const Key("checkbox"),
      activeColor: Theme.of(context).primaryColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.lang_i_agree_to,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/privacy_policy',
                  arguments: widget.contextLocale);
            },
            child: Text(
              widget.lang_privacy_policy,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
      validator: (bool? value) {
        if (value == true) {
          return null;
        } else {
          return widget.lang_required;
        }
      },
    );
  }

  TextFormField fixedPhoneNumberField() {
    return TextFormField(
      controller: widget.phoneNumberController,
      enabled: widget.phoneNumberEnabled,
      validator: (dynamic value) {
        if (value.isEmpty || value.length != 9) {
          return widget.lang_required;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixText: "+998 ",
        counterText: '',
        labelText: '${widget.lang_mobile_number} *',
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      // inputFormatters: [maskTextInputFormatter],
      maxLength: 9,
      keyboardType: TextInputType.number,
      //onSubmitted: (){},
    );
  }

  TextFormField fixedReferrerPhoneNumberField() {
    return TextFormField(
      controller: widget.referrerNumberController,
      validator: (dynamic value) {
        if (value.isNotEmpty && value.length < 9) {
          return widget.lang_required;
        }
        return null;
      },
      readOnly: widget.driverInfo.referrerPhoneNumber != null ? true : false,
      decoration: InputDecoration(
        prefixText: "+998 ",
        labelText: widget.lang_referrer_phone,
        counterText: '',
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      // inputFormatters: [maskTextInputFormatter],
      maxLength: 9,
      keyboardType: TextInputType.number,
      //onSubmitted: (){},
    );
  }

  TextFormField fixedTextField(String title, TextEditingController controller,
      nameKey, String validator, bool autofocus) {
    return TextFormField(
      autofocus: autofocus,
      textInputAction: TextInputAction.next,
      validator: (dynamic value) {
        if (value.isEmpty || value.length <= 3) {
          return validator;
        }
        return null;
      },
      onChanged: (_) {
        if (!_enabled) {
          setState(() {
            _enabled = true;
          });
        }
      },
      controller: controller,
      key: nameKey,
      decoration: InputDecoration(
        labelText: '$title *',
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField fixedEmailField() {
    return TextFormField(
      key: const Key("email"),
      textInputAction: TextInputAction.next,
      validator: (dynamic val) => val.isNotEmpty && !val.contains("@")
          ? widget.lang_enter_valid_email
          : null,
      controller: widget.emailController,
      decoration: InputDecoration(
        labelText: widget.lang_email,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
