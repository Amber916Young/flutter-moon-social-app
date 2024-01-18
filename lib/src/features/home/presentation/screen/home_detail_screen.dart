import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/constant/images.dart';

class HomeDetailScreen extends StatefulWidget {
  const HomeDetailScreen({Key? key}) : super(key: key);

  @override
  _HomeDetailScreenState createState() => _HomeDetailScreenState();
}

class ImageModel {
  String image;
  int id;

  ImageModel({required this.image, required this.id});
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  late bool isClick = true;
  late List<ImageModel> galleryItems = [
    ImageModel(image: "https://i.imgur.com/r6vIrtL.png", id: 1),
    ImageModel(image: "https://i.imgur.com/H83Bqeu.png", id: 2),
  ];

  late final PageController _controller = PageController();
  bool enabled = true;

  @override
  void initState() {
    super.initState();
    setTime();
  }

  Future<void> setTime() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      enabled = false;
    });
  }

  Widget buildEffect(BuildContext context) {
    return Shimmer.fromColors(enabled: enabled, baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100, child: buildView(context));
  }

  Widget buildView(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
              height: height * .5,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      galleryItems[index].image,
                    ),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
                  );
                },
                itemCount: galleryItems.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null ? 0 : event.cumulativeBytesLoaded / 200,
                    ),
                  ),
                ),
                pageController: _controller,
                onPageChanged: (id) {},
              )),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              "这是标题这是标题这👉是标题这是标题这是🌝💫标题这是标题这是标是标题这是标题这是标是标题这是标题这是标题",
              style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
                "Flutter的生态系统相对较小，这是因为Flutter是一个较新的框架，相对于React Native或Ionic等其他框架而言，Flutter的开发者数量和用户群体较少，其社区和生态系统相对薄弱。这使得一些开发者可能会发现在使用Flutter开发应用程序时，需要花费更多的时间和精力去解决问题，或者自己编写某些必要的功能。然而，随着Flutter的不断发展和壮大，其社区和生态系统也在逐渐扩大和完善，未来可能会有更多的第三方库和工具出现，"
                "更多的开发者会参与到Flutter的开发中来，这有助于提升Flutter的生态系统。",
                style: textMedium),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return PortalMasterLayout(
        pageIndex: 0,
        showDrawer: true,
        showBottomBar: true,
        endDrawerEnableOpenDragGesture: true,
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 10, spreadRadius: 1)],
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.fontSizeOverLarge, vertical: Dimensions.radiusDefault),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ),
            )),
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(Images.logo),
                ),
                SizedBox(
                  width: Dimensions.paddingSizeDefault,
                ),
                Text('用户名', style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge))
              ],
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeExtraSmall,
              ),
              decoration: BoxDecoration(
                color: isClick ? Theme.of(context).hoverColor : Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              ),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      isClick = !isClick;
                    });
                  },
                  child: Text(isClick ? '已关注' : "关 注", style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault))),
            ),
            SizedBox(
              width: Dimensions.paddingSizeDefault,
            ),
            IconButton(
              icon: const Icon(Icons.settings, size: 25),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 25),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body:  !enabled
            ? buildView(context):buildEffect(context)

        );
  }
}
