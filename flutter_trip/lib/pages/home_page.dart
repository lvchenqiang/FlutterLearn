

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

import 'package:flutter_trip/widgets/gird_nav.dart';
import 'package:flutter_trip/widgets/local_nav.dart';


const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

  double appBarAlpha = 0;

  HomeModel homeModel;


  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }


  @override
  Widget build(BuildContext context) {

  
   if(homeModel == null){
     return Center(
       child: CircularProgressIndicator(),
     );
   }


    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification){
                if(scrollNotification is ScrollNotification && scrollNotification.depth == 0){
                  // 滚动且是列表滚动的时候
                  print(scrollNotification.metrics.pixels);
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
             child: ListView(
               children: <Widget>[
                 Container(
                   height: 160,
                   child: Swiper(
                     itemCount: _imageUrls.length,
                     autoplay: true,
                     itemBuilder: (BuildContext context, int index){
                       return Image.network(_imageUrls[index],
                           fit: BoxFit.fill,
                       );
                     },
                     pagination: SwiperPagination(),
                   ),
                 ),
                 Padding(
                   padding: EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
                   child: LocalNav(localNavList:homeModel.localNavList),
                 ),

                GirdNav(model: homeModel.gridNav),
                 Container(
                   height: 800,
                   child: ListTile(
                     title: Text(homeModel.config.searchUrl),
                   ),
                 )
               ],
             ),  
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(homeModel.config.searchUrl),
              ),
              )
            ),
          )
        ],
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 请求网络接口
   loadData();

  }

  void loadData() async{
  //   HomdeDao.fetch().then((result){
  //    print(result);
  //   }).catchError((error){
  //  print(error);
  //   });


  try {
    HomeModel model = await HomdeDao.fetch();

    print(model.config.searchUrl);

    print("成功");
      setState(() {
       homeModel = model;
    });



  }catch(e)
  {
  print("失败");
    setState(() {
      homeModel = HomeModel();
    });
  }





  }
}