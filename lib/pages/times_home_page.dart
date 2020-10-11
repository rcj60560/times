import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/dio/constant.dart';
import 'package:flutterapp/dio/dio_manager.dart';

class TimesHomePage extends StatefulWidget {
  int id;

  TimesHomePage(this.id);

  @override
  State<StatefulWidget> createState() {
    return TimesHomePageState();
  }
}

class TimesHomePageState extends State<TimesHomePage> {
  @override
  void initState() {
    super.initState();
    var instance = DioManager.getInstance();
    Map map = Map<String, String>();
    map['locationId'] = widget.id.toString();
    instance.get(Constant.HotPlayMovies, map, (data) {
      print('-==> data:' + data.toString());
    }, (e) {
      print('--< error:');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.id.toString()),
      ),
    );
  }
}
