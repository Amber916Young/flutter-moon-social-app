import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_comment_dialog.dart';
import 'package:moon/src/core/component/tag_icon.dart';
import 'package:moon/src/core/component/text_widget.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/route/routes.dart';
import 'package:moon/src/features/auth/data/model/userinfo_model.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:moon/src/features/profile/presentation/my_friends_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int active = 0;
  void _showCommentPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomCommentPopup(); // Custom CommentBottomSheet widget
      },
    );
  }

  Widget _buildImage(String imageUrl, int count) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = (screenWidth - 2 * Dimensions.paddingSizeLarge - 2 * 12) / count;
    return FadeInImage.assetNetwork(
      placeholder: Images.placeholderImage,
      height: imageWidth,
      width: imageWidth,
      fit: BoxFit.cover,
      image: imageUrl,
      imageErrorBuilder: (context, error, stackTrace) => Image.asset(Images.placeholderImage, height: imageWidth / 2, width: imageWidth / 2, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return PortalMasterLayout(
      pageIndex: 0,
      showDrawer: true,
      endDrawerEnableOpenDragGesture: true,
      key: _scaffoldKey,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '同声',
                  style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: ColorResources.refundColor),
                ),
                const SizedBox(
                  width: Dimensions.paddingSizeDefault,
                ),
                Text('互助', style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge))
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 25),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.edit_outlined, size: 25),
          onPressed: () {},
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            return Future.delayed(const Duration(seconds: 2));
          },
          backgroundColor: Theme.of(context).primaryColor,
          color: Colors.white,
          child: CustomScrollView(slivers: [
            // SliverPersistentHeader(
            //   pinned: true,
            //   delegate: SliverDelegateCategory(
            //     child: Container(
            //       width: 80,
            //       height: 50,
            //       padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            //       child: TabBar(
            //         isScrollable: true,
            //         tabAlignment: TabAlignment.start,
            //         controller: _tabController,
            //         tabs: [
            //           Tab(
            //             child: Text("关注"),
            //           ),
            //           Tab(
            //             child: Text(
            //               "发现",
            //               style: textBold,
            //             ),
            //           ),
            //           Tab(
            //             child: Text("官方"),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.homeDetailScreen);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            enabled: false,
                            leading: CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage(Images.logo),
                            ),
                            title: Text(
                              getTranslated('nick_name', context)!,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            subtitle: Text(
                              "今天 11:36",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            trailing: const Icon(
                              Icons.menu,
                              size: 20,
                            ),
                            selected: false,
                            onTap: () {},
                          ),
                          // tags
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                            child: Container(
                              width: 120,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraExtraSmall),
                              decoration: BoxDecoration(
                                color: ColorResources.refundColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.wine_bar_outlined, color: ColorResources.refundColor),
                                  Text(
                                    "女权思考",
                                    style: textMedium.copyWith(color: ColorResources.refundColor),
                                  ),
                                  Icon(Icons.arrow_right_rounded, color: ColorResources.refundColor),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.paddingSizeSmall,
                          ),
                          // Title maxline 1
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                            child: Text(
                              "这是标题这是标题这是标题这是标题这是标题这是标题这是标是标题这是标题这是标是标题这是标题这是标题",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                          // content maxline 5
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                            child: Text(
                                "Flutter的生态系统相对较小，这是因为Flutter是一个较新的框架，相对于React Native或Ionic等其他框架而言，Flutter的开发者数量和用户群体较少，其社区和生态系统相对薄弱。这使得一些开发者可能会发现在使用Flutter开发应用程序时，需要花费更多的时间和精力去解决问题，或者自己编写某些必要的功能。然而，随着Flutter的不断发展和壮大，其社区和生态系统也在逐渐扩大和完善，未来可能会有更多的第三方库和工具出现，"
                                "更多的开发者会参与到Flutter的开发中来，这有助于提升Flutter的生态系统。",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: textMedium),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                  child: Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: [
                                      _buildImage('https://i.imgur.com/H83Bqeu.png', 3),
                                      _buildImage('https://i.imgur.com/r6vIrtL.png', 3),
                                      _buildImage('https://i.imgur.com/A7ksSCa.jpg', 3),
                                    ],
                                  )),
                            ],
                          ),

                          SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120,
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraExtraSmall),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.volunteer_activism_outlined,
                                      ),
                                      Text("女权思考", style: textMedium),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_outlined,
                                          color: ColorResources.amberColor,
                                        ),
                                        Text("1", style: textRegular),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Dimensions.paddingSizeSmall,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_border_outlined,
                                          color: ColorResources.failColor,
                                        ),
                                        Text("1", style: textRegular),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Dimensions.paddingSizeSmall,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          // click to comment
                                          _showCommentPopup(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.message_outlined,
                                              color: Theme.of(context).hintColor,
                                            ),
                                            Text("4", style: textRegular),
                                          ],
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // row tag  three clickable icons
                    Divider(thickness: 2, indent: 0, endIndent: 0),

                    ListTile(
                      enabled: false,
                      leading: CircleAvatar(
                        radius: 38,
                        backgroundImage: AssetImage(Images.pinterest),
                      ),
                      title: Text(
                        "number2",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      subtitle: Text(
                        "昨天 06：23",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      trailing: const Icon(
                        Icons.menu,
                        size: 20,
                      ),
                      selected: false,
                      onTap: () {},
                    ),
                    // tags
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraExtraSmall),
                        decoration: BoxDecoration(
                          color: ColorResources.footerColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.wb_sunny_outlined, color: ColorResources.failColor),
                            Text(
                              "生活方式",
                              style: textMedium.copyWith(color: ColorResources.failColor),
                            ),
                            Icon(Icons.arrow_right_rounded, color: ColorResources.failColor),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    // Title maxline 1
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                      child: Text(
                        "这是标题这是标题这是标题这是标题这是标题这是标题这是标是标题这是标题这是标是标题这是标题这是标题",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    // content maxline 5
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                      child: Text(
                          "Flutter的生态系统相对较小，这是因为Flutter是一个较新的框架，相对于React Native或Ionic等其他框架而言，Flutter的开发者数量和用户群体较少，其社区和生态系统相对薄弱。这使得一些开发者可能会发现在使用Flutter开发应用程序时，需要花费更多的时间和精力去解决问题，或者自己编写某些必要的功能。然而，随着Flutter的不断发展和壮大，其社区和生态系统也在逐渐扩大和完善，未来可能会有更多的第三方库和工具出现，"
                          "更多的开发者会参与到Flutter的开发中来，这有助于提升Flutter的生态系统。",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: textMedium),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 12,
                          children: [
                            _buildImage('https://i.imgur.com/7PHHNZO.png', 1),
                          ],
                        )),

                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 120,
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraExtraSmall),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.volunteer_activism_outlined,
                                ),
                                Text("女权思考", style: textMedium),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_outlined,
                                    color: ColorResources.amberColor,
                                  ),
                                  Text("9", style: textRegular),
                                ],
                              ),
                              SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite_rounded,
                                    color: ColorResources.failColor,
                                  ),
                                  Text("1", style: textRegular),
                                ],
                              ),
                              SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.message_outlined,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  Text("12", style: textRegular),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    Divider(thickness: 2, indent: 0, endIndent: 0),
                  ]);
                },
                childCount: 1,
              ),
            ),
          ])),
    );
  }
}

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String text;

  MenuTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20),
        Text(text, style: textRegular),
      ],
    );
  }
}
