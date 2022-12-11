import 'dart:convert';

import 'package:covid_tracker/Model/world_state_model.dart';
import 'package:covid_tracker/Services/Utilites/api_uri.dart';
import 'package:http/http.dart' as http;

class StatedServices{
  Future<WorldStatesModel> fetchWorldRecords() async{
    final response = await http.get(Uri.parse(ApiUrl.worldUri));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('error');
    }

  }
  Future<List<dynamic>> fetchCountriesRecords() async{
    var data;
    final response = await http.get(Uri.parse(ApiUrl.countryUri));

    if(response.statusCode == 200){
       data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('error');
    }

  }
}