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



  SearchBar({Key key, this.enabled = true, this.hideLeft, this.type = SearchType.normal, this.hint, this.defaultText, this.leftBtnClick, this.rightBtnClick, this.speakClick, this.inputBoxClick, this.onChange}) : super(key: key);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

 
bool showClear = false; /// 是否显示clear按钮

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
     padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
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
     padding: EdgeInsets.fromLTRB(6, 5, 5 , 5),
       child: Row(
          children: <Widget>[
            Text('上海',
            style: TextStyle(color: _homeFontColor(),fontSize: 14),
            ),
           Icon(
             Icons.expand_more,
             size:22,
             color:_homeFontColor()
           )
          ],
       ),
     ), widget.leftBtnClick),
     Expanded(
       flex: 1,
       child: _inputBox(),
     ),
      _wrap(Container(
       padding: EdgeInsets.fromLTRB(10, 5, 10, 5), 
       child: Icon(
         Icons.comment,
         size: 26,
         color: _homeFontColor(),
       ),
     ), widget.rightBtnClick),

    ],
  ),
);
}




Color _homeFontColor(){
return widget.type == SearchType.homeLight? Colors.black54:Colors.white; 
}



Widget _inputBox(){
Color inputBoxColor;
if(widget.type == SearchType.home)
{
  inputBoxColor = Colors.white;
}else{
  inputBoxColor = Color(int.parse('0xffededed'));
}

return Container(
  height: 30,
  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
  decoration: BoxDecoration(
    color: inputBoxColor,
    borderRadius: BorderRadius.circular(widget.type == SearchType.normal?5:15)
  ),
 child: Row(
   children: <Widget>[
     Icon(
     Icons.search,
     size: 20,
     color: widget.type == SearchType.normal ? Colors.grey:Colors.blue,
    // color: Colors.red,
     ),
     Expanded(
       flex: 1,
       child: widget.type == SearchType.normal?TextField(
         controller: _controller,
         onChanged: _onchange,
         autofocus: true,
         style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.w300),
         decoration: InputDecoration(
           contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
           border: InputBorder.none,
           hintText: widget.hint?? '',
           hintStyle: TextStyle(fontSize: 15),
         ),
       ) :  _wrap(Container(
         child: Text(
           widget.defaultText,
           style:TextStyle(fontSize:13,color:Colors.grey) 
         ),
       ), widget.inputBoxClick),
     ),
     showClear?_wrap(Icon(
       Icons.mic,
       size: 22,
       color:  widget.type==SearchType.normal? Colors.blue:Colors.grey,
     ), widget.speakClick) : 
     _wrap(Icon(
       Icons.clear,
       size:20,
       color:Colors.grey
     ), (){
       setState(() {
         _controller.clear();
       });
     })

   ],
 ),
);


}




Widget  _wrap(Widget child, void Function() callBack){
return GestureDetector(
  onTap: (){
    if(callBack != null) callBack();
  },
  child: child,
);
}




void _onchange(String text){
if(text.length>0){
 setState(() {
   showClear = false;
 });
}else{
  setState(() {
    showClear = true;
  });
}

if(widget.onChange != null){
  widget.onChange(text);
}


}











}




enum SearchType {
home,
homeLight,
normal

}