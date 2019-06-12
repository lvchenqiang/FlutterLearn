import 'dart:async';
import 'dart:convert';

import 'package:flutter_trip/model/home_search_model.dart';
import 'package:http/http.dart' as http;


String searchUrl = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';


// 搜索接口
class SearchDao {


static Future<HomeSearchModel>fetch(String url, String text) async {
 final response = await http.get(url);
 print(response);

 if(response.statusCode == 200){
    Utf8Decoder  utf8decoder = Utf8Decoder(); // 处理中文乱码的问题
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    HomeSearchModel model =  HomeSearchModel.fromJson(result);
    model.keyWord = text;
    return model;
  }else{
    print('请求失败');
    throw Exception("首页搜索接口失败");
  }


} 


}