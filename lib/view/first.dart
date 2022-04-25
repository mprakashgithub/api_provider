import 'package:api_provider/models/post_model.dart';
import 'package:api_provider/provider/first_provider.dart';
import 'package:api_provider/repository/api_network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  List<PostListModel>? postData;
  bool isLoaded = false;
  getPostList() async {
    postData = await ApiNetwork().getPostsData();
    if (postData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Provider Demo"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(35),
            color: Colors.yellow[200],
            child: Consumer<FirstProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    Text('${provider.value}'),
                    MaterialButton(
                      onPressed: () {
                        provider.setValue(50);
                      },
                      child: Text("Update"),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
              child: isLoaded == true
                  ? ListView.builder(
                      itemCount: postData == null ? 0 : postData!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(postData![index].userId.toString()),
                          subtitle: Text(postData![index].body.toString()),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ))
        ],
      ),
    );
  }
}
