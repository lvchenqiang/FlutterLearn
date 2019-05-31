import 'package:flutter/material.dart';
import 'package:flutter_doubanmovie/page/hot/HotMoviesListWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HotWidget extends StatefulWidget {
  HotWidget({Key key}) : super(key: key);

  _HotWidgetState createState() => _HotWidgetState();
}

class _HotWidgetState extends State<HotWidget> {

  String curCity;



  void _jumpToCitysWidget() async{
    var selectCity = await Navigator.pushNamed(context, '/Citys',arguments: curCity);
    if(selectCity == null) return;

    final prefs = await SharedPreferences.getInstance(); 
    prefs.setString('curCity', selectCity); //存取数据


    setState(() {
      curCity =  selectCity;
    });
  }


  void initData() async {

    final prefs = await SharedPreferences.getInstance();//获取 prefs

    String city = prefs.getString('curCity');//获取 key 为 curCity 的值

    if (city != null && city.isNotEmpty) { //如果有值
      setState((){
        curCity = city;
      });
    } else {//如果没有值，则使用默认值
      setState((){
        curCity = '杭州';
      });
    }
  }


  
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('HotWidgetState initState');
    initData();
  }


  @override
  Widget build(BuildContext context) {
    if (curCity != null && curCity.isNotEmpty) {//如果 curCity 不为空
     return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 80,
          alignment: Alignment.bottomCenter,
          padding:EdgeInsets.only(left: 20,right: 20),
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Text(curCity,
                style: TextStyle(fontSize: 16),
                ),
                onTap: (){
                  _jumpToCitysWidget();
                },
              ),
              Icon(Icons.arrow_drop_down),
              Expanded(
                flex: 1,
                child: TextField(
                 textAlign: TextAlign.center,
                 style: TextStyle(fontSize: 16),
                 decoration: InputDecoration(
                   hintText: '\uE8b6 电影 / 电视剧 / 影人',
                   hintStyle: TextStyle(fontFamily: 'MaterialIcons',fontSize: 16),
                   contentPadding:EdgeInsets.only(top: 8),
                   border:OutlineInputBorder(
                     borderSide:BorderSide.none,
                     borderRadius:BorderRadius.all(Radius.circular(5)),
                   ),
                   fillColor: Colors.black12,
                   filled: true
                 ),
                ),
              )
            ],
          
          ),
          
        ),// 头部视图
        Expanded(
            flex: 1,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                    Container(
                      constraints: BoxConstraints.expand(height: 50),
                      child: TabBar(
                          unselectedLabelColor: Colors.black12,
                          labelColor: Colors.black87,
                          indicatorColor: Colors.black87,
                          tabs: <Widget>[Tab(text: '正在热映'), Tab(text: '即将上映')]),
                    ),
                   Expanded(
                      child: Container(
                        child: TabBarView(
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            HotMoviesListWidget(curCity),
                            Center(
                              child: Text('即将上映'),
                            )
                          ],
                        ),
                      ),
                    )

                ],
              ),
            ),
          )
      ],
    );
    }else{
      return Center(
        child: CircularProgressIndicator(),
      ); 
    }
   
}
}