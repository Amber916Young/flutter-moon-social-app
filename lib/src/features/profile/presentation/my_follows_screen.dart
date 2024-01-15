import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/component/custom_text_field.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'dart:io';

class MyFriendsScreen extends StatefulWidget {
  const MyFriendsScreen({Key? key}) : super(key: key);

  @override
  State<MyFriendsScreen> createState() => _MyFriendsScreenState();
}

class _MyFriendsScreenState extends State<MyFriendsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  late bool _isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return PortalMasterLayout(
        pageIndex: 4,
        showDrawer: true,
        endDrawerEnableOpenDragGesture: true,
        key: _scaffoldKey,
        showBottomBar: false,
        appBar: CustomAppBar(context: context, title: getTranslated('my_favourite', context)),
        body: SafeArea(
            child: CustomScrollView(
          slivers: [],
        )));
  }
}
