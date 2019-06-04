import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widgets/webview.dart';


class LocalNav extends StatefulWidget {

  final List<CommonModel> localNavList;

  LocalNav({Key key,@required this.localNavList}) : super(key: key);

  _LocalNavState createState() => _LocalNavState();
}

class _LocalNavState extends State<LocalNav> {



 Widget _items(BuildContext context){

  if(widget.localNavList == null) return null;
   
   List<Widget> items = [];
   widget.localNavList.forEach((model){
    items.add(_item(context, model));
   });

  return Row(
   mainAxisAlignment: MainAxisAlignment.spaceBetween, // 平均排列
   children: items,
  );
 }

 Widget _item(BuildContext context,CommonModel model){


return GestureDetector(
      onTap: (){
        print(model.title);

        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          WebView(url: model.url,title: model.title,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
        ));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width:32,
            height:32
          ),
          Spacer(),
          Text(
            model.title,
            style: TextStyle(fontSize: 12,),
          )
        ],
      ),
);
 }

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 64,
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.all(Radius.circular(6)),
       ),
       child: Padding(
         padding: EdgeInsets.all(7),
         child: _items(context),
       )
    );
  }
}