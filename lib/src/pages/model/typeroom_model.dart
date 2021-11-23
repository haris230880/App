// To parse this JSON data, do
//
//     final typeRoomModel = typeRoomModelFromJson(jsonString);

import 'dart:convert';

TypeRoomModel typeRoomModelFromJson(String str) => TypeRoomModel.fromJson(json.decode(str));

String typeRoomModelToJson(TypeRoomModel data) => json.encode(data.toJson());

class TypeRoomModel {
  TypeRoomModel({
    this.categorys,
  });

  List<Category> categorys;

  factory TypeRoomModel.fromJson(Map<String, dynamic> json) => TypeRoomModel(
    categorys: List<Category>.from(json["categorys"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categorys": List<dynamic>.from(categorys.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
  });

  String categoryId;
  String categoryName;
  String categoryImage;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_image": categoryImage,
  };
}
