import 'package:flutter/material.dart';

/// 加载进度条
class LoadingContainer extends StatelessWidget {

final Widget child;
final bool isLoading;
final bool cover; /// 是否覆盖整个布局

  const LoadingContainer({Key key, @required this.child, this.isLoading = false, @required this.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover?!isLoading?child:_loadView:
    Stack(
      children: <Widget>[
        child,
        isLoading?_loadView:null
      ],
    );
  }


  Widget get _loadView{

  }



}