import 'package:flutter/material.dart';

class HotMoviesListWidget extends StatefulWidget {

  String curCity;
  HotMoviesListWidget(String city) {
    curCity = city;
  }

  _HotMoviesListWidgetState createState() => _HotMoviesListWidgetState();
}

class _HotMoviesListWidgetState extends State<HotMoviesListWidget> {


 void _getData(){

   print("获取数据");
 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
        child: Text("111"),
       ),
    );
  }
}