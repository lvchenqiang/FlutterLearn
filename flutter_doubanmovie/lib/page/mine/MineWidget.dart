import 'package:flutter/material.dart';


class MineWidget extends StatefulWidget {
  MineWidget({Key key}) : super(key: key);

  _MineWidgetState createState() => _MineWidgetState();
}

class _MineWidgetState extends State<MineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text("我的"),
       ),
    );
  }
}