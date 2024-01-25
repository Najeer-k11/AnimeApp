
import 'dart:convert';

import 'package:animecrunch/models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  String mainUrl = 'https://api.jikan.moe/v4' ;
  String content = '/top/anime' ;
  String random = '/top/manga';
  List<Item> data = [];
  List<Item> rand = [];
  Future<List<Item>> getData() async {
    try{
      var response = await http.get(Uri.parse(mainUrl+content));
      Map<String,dynamic> decoded = jsonDecode(response.body) ;
      for(int i=0; i < decoded['data'].length ; i++)
        {
          data.add(Item.fromJson(decoded['data'][i])) ;
        }
      return data;
    } catch(e) {
      return data;
    }
  }

  Future<List<Item>> getRand() async {
    try{
      var res = await http.get(Uri.parse(mainUrl+random));
      Map<String,dynamic> dec = jsonDecode(res.body);
      for(int i=0; i < dec['data'].length ; i++){
        rand.add(Item.fromJson(dec['data'][i])) ;
      }
      return rand;
    } catch(e) {
      return rand;
    }
  }

}