import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    var message = jsonDecode(respons.body)["message"]["en"];
    var state = jsonDecode(respons.body)["data"]?["status"];
    print('logging respons: $message');
    if (state == 200) {
      var username = jsonDecode(respons.body)["data"]?["user"]['username'];
      var email = jsonDecode(respons.body)["data"]?["user"]['email'];
      token = jsonDecode(respons.body)['data']['token'];
      _saveToken(token);
      print('-----------------------------------------------------');
      print('username is: $username');
      print('emial is: $email');
      print('-----------------------------------------------------');
      if (jsonDecode(respons.body)['data']['user']['type'] == 'user') {
        return 'user';
      } else {
        return 'celebrity';
      }
    } else if (message == "Invalid Credentials") {
      return "Invalid Credentials";
    } else {
      return "";
    }
  }

  //userRegister--------------------------------------------------------------------------------------------

  Future<String> userRegister(
      String username, String password, String email, String countryId) async {
    var userType;

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
        _saveToken(token);
        print(userType);
        return '$userType';
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

  //celebrityRegister--------------------------------------------------------------------------------------------

  Future<String> celebrityRegister(String username, String password,
      String email, String countryId, String categoryId) async {
    var userType;

   // try {
      Map<String, dynamic> data = {
        "username": username,
        "password": password,
        "email": email,
        'country_id':  countryId,
        'category_id': categoryId
      };
      String url = "$serverUrl/celebrity/register";
      final respons = await http.post(Uri.parse(url), body: data);
      var message = jsonDecode(respons.body)?["message"]?["en"];
      int? status = jsonDecode(respons.body)?["data"]?["status"];
      print('user register respons: $message');
      print('status register respons: $status');

      //--------------------------------------------------------
      if (status == 200) {
        token = jsonDecode(respons.body)['data']['token'];
        userType = jsonDecode(respons.body)['data']?['celebrity']?['type'];
        _saveToken(token);
        print('respons body: ${jsonDecode(respons.body)}');
        print(userType);
        return '$userType';
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
    //} catch (e) {
    //  print(e.toString());
   // }
    return "";
  }

  //save token------------------------------------------------------------

  static _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  //red token------------------------------------------------------------
  static Future<String>  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.getString(key) ?? 0;
    //print('token is : $value');
    String re=value.toString();
    return re;
  }
}
