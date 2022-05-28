import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Celebrity/DiscountCodes/ModelDiscountCode.dart';


String serverUrl = "https://mobile.celebrityads.net/api";
Future<UserGiftOrds> getUsreAdvSpaceOrder(String token) async {
  print('user advertising token: $token');

  String url = "$serverUrl/user/GiftOrders";
  //try{
  final respons = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });


  if (respons.statusCode == 200) {
    final body = respons.body;
    UserGiftOrds userAdvGiftOrds = UserGiftOrds.fromJson(jsonDecode(body));
    print('*************************************************');
    print(respons.body.runtimeType);
    print(respons.body);
    print('*************************************************');

    return userAdvGiftOrds;
  } else {
    throw Exception('Failed to load Advertising request');
  }
  //} catch (e) {
  // print(e.toString());
  //}
  //return null;

}

//------------------------------------------------------------------
class UserGiftOrds {
  bool? success;
  Data? data;
  Message? message;

  UserGiftOrds({this.success, this.data, this.message});

  UserGiftOrds.fromJson(Map<String, dynamic> json) {
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
  List<GiftOrders>? giftOrders;
  int? status;

  Data({this.giftOrders, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['GiftOrders'] != null) {
      giftOrders = <GiftOrders>[];
      json['GiftOrders'].forEach((v) {
        giftOrders!.add(new GiftOrders.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.giftOrders != null) {
      data['GiftOrders'] = this.giftOrders!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class GiftOrders {
  int? id;
  Celebrity? celebrity;
  User? user;
  String? date;
  AccountStatus? adType;
  City? status;
  int? price;
  Occasion? occasion;
  AccountStatus? giftType;
  String? description;
  String? from;
  String? to;
  CelebrityPromoCode? celebrityPromoCode;

  GiftOrders(
      {this.id,
        this.celebrity,
        this.user,
        this.date,
        this.adType,
        this.status,
        this.price,
        this.occasion,
        this.giftType,
        this.description,
        this.from,
        this.to,
        this.celebrityPromoCode});

  GiftOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    celebrity = json['celebrity'] != null
        ? new Celebrity.fromJson(json['celebrity'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    date = json['date'];
    adType = json['ad_type'] != null
        ? new AccountStatus.fromJson(json['ad_type'])
        : null;
    status = json['status'] != null ? new City.fromJson(json['status']) : null;
    price = json['price'];
    occasion = json['occasion'] != null
        ? new Occasion.fromJson(json['occasion'])
        : null;
    giftType = json['gift_type'] != null
        ? new AccountStatus.fromJson(json['gift_type'])
        : null;
    description = json['description'];
    from = json['from'];
    to = json['to'];
    celebrityPromoCode = json['celebrity_promo_code'] != null
        ? new CelebrityPromoCode.fromJson(json['celebrity_promo_code'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.occasion != null) {
      data['occasion'] = this.occasion!.toJson();
    }
    if (this.giftType != null) {
      data['gift_type'] = this.giftType!.toJson();
    }
    data['description'] = this.description;
    data['from'] = this.from;
    data['to'] = this.to;
    if (this.celebrityPromoCode != null) {
      data['celebrity_promo_code'] = this.celebrityPromoCode!.toJson();
    }
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

class User {
  int? id;
  String? username;
  String? name;
  String? image;
  String? email;
  String? phonenumber;
  Country? country;
  City? city;
  AccountStatus? accountStatus;
  Null? gender;
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
        this.accountStatus,
        this.gender,
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
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    accountStatus = json['account_status'] != null
        ? new AccountStatus.fromJson(json['account_status'])
        : null;
    gender = json['gender'];
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
    if (this.accountStatus != null) {
      data['account_status'] = this.accountStatus!.toJson();
    }
    data['gender'] = this.gender;
    data['type'] = this.type;
    return data;
  }
}

class AccountStatus {
  int? id;
  String? name;
  String? nameEn;

  AccountStatus({this.id, this.name, this.nameEn});

  AccountStatus.fromJson(Map<String, dynamic> json) {
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

class Occasion {
  int? id;
  String? name;
  String? nameEn;
  String? image;

  Occasion({this.id, this.name, this.nameEn, this.image});

  Occasion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['image'] = this.image;
    return data;
  }
}

class CelebrityPromoCode {
  int? id;
  String? code;
  String? discountType;
  int? discount;
  int? numOfPerson;
  String? description;
  List<AdTypes>? adTypes;
  String? dateFrom;
  String? dateTo;
  City? status;

  CelebrityPromoCode(
      {this.id,
        this.code,
        this.discountType,
        this.discount,
        this.numOfPerson,
        this.description,
        this.adTypes,
        this.dateFrom,
        this.dateTo,
        this.status});

  CelebrityPromoCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discountType = json['discount_type'];
    discount = json['discount'];
    numOfPerson = json['num_of_person'];
    description = json['description'];
    if (json['ad_types'] != null) {
      adTypes = <AdTypes>[];
      json['ad_types'].forEach((v) {
        adTypes!.add(AdTypes.fromJson(v));
      });
    }
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    status = json['status'] != null ? new City.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['num_of_person'] = this.numOfPerson;
    data['description'] = this.description;
    if (this.adTypes != null) {
      data['ad_types'] = this.adTypes!.map((v) => v.toJson()).toList();
    }
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
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


