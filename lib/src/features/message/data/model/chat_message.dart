class ChatMessageModel {
  String? messageContent;
  String? messageType;
  ChatMessageModel({this.messageContent, this.messageType});
  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    messageContent = json['messageContent'];
    messageType = json['messageType'];
  }
}
