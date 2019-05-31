import 'package:flutter/material.dart';

class HotWidget extends StatefulWidget {
  HotWidget({Key key}) : super(key: key);

  _HotWidgetState createState() => _HotWidgetState();
}

class _HotWidgetState extends State<HotWidget> {
  @override
  Widget build(BuildContext context) {
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
                child: Text('杭州',
                style: TextStyle(fontSize: 16),
                ),
                onTap: (){
                  print("点击了标题");
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
                            // HotMoviesListWidget(curCity),
                            Center(
                              child: Text('正在热映'),
                            ),
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
}
}