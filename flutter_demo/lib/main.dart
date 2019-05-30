import 'package:flutter/material.dart';


import 'package:flutter_demo1/page/TextPage.dart';
import 'package:flutter_demo1/page/ImagePage.dart';
import 'package:flutter_demo1/page/TextFieldPage.dart';
import 'package:flutter_demo1/page/ButtonPage.dart';
import 'package:flutter_demo1/page/SnackBarPage.dart';
import 'package:flutter_demo1/page/DialogPage.dart';
import 'package:flutter_demo1/page/BottomSheetPage.dart';
import 'package:flutter_demo1/page/MenuPage.dart';
import 'package:flutter_demo1/page/GestureDetectorPage.dart';
import 'package:flutter_demo1/page/FlexPage.dart';
import 'package:flutter_demo1/page/LinearPage.dart';
import 'package:flutter_demo1/page/WrapPage.dart';
import 'package:flutter_demo1/page/ContainersPage.dart';
import 'package:flutter_demo1/page/FeaturesPage.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Widget Demo'),
        routes:{
          '/Page0': (context) => TextPage(),
          '/Page1': (context) => ImagePage(),
          '/Page2':(context) => TextFieldPage(),
          '/Page3':(context) => ButtonPage(),
          '/Page4':(context) => SnackBarPage(),
          '/Page5':(context) => DialogPage(),
          '/Page6':(context) => BottomSheetPage(),
          '/Page7':(context) => MenuPage(),
          '/Page8':(context) => GestureDetectorPage(),
          '/Page9':(contex) => FlexPage(),
          '/Page10':(context) => LinearPage(),
          '/Page11':(context) => WrapPage(),
          '/Page12':(context) => ContainersPage(),
          '/Page13':(context) => FeaturesPage(),
        }
    );
  }
}


class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

final String title;

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    List<String> widgets = [
    '第1节 -- 文本框',
    '第2节 -- 图片和Icon',
    '第3节 -- 输入框',
    '第4节 -- Button',
    '第5节 -- SnackBar',
    '第6节 -- 对话框',
    '第7节 -- BottomSheet',
    '第8节 -- 菜单栏',
    '第9节 -- 手势识别Widget',
    '第10节 -- 弹性布局',
    '第11节 -- 线性布局',
    '第12节 -- 流式布局',
    '第13节 -- 层叠布局',
    '第14节 -- 容器类Widget',
    '第15节 -- 功能类Widget',
    '第16节 -- SingleChildScrollView',
    '第17节 -- ListView',
    '第18节 -- CustomScrollView',
    '第19节 -- GridView',
    '第20节 -- PageView',
    '第21节 -- 响应式编程',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return GestureDetector(
             child: ListTile(title: Text(widgets[index]),
             onTap: (){
               Navigator.pushNamed(context, '/Page' + index.toString());
             },),
          );
        },
        separatorBuilder: (context, index){
          return Divider();
        },
      ),
    );
  }
}