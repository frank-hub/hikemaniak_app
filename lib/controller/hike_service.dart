import 'dart:convert';

import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/model/hike.dart';
import 'package:http/http.dart' as http;

class hikeService {
  // List<Hike> hike = [];
  late Hike hike = Hike();

  Future<void> adminHikes() async {
    final response = await http.get(Uri.parse('$BASE_URL/hike/index'));

    try{
      if(response.statusCode == 200){
        Map<String,dynamic> resData = json.decode(response.body);
        List<dynamic> hikes = resData['data'];
        // hike = hikes.map((data) => Hike.fromJson(data)).toList();
      }
    }catch(e){
      print(e);
    }
  }

  Future<Hike?> showHike(String id) async{
    final response = await http.get(Uri.parse('$BASE_URL/hike/show/$id'));

    if(response.statusCode == 200){
      Map<String,dynamic> resData = json.decode(response.body);

      Map<String,dynamic> hikeDetails = resData['data'];

      hike = Hike.fromJson(hikeDetails);

      return hike;
    }
    return null;
  }
}