import 'package:flutter/material.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/Circle_indicator.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:moon/src/features/message/data/model/chat_user.dart';
import 'package:moon/src/features/message/presentation/widget/conversation_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  List<ChatUsers> chatUsers = [];

  @override
  void initState() {
    super.initState();
    chatUsers = [
      ChatUsers(username: "Jane Russel", messageText: "Awesome Setup", imageUrl: "images/userImage1.jpeg", time: "Now", unread: 3),
      ChatUsers(username: "Glady's Murphy", messageText: "That's Great", imageUrl: "images/userImage2.jpeg", time: "Yesterday", unread: 0),
      ChatUsers(username: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageUrl: "images/userImage4.jpeg", time: "28 Mar", unread: 0),
      ChatUsers(username: "John Wick", messageText: "How are you?", imageUrl: "images/userImage8.jpeg", time: "18 Feb", unread: 0),
    ];
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(labelPadding: const EdgeInsets.only(left: 20, right: 20), controller: _tabController, labelColor: Theme.of(context).primaryColor, unselectedLabelColor: Theme.of(context).unselectedWidgetColor, isScrollable: true, indicatorSize: TabBarIndicatorSize.label, indicator: CircleTabIndicator(), tabs: [
              Tab(
                  icon: Row(
                children: [
                  Icon(
                    Icons.offline_bolt_outlined,
                    size: 20,
                  ),
                  Text("官方"),
                ],
              )),
              Tab(
                  icon: Row(
                children: [
                  Icon(
                    Icons.girl,
                    size: 20,
                  ),
                  Text("好友"),
                ],
              )),
              Tab(text: "未知"),
            ]),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
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
              SizedBox(),
              SizedBox(),
            ],
          ),
        ),
      ]),
    );
  }
}
