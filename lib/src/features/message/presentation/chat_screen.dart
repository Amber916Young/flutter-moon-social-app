import 'package:flutter/material.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';

class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen({Key? key}) : super(key: key);

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        pageIndex: 3,
        showDrawer: true,
        endDrawerEnableOpenDragGesture: true,
        appBar: CustomAppBar(
          context: context,
          isBackButtonExist: false,
          title: "",
          flexibleSpace: SafeArea(
              child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kriss Benwat",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          )),
        ),
        body: Column(
          children: [],
        ));
  }
}
