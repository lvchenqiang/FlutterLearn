import 'package:flutter/material.dart';


import 'package:flutter_demo1/page/TextPage.dart';


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
    '第14节 -- 文本框',
    '第15节 -- 图片和Icon',
    '第16节 -- 输入框',
    '第17节 -- SnackBar',
    '第18节 -- 对话框',
    '第19节 -- BottomSheet',
    '第20节 -- 菜单栏',
    '第21节 -- 手势识别Widget',
    '第24节 -- 弹性布局',
    '第25节 -- 线性布局',
    '第26节 -- 流式布局',
    '第27节 -- 层叠布局',
    '第28节 -- 容器类Widget',
    '第29节 -- 功能类Widget',
    '第30节 -- SingleChildScrollView',
    '第31节 -- ListView',
    '第32节 -- CustomScrollView',
    '第33节 -- GridView',
    '第34节 -- PageView',
    '第52节 -- 响应式编程',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    )
  }
}