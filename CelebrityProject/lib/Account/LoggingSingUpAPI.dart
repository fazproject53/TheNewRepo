import 'dart:convert';

import 'package:celepraty/Account/Singup.dart';
import 'package:http/http.dart' as http;

class DatabaseHelper {
  String serverUrl = "https://mobile.celebrityads.net/api";
  String token = '';
  //logging--------------------------------------------------------------------------------------------
  Future<String> loggingMethod(String username, String password) async {
    String userType = '';
    Map<String, dynamic> data = {"username": username, "password": password};
    String url = "$serverUrl/login";
    final respons = await http.post(Uri.parse(url), body: data);
    //print(respons.body);
    String message = jsonDecode(respons.body)["message"]["en"];
    print('logging respons: $message');
    if (message == "Login Successfully") {
      userType = jsonDecode(respons.body)['data']['user']['type'];
      return userType;
    } else if (message == "Invalid Credentials") {
      return "Invalid Credentials";
    } else {
      return "";
    }
  }

  //userRegister--------------------------------------------------------------------------------------------

  Future<String> userRegister(
      String username, String password, String email, String countryId) async {
    String userType = '';

     try {
    Map<String, dynamic> data = {
      "username": username,
      "password": password,
      "email": email,
      'country_id': countryId
    };
    String url = "$serverUrl/user/new_register";
    final respons = await http.post(Uri.parse(url), body: data);
    var message = jsonDecode(respons.body)["message"]["en"];
    int? status = jsonDecode(respons.body)?["data"]?["status"];
    print('user register respons: $message');
    print('status register respons: $status');

    //--------------------------------------------------------
    if (status == 200) {
      token = jsonDecode(respons.body)['data']['token'];
      userType = jsonDecode(respons.body)['data']?['user']?['type'];
      print(token);

      print(userType);
      return userType;
    } else if (message['email']?[0] == "The email has already been taken." &&
        message['username']?[0] == "The username has already been taken.") {
      print("email username found");
      return "email and username found";
      //--------------------------------------------------------
    } else if (message['username']?[0] ==
        "The username has already been taken.") {
      print("username found");
      return "username found";
    } else if (message['email']?[0] == "The email has already been taken.") {
      print("email found");
      return "email found";
      //--------------------------------------------------------
    }
    } catch (e) {
      print(e.toString());
    }
    return "";
  }


  //userRegister--------------------------------------------------------------------------------------------

  Future<String> celebrityRegister(
      String username, String password, String email, String countryId,String categoryId) async {
    String userType = '';

    //try {
      Map<String, dynamic> data = {
        "username": username,
        "password": password,
        "email": email,
        'country_id': countryId,
        'category_id':categoryId
      };
      String url = "$serverUrl/celebrity/register";
      final respons = await http.post(Uri.parse(url), body: data);
      var message = jsonDecode(respons.body)["message"]["en"];
      int? status = jsonDecode(respons.body)?["data"]?["status"];
      print('user register respons: $message');
      print('status register respons: $status');

      //--------------------------------------------------------
      if (status == 200) {
        token = jsonDecode(respons.body)['data']['token'];
        userType = jsonDecode(respons.body)?['data']?['user']?['type'];
        print(token);

        print(userType);
        return userType;
      } else if (message['email']?[0] == "The email has already been taken." &&
          message['username']?[0] == "The username has already been taken.") {
        print("email username found");
        return "email and username found";
        //--------------------------------------------------------
      } else if (message['username']?[0] ==
          "The username has already been taken.") {
        print("username found");
        return "username found";
      } else if (message['email']?[0] == "The email has already been taken.") {
        print("email found");
        return "email found";
        //--------------------------------------------------------
      }
    // } catch (e) {
    //   print(e.toString());
    // }
    return "";
  }
}
