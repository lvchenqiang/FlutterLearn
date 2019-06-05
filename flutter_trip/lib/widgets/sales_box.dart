import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widgets/webview.dart';




class SalesBox extends StatelessWidget {
 
   final SalesBoxModel salesBox;

  const SalesBox({Key key,this.salesBox}) : super(key: key);
  
 

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         color: Colors.white,
        //  borderRadius: BorderRadius.all(Radius.circular(6)),
       ),
       child:_genSalesBoxItems(context),
       );
  }




// 生成items
_genSalesBoxItems(BuildContext context){
  List<Widget> items = [];
 if(salesBox == null) return items;
 


return Column(
  children: <Widget>[
    Container(
      height: 44,
      margin: EdgeInsets.only(left:10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Color(0xfff2f2f2))),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.network(salesBox.icon,
          height:15,
          fit: BoxFit.fill,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 1,bottom: 1,right: 8),
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(colors: [Color(0xffff4e63),Color(0xffff6cc9)],begin: Alignment.centerLeft,end: Alignment.centerRight),
               
            ),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                WebView(url: salesBox.moreUrl,title: "更多活动")
             ));
              },
              child: Text('获取更多福利>', style: TextStyle(fontSize:12,color: Colors.white),),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(0,1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(1,2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(2,3),
          )
        ],
      ),

    )
  ],
);
}


Widget _genDoubleItems(BuildContext context,CommonModel leftItem, CommonModel rightItem, bool isFirst, bool isCenter){


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