import 'package:flutter/material.dart';
import 'package:flutter_trip/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: "哈哈",
            hint: '2232323',
            leftBtnClick: (){
              Navigator.pop(context);
            },
            onChange: _onTextChange,
          )
        ],
      ),
    );
  }




/// 输入框字符串的回调
  void _onTextChange(String text){

  }
}