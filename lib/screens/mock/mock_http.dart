

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

final http.Client httpClient = MockClient(_mockHandler);


Future<http.Response> _mockHandler(http.Request request){
  var result = jsonDecode(request.body) as Map<String, dynamic>;
  if(result['email'] == 'root' && result['password'] == 'password'){
    return Future.value(http.Response('', 200));
  }
  else {
    return Future.value(http.Response('', 401));
  }
}


