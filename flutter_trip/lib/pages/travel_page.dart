import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/dao/travel_tab_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_trip/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  TravelPage({Key key}) : super(key: key);

  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with SingleTickerProviderStateMixin{
TabController _controller ;
List<TravelTab> tabs = [];
TravelTabModel travelTabModel;


@override
  void initState() {
    _controller = TabController(length: 0,vsync: this);
    // TravelDao.fetch(url, params, groupChannelCode, type, pageIndex, pageSize)
    TravelTabDao.fetch().then((TravelTabModel model){
      _controller = TabController(length: model.tabs.length,vsync: this);
      setState(() {
        travelTabModel = model;
        tabs = model.tabs;
      });
    }).catchError((error){
      print(error);
    }
    );


    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color(0xff2fcfbb,),
                    width: 3
                  ),
                  insets: EdgeInsets.only(bottom: 10)
                ),
                tabs: tabs.map<Tab>((TravelTab tab){
                  return Tab(text: tab.labelName);
                }).toList(),
              ),
            ),
            Flexible(
              child: TabBarView(
              controller: _controller,
              children: tabs.map((TravelTab tab){
                return TravelTabPage(
                  travelUrl: travelTabModel.url,
                  params: travelTabModel.params,
                  groupChannelCode: tab.groupChannelCode,
                  type: tab.type,
                );
              }).toList(),
            ),
            )
          ],
        ),
    );
  }
}