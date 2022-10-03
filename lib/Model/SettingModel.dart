class SettingModel {
  int? status;
  String? msg;
  List<SettingData>? data;

  SettingModel({this.status, this.msg, this.data});

  SettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <SettingData>[];
      json['data'].forEach((v) {
        data!.add(new SettingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SettingData {
  String? logo;
  String? splashScreen;
  bool is_editor=false;

  SettingData({this.logo, this.splashScreen,required this.is_editor});

  SettingData.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    splashScreen = json['splash_screen'];
    is_editor = json['is_editor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['splash_screen'] = this.splashScreen;
    data['is_editor'] = this.is_editor;
    return data;
  }
}
