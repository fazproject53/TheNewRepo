import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Account/LoggingSingUpAPI.dart';


String serverUrl = "https://mobile.celebrityads.net/api";
Future<Advertising> getAdvertisingOrder(String token) async {
  print('advatisting token: $token');

  String url = "$serverUrl/celebrity/AdvertisingOrders";
  //try{
  final respons = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });


  if (respons.statusCode == 200) {
    final body = respons.body;
    Advertising advertising = Advertising.fromJson(jsonDecode(body));
    print('*************************************************');
    print(respons.body.runtimeType);
    print(respons.body);
    print('*************************************************');

    return advertising;
  } else {
    throw Exception('Failed to load Advertising request');
  }
  //} catch (e) {
   // print(e.toString());
  //}
  //return null;

}

//--------------------------------------------------------------------------------------
class Advertising {
  bool? success;
  Data? data;
  Message? message;

  Advertising({this.success, this.data, this.message});

  Advertising.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  List<AdvertisingOrders>? advertisingOrders;
  int? status;

  Data({this.advertisingOrders, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['advertisingOrders'] != null) {
      advertisingOrders = <AdvertisingOrders>[];
      json['advertisingOrders'].forEach((v) {
        advertisingOrders!.add(AdvertisingOrders.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.advertisingOrders != null) {
      data['advertisingOrders'] =
          this.advertisingOrders!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class AdvertisingOrders {
  int? id;
  Celebrity? celebrity;
  User? user;
  String? date;
  AdType? adType;
  AdType? status;
  int? price;
  String? description;
  Null? celebrityPromoCode;
  AdType? adOwner;
  AdType? advertisingAdType;
  AdType? adFeature;
  AdType? adTiming;
  String? file;

  AdvertisingOrders(
      {this.id,
      this.celebrity,
      this.user,
      this.date,
      this.adType,
      this.status,
      this.price,
      this.description,
      this.celebrityPromoCode,
      this.adOwner,
      this.advertisingAdType,
      this.adFeature,
      this.adTiming,
      this.file});

  AdvertisingOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    celebrity = json['celebrity'] != null
        ? Celebrity.fromJson(json['celebrity'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    date = json['date'];
    adType = json['ad_type'] != null ? AdType.fromJson(json['ad_type']) : null;
    status = json['status'] != null ? AdType.fromJson(json['status']) : null;
    price = json['price'];
    description = json['description'];
    celebrityPromoCode = json['celebrity_promo_code'];
    adOwner =
        json['ad_owner'] != null ? AdType.fromJson(json['ad_owner']) : null;
    advertisingAdType = json['advertising_ad_type'] != null
        ? new AdType.fromJson(json['advertising_ad_type'])
        : null;
    adFeature = json['ad_feature'] != null
        ? new AdType.fromJson(json['ad_feature'])
        : null;
    adTiming = json['ad_timing'] != null
        ? new AdType.fromJson(json['ad_timing'])
        : null;
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.celebrity != null) {
      data['celebrity'] = this.celebrity!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['date'] = this.date;
    if (this.adType != null) {
      data['ad_type'] = this.adType!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['price'] = this.price;
    data['description'] = this.description;
    data['celebrity_promo_code'] = this.celebrityPromoCode;
    if (this.adOwner != null) {
      data['ad_owner'] = this.adOwner!.toJson();
    }
    if (this.advertisingAdType != null) {
      data['advertising_ad_type'] = this.advertisingAdType!.toJson();
    }
    if (this.adFeature != null) {
      data['ad_feature'] = this.adFeature!.toJson();
    }
    if (this.adTiming != null) {
      data['ad_timing'] = this.adTiming!.toJson();
    }
    data['file'] = this.file;
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
  Null? city;
  String? description;
  String? pageUrl;
  String? snapchat;
  String? tiktok;
  String? youtube;
  String? instagram;
  String? twitter;
  String? facebook;
  Category? category;
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
    city = json['city'];
    description = json['description'];
    pageUrl = json['page_url'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
    youtube = json['youtube'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
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
    data['city'] = this.city;
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

class Category {
  String? name;
  String? nameEn;

  Category({this.name, this.nameEn});

  Category.fromJson(Map<String, dynamic> json) {
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

class User {
  int? id;
  String? username;
  String? name;
  String? image;
  String? email;
  String? phonenumber;
  Country? country;
  Category? city;
  String? type;

  User(
      {this.id,
      this.username,
      this.name,
      this.image,
      this.email,
      this.phonenumber,
      this.country,
      this.city,
      this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new Category.fromJson(json['city']) : null;
    type = json['type'];
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
    data['type'] = this.type;
    return data;
  }
}

class AdType {
  int? id;
  String? name;
  String? nameEn;

  AdType({this.id, this.name, this.nameEn});

  AdType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
