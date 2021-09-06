import 'package:flutter/material.dart';

class UserData {
  String email;
  String name;
  String phoneNumber;
  String passportNo;
  int age;
  String gender;
  String ethnity;
  String address;
  String postcode;
  String state;
  bool isVerified;
  bool isFirstTimeLogin;
  String dose1;
  String dose2;
  String dose1_date;
  String dose2_date;
  String last_checkin;
  String last_checkin_address;

  UserData({
    this.email = "",
    this.name = "",
    this.phoneNumber = "",
    this.passportNo = "",
    this.age = 0,
    this.gender = "",
    this.ethnity = "",
    this.address = "",
    this.postcode = "",
    this.state = "",
    this.isVerified = false,
    this.isFirstTimeLogin = true,
    this.dose1 = "",
    this.dose2 = "",
    this.dose1_date = "",
    this.dose2_date = "",
    this.last_checkin = "",
    this.last_checkin_address = "",
  });

  void fromJson(Map<String, dynamic> json) {
    this.email = json["email"] ?? "";
    this.name = json["name"] ?? "";
    this.phoneNumber = json["phoneNumber"] ?? "";
    this.passportNo = json["passportNo"] ?? "";
    this.age = json["age"] ?? "";
    this.gender = json["gender"] ?? "";
    this.ethnity = json["ethnity"] ?? "";
    this.address = json["address"] ?? "";
    this.postcode = json["postcode"] ?? "";
    this.state = json["state"] ?? "";
    this.isVerified = json["isVerified"] ?? "";
    this.isFirstTimeLogin = json["isFirstTimeLogin"] ?? "";
    this.dose1 = json["dose1"] ?? "";
    this.dose1_date = json["dose1_date"] ?? "";
    this.dose2 = json["dose2"] ?? "";
    this.dose2_date = json["dose2_date"] ?? "";
    this.last_checkin = json["last_checkin"] ?? "";
    this.last_checkin_address = json["last_checkin_address"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "name": this.name,
      "phoneNumber": this.phoneNumber,
      "passportNo": this.passportNo,
      "age": this.age,
      "gender": this.gender,
      "ethnity": this.ethnity,
      "address": this.address,
      "postcode": this.postcode,
      "state": this.state,
      "isVerified": this.isVerified,
      "isFirstTimeLogin": this.isFirstTimeLogin,
      "dose1": this.dose1,
      "dose1_date": this.dose1_date,
      "dose2": this.dose2,
      "dose2_date": this.dose2_date,
      "last_checkin": this.last_checkin,
      "last_checkin_address": this.last_checkin_address,
    };
  }
}
