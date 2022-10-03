class VerifyUserOtp {
  int? status;
  String? msg;
  Data? data;

  VerifyUserOtp({this.status, this.msg, this.data});

  VerifyUserOtp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? mobile;
  String? district;
  String? mandal;
  String? village;
  String? villageId;
  String? sponserName;
  String? userType;

  Data(
      {this.name,
        this.mobile,
        this.district,
        this.mandal,
        this.village,
        this.villageId,
        this.sponserName,
        this.userType});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    district = json['district'];
    mandal = json['mandal'];
    village = json['village'];
    villageId = json['village_id'];
    sponserName = json['sponser_name'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['district'] = this.district;
    data['mandal'] = this.mandal;
    data['village'] = this.village;
    data['village_id'] = this.villageId;
    data['sponser_name'] = this.sponserName;
    data['user_type'] = this.userType;
    return data;
  }
}
