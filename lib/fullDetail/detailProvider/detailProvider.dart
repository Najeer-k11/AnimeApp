import 'dart:convert';

import 'package:http/http.dart' as http ;

import '../model/detailAnime.dart';
class DetailProvider {
  String url = 'https://api.jikan.moe/v4/anime/';

  Future<Data> getDetails(String id) async {
    try{
      var res = await http.get(Uri.parse(url+id));
      Map<String,dynamic> dec = jsonDecode(res.body);
      return Data.fromJson(dec['data']);
    } catch(e){
      throw(e.toString());
    }
  }
}