class ProfileModel {
  int? status;
  String? msg;
  ProfileInfo? data;

  ProfileModel({this.status, this.msg, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new ProfileInfo.fromJson(json['data']) : null;
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

class ProfileInfo {
  String? userId;
  String? name;
  String? mobile;
  String? district;
  String? mandal;
  String? village;
  String? status;
  String? isVerify;
  String? userType;
  String? district_id;
  String? mandal_id;
  String? village_id;

  ProfileInfo(
      {this.userId,
        this.name,
        this.mobile,
        this.district,
        this.mandal,
        this.village,
        this.status,
        this.isVerify,
        this.userType,
        this.district_id,
        this.mandal_id,
        this.village_id,


      });

  ProfileInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    district = json['district'];
    mandal = json['mandal'];
    village = json['village'];
    status = json['status'];
    isVerify = json['is_verify'];
    userType = json['user_type'];
    district_id = json['district_id'];
    mandal_id = json['mandal_id'];
    village_id = json['village_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['district'] = this.district;
    data['mandal'] = this.mandal;
    data['village'] = this.village;
    data['status'] = this.status;
    data['is_verify'] = this.isVerify;
    data['user_type'] = this.userType;
    data['district_id'] = this.district_id;
    data['mandal_id'] = this.mandal_id;
    data['village_id'] = this.village_id;
    return data;
  }
}
