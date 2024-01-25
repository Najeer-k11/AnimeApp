import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/item.dart';

class SearchProvider {
  String url = 'https://api.jikan.moe/v4/anime?q=';
  List<Item> data = [];
  Future<List<Item>> getSearch(String query) async {
    try{
      var res = await http.get(Uri.parse(url+query+'?sfw=true'));
      Map<String,dynamic> dec = jsonDecode(res.body);
      for(int i=0; i < dec['data'].length ; i++){
        data.add(Item.fromJson(dec['data'][i]));
      }
      return data;
    }catch(e){
      return data;
    }
  }
}