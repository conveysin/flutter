class LoginModel {
  int? status;
  String? msg;
  LoginData? data;

  LoginModel({this.status, this.msg, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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

class LoginData {
  String? name;
  String? mobile;
  String? district;
  String? mandal;
  String? village;
  String? status;
  String? mobileVerify;
  String? userType;
  String? is_verify;
  String? user_id;
  String? village_id;

  LoginData(
      {this.name,
        this.mobile,
        this.district,
        this.mandal,
        this.village,
        this.status,
        this.mobileVerify,
        this.userType,
        this.is_verify,
        this.user_id,
        this.village_id,

      });

  LoginData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    district = json['district'];
    mandal = json['mandal'];
    village = json['village'];
    status = json['status'];
    mobileVerify = json['mobile_verify'];
    userType = json['user_type'];
    is_verify = json['is_verify'];
    user_id = json['user_id'];
    village_id = json['village_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['district'] = this.district;
    data['mandal'] = this.mandal;
    data['village'] = this.village;
    data['status'] = this.status;
    data['mobile_verify'] = this.mobileVerify;
    data['user_type'] = this.userType;
    data['is_verify'] = this.is_verify;
    data['user_id'] = this.user_id;
    data['village_id'] = this.village_id;
    return data;
  }
}
