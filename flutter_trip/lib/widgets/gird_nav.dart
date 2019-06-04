import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';

class GirdNav extends StatefulWidget {

  final GridNavModel model;

  GirdNav({Key key,@required this.model}) : super(key: key);

  _GirdNavState createState() => _GirdNavState();
}

class _GirdNavState extends State<GirdNav> {
  @override
  Widget build(BuildContext context) {

    
    return Container(
       child: Center(
         child: Text(widget.model.hotel.startColor),
       ),
    );
  }
}