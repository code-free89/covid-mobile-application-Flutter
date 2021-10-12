class DependentData {
  String id;
  String address;
  String age;
  String gender;
  String name;
  String passport;
  String postcode;
  String relation;
  String state;
  String user_id;
  bool vaccineDependency;

  DependentData({
    this.id = "",
    this.address = "",
    this.age = "",
    this.gender = "",
    this.name = "",
    this.passport = "",
    this.postcode = "",
    this.relation = "",
    this.state = "",
    this.user_id = "",
    this.vaccineDependency = false,
  });

  void fromJson(Map<String, dynamic> json) {
    this.id = json["id"] ?? "";
    this.address = json["address"] ?? "";
    this.age = json["address"] ?? "";
    this.gender = json["gender"] ?? "";
    this.name = json["name"] ?? "";
    this.passport = json["passport"] ?? "";
    this.postcode = json["postcode"] ?? "";
    this.relation = json["relation"] ?? "";
    this.state = json["state"] ?? "";
    this.user_id = json["user_id"] ?? "";
    this.vaccineDependency = json["vaccineDependency"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "address": this.address,
      "age": this.age,
      "gender": this.gender,
      "name": this.name,
      "passport": this.passport,
      "postcode": this.postcode,
      "relation": this.relation,
      "state": this.state,
      "user_id": this.user_id,
      "vaccineDependency": this.vaccineDependency,
    };
  }
}
