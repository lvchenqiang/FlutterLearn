import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';

import 'package:flutter_trip/model/home_search_model.dart';
import 'package:flutter_trip/widgets/search_bar.dart';



const String url = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchPage extends StatefulWidget {


final bool hideLeft;
final String searchUrl;
final String keyword;
final String hint;

  SearchPage({Key key, this.hideLeft = true, this.searchUrl = url, this.keyword, this.hint}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

String keyword;
HomeSearchModel searchModel;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: <Widget>[
          _appBar(),
         MediaQuery.removePadding(
           context: context,
           removeTop: true,
           child: Expanded(
           flex: 1,
           child:  ListView.builder(
            itemCount: searchModel?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index){
            
            return _genListItem(context,index);
          },
          ),
         ),
         )
        ],
      ),
    );
  }




/// 输入框字符串的回调
  void _onTextChange(String text){
   keyword = text;
   if(text.length == 0) {
     setState(() {
       searchModel = null;
     });
   }else{
   
  
  SearchDao.fetch(widget.searchUrl,text).then((model){
   if(model.keyWord == keyword){ // 当前服务器返回内容与请求内容一致
     setState(() {
     searchModel = model;
   });
   }
  print(model.data);
  }).catchError((error){
   print(error);
  }); 
   


   }
  }





Widget _genListItem(BuildContext context, int index){

if(searchModel == null || searchModel.data == null) return null;

return Text(
  searchModel.data[index].word
);
}

Widget _appBar(){

  return Column(
   children: <Widget>[
     Container(
       decoration: BoxDecoration(
         gradient: LinearGradient(
          colors: [Color(0x66000000),Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
       ),
       child: Container(
         padding: EdgeInsets.only(top: 20),
         height: 80,
         decoration: BoxDecoration(
           color: Colors.white,
         ),
         child: SearchBar(
            hideLeft: widget.hideLeft,
            defaultText: widget.keyword,
            hint: widget.hint,
            leftBtnClick: (){
              Navigator.pop(context);
            },
            onChange: _onTextChange,
            
          ),
       ),
     )
   ],
  );
}


}