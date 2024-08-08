import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';



part 'sign_in_with_http.g.dart';
@JsonSerializable()
class FormData{
  String? email;
  String? password;

  FormData({this.email, this.password});

  factory FormData.fromJson(Map<String, dynamic> json) => _$FormDataFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}

class SignInWithHttp extends StatefulWidget {

  final http.Client? client;
  
  
  const SignInWithHttp({super.key, this.client});

  @override
  State<SignInWithHttp> createState() => _SignInWithHttpState();
}

class _SignInWithHttpState extends State<SignInWithHttp> {
  FormData formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in with http"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value){
                formData.email = value;
              },
              
              autofocus: true,
              decoration: const InputDecoration(
                
                labelText: "Email",
                hintText: "Your email address",
                filled: true

              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              onChanged: (value){
                formData.password = value;
              },
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Password",
                filled: true

              ),
            ),

            const SizedBox(height: 30),
            TextButton(

              child: const Text("Sign up"),
              onPressed: () async{
                final result = await widget.client!.post(
                  Uri.parse('https/example.com'),
                  body: jsonEncode(formData.toJson())
                );
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(result.statusCode == 200? "Successfully signed in.": "Unable to sign in."),   
                    content: TextButton(
                      child: const Text("OK"),
                      onPressed: (){
                        Navigator.pop(context);  
                      },
                    )                 
                  )
                );  
              },
            ),
          ],
        ),
      )
    );
  }
}