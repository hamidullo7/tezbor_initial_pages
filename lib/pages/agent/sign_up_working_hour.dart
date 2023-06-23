import '../../utils/html_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AgentSignUpWorkingTime extends StatefulWidget {
  AgentSignUpWorkingTime(
      {Key? key,
      this.args,
      this.platform,
      this.appType,
      required this.onPressNext,
      this.lang_working_time = 'lang_working_time',
      this.lang_monday = 'lang_monday',
      this.lang_tuesday = 'lang_tuesday',
      this.lang_wednesday = 'lang_wednesday',
      this.lang_thursday = 'lang_thursday',
      this.lang_friday = 'lang_friday',
      this.lang_saturday = 'lang_saturday',
      this.lang_sunday = 'lang_sunday',
      this.lang_next = 'lang_next',
      this.lang_opens_at = 'lang_opens_at',
      this.lang_close_at = 'lang_close_at'})
      : super(key: key);

  final dynamic args;
  final dynamic platform;
  final dynamic appType;
  final void Function(dynamic args, dynamic platform, dynamic appType,
      dynamic opensAt, dynamic closeAt, dynamic week) onPressNext;
  final String lang_working_time;
  final String lang_monday;
  final String lang_tuesday;
  final String lang_wednesday;
  final String lang_thursday;
  final String lang_friday;
  final String lang_saturday;
  final String lang_sunday;
  final String lang_next;
  final String lang_opens_at;
  final String lang_close_at;

  @override
  _AgentSignUpWorkingTimeState createState() => _AgentSignUpWorkingTimeState();
}

class _AgentSignUpWorkingTimeState extends State<AgentSignUpWorkingTime> {
  Key toggle = Key("toggle");
  // final apiController = NewApiController();
  List<bool> week = [false, false, false, false, false, false, false];
  int num = 2;
  List<String> opensAt = [
    '8:00',
    '8:00',
    '8:00',
    '8:00',
    '8:00',
    '8:00',
    '8:00'
  ];
  List<String> closeAt = [
    '21:00',
    '21:00',
    '21:00',
    '21:00',
    '21:00',
    '21:00',
    '21:00'
  ];
  String? dropdownValue1;
  String? dropdownValue2;

  @override
  Widget build(BuildContext context) {
    // final UserInfoData args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lang_working_time,
          style: TextStyle(
              color: HexColor.fromHex("#52AD44"), fontWeight: FontWeight.w700),
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.79,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= 2; i++)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset("assets/icons/big_line.svg",
                                width: MediaQuery.of(context).size.width * 0.40,
                                color: num >= i
                                    ? HexColor.fromHex("#FBAB0E")
                                    : Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Row(
                          children: [
                            buildText(widget.lang_monday),
                            Spacer(),
                            buildSwitch(week[0], 0)
                          ],
                        ),
                        buildVisibility(context, 0),
                        Row(
                          children: [
                            buildText(widget.lang_tuesday),
                            Spacer(),
                            buildSwitch(week[1], 1)
                          ],
                        ),
                        buildVisibility(context, 1),
                        Row(
                          children: [
                            buildText(widget.lang_wednesday),
                            Spacer(),
                            buildSwitch(week[2], 2)
                          ],
                        ),
                        buildVisibility(context, 2),
                        Row(
                          children: [
                            buildText(widget.lang_thursday),
                            Spacer(),
                            buildSwitch(week[3], 3)
                          ],
                        ),
                        buildVisibility(context, 3),
                        Row(
                          children: [
                            buildText(widget.lang_friday),
                            Spacer(),
                            buildSwitch(week[4], 4)
                          ],
                        ),
                        buildVisibility(context, 4),
                        Row(
                          children: [
                            buildText(widget.lang_saturday),
                            Spacer(),
                            buildSwitch(week[5], 5)
                          ],
                        ),
                        buildVisibility(context, 5),
                        Row(
                          children: [
                            buildText(widget.lang_sunday),
                            Spacer(),
                            buildSwitch(week[6], 6, keyName: toggle)
                          ],
                        ),
                        buildVisibility(context, 6),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          RawMaterialButton(
            constraints: BoxConstraints(
              minHeight: 43,
              minWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            fillColor: Colors.green,
            splashColor: Colors.lightGreen,
            onPressed: () {
              widget.onPressNext(widget.args, widget.platform, widget.appType,
                  opensAt, closeAt, week);
            },
            child: Text(
              widget.lang_next,
              maxLines: 1,
              style: TextStyle(color: Colors.white),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }

  Visibility buildVisibility(BuildContext context, int index) {
    return Visibility(
      visible: week[index],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: DropdownButton<String>(
              value: opensAt[index],
              icon: Icon(Icons.keyboard_arrow_down),
              underline: Container(
                height: 0,
              ),
              isExpanded: true,
              hint: Text(widget.lang_opens_at,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              onChanged: (dynamic newValue) {
                setState(() {
                  opensAt[index] = newValue;
                });
              },
              items: <String>[
                '12:00',
                '12:30',
                '1:00',
                '1:30',
                '2:00',
                '2:30',
                '3:00',
                '3:30',
                '4:00',
                '4:30',
                '5:00',
                '5:30',
                '6:00',
                '6:30',
                '7:00',
                '7:30',
                '8:00',
                '8:30',
                '9:00',
                '9:30',
                '10:00',
                '10:30',
                '11:00',
                '11:30'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Flexible(
            child: DropdownButton<String>(
              value: closeAt[index] != null ? closeAt[index] : dropdownValue2,
              icon: Icon(Icons.keyboard_arrow_down),
              underline: Container(
                height: 0,
              ),
              isExpanded: true,
              hint: Text(
                widget.lang_close_at,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              onChanged: (dynamic newValue) {
                setState(() {
                  closeAt[index] = newValue;
                });
              },
              items: <String>[
                '12:00',
                '12:30',
                '13:00',
                '13:30',
                '14:00',
                '14:30',
                '15:00',
                '15:30',
                '16:00',
                '16:30',
                '17:00',
                '17:30',
                '18:00',
                '18:30',
                '19:00',
                '19:30',
                '20:00',
                '20:30',
                '21:00',
                '21:30',
                '22:00',
                '22:30',
                '23:00',
                '23:30'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Switch buildSwitch(bool check, int num, {keyName}) {
    return Switch(
      key: keyName,
      value: check,
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value) {
        setState(() {
          week[num] = value;
        });
      },
    );
  }

  Text buildText(String title) => Text(title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ));
}
