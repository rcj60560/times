import 'package:flutter/cupertino.dart';
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
        body: Container(
          child: Center(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("请选择城市"),
                  CupertinoPicker(
                    diameterRatio: 1.1,
                    onSelectedItemChanged: (int value) {
                      print('index : ${value}');
                    },
                    itemExtent: 50,
                    children: _getSelectedItem(cityModel),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getSelectedItem(CityModel cityModel) {
    List<Widget> widgets = [];
    if (cityModel == null) {
      var text = Text("无数据");
      widgets.add(text);
      return widgets;
    }
    var cityList = cityModel.p;

    var length = cityList.length;
    for (int i = 0; i < length; i++) {
      var city = Text(cityList[i].n);
      widgets.add(city);
    }
    return widgets;
  }
}
