class DepartmentModel {
  int? status;
  String? msg;
  Data? data;

  DepartmentModel({this.status, this.msg, this.data});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
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
  String? sponserName;
  List<DepartmentData>? data;

  Data({this.sponserName, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    sponserName = json['sponser_name'];
    if (json['data'] != null) {
      data = <DepartmentData>[];
      json['data'].forEach((v) {
        data!.add(new DepartmentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sponser_name'] = this.sponserName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DepartmentData {
  String? id;
  String? name;
  String? logo;
  int? unread_post_count;

  DepartmentData({this.id, this.name, this.logo,this.unread_post_count});

  DepartmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    unread_post_count = json['unread_post_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['unread_post_count'] = this.unread_post_count;
    return data;
  }
}
