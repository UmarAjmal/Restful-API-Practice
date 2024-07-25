import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/PostModel.dart';

class HomePage extends StatelessWidget {
  List<PostModel> postList = [];

  //get indexed => null;

  Future<List<PostModel>> getAPI() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      postList.clear();
      List<dynamic> data = jsonDecode(response.body);
      for (var item in data) {
        postList.add(PostModel.fromJson(item as Map<String, dynamic>));
      }
      return postList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESTFUL API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<PostModel>>(
              future: getAPI(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ID",
                                style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              Text(postList[index].id.toString()),
                              Text(
                                "Title",
                                  style: TextStyle(fontWeight: FontWeight.bold)                              ),
                              Text(postList[index].title as String),
                              Text(
                                "Description",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(postList[index].body as String),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
