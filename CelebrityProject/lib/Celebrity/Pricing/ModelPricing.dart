class Pricing {
  bool? success;
  Data? data;
  Message? message;

  Pricing({this.success, this.data, this.message});

  Pricing.fromJson(Map<String, dynamic> json) {
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
  Price? price;
  int? status;

  Data({this.price, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Price {
  int? id;
  int? adSpacePrice;
  int? giftVoicePrice;
  int? giftImagePrice;
  int? giftVedioPrice;
  int? advertisingPriceFrom;
  int? advertisingPriceTo;

  Price(
      {this.id,
        this.adSpacePrice,
        this.giftVoicePrice,
        this.giftImagePrice,
        this.giftVedioPrice,
        this.advertisingPriceFrom,
        this.advertisingPriceTo});

  Price.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adSpacePrice = json['ad_space_price'];
    giftVoicePrice = json['gift_voice_price'];
    giftImagePrice = json['gift_image_price'];
    giftVedioPrice = json['gift_vedio_price'];
    advertisingPriceFrom = json['advertising_price_from'];
    advertisingPriceTo = json['advertising_price_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ad_space_price'] = this.adSpacePrice;
    data['gift_voice_price'] = this.giftVoicePrice;
    data['gift_image_price'] = this.giftImagePrice;
    data['gift_vedio_price'] = this.giftVedioPrice;
    data['advertising_price_from'] = this.advertisingPriceFrom;
    data['advertising_price_to'] = this.advertisingPriceTo;
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