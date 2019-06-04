import 'dart:async';
import 'dart:convert';

import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http;


String home_url = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomdeDao{

static Future<HomeModel> fetch() async{
  final response = await http.get(home_url);
  print(response);

  if(response.statusCode == 200){
    Utf8Decoder  utf8decoder = Utf8Decoder(); // 处理中文乱码的问题
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    return HomeModel.fromJson(result);
  }else{
    print('请求失败');
    throw Exception("请求首页接口失败");
  }
}


}