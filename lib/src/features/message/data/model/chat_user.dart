class ChatUsers {
  String? username;
  String? messageText;
  String? imageUrl;
  String? time;
  int? unread;
  ChatUsers({this.username, this.messageText, this.imageUrl, this.time, this.unread});
  ChatUsers.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    messageText = json['messageText'].cast<String>();
    imageUrl = json['imageUrl'];
    time = json['time'];
    unread = json['unread'];
  }
}
