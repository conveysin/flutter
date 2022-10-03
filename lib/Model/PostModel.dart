class PostModel {
  int? status;
  String? msg;
  List<PostData>? data;

  PostModel({this.status, this.msg, this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(new PostData.fromJson(v));
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

class PostData {
  String? postImage;
  String? contentEnglish;
  String? contentTelgu;
  String? post_date;
  String? post_author;
  String? post_id;
  int? likes;
  int? views;
  bool? isLike;
  bool? is_view;

  PostData(
      {this.postImage,
        this.contentEnglish,
        this.contentTelgu,
        this.post_date,
        this.post_author,
        this.post_id,
        this.likes,
        this.views,
        this.isLike,
        this.is_view,
      });

  PostData.fromJson(Map<String, dynamic> json) {
    postImage = json['post_image'];
    contentEnglish = json['content_english'];
    contentTelgu = json['content_telgu'];
    post_date = json['post_date'];
    post_author = json['post_author'];
    post_id = json['post_id'];
    likes = json['likes'];
    views = json['views'];
    isLike = json['is_like'];
    is_view = json['is_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_image'] = this.postImage;
    data['content_english'] = this.contentEnglish;
    data['content_telgu'] = this.contentTelgu;
    data['post_date'] = this.post_date;
    data['post_author'] = this.post_author;
    data['post_id'] = this.post_id;
    data['likes'] = this.likes;
    data['views'] = this.views;
    data['isLike'] = this.isLike;
    data['is_view'] = this.is_view;
    return data;
  }
}
