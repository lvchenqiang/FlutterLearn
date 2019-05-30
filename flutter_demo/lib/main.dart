import 'package:flutter/material.dart';


import 'package:flutter_demo1/page/TextPage.dart';
import 'package:flutter_demo1/page/ImagePage.dart';
import 'package:flutter_demo1/page/TextFieldPage.dart';
import 'package:flutter_demo1/page/SnackBarPage.dart';





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
          '/Page2':(contex) => TextFieldPage(),
          '/Page3':(context) => SnackBarPage(),
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
    '第4节 -- SnackBar',
    '第5节 -- 对话框',
    '第6节 -- BottomSheet',
    '第7节 -- 菜单栏',
    '第8节 -- 手势识别Widget',
    '第9节 -- 弹性布局',
    '第10节 -- 线性布局',
    '第11节 -- 流式布局',
    '第12节 -- 层叠布局',
    '第13节 -- 容器类Widget',
    '第14节 -- 功能类Widget',
    '第15节 -- SingleChildScrollView',
    '第16节 -- ListView',
    '第17节 -- CustomScrollView',
    '第18节 -- GridView',
    '第19节 -- PageView',
    '第20节 -- 响应式编程',
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