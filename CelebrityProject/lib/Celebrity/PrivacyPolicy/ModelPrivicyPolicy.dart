import 'dart:convert';
import 'package:http/http.dart' as http;

class PrivicyPolicy {
  bool? success;
  Data? data;
  Message? message;

  PrivicyPolicy({this.success, this.data, this.message});

  PrivicyPolicy.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Data {
  Celebrity? celebrity;
  int? status;

  Data({this.celebrity, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    celebrity = json['celebrity'] != null
        ? new Celebrity.fromJson(json['celebrity'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.celebrity != null) {
      data['celebrity'] = this.celebrity!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Celebrity {
  int? id;
  String? username;
  String? name;
  String? image;
  String? email;
  String? phonenumber;
  Country? country;
  City? city;
  String? description;
  String? pageUrl;
  String? snapchat;
  String? tiktok;
  String? youtube;
  String? instagram;
  String? twitter;
  String? facebook;
  City? category;
  String? brand;
  String? advertisingPolicy;
  String? giftingPolicy;
  String? adSpacePolicy;

  Celebrity(
      {this.id,
        this.username,
        this.name,
        this.image,
        this.email,
        this.phonenumber,
        this.country,
        this.city,
        this.description,
        this.pageUrl,
        this.snapchat,
        this.tiktok,
        this.youtube,
        this.instagram,
        this.twitter,
        this.facebook,
        this.category,
        this.brand,
        this.advertisingPolicy,
        this.giftingPolicy,
        this.adSpacePolicy});

  Celebrity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    description = json['description'];
    pageUrl = json['page_url'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
    youtube = json['youtube'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    category =
    json['category'] != null ? new City.fromJson(json['category']) : null;
    brand = json['brand'];
    advertisingPolicy = json['advertising_policy'];
    giftingPolicy = json['gifting_policy'];
    adSpacePolicy = json['ad_space_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['image'] = this.image;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['description'] = this.description;
    data['page_url'] = this.pageUrl;
    data['snapchat'] = this.snapchat;
    data['tiktok'] = this.tiktok;
    data['youtube'] = this.youtube;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['brand'] = this.brand;
    data['advertising_policy'] = this.advertisingPolicy;
    data['gifting_policy'] = this.giftingPolicy;
    data['ad_space_policy'] = this.adSpacePolicy;
    return data;
  }
}

class Country {
  String? name;
  String? nameEn;
  String? flag;

  Country({this.name, this.nameEn, this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEn = json['name_en'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['flag'] = this.flag;
    return data;
  }
}

class City {
  String? name;
  String? nameEn;

  City({this.name, this.nameEn});

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class Message {
  String? en;
  String? ar;

  Message({this.en, this.ar});

  Message.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}

///get
Future<PrivicyPolicy> fetchCelebritie() async {
  String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOWVjZjA0OGYxODVkOGZjYjQ5YTI3ZTgyYjQx'
      'YjBmNTg3OTMwYTA3NDY3YTc3ZjQwOGZlYWFmNjliNGYxMDQ4ZjEzMjgxMWU4MWNhMDJlNjYiLCJpYXQiOjE2NTAxOTc4MTIuNjUzNTQ5OTA5NTkxNjc0ODA0Njg3NSwibmJmIjoxNjUwMTk3ODEyLjY1Mz'
      'U1MzAwOTAzMzIwMzEyNSwiZXhwIjoxNjgxNzMzODEyLjY0Mzg2NjA2MjE2NDMwNjY0MDYyNSwic3ViIjoiMTEiLCJzY29wZXMiOltdfQ.toMOLVGTbNRcIqD801Xs3gJujhMvisCzAHHQC_P8UYp3lmzlG3rwadB4M0ro'
      'oMIVt82AB2CyZfT37tVVWrjAgNq4diKayoQC5wPT7QQrAp5MERuTTM7zH2n3anZh7uargXP1Mxz3X9PzzTRSvojDlfCMsX1PrTLAs0fGQOVVa-u3lkaKpWkVVa1lls0S755KhZXCAt1lKBNcm7GHF657QCh4_daSEOt'
      '4WSF4yq-F6i2sJH-oMaYndass7HMj05wT9Z2KkeIFcZ21ZEAKNstraKUfLzwLr2_buHFNmnziJPG1qFDgHLOUo6Omdw3f0ciPLiLD7FnCrqo_zRZQw9V_tPb1-o8MEZJmAH2dfQWQBey4zZgUiScAwZAiPNcTPBWXmS'
      'GQHxYVjubKzN18tq-w1EPxgFJ43sRRuIUHNU15rhMio_prjwqM9M061IzYWgzl3LW1NfckIP65l5tmFOMSgGaPDk18ikJNmxWxpFeBamL6tTsct7-BkEuYEU6GEP5D1L-uwu8GGI_T6f0VSW9sal_5Zo0lEsUuR2nO1yr'
      'SF8ppooEkFHlPJF25rlezmaUm0MIicaekbjwKdja5J5ZgNacpoAnoXe4arklcR6djnj_bRcxhWiYa-0GSITGvoWLcbc90G32BBe2Pz3RyoaiHkAYA_BNA_0qmjAYJMwB_e8U';
  final response = await http.get(Uri.parse('https://mobile.celebrityads.net/api/celebrity/profile'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return PrivicyPolicy.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load activity');
  }
}

///post