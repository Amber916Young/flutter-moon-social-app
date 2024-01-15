import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/component/custom_button.dart';
import 'package:moon/src/core/component/custom_loading.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/component/custom_text_field.dart';
import 'package:moon/src/core/component/tag_icon.dart';
import 'package:moon/src/core/component/text_widget.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/provider/theme_provider.dart';
import 'package:moon/src/core/route/routes.dart';
import 'package:moon/src/features/auth/data/model/userinfo_model.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FocusNode? _firstNameFocus;
  FocusNode? _lastNameFocus;
  FocusNode? _emailFocus;
  FocusNode? _phoneNumberFocus;
  FocusNode? _passwordFocus;
  FocusNode? _confirmPasswordFocus;
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneNumberController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    _isLoggedIn = true;

    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _emailFocus = FocusNode();
    _phoneNumberFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    if (_isLoggedIn) {
      UserInfoModel? userInfoModel = UserInfoModel();
      _firstNameController!.text = userInfoModel.fName ?? '';
      _lastNameController!.text = userInfoModel.lName ?? '';
      _phoneNumberController!.text = userInfoModel.phone ?? '';
      _emailController!.text = userInfoModel.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return PortalMasterLayout(
        pageIndex: 4,
        showDrawer: true,
        endDrawerEnableOpenDragGesture: true,
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              height: height * .4,
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).darkTheme ? ColorResources.blackColor : ColorResources.colorLightGray, // Set the background color here
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.radiusLarge), bottomRight: Radius.circular(Dimensions.radiusLarge)), // Optional: Add rounded corners
              ),
            ),
            CustomScrollView(slivers: [
              SliverAppBar(
                pinned: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.message_outlined, size: 20),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.help,
                      size: 20,
                    ),
                    onPressed: () {},
                  )
                ],
                backgroundColor: Theme.of(context).cardColor,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.settings_outlined, size: 20),
                  onPressed: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: CircleAvatar(
                          radius: 38,
                          backgroundImage: AssetImage(Images.logo),
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeDefault,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("同舟号： tz78982813213"),
                                    SizedBox(
                                      width: Dimensions.paddingSizeExtraSmall,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                      ),
                                      child: TagWithIcon(tagText: 'Lv.2'),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, Routes.getEditProfileRoute());
                                    },
                                    icon: Icon(
                                      Icons.arrow_right_rounded,
                                      color: Colors.grey,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Text(
                              "tothemoon",
                              style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            Row(
                              children: [
                                TagWithIcon(tagText: '隐身'),
                                TagWithIcon(
                                  tagText: '任务中心',
                                  iconData: Icons.task,
                                ),
                                TagWithIcon(
                                  tagText: '去主页',
                                  iconData: Icons.home,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(
                height: Dimensions.paddingSizeLarge,
              )),
              const SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Text(
                      "简介：这简介这简介这简介这简介这简介这简介",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(
                height: Dimensions.paddingSizeLarge,
              )),
              SliverToBoxAdapter(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextWithNumberWidget(text: getTranslated('my_focus', context)!, number: "20"),
                  TextWithNumberWidget(text: getTranslated('followers', context)!, number: "192"),
                  TextWithNumberWidget(text: getTranslated('my_friends', context)!, number: "19"),
                  TextWithNumberWidget(text: getTranslated('join', context)!, number: "2"),
                ],
              )),
              SliverToBoxAdapter(
                child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.profileBg1),
                        fit: BoxFit.fill,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge2),
                    child: Padding(
                        padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraLarge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset("assets/svg/fxrz.svg", height: 25),
                                Text(
                                  'Yxxxxx',
                                  style: textRegular.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  getTranslated('to_verify', context)!,
                                  style: textRegular.copyWith(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.arrow_right_rounded,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            )
                          ],
                        ))),
              ),
              SliverToBoxAdapter(
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault) // Optional: Add rounded corners
                        ),
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    padding: EdgeInsets.all(16.0),
                    child: IntrinsicHeight(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                        Flexible(
                                          child: Text(
                                            getTranslated('women_empowerment', context)!,
                                            style: textBold,
                                            maxLines: 3,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_right_rounded,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: Dimensions.paddingSizeExtraSmall,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "10",
                                            style: textBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),
                                          ),
                                          Text(
                                            getTranslated('flowers', context)!,
                                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
                                          ),
                                          SizedBox(
                                            width: Dimensions.paddingSizeDefault,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraExtraSmall),
                                            decoration: BoxDecoration(
                                              color: ColorResources.footerColor,
                                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                            ),
                                            child: Text(
                                              getTranslated('view_all', context)!,
                                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.failColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.paddingSizeExtraSmall,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslated('today_collection', context)!.replaceAll("NUM", "12"),
                                            style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.acceptedColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Image.asset(Images.loyal, width: 30, height: 30),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          indent: 2,
                          endIndent: 2,
                          color: ColorResources.borderColor,
                        ),
                        Expanded(
                            child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(getTranslated('my_wallet', context)!, style: Theme.of(context).textTheme.bodyMedium),
                                      const Icon(
                                        Icons.arrow_right_rounded,
                                        color: Colors.grey,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "0",
                                        style: textBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),
                                      ),
                                      Text(
                                        getTranslated('moon_coins', context)!,
                                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
                                      ),
                                      SizedBox(
                                        width: Dimensions.paddingSizeDefault,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${getTranslated('today_earnings', context)!}0",
                                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.failColor),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(Images.payment, width: 30, height: 30),
                                ],
                              )
                            ],
                          ),
                        ))
                      ],
                    ))),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: Dimensions.paddingSizeLarge,
              )),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault) // Optional: Add rounded corners
                      ),
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // ListTile(
                      //   onTap: () => Navigator.pushNamed(context, Routes.getLanguageRoute('menu')),
                      //   leading: Image.asset(Images.language, width: 20, height: 20, color: Theme.of(context).textTheme.bodyLarge!.color),
                      //   title: Text(getTranslated('language', context)!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MenuTile(
                            text: getTranslated('draft_box', context)!,
                            icon: Icons.search,
                          ),
                          MenuTile(
                            icon: Icons.thumb_up_outlined,
                            text: getTranslated('hit_like', context)!,
                          ),
                          MenuTile(
                            icon: Icons.collections_outlined,
                            text: getTranslated('favourite', context)!,
                          ),
                          MenuTile(
                            icon: Icons.mic_rounded,
                            text: getTranslated('my_voice', context)!,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MenuTile(icon: Icons.featured_play_list_outlined, text: getTranslated('my_question', context)!),
                          MenuTile(icon: Icons.notifications, text: getTranslated('my_reply', context)!),
                          MenuTile(icon: Icons.question_mark_rounded, text: getTranslated('help_and_support', context)!),
                          MenuTile(icon: Icons.help, text: getTranslated('entrepreneur', context)!),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault) // Optional: Add rounded corners
                          ),
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SwitchListTile(
                            value: Provider.of<ThemeProvider>(context).darkTheme,
                            onChanged: (bool isActive) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                            title: Text(getTranslated('dark_theme', context)!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          ListTile(
                            onTap: () => Navigator.pushNamed(context, Routes.getLanguageRoute('menu')),
                            leading: Image.asset(Images.language, width: 20, height: 20, color: Theme.of(context).textTheme.bodyLarge!.color),
                            title: Text(getTranslated('language', context)!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          ),
                          ListTile(
                            onTap: () => Navigator.pushNamed(context, Routes.getLoginRoute()),
                            leading: Image.asset(Images.logOut, width: 20, height: 20, color: Theme.of(context).textTheme.bodyLarge!.color),
                            title: Text(getTranslated('logout', context)!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          ),
                        ],
                      )))
            ]),
          ],
        ));
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
        Text(text, style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
      ],
    );
  }
}
