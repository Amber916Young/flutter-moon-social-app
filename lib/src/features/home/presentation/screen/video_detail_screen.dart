import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:video_player/video_player.dart';

// class VideoScreen extends StatefulWidget {
//   const VideoScreen({Key? key}) : super(key: key);
//
//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//    return PortalMasterLayout(
//         pageIndex: 0,
//         showDrawer: true,
//         showBottomBar: false,
//         endDrawerEnableOpenDragGesture: true,
//         body:Container(
//         child:
//        SingleChildScrollView(
//        physics: new BouncingScrollPhysics(),
//     scrollDirection: Axis.vertical,
//     child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       ListView.separated(
//         shrinkWrap: true,
//         cacheExtent: 1000,
//         physics: NeverScrollableScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         key: PageStorageKey(widget.position),
//         addAutomaticKeepAlives: true,
//         itemCount: itemList.isEmpty ? 0 : itemList.length,
//         itemBuilder: (BuildContext context, int index) =>
//             Container(
//               width: double.infinity,
//               height: 350.0,
//               alignment: Alignment.center,
//               child: Container(
//                   key: new PageStorageKey(
//                     "keydata$index",
//                   ),
//                   child: VideoWidget(
//                     play: true,
//                     url: itemList.elementAt(index),
//                   )
//               ),
//             ),
//         separatorBuilder: (context, index) {
//           return Divider();
//         },
//       ),
//
//
//
//     ]))));
//    }
// }

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoScreen> {
  VideoPlayerController? _videoPlayerController;

  ChewieController? chewieController;

  final videos = ['https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4'];

  Future initializeVideo() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videos[Random().nextInt(4)]));
    await _videoPlayerController!.initialize().then(
          (_) => setState(() {
            chewieController = ChewieController(
              videoPlayerController: _videoPlayerController!,
              aspectRatio: 16 / 9,
              autoPlay: true,
              looping: true,
            );
          }),
        );
    _videoPlayerController!.play();
  }

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        pageIndex: 3,
        showDrawer: true,
        showBottomBar: true,
        endDrawerEnableOpenDragGesture: true,
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {},
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getTranslated('following', context)!,
                    style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                    ),
                  ),
                  const SizedBox(
                    width: Dimensions.paddingSizeDefault,
                  ),
                  Text(getTranslated('for_you', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge))
                ],
              ),
            ),
          ),
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.settings_outlined, size: 20),
            onPressed: () {},
          ),
        ),
        body: PageView.builder(
            itemCount: videos.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = videos[index];
              _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(data));
              chewieController = ChewieController(
                videoPlayerController: _videoPlayerController!,
                aspectRatio: 16 / 9,
                autoPlay: true,
                looping: true,
              );
              return Stack(
                fit: StackFit.expand,
                children: [
                  _video(context),
                  _bottom(),
                  _right(context),
                ],
              );
            }));
  }

  Widget _video(BuildContext context) {
    return Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AspectRatio(
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          child: Chewie(controller: chewieController!),
        ));
  }

  Widget _right(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 80,
        height: MediaQuery.of(context).size.height / 1.5,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(Images.gifBox),
                  ),
                  Positioned(
                    top: 40,
                    left: 17,
                    child: ClipOval(
                      child: Material(
                        color: Colors.red,
                        child: InkWell(
                          splashColor: Colors.orange,
                          child: SizedBox(
                              width: 16,
                              height: 16,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 14,
                              )),
                          onTap: () {},
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            IconButton(
              icon: TtIcon(
                iconData: Icons.favorite,
                size: 36,
              ),
              onPressed: () {},
            ),
            TtText(text: '856', size: 18),
            SizedBox(height: 16),
            IconButton(
              icon: TtIcon(iconData: Icons.comment, size: 36),
              onPressed: () {},
            ),
            TtText(text: '35', size: 18),
            SizedBox(height: 16),
            IconButton(
              icon: TtIcon(iconData: Icons.send, size: 36),
              onPressed: () {},
            ),
            TtText(
              text: '1',
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottom() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: 200,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Row(children: [
                    TtIcon(
                      iconData: Icons.shopping_cart,
                      size: 16,
                    ),
                    TtText(text: 'Shop', size: 18),
                  ]),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                TtText(text: '@account_name', size: 18),
                Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                )
              ],
            ),
            SizedBox(height: 6),
            TtText(text: 'This is caption #hashtag #hashtag #hashtag', size: 13),
            SizedBox(height: 6),
            Row(
              children: [
                TtIcon(iconData: Icons.music_note, size: 14),
                TtText(text: 'Original Sound', size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TtIcon extends StatelessWidget {
  final IconData iconData;
  final double size;

  const TtIcon({Key? key, required this.iconData, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(iconData, size: this.size, color: Colors.white);
  }
}

class TtText extends StatelessWidget {
  final String text;
  final double size;

  const TtText({Key? key, required this.text, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.white, fontSize: this.size));
  }
}
