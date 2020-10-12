import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/dio/constant.dart';
import 'package:flutterapp/dio/dio_manager.dart';
import 'package:flutterapp/model/city_model.dart';
import 'package:flutterapp/pages/times_home_page.dart';

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
      home: HomePage(cityModel),
    );
  }
}

class HomePage extends StatefulWidget {
  CityModel cityModel;

  HomePage(this.cityModel);

  @override
  State<StatefulWidget> createState() {
    return HomePageStare();
  }
}

class HomePageStare extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  height: 200,
                  child: CupertinoPicker(
                    diameterRatio: 1.1,
                    onSelectedItemChanged: (int value) {
                      index = value;
                    },
                    itemExtent: 45,
                    children: _getSelectedItem(widget.cityModel),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TimesHomePage(widget.cityModel.p[index].id);
                    }));
                  },
                  child: Text("跳转"),
                )
              ],
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
