class CheckInHistoryData {
  String location;
  String date;
  String user_id;

  CheckInHistoryData({
    this.location = "",
    this.date = "",
    this.user_id = "",
  });

  void fromJson(Map<String, dynamic> json) {
    this.location = json["location"] ?? "";
    this.date = json["date"] ?? "";
    this.user_id = json["user_id"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "location": this.location,
      "date": this.date,
      "user_id": this.user_id,
    };
  }
}
