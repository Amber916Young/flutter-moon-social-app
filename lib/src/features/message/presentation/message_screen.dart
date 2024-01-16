import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:moon/src/features/message/data/model/chat_user.dart';
import 'package:moon/src/features/message/widget/conversation_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<ChatUsers> chatUsers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatUsers = [
      ChatUsers(username: "Jane Russel", messageText: "Awesome Setup", imageUrl: "images/userImage1.jpeg", time: "Now", unread: 3),
      ChatUsers(username: "Glady's Murphy", messageText: "That's Great", imageUrl: "images/userImage2.jpeg", time: "Yesterday", unread: 0),
      ChatUsers(username: "Jorge Henry", messageText: "Hey where are you?", imageUrl: "images/userImage3.jpeg", time: "31 Mar", unread: 4),
      ChatUsers(username: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageUrl: "images/userImage4.jpeg", time: "28 Mar", unread: 0),
      ChatUsers(username: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageUrl: "images/userImage5.jpeg", time: "23 Mar", unread: 0),
      ChatUsers(username: "Jacob Pena", messageText: "will update you in evening", imageUrl: "images/userImage6.jpeg", time: "17 Mar", unread: 0),
      ChatUsers(username: "Andrey Jones", messageText: "Can you please share the file?", imageUrl: "images/userImage7.jpeg", time: "24 Feb", unread: 0),
      ChatUsers(username: "John Wick", messageText: "How are you?", imageUrl: "images/userImage8.jpeg", time: "18 Feb", unread: 0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
      pageIndex: 3,
      showDrawer: true,
      endDrawerEnableOpenDragGesture: true,
      appBar: CustomAppBar(
        context: context,
        title: getTranslated('my_message', context),
        isBackButtonExist: false,
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationListWidget(
                  username: chatUsers[index].username!,
                  messageText: chatUsers[index].messageText!,
                  imageUrl: chatUsers[index].imageUrl!,
                  time: chatUsers[index].time!,
                  unread: chatUsers[index].unread!,
                );
              },
            ),
          ])),
    );
  }
}
