import 'dart:convert';

import 'package:api_provider/models/country_model.dart';
import 'package:api_provider/models/post_model.dart';
import 'package:api_provider/repository/base_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiNetwork {
  //getdata
  Future<CountryListData?> getCountryData() async {
    var client = http.Client();
    BaseRepository baseRepoUrl = BaseRepository();
    final url = baseRepoUrl.baseUrl;
    try {
      // var response = await client
      //     .get(Uri.parse("https://countriesnow.space/api/v0.1/countries/"));
      var response = await client.get(url);

      var jsonStr = jsonDecode(response.body);
      print("Api Call in getCountryData");
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var json = response.body;
        Map<String, dynamic> mapData = jsonDecode(json);
        return CountryListData.fromJson(mapData);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  //get post data
  Future<List<PostListModel>?> getPostsData() async {
    var client = http.Client();
    // BaseRepository baseRepoUrl = BaseRepository();
    // final url = baseRepoUrl.baseUrl;
    try {
      var response = await client
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      var jsonStr = jsonDecode(response.body);
      print("Api Call in getPostsData");
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var json = response.body;
        return postListModelFromJson(json);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
