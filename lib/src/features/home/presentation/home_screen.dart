import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
import 'package:moon/src/core/helper/date_converter.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/route/routes.dart';
import 'package:moon/src/features/auth/data/model/userinfo_model.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:moon/src/features/home/data/model/post_model.dart';
import 'package:provider/provider.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:moon/src/features/profile/presentation/my_friends_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  List<PostModel> postModelList = [];

  @override
  void initState() {
    super.initState();
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 0;

    PostModel postModel = PostModel(username: "user1", imageUrls: ['https://i.imgur.com/H83Bqeu.png', "https://i.imgur.com/r6vIrtL.png", "https://i.imgur.com/A7ksSCa.jpg"], postTime: "2024-01-14 20:38:37.277", title: "这是标题这是标题这是标题这是标题这是标题这是标题这是标是标题这是标题这是标是标题这是标题这是标题", brief: "briefw23jfhasdkf", tags: ["tags", "tags2"], hitLikes: 12, comments: 3);
    postModelList.add(postModel);
    PostModel postModel2 = PostModel(
        username: "user2",
        imageUrls: [],
        postTime: "2024-01-15 20:38:37.277",
        title: "3332",
        brief: "Flutter的生态系统相对较小，这是因为Flutter是一个较新的框架，相对于React Native或Ionic等其他框架而言，Flutter的开发者数量和用户群体较少，其社区和生态系统相对薄弱。这使得一些开发者可能会发现在使用Flutter开发应用程序时，需要花费更多的时间和精力去解决问题，或者自己编写某些必要的功能。然而，随着Flutter的不断发展和壮大，其社区和生态系统也在逐渐扩大和完善，未来可能会有更多的第三方库和工具出现，"
            "更多的开发者会参与到Flutter的开发中来，这有助于提升Flutter的生态系统。",
        tags: ["tags", "tags2"],
        hitLikes: 12,
        comments: 3);
    postModelList.add(postModel2);

    PostModel postModel3 = PostModel(
        username: "use322",
        imageUrls: ['https://i.imgur.com/H83Bqeu.png'],
        postTime: "2024-01-15 17:38:37.277",
        title: "3332",
        brief: "Flutter的生态系统相对较小，这是因为Flutter是一个较新的框架，相对于React Native或Ionic等其他框架而言，Flutter的开发者数量和用户群体较少，其社区和生态系统相对薄弱。这使得一些开发者可能会发现在使用Flutter开发应用程序时，需要花费更多的时间和精力去解决问题，或者自己编写某些必要的功能。然而，随着Flutter的不断发展和壮大，其社区和生态系统也在逐渐扩大和完善，未来可能会有更多的第三方库和工具出现，"
            "更多的开发者会参与到Flutter的开发中来，这有助于提升Flutter的生态系统。",
        tags: ["tags", "tags2"],
        hitLikes: 12,
        comments: 0);
    postModelList.add(postModel3);
    PostModel postModel4 = PostModel(
        username: "763232",
        imageUrls: [],
        postTime: "2024-01-15 17:34:37.277",
        title: "3332",
        brief: "Flutter的生态系统相对较小，这是因为Flutter是一个较新的框架，相对于React Native或Ionic等其他框架而言，Flutter的开发者数量和用户群体较少，其社区和生态系统相对薄弱。这使得一些开发者可能会发现在使用Flutter开发应用程序时，需要花费更多的时间和精力去解决问题，或者自己编写某些必要的功能。然而，随着Flutter的不断发展和壮大，其社区和生态系统也在逐渐扩大和完善，未来可能会有更多的第三方库和工具出现，"
            "更多的开发者会参与到Flutter的开发中来，这有助于提升Flutter的生态系统。",
        tags: ["tags", "tags2"],
        hitLikes: 2,
        comments: 30);
    postModelList.add(postModel4);
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
    double screenWidth = MediaQuery.of(context).size.width / 2;
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
                    style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
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
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColorDark,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: 'Places'),
                        Tab(text: 'Inspiration'),
                        Tab(text: 'Emotions'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MasonryGridView.builder(
                          itemCount: postModelList.length,
                          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            PostModel postModel = postModelList[index];

                            DateTime start0 = DateConverter.convertStringToDatetime(postModel.postTime!);
                            String timePost = timeago.format(start0);
                            return Container(
                              margin: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.all(color: Theme.of(context).secondaryHeaderColor, width: 1),
                                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(0.2), blurRadius: 1, spreadRadius: 0)],
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.homeDetailScreen);
                                },
                                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
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
                                        postModel.username!,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      subtitle: Text(
                                        timePost,
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      trailing: const Icon(
                                        Icons.menu,
                                        size: 20,
                                      ),
                                      selected: false,
                                      onTap: () {},
                                    ),
                                    if ((postModel.imageUrls ?? []).isNotEmpty)
                                      CarouselSlider(
                                        options: CarouselOptions(height: 130),
                                        items: (postModel.imageUrls ?? []).map((imageUrl) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                  width: width,
                                                  // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                                  decoration: BoxDecoration(color: Colors.amber),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: Images.placeholderImage,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                    image: imageUrl,
                                                    imageErrorBuilder: (context, error, stackTrace) => Image.asset(Images.placeholderImage, height: 130, fit: BoxFit.cover),
                                                  ));
                                            },
                                          );
                                        }).toList(),
                                      ),

                                    if ((postModel.imageUrls ?? []).isNotEmpty)
                                      SizedBox(
                                        height: Dimensions.paddingSizeDefault,
                                      ),
                                    // tags
                                    Container(
                                      height: 30,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: (postModel.tags ?? []).length, // Number of items in the list
                                        itemBuilder: (context, index) {
                                          String tag = postModel.tags![index];
                                          return Container(
                                            margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraExtraSmall),
                                            decoration: BoxDecoration(
                                              color: ColorResources.refundColor.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  " #$tag",
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                ),
                                                Icon(Icons.arrow_right_rounded, color: ColorResources.refundColor),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: Dimensions.paddingSizeSmall,
                                    ),
                                    // Title maxline 1
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                      child: Text(
                                        postModel.title ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: Dimensions.paddingSizeDefault,
                                    ),
                                    // content maxline 5
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                      child: Text(postModel.brief ?? "", maxLines: 3, overflow: TextOverflow.ellipsis, style: textMedium),
                                    ),
                                    const SizedBox(
                                      height: Dimensions.paddingSizeDefault,
                                    ),

                                    Padding(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.favorite_border_outlined,
                                                  color: ColorResources.failColor,
                                                ),
                                                Text((postModel.hitLikes ?? 0).toString(), style: textRegular),
                                              ],
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
                                                    Text((postModel.comments ?? 0).toString(), style: textRegular),
                                                  ],
                                                ))
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }),
                      Container(
                        child: Text("Inspiration"),
                      ),
                      Container(
                        child: Text("233"),
                      ),
                    ],
                  ),
                )
              ],
            )));
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
