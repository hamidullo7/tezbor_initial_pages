import 'dart:io';
import '../../utils/html_color.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../widget/text_button.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:image_picker/image_picker.dart';

class AgentSignUpScreen extends StatefulWidget {
  const AgentSignUpScreen({
    Key? key,
    this.fixedLengthList = const [],
    this.fixedFileList = const [],
    required this.apiController,
    required this.onTapLocation,
    required this.onTapPrivacy,
    this.maskTextInputFormatter,
    this.userDetails,
    this.lang_agent_info = 'lang_agent_info',
    this.lang_name = 'lang_name',
    this.lang_this_field = 'lang_this_field',
    this.lang_last_name = 'lang_last_name',
    this.lang_place_name = 'lang_place_name',
    this.lang_place_address = 'lang_place_address',
    this.lang_add_photos = 'lang_add_photos',
    this.lang_next = 'lang_next',
    this.lang_i_agree_to = 'lang_i_agree_to',
    this.lang_privacy_policy = 'lang_privacy_policy',
    this.lang_isChecked = 'lang_isChecked',
    this.lang_mobile_number = 'lang_mobile_number',
    this.lang_enter_valid_email = 'lang_enter_valid_email',
    this.lang_email = 'lang_email',
    this.contextLocale,
    this.formKey,
    this.placeAddressController,
    required this.onNextParess,
  }) : super(key: key);

  final List<int> fixedLengthList;
  final List<File> fixedFileList;
  final dynamic apiController;
  final Function() onTapPrivacy;
  final Future<void> Function(dynamic number, dynamic name, dynamic lastName,
      dynamic email, dynamic place_name, dynamic place_address) onNextParess;
  final Function() onTapLocation;
  final dynamic maskTextInputFormatter;
  final dynamic userDetails;
  final String lang_agent_info;
  final String lang_name;
  final String lang_this_field;
  final String lang_last_name;
  final String lang_place_name;
  final String lang_place_address;
  final String lang_add_photos;
  final String lang_next;
  final String lang_i_agree_to;
  final String lang_privacy_policy;
  final String lang_isChecked;
  final String lang_mobile_number;
  final String lang_enter_valid_email;
  final String lang_email;
  final dynamic placeAddressController;

  final dynamic contextLocale;
  //context.locale.toString()
  final dynamic formKey;

  @override
  // ignore: library_private_types_in_public_api
  _AgentSignUpScreenState createState() => _AgentSignUpScreenState();
}

class _AgentSignUpScreenState extends State<AgentSignUpScreen> {
  int counter = 0;

  /*----------------------------Upload a photo--------------------------------*/
  File? _image;
  final imagePicker = ImagePicker();
  int? identityImageId;

  Future getImage() async {
    return await imagePicker.getImage(
        source: ImageSource.camera, maxHeight: 800.0, maxWidth: 800.0);
  }

  /*--------------------------------------------------------------------------*/

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController placeName = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  Key address = const Key("placeAddress");
  Key pName = const Key("pName");
  Key name = const Key("name");
  Key lastName = const Key("lastName");

  String? lat;
  String? long;
  String? city;

  int num = 1;

  uploadFile(image) async {
    var file = File(image.path);
    await widget.apiController.newUploadImage(file).then((imageId) {
      if (imageId != null) {
        setState(() {
          _image = file;
          widget.fixedFileList.add(file);
          identityImageId = imageId;
          widget.fixedLengthList.add(imageId);
          counter++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userDetails.registered != null &&
        widget.userDetails.registered) {
      setState(() {
        phoneNumberController.text = widget.userDetails.phoneNumber;
        lastNameController.text = widget.userDetails.lastName;
        nameController.text = widget.userDetails.firstName;
        emailController.text = widget.userDetails.email;
      });
    } else {
      setState(() {
        phoneNumberController.text = widget.userDetails.phoneNumber;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.lang_agent_info,
            style: TextStyle(
                color: HexColor.fromHex("#52AD44"),
                fontWeight: FontWeight.w700),
          ),
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 1; i <= 2; i++)
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset("assets/icons/big_line.svg",
                              width: MediaQuery.of(context).size.width * 0.40,
                              color: num >= i
                                  ? HexColor.fromHex("#FBAB0E")
                                  : Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                  ],
                ),
                Form(
                    key: widget.formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 5.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: fixedTextField(
                                    widget.lang_name,
                                    nameController,
                                    widget.lang_this_field,
                                    name,
                                    autoFocus:
                                        widget.userDetails.registered != null &&
                                                widget.userDetails.registered
                                            ? false
                                            : true),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: fixedTextField(
                                    widget.lang_last_name,
                                    lastNameController,
                                    widget.lang_this_field,
                                    lastName),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          fixedEmailField(),
                          SizedBox(height: 20),
                          fixedTextField(widget.lang_place_name, placeName,
                              widget.lang_this_field, pName),
                          SizedBox(height: 20),
                          fixedTextFieldWithIcon(
                              widget.lang_place_address,
                              widget.placeAddressController,
                              widget.lang_this_field,
                              address),
                          SizedBox(height: 20),
                          fixedPhoneNumberField(),
                          SizedBox(height: 10),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Row(
                                  children: [
                                    Visibility(
                                      visible: _image != null ? true : false,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          for (int i = 0; i < counter; i++)
                                            Container(
                                                padding: EdgeInsets.all(4),
                                                alignment: Alignment.topLeft,
                                                child: Image.file(
                                                    widget.fixedFileList[i])),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        color: HexColor.fromHex(
                                          "#EFEFEF",
                                        ),
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.add_photo_alternate,
                                              color:
                                                  HexColor.fromHex("#878787"),
                                            ),
                                            onPressed: () async {
                                              await getImage()
                                                  .then((image) async {
                                                if (image != null) {
                                                  await uploadFile(image);
                                                }
                                              });
                                            })),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: _image == null ? true : false,
                                      child: Text(widget.lang_add_photos,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            child: buildCheckboxListTileFormField(context),
                          ),
                        ],
                      ),
                    )),
                Spacer(),
                Container(
                  height: 43,
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.only(bottom: 20),
                  child: customFlatButton(
                    key: const Key("submit_sign_up_btn"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    label: widget.lang_next,
                    onPressed: () async {
                      widget.onNextParess(
                          phoneNumberController.text,
                          nameController.text,
                          lastNameController.text,
                          emailController.text,
                          placeName.text,
                          widget.placeAddressController.text);
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  CheckboxListTileFormField buildCheckboxListTileFormField(
      BuildContext context) {
    return CheckboxListTileFormField(
      activeColor: Theme.of(context).primaryColor,
      title: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Row(
          children: [
            Text(
              '${widget.lang_i_agree_to} ',
              style: const TextStyle(fontSize: 14, color: Colors.black),
              key: const Key("privacy_policy_checkbox"),
            ),
            GestureDetector(
              onTap: widget.onTapPrivacy,
              child: Container(
                child: Text(
                  widget.lang_privacy_policy,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onSaved: (value) {},
      validator: (value) {
        if (value != null && value) {
          return null;
        } else {
          return widget.lang_isChecked;
        }
      },
    );
  }

  TextFormField fixedPhoneNumberField() {
    return TextFormField(
      controller: phoneNumberController,
      validator: (dynamic value) {
        if (value.isEmpty) {
          return widget.lang_this_field;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixText: "+998 ",
        labelText: widget.lang_mobile_number,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      inputFormatters: [widget.maskTextInputFormatter],
      keyboardType: TextInputType.number,
      //onSubmitted: (){},
    );
  }

  TextFormField fixedTextField(
      String title, TextEditingController controller, String validator, Keyname,
      {bool autoFocus = false}) {
    return TextFormField(
      validator: (dynamic value) {
        if (value.isEmpty) {
          return validator;
        }
        return null;
      },
      key: Keyname,
      autofocus: autoFocus,
      textInputAction: TextInputAction.next,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField fixedTextFieldWithIcon(String title,
      TextEditingController controller, String validator, Keyname) {
    return TextFormField(
      validator: (dynamic value) {
        if (value.isEmpty) {
          return validator;
        }
        return null;
      },
      key: Keyname,
      controller: controller,
      readOnly: true,
      onTap: widget.onTapLocation,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: Icon(Icons.my_location_outlined,
            color: Theme.of(context).colorScheme.secondary),
        labelText: title,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      keyboardType: TextInputType.text,
    );
  }

  TextFormField fixedTextNumbers(
      String title, TextEditingController controller, String validator) {
    return TextFormField(
      validator: (dynamic value) {
        if (value.isEmpty) {
          return validator;
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      keyboardType: TextInputType.number,
    );
  }

  TextFormField fixedEmailField() {
    return TextFormField(
      key: Key("email"),
      controller: emailController,
      textInputAction: TextInputAction.next,
      validator: (dynamic val) => val.isNotEmpty && !val.contains("@")
          ? widget.lang_enter_valid_email
          : null,
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
