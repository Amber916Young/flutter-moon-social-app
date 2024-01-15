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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? file;
  XFile? data;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  late bool _isLoggedIn;

  void _choose() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      }
    });
  }

  _pickImage() async {
    data = await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return PortalMasterLayout(
        pageIndex: 4,
        showDrawer: true,
        endDrawerEnableOpenDragGesture: true,
        key: _scaffoldKey,
        showBottomBar:false,
        appBar: CustomAppBar(context: context, title: getTranslated('my_profile', context)),
        body:
        SafeArea(
        child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Center(
              child: Container(
                width: width > 700 ? 700 : width,
                padding: width > 700 ? const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall) : null,
                decoration: width > 700
                    ? BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
                      )
                    : BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // for profile image
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorResources.borderColor,
                        border: Border.all(color: Colors.white54, width: 3),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: ResponsiveHelper.isMobilePhone() ? _choose : _pickImage,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: file != null
                                  ? Image.file(file!, width: 80, height: 80, fit: BoxFit.fill)
                                  : data != null
                                      ? Image.network(data!.path, width: 80, height: 80, fit: BoxFit.fill)
                                      : Image.asset(
                                          Images.placeholderUser,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                            Positioned(
                              bottom: 15,
                              right: -10,
                              child: InkWell(
                                  onTap: ResponsiveHelper.isMobilePhone() ? _choose : _pickImage,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorResources.borderColor,
                                      border: Border.all(width: 2, color: Colors.white54),
                                    ),
                                    child: const Icon(Icons.edit, size: 13),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // for name
                    Center(
                        child: Text(
                      'user Name',
                      style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                    )),

                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    ListTile(
                      title: Text(
                        getTranslated('nick_name', context)!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            getTranslated('nick_name', context)!,
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorResources.getHintColor(context)),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      selected: false,
                      onTap: () {},
                    ),

                    Divider(thickness: 1, indent: 20, endIndent: 20),

                    ListTile(
                      title: Text(
                        getTranslated('moon_account', context)!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "TZ293876432",
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorResources.getHintColor(context)),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      selected: false,
                      onTap: () {},
                    ),
                    Divider(thickness: 1, indent: 20, endIndent: 20),

                    ListTile(
                      title: Text(
                        getTranslated('gender', context)!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "女",
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorResources.getHintColor(context)),
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                      selected: false,
                      onTap: () {},
                    ),
                    Divider(thickness: 1, indent: 20, endIndent: 20),
                    ListTile(
                      title: Text(
                        getTranslated('district', context)!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "未知",
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorResources.getHintColor(context)),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      selected: false,
                      onTap: () {},
                    ),
                    Divider(thickness: 1, indent: 20, endIndent: 20),
                    ListTile(
                      title: Text(
                        getTranslated('description', context)!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "dsfjhbknlms.,",
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorResources.getHintColor(context)),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      selected: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
