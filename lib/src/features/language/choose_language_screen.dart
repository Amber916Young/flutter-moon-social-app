import 'package:flutter/material.dart';
import 'package:moon/src/core/component/portal_master_layout.dart';
import 'package:provider/provider.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_button.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_constants.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/data/model/language_model.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/provider/language_provider.dart';
import 'package:moon/src/core/provider/localization_provider.dart';
import 'package:moon/src/core/route/routes.dart';
import 'package:moon/src/features/language/widget/search_widget.dart';

class ChooseLanguageScreen extends StatelessWidget {
  final bool fromMenu;
  const ChooseLanguageScreen({Key? key, this.fromMenu = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    Provider.of<LanguageProvider>(context, listen: false).initializeAllLanguages(context);

    return PortalMasterLayout(
        pageIndex: 4,
        showDrawer: false,
        showBottomBar: false,
        endDrawerEnableOpenDragGesture: true,
        body: Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                padding: width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeLarge) : EdgeInsets.zero,
                child: Container(
                  width: width > 700 ? 700 : width,
                  padding: width > 700 ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
                  decoration: width > 700
                      ? BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
                        )
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Container(
                          width: 1170,
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, top: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge),
                          child: Text(
                            getTranslated('choose_the_language', context)!,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 22, color: Theme.of(context).textTheme.bodyLarge!.color),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Container(
                          width: 1170,
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge),
                          child: const SearchWidget(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Consumer<LanguageProvider>(
                          builder: (context, languageProvider, child) => Expanded(
                                  child: Scrollbar(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Center(
                                    child: SizedBox(
                                      width: 1170,
                                      child: ListView.builder(itemCount: languageProvider.languages.length, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, itemBuilder: (context, index) => _languageWidget(context: context, languageModel: languageProvider.languages[index], languageProvider: languageProvider, index: index)),
                                    ),
                                  ),
                                ),
                              ))),
                      Consumer<LanguageProvider>(
                          builder: (context, languageProvider, child) => Center(
                                child: Container(
                                  width: 1170,
                                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeLarge),
                                  child: CustomButton(
                                    btnTxt: getTranslated('save', context),
                                    onTap: () {
                                      // Provider.of<OnBoardingProvider>(context, listen: false).toggleShowOnBoardingStatus();
                                      if (languageProvider.languages.isNotEmpty && languageProvider.selectIndex != -1) {
                                        Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                                          AppConstants.languages[languageProvider.selectIndex!].languageCode!,
                                          AppConstants.languages[languageProvider.selectIndex!].countryCode,
                                        ));
                                        Navigator.pop(context);
                                      } else {
                                        showCustomSnackBar(getTranslated('select_a_language', context));
                                      }
                                    },
                                  ),
                                ),
                              )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _languageWidget({required BuildContext context, required LanguageModel languageModel, required LanguageProvider languageProvider, int? index}) {
    return InkWell(
      onTap: () {
        languageProvider.setSelectIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: languageProvider.selectIndex == index ? Theme.of(context).primaryColor.withOpacity(.15) : null,
          border: Border(top: BorderSide(width: 1.0, color: languageProvider.selectIndex == index ? Theme.of(context).primaryColor : Colors.transparent), bottom: BorderSide(width: 1.0, color: languageProvider.selectIndex == index ? Theme.of(context).primaryColor : Colors.transparent)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: languageProvider.selectIndex == index ? Colors.transparent : Colors.white54.withOpacity(.3))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(languageModel.imageUrl!, width: 34, height: 34),
                  const SizedBox(width: 30),
                  Text(
                    languageModel.languageName!,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ],
              ),
              languageProvider.selectIndex == index ? Image.asset(Images.done, width: 17, height: 17, color: Theme.of(context).primaryColor) : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
