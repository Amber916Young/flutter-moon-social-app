import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/component/custom_text_field.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:moon/src/core/component/tag_icon.dart';
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
  FocusNode? _searchFocus;
  TextEditingController? _searchController;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: CustomAppBar(context: context, title: getTranslated('my_friends', context)),
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverDelegateCategory(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    width: MediaQuery.of(context).size.width -
                        (ResponsiveHelper.isDesktop(context)
                            ? 350
                            : ResponsiveHelper.isTab(context)
                                ? 300
                                : 0),
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.radiusExtraSmall),
                    child: CustomTextField(
                      hintText: getTranslated('search', context),
                      isShowBorder: true,
                      isPassword: false,
                      isShowSuffixIcon: true,
                      prefixIconUrl: Images.search,
                      focusNode: _searchFocus,
                      controller: _searchController,
                      inputAction: TextInputAction.done,
                      isSearch: true,
                    ),
                  ),
                ]),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(children: [
                    ListTile(
                      title: Row(children: [
                        Text("用户 $index"),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          ),
                          child: TagWithIcon(
                            tagText: 'Lv.$index',
                            color: Theme.of(context).hoverColor,
                          ),
                        ),
                      ]),
                      subtitle: Text("这是描述这是描述这是描述这是描述这是描述"),
                      leading: CircleAvatar(
                        radius: 38,
                        backgroundImage: AssetImage(Images.logo),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).hoverColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraExtraSmall),
                        child: Text("互相关注"),
                      ),
                    ),
                    Divider(thickness: 1, indent: 20, endIndent: 20),
                  ]);
                },
                childCount: 20,
              ),
            ),
          ],
        ));
  }
}

class SliverDelegateCategory extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegateCategory({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegateCategory oldDelegate) {
    return oldDelegate.maxExtent != 70 || oldDelegate.minExtent != 70 || child != oldDelegate.child;
  }
}
