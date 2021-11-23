// To parse this JSON data, do
//
//     final rentalroomModel = rentalroomModelFromJson(jsonString);

import 'dart:convert';

RentalroomModel rentalroomModelFromJson(String str) => RentalroomModel.fromJson(json.decode(str));

String rentalroomModelToJson(RentalroomModel data) => json.encode(data.toJson());

class RentalroomModel {
  RentalroomModel({
    this.rentalroom,
  });

  List<Rentalroom> rentalroom;

  factory RentalroomModel.fromJson(Map<String, dynamic> json) => RentalroomModel(
    rentalroom: List<Rentalroom>.from(json["rentalroom"].map((x) => Rentalroom.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rentalroom": List<dynamic>.from(rentalroom.map((x) => x.toJson())),
  };
}

class Rentalroom {
  Rentalroom({
    this.rentalroomId,
    this.rentalroomName,
    this.rentalroomPrice,
    this.rentalroomNameLocation,
    this.rentalroomLatitude,
    this.rentalroomLongitude,
    this.rentalroomPhone,
    this.rentalroomLimitedroomSex,
    this.rentalroomApprove,
    this.rentalroomFacilities,
    this.categoryId,
    this.memberId,
    this.picId,
    this.picture,
    this.categoryName,
    this.categoryImage,
  });

  String rentalroomId;
  String rentalroomName;
  String rentalroomPrice;
  String rentalroomNameLocation;
  String rentalroomLatitude;
  String rentalroomLongitude;
  String rentalroomPhone;
  String rentalroomLimitedroomSex;
  String rentalroomApprove;
  String rentalroomFacilities;
  String categoryId;
  String memberId;
  String picId;
  String picture;
  String categoryName;
  String categoryImage;

  factory Rentalroom.fromJson(Map<String, dynamic> json) => Rentalroom(
    rentalroomId: json["rentalroom_id"],
    rentalroomName: json["rentalroom_name"],
    rentalroomPrice: json["rentalroom_price"],
    rentalroomNameLocation: json["rentalroom_name_location"],
    rentalroomLatitude: json["rentalroom_latitude"],
    rentalroomLongitude: json["rentalroom_longitude"],
    rentalroomPhone: json["rentalroom_phone"],
    rentalroomLimitedroomSex: json["rentalroom_limitedroom_sex"],
    rentalroomApprove: json["rentalroom_approve"],
    rentalroomFacilities: json["rentalroom_facilities"],
    categoryId: json["category_id"],
    memberId: json["member_id"],
    picId: json["pic_id"],
    picture: json["picture"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "rentalroom_id": rentalroomId,
    "rentalroom_name": rentalroomName,
    "rentalroom_price": rentalroomPrice,
    "rentalroom_name_location": rentalroomNameLocation,
    "rentalroom_latitude": rentalroomLatitude,
    "rentalroom_longitude": rentalroomLongitude,
    "rentalroom_phone": rentalroomPhone,
    "rentalroom_limitedroom_sex": rentalroomLimitedroomSex,
    "rentalroom_approve": rentalroomApprove,
    "rentalroom_facilities": rentalroomFacilities,
    "category_id": categoryId,
    "member_id": memberId,
    "pic_id": picId,
    "picture": picture,
    "category_name": categoryName,
    "category_image": categoryImage,
  };
}
