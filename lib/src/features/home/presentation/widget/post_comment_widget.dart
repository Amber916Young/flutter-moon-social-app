import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/helper/date_converter.dart';
import 'package:moon/src/features/home/data/model/comment_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCommentWidget extends StatefulWidget {
  final CommentModel comment;

  PostCommentWidget(this.comment);

  @override
  _PostCommentWidgetState createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends State<PostCommentWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    DateTime start0 = DateConverter.convertStringToDatetime(widget.comment.commentTime);
    String timePost = timeago.format(start0);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.comment.avatar),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      Text(
                        widget.comment.author,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    '${timePost}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Text(
                widget.comment.content,
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Icon(Icons.favorite, color: Colors.red),
                  ),
                  Text('${widget.comment.likes}'),
                  SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Icon(Icons.comment),
                  ),
                  Text('${widget.comment.userComments}'),
                  SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.reply_rounded),
                  ),
                  Text('Reply'),
                ],
              ),
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          isExpanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: Color.fromRGBO(141, 141, 141, 0.5),
                      height: 0.5,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    if (widget.comment.subComments.length > 2)
                      Column(
                        children: [
                          SubCommentWidget(widget.comment.subComments[0]),
                          SubCommentWidget(widget.comment.subComments[1]),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text('View ${widget.comment.subComments.length - 2} more comments'),
                          ),
                        ],
                      )
                    else
                      for (var subComment in widget.comment.subComments) SubCommentWidget(subComment),
                  ],
                )
              : Container(),
          const SizedBox(height: Dimensions.paddingSizeDefault),
        ],
      ),
    );
  }
}

class SubCommentWidget extends StatelessWidget {
  final CommentModel subComment;

  SubCommentWidget(this.subComment);

  @override
  Widget build(BuildContext context) {
    DateTime subCommentTime = DateConverter.convertStringToDatetime(subComment.commentTime);
    String timeSubComment = timeago.format(subCommentTime);

    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraLarge, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeExtraSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(subComment.avatar),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  Text(
                    subComment.author,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                '${timeSubComment}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Text(subComment.content),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(
            children: [
              Icon(Icons.favorite, color: ColorResources.failColor),
              Text('${subComment.likes} Likes'),
              SizedBox(width: 8.0),
              InkWell(
                onTap: () {},
                child: Icon(Icons.reply_rounded),
              ),
              Text('Reply'),
            ],
          ),
          const Divider(
            color: Color.fromRGBO(141, 141, 141, 0.5),
            height: 0.5,
          ),
        ],
      ),
    );
  }
}
