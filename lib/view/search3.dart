import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Search3 extends StatefulWidget {
  @override
  _Search3State createState() => new _Search3State();
}

class _Search3State extends State<Search3> {
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(Uri.parse(url));
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map<String, dynamic> user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     _searchResult[i].profileUrl!,
                          //   ),
                          // ),
                          title: Text(_searchResult[i].firstName! +
                              ' ' +
                              _searchResult[i].lastName!),
                        ),
                        margin: const EdgeInsets.all(0.0),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: _userDetails.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     _userDetails[index].profileUrl!,
                          //   ),
                          // ),
                          title: Text(_userDetails[index].firstName! +
                              ' ' +
                              _userDetails[index].lastName!),
                        ),
                        margin: const EdgeInsets.all(0.0),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.firstName!.contains(text) ||
          userDetail.lastName!.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://jsonplaceholder.typicode.com/users';

class UserDetails {
  final int? id;
  final String? firstName, lastName;

  UserDetails({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      firstName: json['name'],
      lastName: json['username'],
    );
  }
}
