import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/UserModel.dart';

class HomePage extends StatelessWidget {
  List<UserModel> userList = [];

  get data => null;

  Future<List<UserModel>> getUserAPI() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Step i in data) {
        userList.add(UserModel.fromJson(Map<String, dynamic>));
      }
      print(data);
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RESTFUL API 03"),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder<List<UserModel>>(
            future: getUserAPI(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Text("LOADIND");
              }else {
                return
                  ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      Card(
                        child: Column(
                          children: [

                            ReusableRow(title: 'Id', value: data[index]['id'].toString(),)   ,
                            ReusableRow(title: 'Name', value: data[index]['name'].toString(),) ,
                            ReusableRow(title: 'UserEmail', value: data[index]['useremail'].toString(),) ,
                            // ReusableRow(title: 'Phone', value: data[index]['phone'].toString(),) ,
                            // ReusableRow(title: 'Address', value: data[index]['address']['city'].toString(),) ,
                            // ReusableRow(title: 'Address', value: data[index]['address']['street'].toString(),) ,
                            // ReusableRow(title: 'Address', value: data[index]['address']['geo'].toString(),) ,
                        ]
                        ),
                      );
                    },

                );
              }
            },
          ),
        )
      ]),
    );
  }
}
// class ResusesbleRow extends StatelessWidget {
//   String id,name, username, email, address, phone, website, company, title;
//
//    ResusesbleRow({
//      required this.id,
//      required this.name,
//      required this. username,
//      required this. email,
//      required this. address,
//      required this. phone,
//      required this. website,
//      required this. company, required  this.title, });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(id),
//         Text(name),
//         Text(username),
//         Text(email),
//         Text(address),
//         Text(phone),
//         Text(website),
//         Text(company),
//       ],
//     );
//   }


class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
        ),
        Text(
          value,
        ),
      ],
    );
  }
}

