import 'package:flutter/material.dart';
import 'package:flutter_demo1/bottomsheet/PersistentBottomSheetWidget.dart';
import 'package:flutter_demo1/bottomsheet/ShowModalBottomSheetWidget.dart';
import 'package:flutter_demo1/bottomsheet/ShowPersistentBottomSheetWidget.dart';
class BottomSheetPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomSheet'),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            child: ListTile(
              title: Text('PersistentBottomSheet: showBottomSheet()'),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowPersistentBottomSheetWidget()));
            },
          ),
          GestureDetector(
            child: ListTile(
              title: Text('PersistentBottomSheet: bottomSheet'),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PersistentBottomSheetWidgetWidget()));
            },
          ),
          GestureDetector(
            child: ListTile(
              title: Text('ModalBottomSheet: showModalBottomSheet()'),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowModalBottomSheetWidget()));
            },
          )
        ],
      ),
    );
  }
}
