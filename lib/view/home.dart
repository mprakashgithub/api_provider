import 'package:api_provider/models/country_model.dart';
import 'package:api_provider/repository/api_network.dart';
import 'package:api_provider/view/first.dart';
import 'package:api_provider/view/search3.dart';
import 'package:api_provider/view/search_data.dart';
import 'package:api_provider/view/second.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  CountryListData? countryData;
  bool isLoaded = false;

  getData() async {
    countryData = await ApiNetwork().getCountryData();
    print("Home Screen");
    print(countryData!.data!.length);
    if (countryData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Search3())));
              },
              icon: Icon(Icons.donut_large)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => SearchListViewData())));
              },
              icon: Icon(Icons.donut_large)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => First())));
              },
              icon: Icon(Icons.nat)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Search2())));
              },
              icon: Icon(Icons.nat))
        ],
      ),
      body: isLoaded == true
          ? ListView.builder(
              itemCount: countryData!.data!.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(countryData!.data![index].iso2.toString()),
                      subtitle:
                          Text(countryData!.data![index].country.toString()),
                      leading: Text(countryData!.data![index].iso3.toString()),
                    ),
                    Text(countryData!.data![index].cities.toString()),
                  ],
                );
              }))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
