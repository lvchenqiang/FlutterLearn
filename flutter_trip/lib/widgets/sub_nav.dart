import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widgets/webview.dart';




class SubNav extends StatelessWidget {

   final List<CommonModel> subNavList;


  const SubNav({Key key,this.subNavList}) : super(key: key);
  
 

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.all(Radius.circular(6)),
       ),
       child: Padding(
         padding: EdgeInsets.all(7),
         child: _genSubNavItems(context),
       )
    );
  }




// 生成items
_genSubNavItems(BuildContext context){
  List<Widget> items = [];
 if(subNavList == null) return items;
 subNavList.forEach((model){
  items.add(_genItem(context,model));
 });

 int separate = (subNavList.length/2+0.5).toInt();


return Column(
  children: <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.sublist(0,separate),
    ),
    Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.sublist(separate,subNavList.length),
      ),
    )
  ],
);
}

_genItem(BuildContext context, CommonModel item){

return _wrapGesture(context, Column(
  children: <Widget>[
    Image.network(item.icon,
     width: 18,
     height: 18,
    ),
    Padding(
      padding: EdgeInsets.only(top: 3),
      child: Text(item.title,
      style:TextStyle(fontSize:12)
      ),
    )
  ],
), item);
}



Widget _wrapGesture(BuildContext context,Widget widget, CommonModel model){
return Expanded(
  flex: 1,
  child: GestureDetector(
  onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          WebView(url: model.url,title: model.title,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
        ));
  },
  child: widget,
 )
);
}
}