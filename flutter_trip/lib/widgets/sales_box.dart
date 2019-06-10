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

  if(salesBox == null) return null;
  List<Widget> items = [];
  items.add(_genDoubleItems(context, salesBox.bigCard1 , salesBox.bigCard2, true, false));
  items.add(_genDoubleItems(context, salesBox.smallCard1 , salesBox.smallCard2, false, false));
  items.add(_genDoubleItems(context, salesBox.smallCard3 , salesBox.smallCard4, false, true));



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
              gradient: LinearGradient(
              colors: [Color(0xffff4e63),Color(0xffff6cc9)],
              begin: Alignment.centerLeft,end: Alignment.centerRight
              ),
               
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
        ],
      ),

    ),
    items[0],
    items[1],
    items[2],
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: items.sublist(1,2),
    //   ),
    // Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: items.sublist(2,3),
    //   ),
  ],
);
}


Widget _genDoubleItems(BuildContext context,CommonModel leftItem, CommonModel rightItem, bool isBig, bool isLast){

return Row(
   mainAxisAlignment: MainAxisAlignment.spaceBetween,
   children: <Widget>[
     _genItem(context, leftItem, isBig, true, isLast),
     _genItem(context, rightItem, isBig, false, isLast), 
   ],
);
}


Widget _genItem(BuildContext context,CommonModel item, bool isBig, bool isLeft, bool isLast){

BorderSide borderSide = BorderSide(width: 0.8,color: Color(0xfff2f2f2));


return _wrapGesture(context, Container(
  decoration: BoxDecoration(
    border: Border(right: isLeft? borderSide:BorderSide.none,
      bottom: isLast?borderSide:BorderSide.none),
    
  ),
  child: Image.network(item.icon,
     width: MediaQuery.of(context).size.width/2 - 10,
     height: isBig?129:80,
     fit: BoxFit.fill,
    ),
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