

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

import 'package:flutter_trip/widgets/gird_nav.dart';
import 'package:flutter_trip/widgets/local_nav.dart';
import 'package:flutter_trip/widgets/sales_box.dart';
import 'package:flutter_trip/widgets/search_bar.dart';
import 'package:flutter_trip/widgets/sub_nav.dart';
import 'package:flutter_trip/widgets/loading_container.dart';
import 'package:flutter_trip/widgets/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
HomePage({Key key}) : super(key: key);

_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


double appBarAlpha = 0;
bool isLoading = true;
HomeModel homeModel;

String SEARCH_BAR_TEXT = "网红打卡点 酒店 美食";

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



_jumpToSearch(){

}

_jumpToSpeak(){


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
    body: LoadingContainer(isLoading: isLoading,child: 
    Stack(
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
            child: _genListView,
             ),
        ),
        _genAppBar
      ],
    ),
    )
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
      isLoading = false;
  });


}catch(e)
{
print("失败");
  setState(() {
    homeModel = HomeModel();
    // isLoading = false;
  });
}


}


Widget get _genAppBar{

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
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
        ),
        child:  SearchBar(
            type: appBarAlpha>0.2?SearchType.homeLight:SearchType.home,
            enabled: false,
            hideLeft: true,
            inputBoxClick: _jumpToSearch,
            speakClick: _jumpToSpeak,
            defaultText: SEARCH_BAR_TEXT,
            leftBtnClick: (){

            },
          ),
      ),
    ),
    Container(
      height: appBarAlpha>0.2?0.5:0,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 0.5)],

      ),
    )
   

  ],
);

}

/**
 * 生成ListView
 */
Widget get _genListView{
return ListView(
              children: <Widget>[
                _genBannerView
                ,
                Padding(
                  padding: EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
                  child: LocalNav(localNavList:homeModel.localNavList),
                ),

              Padding(
                padding: EdgeInsets.only(left: 12,right: 12),
                child: GirdNav(gridNavmodel: homeModel.gridNav),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12,right: 12,top: 7),
                child: SubNav(subNavList: homeModel.subNavList),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12,right: 12,top: 7),
                child: SalesBox(salesBox:homeModel.salesBox),
              ),
              //  Container(
              //    height: 800,
              //    child: ListTile(
              //      title: Text(homeModel.config.searchUrl),
              //    ),
              //  )
              ],
            );
        
}




/**
 * 生成bannerView
 */
Widget get _genBannerView{

return Container(
                  height: 160,
                  child: Swiper(
                    itemCount: homeModel.bannerList.length,
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        onTap: (){
                        CommonModel model = homeModel.bannerList[index]; 
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
        WebView(url: model.url,title: model.title,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
      ));
                        },
                        child: Image.network(homeModel.bannerList[index].icon,
                          fit: BoxFit.fill,
                      )
                      );
                    },
                    pagination: SwiperPagination(),
                  ),
                );
}

}