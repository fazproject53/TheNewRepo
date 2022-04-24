class DiscountModel {
  bool? success;
  Data? data;
  Message? message;

  DiscountModel({this.success, this.data, this.message});

  DiscountModel.fromJson(Map<String, dynamic> json) {
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
  List<PromoCode>? promoCode;
  int? status;

  Data({this.promoCode, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['promoCode'] != null) {
      promoCode = <PromoCode>[];
      json['promoCode'].forEach((v) {
        promoCode!.add(new PromoCode.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promoCode != null) {
      data['promoCode'] = this.promoCode!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class PromoCode {
  int? id;
  String? code;
  String? discountType;
  int? numOfPerson;
  String? description;
  AdType? adType;
  String? dateFrom;
  String? dateTo;

  PromoCode(
      {this.id,
        this.code,
        this.discountType,
        this.numOfPerson,
        this.description,
        this.adType,
        this.dateFrom,
        this.dateTo});

  PromoCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    discountType = json['discount_type'];
    numOfPerson = json['num_of_person'];
    description = json['description'];
    adType =
    json['ad_type'] != null ? new AdType.fromJson(json['ad_type']) : null;
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount_type'] = this.discountType;
    data['num_of_person'] = this.numOfPerson;
    data['description'] = this.description;
    if (this.adType != null) {
      data['ad_type'] = this.adType!.toJson();
    }
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    return data;
  }
}

class AdType {
  String? name;
  String? nameEn;

  AdType({this.name, this.nameEn});

  AdType.fromJson(Map<String, dynamic> json) {
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