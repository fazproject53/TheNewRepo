import 'dart:convert';
import 'package:http/http.dart' as http;



class Section {
  bool? success;
  List<Data>? data;
  Message? message;

  Section({this.success, this.data, this.message});

  Section.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Data {
  String? sectionName;
  String? title;
  String? titleEn;
  String? value;
  String? valueEn;
  int? categoryId;
  int? active;

  Data(
      {this.sectionName,
      this.title,
      this.titleEn,
      this.value,
      this.valueEn,
      this.categoryId,
      this.active});

  Data.fromJson(Map<String, dynamic> json) {
    sectionName = json['section_name'];
    title = json['title'];
    titleEn = json['title_en'];
    value = json['value'];
    valueEn = json['value_en'];
    categoryId = json['category_id'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_name'] = this.sectionName;
    data['title'] = this.title;
    data['title_en'] = this.titleEn;
    data['value'] = this.value;
    data['value_en'] = this.valueEn;
    data['category_id'] = this.categoryId;
    data['active'] = this.active;
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

// partners =========================================================================================================================================================

class Partner {
  bool? success;
  DataPartner? data;
  MessagePartner? message;

  Partner({this.success, this.data, this.message});

  Partner.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataPartner.fromJson(json['data']) : null;
    message = json['message'] != null
        ? new MessagePartner.fromJson(json['message'])
        : null;
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

class DataPartner {
  int? active;
  List<Partners>? partners;

  DataPartner({this.active, this.partners});

  DataPartner.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    if (json['partners'] != null) {
      partners = <Partners>[];
      json['partners'].forEach((v) {
        partners!.add(new Partners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    if (this.partners != null) {
      data['partners'] = this.partners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Partners {
  String? link;
  String? image;

  Partners({this.link, this.image});

  Partners.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['image'] = this.image;
    return data;
  }
}

class MessagePartner {
  String? en;
  String? ar;

  MessagePartner({this.en, this.ar});

  MessagePartner.fromJson(Map<String, dynamic> json) {
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

// header ============================================================================================================================================

class header {
  bool? success;
  DataHeader? data;
  MessageHeader? message;

  header({this.success, this.data, this.message});

  header.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataHeader.fromJson(json['data']) : null;
    message = json['message'] != null
        ? new MessageHeader.fromJson(json['message'])
        : null;
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

class DataHeader {
  int? active;
  List<Header>? header;

  DataHeader({this.active, this.header});

  DataHeader.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    if (json['header'] != null) {
      header = <Header>[];
      json['header'].forEach((v) {
        header!.add(new Header.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    if (this.header != null) {
      data['header'] = this.header!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Header {
  String? title;
  String? titleEn;
  String? image;

  Header({this.title, this.titleEn, this.image});

  Header.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleEn = json['title_en'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['title_en'] = this.titleEn;
    data['image'] = this.image;
    return data;
  }
}

class MessageHeader {
  String? en;
  String? ar;

  MessageHeader({this.en, this.ar});

  MessageHeader.fromJson(Map<String, dynamic> json) {
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

// links =================================================================================================================

class link {
  bool? success;
  DataLink? data;
  MessageLink? message;

  link({this.success, this.data, this.message});

  link.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataLink.fromJson(json['data']) : null;
    message = json['message'] != null
        ? new MessageLink.fromJson(json['message'])
        : null;
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

class DataLink {
  int? active;
  List<Links>? links;

  DataLink({this.active, this.links});

  DataLink.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String? link;
  String? title;
  String? titleEn;

  Links({this.link, this.title, this.titleEn});

  Links.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    title = json['title'];
    titleEn = json['title_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['title'] = this.title;
    data['title_en'] = this.titleEn;
    return data;
  }
}

class MessageLink {
  String? en;
  String? ar;

  MessageLink({this.en, this.ar});

  MessageLink.fromJson(Map<String, dynamic> json) {
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

// categories ====================================================================================================================================

class Category {
  bool? success;
  DataCategory? data;
  MessageCategory? message;

  Category({this.success, this.data, this.message});

  Category.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? new DataCategory.fromJson(json['data']) : null;
    message = json['message'] != null
        ? new MessageCategory.fromJson(json['message'])
        : null;
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

class DataCategory {
  int? active;
  TheCategory? category;
  List<Celebrities>? celebrities;

  DataCategory({this.active, this.category, this.celebrities});

  DataCategory.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    category = json['category'] != null
        ? new TheCategory.fromJson(json['category'])
        : null;
    if (json['celebrities'] != null) {
      celebrities = <Celebrities>[];
      json['celebrities'].forEach((v) {
        celebrities!.add(new Celebrities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.celebrities != null) {
      data['celebrities'] = this.celebrities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TheCategory {
  String? name;
  String? nameEn;

  TheCategory({this.name, this.nameEn});

  TheCategory.fromJson(Map<String, dynamic> json) {
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

class Celebrities {
  String? name;
  String? image;
  String? email;
  String? phonenumber;

  Celebrities({this.name, this.image, this.email, this.phonenumber});

  Celebrities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phonenumber = json['phonenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    return data;
  }
}

class MessageCategory {
  String? en;
  String? ar;

  MessageCategory({this.en, this.ar});

  MessageCategory.fromJson(Map<String, dynamic> json) {
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

// the fetch functions ===================================================================================

Future<link> fetchLinks() async {
  final response =
      await http.get(Uri.parse('http://mobile.celebrityads.net/api/links'));

  if (response.statusCode == 200) {
    final body = response.body;

    link link_ = link.fromJson(jsonDecode(body));
    print("------------Reading link from network");
    return link_;
  } else {
    throw Exception('Failed to lode link ');
  }
}

//---------------------------------------------------------------------------
Future<header> fetchHeader() async {
  final response =
      await http.get(Uri.parse('http://mobile.celebrityads.net/api/header'));

  if (response.statusCode == 200) {
    final body = response.body;

    header header_ = header.fromJson(jsonDecode(body));
    print("Reading header from network------------");
    return header_;
  } else {
    throw Exception('Failed to load header');
  }
}

//--------------------------------------------------------------------
Future<Partner> fetchPartners() async {
  final response =
      await http.get(Uri.parse('http://mobile.celebrityads.net/api/partners'));

  if (response.statusCode == 200) {
    final body = response.body;
    Partner partner = Partner.fromJson(jsonDecode(body));
    print("Reading Partners from network------------ ");
    return partner;
  } else {
    throw Exception('Failed to load Partners');
  }
}

//------------------------------------------------------------------------
Future<Category> fetchCategories(int id, int pagNumber) async {
  final response = await http.get(Uri.parse(
      'http://mobile.celebrityads.net/api/category/celebrities/$id?page=$pagNumber'));
  if (response.statusCode == 200) {
    final body = response.body;
    Category category = Category.fromJson(jsonDecode(body));
    print("Reading category from network------------ ");
    return category;
  } else {
    throw Exception('Failed to load Category');
  }
}


