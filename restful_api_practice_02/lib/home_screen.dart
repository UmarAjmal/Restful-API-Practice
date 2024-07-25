import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restful_api_practice_02/model/PostsModel.dart';

class HomePage extends StatelessWidget {
  
  List<Postsmodel> postList = [];
  Future<List<Postsmodel>> getPostAPI() async
  {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString(),);
    if(response.statusCode == 200)
      {
        for (var item in data)
        {
          postList.add(Postsmodel.fromJson(item as Map<String, dynamic>));
        }
        return postList;
      }
    else
      {
        return postList;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESTFUL API 02'),
      ),
      body: Column(
        children: [
          Expanded(
            child:
      FutureBuilder<List<Postsmodel>>(
          future: getPostAPI(),
        builder: (context, snapshot){
          return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data?[index].url as String),
                ),
                title: Text("Note id: "+snapshot.data![index].id.toString()),
                subtitle: Text(snapshot.data?[index].title as String),


              );
          });
        }
          ),
          ),],
      ),
    );
  }
}
