import 'package:flutter/material.dart';


class MoviesWidget extends StatefulWidget {
  MoviesWidget({Key key}) : super(key: key);

  _MoviesWidgetState createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text("电影"),
       ),
    );
  }
}