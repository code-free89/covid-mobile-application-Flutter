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
  });

  void fromJson(Map<String, dynamic> json) {
    this.email = json["email"];
    this.name = json["name"];
    this.phoneNumber = json["phoneNumber"];
    this.passportNo = json["passportNo"];
    this.age = json["age"];
    this.gender = json["gender"];
    this.ethnity = json["ethnity"];
    this.address = json["address"];
    this.postcode = json["postcode"];
    this.state = json["state"];
    this.isVerified = json["isVerified"];
    this.isFirstTimeLogin = json["isFirstTimeLogin"];
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
    };
  }
}
