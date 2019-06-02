import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  TravelPage({Key key}) : super(key: key);

  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
     child: Text("旅行"),
    );
  }
}