class SignupModel {
  int? status;
  String? msg;
  SignupData? data;

  SignupModel({this.status, this.msg, this.data});

  SignupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new SignupData.fromJson(json['data']) : null;
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

class SignupData {
  int? userId;
  int? otp;

  SignupData({this.userId, this.otp});

  SignupData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['otp'] = this.otp;
    return data;
  }
}
