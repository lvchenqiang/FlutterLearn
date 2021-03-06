import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5'];


class WebView extends StatefulWidget {

final String url;
final String statusBarColor;
final String title;
final bool hideAppBar;
final bool backForbid;

  WebView({this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid = false});

  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool exiting = false;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   flutterWebviewPlugin.close();
   _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
    print(url);
  });


   _onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
     switch (state.type) {
       case WebViewState.startLoad:
         if(_isToMain(state.url) && !exiting){
           if(widget.backForbid){
             flutterWebviewPlugin.launch(widget.url);
           }else{
             Navigator.pop(context);
             exiting = true;
           }
         }
         break;
       default:
     }

  });


  _onHttpError = flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error){
    print(error);
  });

  }


 bool _isToMain(String url){
   bool contain = false;
   for(final value in CATCH_URLS){
     if(url?.endsWith(value)??false){
       contain = true;
     }
   }

   return contain;
 }

  @override
  void dispose() {
    // TODO: implement dispose

     _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    flutterWebviewPlugin.dispose();

    super.dispose();

  


  }
  @override
  Widget build(BuildContext context) {

  String statusBarColorstr = widget.statusBarColor ?? 'ffffff';
  Color backButtonColor;
  if(statusBarColorstr == 'ffffff'){
     backButtonColor = Colors.black;
  }else{
     backButtonColor = Colors.white;
  }


    return Scaffold(
      body: Column(
       children: <Widget>[
       _appBar(Color(int.parse('0xff'+statusBarColorstr)), backButtonColor),
       Expanded(child: WebviewScaffold(url: widget.url,
         withZoom:true,
         withLocalStorage: true,
         hidden: true,
         initialChild: Container(
           color: Colors.white,
           child: Center(
             child: Text("waiting"),
           ),
         ),
       ) 
       )
       ],
      ),
    );
  }




  _appBar(Color backgroundColor, Color backButtonColor){
   if(widget.hideAppBar ?? false){

     return Container(
       color: backgroundColor,
       height: 30,
     );
   }else{
  return Container(
    color: backgroundColor,
    padding: EdgeInsets.only(top: 40,bottom: 10),
    child: FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.close,
                color: backButtonColor,
                size: 26,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Center(
              child: Text(widget.title??"", style: TextStyle(color: backButtonColor,fontSize: 20)),
            ),
          )
        ],
      ),
    ),
  ); 
   }

  }


}