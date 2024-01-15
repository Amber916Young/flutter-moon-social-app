class PostModel {
  String? username;
  List<String>? imageUrls;
  String? postTime;
  String? title;
  String? brief;
  List<String>? tags;
  int? hitLikes;
  int? comments;

  PostModel(
      {this.username,
        this.imageUrls,
        this.postTime,
        this.title,
        this.brief,
        this.tags,
        this.hitLikes,
        this.comments});

  PostModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    imageUrls = json['imageUrls'].cast<String>();
    postTime = json['postTime'];
    title = json['title'];
    brief = json['brief'];
    tags = json['tags'].cast<String>();
    hitLikes = json['hitLikes'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['imageUrls'] = this.imageUrls;
    data['postTime'] = this.postTime;
    data['title'] = this.title;
    data['brief'] = this.brief;
    data['tags'] = this.tags;
    data['hitLikes'] = this.hitLikes;
    data['comments'] = this.comments;
    return data;
  }
}