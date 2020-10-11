import 'package:flutter/material.dart';
import 'package:flutterapp/dio/constant.dart';
import 'package:flutterapp/dio/dio_manager.dart';
import 'package:flutterapp/model/city_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  CityModel cityModel;
  int index = 0;

  @override
  void initState() {
    super.initState();
    var instance = DioManager.getInstance();
    instance.get(Constant.HotCitiesByCinema, null, (data) {
      setState(() {
        cityModel = CityModel.fromJson(data);
      });
    }, (error) {
      print('error:' + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Times"),
          centerTitle: true,
        ),
        body: Center(
          child: Text(cityModel == null ? "城市名称" : cityModel.p[index].n),
        ),
      ),
    );
  }
}
