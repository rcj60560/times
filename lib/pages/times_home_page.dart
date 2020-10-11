import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/dio/constant.dart';
import 'package:flutterapp/dio/dio_manager.dart';
import 'package:flutterapp/model/hot_play_movies_model.dart';

class TimesHomePage extends StatefulWidget {
  int id;

  TimesHomePage(this.id);

  @override
  State<StatefulWidget> createState() {
    return TimesHomePageState();
  }
}

class TimesHomePageState extends State<TimesHomePage> {
  List<Movies> movies;

  @override
  void initState() {
    super.initState();
    var instance = DioManager.getInstance();
    Map map = Map<String, String>();
    map['locationId'] = widget.id.toString();
    instance.get(Constant.HotPlayMovies, map, (data) {
      HotPlayMoviesModel hotPlayMoviesModel = HotPlayMoviesModel.fromJson(data);
      setState(() {
        movies = hotPlayMoviesModel.movies;
      });
    }, (e) {
      print('--< error:');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: movies == null ? 0 : movies.length,
          itemBuilder: _itemMovies,
        ),
      ),
    );
  }

  Widget _itemMovies(BuildContext context, int index) {
    Movies movie = movies[index];
    var img = Padding(
      padding: EdgeInsets.all(1),
      child: Image.network(movie.img),
    );
    return img;
  }
}
