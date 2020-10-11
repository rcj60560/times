import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimesHomePage extends StatefulWidget {
  int index = -1;

  TimesHomePage(this.index);

  @override
  State<StatefulWidget> createState() {
    return TimesHomePageState();
  }
}

class TimesHomePageState extends State<TimesHomePage> {
  @override
  void initState() {
    super.initState();
    print('==》 ${widget.index}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.index.toString()),
      ),
    );
  }
}
