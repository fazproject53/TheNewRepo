import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'TheUser.dart';
import 'logging.dart' as login;
String rememberIsLogin = '';

class DatabaseHelper {
  String serverUrl = "https://mobile.celebrityads.net/api";
  String token = '';
  //logging--------------------------------------------------------------------------------------------
  Future<String> loggingMethod(String username, String password) async {
    Map<String, dynamic> data = {"username": username, "password": password};
    String url = "$serverUrl/login";
    final respons = await http.post(Uri.parse(url), body: data);

    var message = jsonDecode(respons.body)["message"]["en"];
    var state = jsonDecode(respons.body)["data"]?["status"];
    print('logging respons: $message');
    if (state == 200) {
      var username = jsonDecode(respons.body)["data"]?["user"]['username'];
      var email = jsonDecode(respons.body)["data"]?["user"]['email'];
      token = jsonDecode(respons.body)['data']['token'];
      _saveToken(token);
      login.Logging.theUser = new TheUser();
      login.Logging.theUser!.name = jsonDecode(respons.body)["data"]?["user"]['name'];
      login.Logging.theUser!.email = jsonDecode(respons.body)["data"]?["user"]['email'];
      login.Logging.theUser!.id = jsonDecode(respons.body)["data"]?["user"]['id'].toString();
      login.Logging.theUser!.phone = jsonDecode(respons.body)["data"]?["user"]['phone'];
      login.Logging.theUser!.image = jsonDecode(respons.body)["data"]?["user"]['image'];
      rememberIsLogin = token;
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
      //print('status register respons: $status');

      //--------------------------------------------------------
      if (status == 200) {
        token = jsonDecode(respons.body)['data']['token'];
        userType = jsonDecode(respons.body)['data']?['user']?['type'];
        _saveToken(token);
        //print(userType);
        return '$userType';
      } else if (message['email']?[0] == "The email has already been taken." &&
          message['username']?[0] == "The username has already been taken.") {
        //print("email username found");
        return "email and username found";
        //--------------------------------------------------------
      } else if (message['username']?[0] ==
          "The username has already been taken.") {
        //print("username found");
        return "username found";
      } else if (message['email']?[0] == "The email has already been taken.") {
        //print("email found");
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

    try {
      Map<String, dynamic> data = {
        "username": username,
        "password": password,
        "email": email,
        'country_id': countryId,
        'category_id': categoryId
      };
      String url = "$serverUrl/celebrity/register";
      final respons = await http.post(Uri.parse(url), body: data);
      var message = jsonDecode(respons.body)?["message"]?["en"];
      int? status = jsonDecode(respons.body)?["data"]?["status"];
      print('user register respons: $message');
      //print('status register respons: $status');

      //--------------------------------------------------------
      if (status == 200) {
        token = jsonDecode(respons.body)['data']['token'];
        userType = jsonDecode(respons.body)['data']?['celebrity']?['type'];
        _saveToken(token);

        // print('respons body: ${jsonDecode(respons.body)}');
        // print(userType);
        return '$userType';
      } else if (message['email']?[0] == "The email has already been taken." &&
          message['username']?[0] == "The username has already been taken.") {
        // print("email username found");
        return "email and username found";
        //--------------------------------------------------------
      } else if (message['username']?[0] ==
          "The username has already been taken.") {
        //print("username found");
        return "username found";
      } else if (message['email']?[0] == "The email has already been taken.") {
        //print("email found");
        return "email found";
        //--------------------------------------------------------
      }
    } catch (e) {
      print(e.toString());
    }
    return "";
  }

  //save token------------------------------------------------------------

  static _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    prefs.setString(key, value);
    print('logging token is: $token');
  }

  //red token------------------------------------------------------------
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    String value = prefs.getString(key) ?? '';
    return value;
  }

  //remember me token------------------------------------------------------------
  static saveRememberToken(String user) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'save';
    prefs.setString(key, rememberIsLogin);

  }
  //get remember me token------------------------------------------------------------
  static Future<String> getRememberToken() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'save';
    String value = prefs.getString(key) ?? '';
    return value;
  }

//save Remember User------------------------------------------------------------
  static saveRememberUser(String user) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user';
    prefs.setString(key, user);
  }
  //get Remember User------------------------------------------------------------
  static Future<String> getRememberUser() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user';
    String value = prefs.getString(key) ?? '';
    print('get Remember user: $value');
    return value;
  }

  //remove token-----------------------------------------------------------------
  static void removeRememberToken() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'save';
    bool de = await prefs.remove(key);
    print('dddddddddddelete $de');
  }
  //remove token-----------------------------------------------------------------
  static void removeRememberUser() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user';
    bool de = await prefs.remove(key);
    print('dddddddddddelete user $de');
  }
}
      //
