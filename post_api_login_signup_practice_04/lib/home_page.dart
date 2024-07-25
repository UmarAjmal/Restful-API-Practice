import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' ;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();


  void login(email, password) async {
    try{
      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {
            'email': email,
            'password' : password,
          }
      );
      var data = jsonDecode(response.body.toString());
      print(data);
      if(response.statusCode == 200){print('SignUp Successful');}else{print('SignUp Failed');}
    }
    catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POST API LOGIN-SIGNUP PAGE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcontroler,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordcontroler,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                login(emailcontroler.text.toString(),passwordcontroler.text.toString());
              },
              child: Container(

                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text('SignUp'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
