// import 'package:driver/model/main_page_con_data.dart';
import '../../widget/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:easy_localization/easy_localization.dart';
// import '../../locale/locale_keys.g.dart';
// import '../main_page_controller.dart';

class DriverRegisteredSuccessfullyPage extends StatefulWidget {
  const DriverRegisteredSuccessfullyPage({
    super.key,
    // ignore: non_constant_identifier_names
    this.lang_successfully_registered = 'lang_successfully_registered',
    // ignore: non_constant_identifier_names
    this.lang_go_to_word = 'lang_go_to_word',
    required this.onPressNext,
  });

  // ignore: non_constant_identifier_names
  final String lang_successfully_registered;
  // ignore: non_constant_identifier_names
  final String lang_go_to_word;

  final void Function() onPressNext;
  @override
  // ignore: library_private_types_in_public_api
  _DriverRegisteredSuccessfullyPageState createState() =>
      _DriverRegisteredSuccessfullyPageState();
}

class _DriverRegisteredSuccessfullyPageState
    extends State<DriverRegisteredSuccessfullyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/icons/success.svg",
                width: 300,
                height: 240,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Center(
              child: Text(widget.lang_successfully_registered,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
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
                  child: nextButton4(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextButton nextButton4() {
    return customFlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: () async {
          widget.onPressNext();
        },
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        disabledColor: const Color.fromRGBO(206, 208, 206, 1),
        label: widget.lang_go_to_word.toUpperCase());
  }
}
