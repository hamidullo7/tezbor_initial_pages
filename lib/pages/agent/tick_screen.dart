import 'package:flutter/material.dart';

class AgentTicKScreen extends StatefulWidget {
  const AgentTicKScreen({Key? key, this.lang_tick_msg = 'lang_tick_msg'})
      : super(key: key);

  final String lang_tick_msg;

  @override
  _AgentTicKScreenState createState() => _AgentTicKScreenState();
}

class _AgentTicKScreenState extends State<AgentTicKScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/tick_icon.png"),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Text(widget.lang_tick_msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(82, 173, 68, 1))),
            ),
          ],
        ),
      ),
    );
  }
}
