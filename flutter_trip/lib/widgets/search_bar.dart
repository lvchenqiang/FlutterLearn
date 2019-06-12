import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {

final bool enabled; // 禁止搜索
final bool hideLeft;
final SearchType type;
final String hint;
final String defaultText; //默认的提示文案 
final void Function() leftBtnClick;
final void Function() rightBtnClick;
final void Function() speakClick;
final void Function() inputBoxClick;
final ValueChanged<String> onChange;



  SearchBar({Key key, this.enabled, this.hideLeft, this.type, this.hint, this.defaultText, this.leftBtnClick, this.rightBtnClick, this.speakClick, this.inputBoxClick, this.onChange}) : super(key: key);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

 
bool showClear; /// 是否显示clear按钮

final TextEditingController _controller = TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    if(widget.defaultText != null){
      _controller.text = widget.defaultText;
    }



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.type == SearchType.normal ? _getNormalSearch:_getHomeSearch;
  }

/**
 * 返回默认的搜索
 */
Widget get _getNormalSearch{
return Container(
  child: Row(
    children: <Widget>[
   _wrap(Container(
       child: widget?.hideLeft??false?null:Icon(
         Icons.arrow_back_ios,
         color:Colors.grey,
         size:16),
     ), widget.leftBtnClick),
     Expanded(
       flex: 1,
       child: _inputBox(),
     ),
      _wrap(Container(
       padding: EdgeInsets.fromLTRB(10, 5, 10, 5), 
       child: Text(
         '搜索',
         style:TextStyle(fontSize:17,color:Colors.blue)
       ),
     ), widget.rightBtnClick),
    ],
  ),
);
}

/**
 * 返回主页搜索
 */
Widget get _getHomeSearch{

return Container(
 child: Row(
   children: <Widget>[
     _wrap(Container(
       child: widget?.hideLeft??false?null:Icon(
         Icons.arrow_back_ios,
         color:Colors.grey,
         size:16),
     ), widget.leftBtnClick),

   ],
 ),
);
}






Widget _inputBox(){


}

Widget  _wrap(Widget child, void Function() callBack){
return GestureDetector(
  onTap: (){
    if(callBack != null) callBack();
  },
  child: child,
);
}

}



enum SearchType {
home,
homeLight,
normal

}