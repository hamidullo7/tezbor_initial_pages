import 'dart:async';
import 'dart:io';
// import 'package:driver/controller/controller.dart';
// import 'package:driver/database/usmo.dart';
// import 'package:driver/model/enter_sms_arguments.dart';
// import 'package:driver/model/main_page_con_data.dart';
// import 'package:driver/utils/user_preferences.dart';
import '../../widget/text_button.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
// import 'package:driver/model/menu_screen_models/driver_info_model.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:easy_localization/easy_localization.dart' as tr;
// import '../../locale/locale_keys.g.dart';
// import 'package:driver/utils/constants.dart';

// import '../main_page_controller.dart';

class DriverTransportPage extends StatefulWidget {
  const DriverTransportPage({
    Key? key,
    this.apiController,
    this.driverInfo,
    required this.onPressNext,
    // ignore: non_constant_identifier_names
    this.lang_transport = 'lang_transport',
    // ignore: non_constant_identifier_names
    this.lang_next = 'lang_next',
    // ignore: non_constant_identifier_names
    this.lang_transport_info_text = 'lang_transport_info_text',
    // ignore: non_constant_identifier_names
    this.lang_tr_front_view = 'lang_tr_front_view',
    // ignore: non_constant_identifier_names
    this.lang_tr_rear_view = 'lang_tr_rear_view',
  }) : super(key: key);

  final dynamic apiController;
  final dynamic driverInfo;
  final Future<void> Function(dynamic dInfo, dynamic imageIds) onPressNext;

  // ignore: non_constant_identifier_names
  final String lang_transport;
  // ignore: non_constant_identifier_names
  final String lang_next;
  // ignore: non_constant_identifier_names
  final String lang_transport_info_text;
  // ignore: non_constant_identifier_names
  final String lang_tr_front_view;
  // ignore: non_constant_identifier_names
  final String lang_tr_rear_view;

  @override
  // ignore: library_private_types_in_public_api
  _DriverTransportPageState createState() => _DriverTransportPageState();
}

class _DriverTransportPageState extends State<DriverTransportPage> {
  // final apiController = NewApiController();
  int platform = 3;
  int stepNum = 3;
  Map files = {
    'front_image': null,
    'rear_image': null,
    'right_image': null,
    'left_image': null
  };
  Map imageIds = {
    'front_image': null,
    'rear_image': null,
    'right_image': null,
    'left_image': null
  };
  final imagePicker = ImagePicker();

  Future getImage() async {
    // ignore: deprecated_member_use
    return await imagePicker.getImage(
        source: ImageSource.camera, maxHeight: 800.0, maxWidth: 800.0);
  }

  uploadFile(image, buttonName) async {
    var file = File(image.path);
    await widget.apiController.newUploadImage(file).then((data) {
      if (data != null) {
        setState(() {
          files[buttonName] = data['file'];
          imageIds[buttonName] = data['id'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final DriverInfoData driverInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.lang_transport,
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
                          color: stepNum >= i
                              ? const Color.fromRGBO(251, 171, 14, 1)
                              : Theme.of(context).colorScheme.secondary),
                    ),
                ],
              ),
            ),
            /* this is info text for photo */
            infoText(),
            carImageRow('front_image', 'tr_front', 'front_image'),
            carImageRow('rear_image', 'tr_rear', 'rear_image'),
            carImageRow('right_image', 'texpasport_front', 'right_image'),
            carImageRow('left_image', 'texpasport_back', 'left_image'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 43,
                  child: nextButton(widget.driverInfo),
                ),
              ],
            ),
          ],
        ));
  }

  TextButton nextButton(dynamic driverInfo) {
    return customFlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: () async {
        widget.onPressNext(driverInfo, imageIds);
      },
      color: Theme.of(context).primaryColor,
      disabledColor: const Color.fromRGBO(206, 208, 206, 1),
      label: widget.lang_next.toUpperCase(),
      textColor: Colors.white,
    );
  }

  Center infoText() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child:
            Text(widget.lang_transport_info_text, textAlign: TextAlign.center),
      ),
    );
  }

  Container carImageRow(String pickedImage, String placeHolderImageName,
      String pickImageButtonName) {
    String infoTxt;
    if (placeHolderImageName == 'tr_front') {
      infoTxt = widget.lang_tr_front_view;
    } else if (placeHolderImageName == 'tr_rear') {
      infoTxt = widget.lang_tr_rear_view;
    } else if (placeHolderImageName == 'texpasport_front') {
      infoTxt = widget.lang_tr_front_view;
    } else if (placeHolderImageName == 'texpasport_back') {
      infoTxt = widget.lang_tr_rear_view;
    } else {
      infoTxt = 'Info text';
    }
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            color: const Color.fromRGBO(230, 230, 230, 1),
            child: files[pickedImage] == null
                ? Image.asset('assets/images/$placeHolderImageName.png',
                    width: 140, height: 70)
                : Image.file(files[pickedImage], width: 140, height: 70),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                infoTxt,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.black12,
              ),
              margin: const EdgeInsets.only(right: 5),
              child: IconButton(
                icon: files[pickedImage] == null
                    ? const Icon(Icons.photo_camera)
                    : const Icon(Icons.replay),
                color: const Color.fromRGBO(135, 135, 135, 1),
                onPressed: () async {
                  await getImage().then((image) {
                    if (image != null) {
                      uploadFile(image, pickImageButtonName);
                    }
                  });
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                iconSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
