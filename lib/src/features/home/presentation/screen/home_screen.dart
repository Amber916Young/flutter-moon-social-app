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
import 'package:moon/src/features/home/presentation/widget/home_post_widget.dart';
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
  List<String> tags = ["Travel", "Food", "Fitness", "Technology", "Fashion", "Fashion", "Fashion"];
  bool isTagsExpanded = false;
  int active = 0;

  @override
  void initState() {
    super.initState();
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 0;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  backgroundImageContainer() {
    return Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        image: const DecorationImage(
          image: NetworkImage("https://i.imgur.com/H83Bqeu.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  backgroundGradientContainer() {
    return Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.4),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  foregroundItems() {
    return Positioned(
      bottom: 20,
      left: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sat, SEP 22 AT 12 PM",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
          ),
          Text(
            "Polo Forest National Park",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
          ),
          Text(
            "The Green Perl, USA",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surface),
          ),
        ],
      ),
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
                  Text('关注', style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  const SizedBox(
                    width: Dimensions.paddingSizeDefault,
                  ),
                  Text(
                    '首页',
                    style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                  ),
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
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: width * .85,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (tags ?? []).length, // Number of items in the list
                            itemBuilder: (context, index) {
                              var tag = tags[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Chip(label: Text(tag)),
                              );
                            }),
                      ),
                      SizedBox(
                          height: 50,
                          width: width * .15,
                          child: IconButton(
                            icon: Icon(isTagsExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded),
                            onPressed: () {
                              setState(() {
                                isTagsExpanded = !isTagsExpanded;
                              });
                            },
                          ))
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: isTagsExpanded ? 100 : 0,
                    width: isTagsExpanded ? MediaQuery.of(context).size.width : 0,
                    child: isTagsExpanded
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: tags.map((tag) {
                                return Chip(label: Text(tag));
                              }).toList(),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 160,
                          height: 250,
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Stack(
                                children: [
                                  backgroundImageContainer(),
                                  backgroundGradientContainer(),
                                  foregroundItems(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const HomePostWidget(),
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
