import 'dart:convert';

import 'package:api_provider/models/country_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  //getdata
  Future<CountryListData?> getCountryData() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse("https://countriesnow.space/api/v0.1/countries/"));

      var jsonStr = jsonDecode(response.body);
      print("Api Call in getCountryData");
      print(response.body);
      if (response.statusCode == 200) {
        var json = response.body;
        Map<String, dynamic> mapData = jsonDecode(json);
        return CountryListData.fromJson(mapData);
      }
    } catch (e) {}
  }
}
