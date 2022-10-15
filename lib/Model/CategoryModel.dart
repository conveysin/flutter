class CategoryModel {
  int? status;
  String? msg;
  // CategoryInfo? data;

  CategoryModel({this.status, this.msg});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['msg'] = this.msg;
  //   // if (this.data != null) {
  //   //   data['data'] = this.data!.toJson();
  //   // }
  //   // return data;
  // }

}

// class CategoryInfo {
//   String? id;
//   String? name;
//   String? logo;

//   CategoryInfo(
//       {this.id,
//         this.name,
//         this.logo,
//       });

//   CategoryInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     logo = json['logo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['logo'] = this.logo;
//     return data;
//   }
// }
