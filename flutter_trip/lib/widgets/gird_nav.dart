import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widgets/webview.dart';

class GirdNav extends StatefulWidget {

  final GridNavModel gridNavmodel;

  GirdNav({Key key,@required this.gridNavmodel}) : super(key: key);

  _GirdNavState createState() => _GirdNavState();
}

class _GirdNavState extends State<GirdNav> {
  @override
  Widget build(BuildContext context) {

    
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      child: Column(
      children: _genGridNavItems(context),
    ),
    );
  }

  _genGridNavItems(BuildContext context){
    List<Widget> items = [];
    if(widget.gridNavmodel == null)return items;

    ///酒店
     if(widget.gridNavmodel.hotel != null){
      items.add(_genGridNavItem(context,widget.gridNavmodel.hotel,true));
     }

     // 机票
     if(widget.gridNavmodel.flight != null){
      items.add(_genGridNavItem(context,widget.gridNavmodel.flight,false));
     }

     // 旅行
     if(widget.gridNavmodel.travel != null){
     items.add(_genGridNavItem(context,widget.gridNavmodel.travel,false));
     }
 
   return items;  
  }

 Widget _genGridNavItem(BuildContext context, GridNavItem item, bool first){
    List<Widget> items = [];
    items.add(_mainItem(context,item.mainItem));
    items.add(_doubleItem(context, item.item1, item.item2, true));
    items.add(_doubleItem(context,item.item3,item.item4,false));


    List<Widget> expanditems = [];
    items.forEach((item){
      expanditems.add(Expanded(child:item,flex:1));
    });
  

  Color startColor = Color(int.parse('0xff'+item.startColor));
  Color endColor = Color(int.parse('0xff'+item.endColor));

  return Container(
    height: 88,
    margin: first?null:EdgeInsets.only(top: 3),
    decoration: BoxDecoration(
    gradient: LinearGradient(colors: [startColor,endColor])
    ),
    child: Row(children:expanditems),
  );
 }


 Widget _mainItem(BuildContext context, CommonModel model){

return _wrapGesture(context, Stack(
   alignment: AlignmentDirectional.center,
    children: <Widget>[
      Image.network(
        model.icon,
        fit:BoxFit.contain,
        height: 88,
        width: 121,
        alignment: AlignmentDirectional.bottomEnd,
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(model.title,
      style: TextStyle(fontSize: 14,color: Colors.white)),
      )
    ],
  ), model);
 }


Widget _doubleItem(BuildContext context,CommonModel topItem,CommonModel bottomItem, bool centerItem){
return Column(
  children: <Widget>[
    Expanded(
      child: _wrapGesture(context, _item(context, topItem, true, centerItem), topItem),
    ),
     Expanded(
      child: _wrapGesture(context, _item(context, bottomItem, false, centerItem), bottomItem),
    )
  ],
);
}


_item(BuildContext context, CommonModel item, bool firstItem, bool centerItem){

BorderSide borderSide = BorderSide(width: 0.8,color: Colors.white);

return FractionallySizedBox(
  widthFactor: 1,
  child: Container(
    decoration: BoxDecoration(
      border: Border(
        left: borderSide,
        bottom: firstItem?borderSide:BorderSide.none
      ),
    ),
    child: Center(
      child: Text(item.title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14,color: Colors.white),
      ),
    ),
  ),
);
}



Widget _wrapGesture(BuildContext context,Widget widget, CommonModel model){
return GestureDetector(
  onTap: (){
 Navigator.push(context, MaterialPageRoute(builder: (context) =>
          WebView(url: model.url,title: model.title,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
        ));
  },
  child: widget,
);
}
}