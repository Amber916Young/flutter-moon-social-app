class CommentModel {
  final String author;
  final String avatar;
  final String content;
  final int likes;
  final int userComments;
  final String commentTime;
  final List<CommentModel> subComments;

  CommentModel({
    required this.author,
    required this.avatar,
    required this.content,
    required this.likes,
    required this.userComments,
    required this.commentTime,
    required this.subComments,
  });
}

enum SortOrder {
  time,
  likes,
}
