import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchListViewData extends StatefulWidget {
  @override
  _SearchListViewDataState createState() => _SearchListViewDataState();
}

class _SearchListViewDataState extends State<SearchListViewData> {
  List<String> dogsBreedList = [];
  // List<String> tempList = List<String>();
  List<String> tempList = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDogsBreed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _searchBar(),
                Expanded(
                  flex: 1,
                  child: _mainData(),
                )
              ],
            ),
          )),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Dog Breeds Here...",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text) {
          _filterDogList(text);
        },
      ),
    );
  }

  Widget _mainData() {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: dogsBreedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                  dogsBreedList[index],
                ));
              }),
    );
  }

  _filterDogList(String text) {
    if (text.isNotEmpty) {
      setState(() {
        dogsBreedList = tempList;
      });
    } else {
      final List<String> filteredBreeds = [];
      tempList.map((breed) {
        if (breed.contains(text.toString().toUpperCase())) {
          filteredBreeds.add(breed);
        }
      }).toList();
      setState(() {
        dogsBreedList.clear();
        dogsBreedList.addAll(filteredBreeds);
      });
    }
  }

  _fetchDogsBreed() async {
    setState(() {
      isLoading = true;
    });
    tempList = [];
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      jsonResponse['message'].forEach((breed, subbreed) {
        tempList.add(breed.toString().toUpperCase());
      });
    } else {
      throw Exception("Failed to load Dogs Breeds.");
    }
    setState(() {
      dogsBreedList = tempList;
      isLoading = false;
    });
  }
}

class Search2 extends StatefulWidget {
  const Search2({Key? key}) : super(key: key);

  @override
  _Search2State createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // results =
      //     _allUsers.where((user) => user["id"] == enteredKeyword).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["id"]),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundUsers[index]["id"].toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index]['name']),
                          subtitle: Text(
                              '${_foundUsers[index]["age"].toString()} years old'),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
