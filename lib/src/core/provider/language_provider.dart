import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_constants.dart';
import 'package:moon/src/core/data/model/language_model.dart';

class LanguageProvider with ChangeNotifier {
  LanguageProvider();

  int? _selectIndex = 0;

  int? get selectIndex => _selectIndex;

  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }

  void setSelectIndex(int? index) {
    _selectIndex = index;
    notifyListeners();
  }

  List<LanguageModel> _languages = [];

  List<LanguageModel> get languages => _languages;

  void searchLanguage(String query, BuildContext context) {
    if (query.isEmpty) {
      _languages.clear();
      _languages = getAllLanguages(context: context);
      notifyListeners();
    } else {
      _selectIndex = -1;
      _languages = [];
      getAllLanguages(context: context).forEach((product) async {
        if (product.languageName!.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(product);
        }
      });
      notifyListeners();
    }
  }

  void initializeAllLanguages(BuildContext context) {
    if (_languages.isEmpty) {
      _languages.clear();
      _languages = getAllLanguages(context: context);
    }
  }
}
