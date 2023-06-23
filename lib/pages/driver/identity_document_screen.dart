import 'dart:io';
// import 'package:driver/controller/controller.dart';
import '../../widget/text_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
// import 'package:driver/model/menu_screen_models/driver_info_model.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:easy_localization/easy_localization.dart' as tr;
// import '../../locale/locale_keys.g.dart';

class DriverIdentityDocPage extends StatefulWidget {
  const DriverIdentityDocPage({
    Key? key,
    this.apiController,
    required this.onNextPress,
    // ignore: non_constant_identifier_names
    this.lang_identity_document = 'lang_identity_document',
    // ignore: non_constant_identifier_names
    this.lang_selfie_info_text = 'lang_selfie_info_text',
    // ignore: non_constant_identifier_names
    this.lang_open_camera = 'lang_open_camera',
    // ignore: non_constant_identifier_names
    this.lang_again = 'lang_again',
    // ignore: non_constant_identifier_names
    this.lang_next = 'lang_next',
  }) : super(key: key);

  final dynamic apiController;
  final void Function(dynamic identityImageId) onNextPress;

  // ignore: non_constant_identifier_names
  final String lang_identity_document;
  // ignore: non_constant_identifier_names
  final String lang_selfie_info_text;
  // ignore: non_constant_identifier_names
  final String lang_open_camera;
  // ignore: non_constant_identifier_names
  final String lang_again;
  // ignore: non_constant_identifier_names
  final String lang_next;

  @override
  // ignore: library_private_types_in_public_api
  _DriverIdentityDocPageState createState() => _DriverIdentityDocPageState();
}

class _DriverIdentityDocPageState extends State<DriverIdentityDocPage> {
  // final apiController = NewApiController();

  int? identityImageId;
  int? stepNum = 2;
  File? _image;
  final imagePicker = ImagePicker();

  Future getImage() async {
    return await imagePicker.getImage(
        source: ImageSource.camera, maxHeight: 800.0, maxWidth: 800.0);
  }

  @override
  Widget build(BuildContext context) {
    // final DriverInfoData driverInfo = ModalRoute.of(context).settings.arguments;
    var _nextButtonPressed;
    if (_image != null) {
      _nextButtonPressed = () async {
        widget.onNextPress(identityImageId);
      };
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.lang_identity_document,
            style: const TextStyle(
                color: Color.fromRGBO(82, 173, 68, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline_rounded),
              color: const Color.fromRGBO(135, 135, 135, 1),
              onPressed: () {},
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              iconSize: 20,
            )
          ],
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.keyboard_backspace),
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
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        body: Column(
          children: [
            /* this is stepper */
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 3; i++)
                    Flexible(
                      child: SvgPicture.asset("assets/icons/line_big.svg",
                          color: stepNum! >= i
                              ? const Color.fromRGBO(251, 171, 14, 1)
                              : Theme.of(context).colorScheme.secondary),
                    ),
                ],
              ),
            ),
            /* this is info text for selfie document */
            Visibility(
              // ignore: sort_child_properties_last
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 20, bottom: 20),
                  child: Text(widget.lang_selfie_info_text,
                      textAlign: TextAlign.center),
                ),
              ),
              visible: _image == null ? true : false,
            ),
            Visibility(
                visible: _image == null ? false : true,
                child: const SizedBox(
                  height: 20,
                )),
            /* this is image example selfie document */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: _image == null
                      ? Image.asset('assets/images/driver-info.png',
                          width: MediaQuery.of(context).size.width * 0.7)
                      : Image.file(_image!,
                          height: MediaQuery.of(context).size.height * 0.5),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 43,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await getImage().then((image) {
                        if (image != null) {
                          uploadFile(image);
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(135, 135, 135, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //Center Row contents horizontally,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: _image == null
                              ? const Icon(Icons.photo_camera)
                              : const Icon(Icons.replay),
                        ),
                        Text(
                          _image == null
                              ? widget.lang_open_camera.toUpperCase()
                              : widget.lang_again.toUpperCase(),
                          key: const Key("openCamera"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 43,
                  child: nextButton2(_nextButtonPressed),
                ),
              ],
            ),
          ],
        ));
  }

  uploadFile(image) async {
    var file = File(image.path);
    await widget.apiController.newUploadImage(file).then((data) {
      if (data != null) {
        setState(() {
          identityImageId = data['id'];
          _image = data['file'];
        });
      }
    });
  }

  TextButton nextButton2(nextButtonPressed) {
    return customFlatButton(
        key: const Key("next"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        disabledColor: const Color.fromRGBO(206, 208, 206, 1),
        onPressed: nextButtonPressed,
        color: const Color.fromRGBO(82, 173, 68, 1),
        textColor: Colors.white,
        label: widget.lang_next.toUpperCase());
  }
}
