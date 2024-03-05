import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/data/model/language_model.dart';
import 'package:moon/src/core/helper/app_mode.dart';

class AppConstants {
  static String _branchId = "-1";
  static String companyId = "20";

  static String getBaseUri(String url) {
    return '$companyId/$_branchId$url';
  }

  static String getBaseUriWithoutBranch(String url) {
    return '$companyId$url';
  }

  static setAppName(String newAppName) {
    appName = newAppName;
  }

  static String getAppName() {
    return appName;
  }

  static String appName = 'OrderIT Food App';
  static const String appVersion = '1.0.0';
  static const AppMode appMode = AppMode.demo;
  static String apiKey = "AIzaSyB-6WQ6f-n5xP39GuEKECSa5sg38IvSK7c";
  static String baseUrl = "https://dev.admin-panel.orderit.ie/api/v1/";

  static String get branchListUrl => getBaseUriWithoutBranch('/branches');

  static String get categoryUri => getBaseUri("/categories");

  static String get configUri => getBaseUri("/config");

  static String get bannerUri => getBaseUri("/banners");

  static String get latestProductUri => getBaseUri("/products");

  static String get trackUri => getBaseUri("/customer/order/track?order_id=");

  static String get messageUri => getBaseUri("/customer/message/get");

  static String get sendMessageUri => getBaseUri("/customer/message/send");
  static String get forgetPasswordUri => getBaseUriWithoutBranch('/auth/forgot-password');
  static String get verifyTokenUri => getBaseUriWithoutBranch('/auth/verify-token');
  static String get resetPasswordUri => getBaseUriWithoutBranch('/auth/reset-password');
  static String get checkPhoneUri => getBaseUriWithoutBranch('/auth/check-phone?phone=');
  static String get verifyPhoneUri => getBaseUriWithoutBranch('/auth/verify-phone');
  static String get checkEmailUri => getBaseUriWithoutBranch('/auth/check-email');
  static String get verifyEmailUri => getBaseUriWithoutBranch('/auth/verify-email');
  static String get registerUri => getBaseUriWithoutBranch('/auth/registration');
  static String get loginUri => getBaseUriWithoutBranch('/auth/login');
  static String get tokenUri => getBaseUriWithoutBranch('/customer/cm-firebase-token');

  static String get placeOrderUri => getBaseUri("/customer/order/place");
  static String get addressListUri => getBaseUriWithoutBranch('/customer/address/list');
  static String get removeAddressUri => getBaseUriWithoutBranch('/customer/address/delete?address_id=');
  static String get addAddressUri => getBaseUriWithoutBranch('/customer/address/add');
  static String get updateAddressUri => getBaseUriWithoutBranch('/customer/address/update/');
  static String get customerInfoUri => getBaseUriWithoutBranch('/customer/info');

  static String get couponUri => getBaseUri("/coupon/list");

  static String get couponApplyUri => getBaseUri("/coupon/apply?code=");

  static String get orderListUri => getBaseUri("/customer/order/list");

  static String get orderCancelUri => getBaseUri("/customer/order/cancel");

  static String get updateMethodUri => getBaseUri("/customer/order/payment-method");

  static String get orderDetailsUri => getBaseUri("/customer/order/details?order_id=");

  static const String pushNotificationUri = 'https://fcm.googleapis.com/fcm/send';

  static String get updateProfileUri => getBaseUriWithoutBranch('/customer/update-profile');
  static const String lastLocationUri = '/delivery-man/last-location?order_id=';
  static String distanceMatrixUri = "/mapapi/distance-api";
  static String searchLocationUri = "/mapapi/place-api-autocomplete";
  static String placeDetailsUri = "/mapapi/place-api-details";
  static String geocodeUri = "/mapapi/geocode-api";
  static const String customerRemove = '/customer/remove-account';

  // Shared Key
  static const String theme = 'theme';
  static const String token = 'token';
  static const String languageCode = 'language_code';
  static const String countryCode = 'country_code';
  static const String cartList = 'cart_list';
  static const String userPassword = 'user_password';
  static const String userAddress = 'user_address';
  static const String userNumber = 'user_number';
  static const String userLogData = 'user_log_data';
  static const String addressPlaceId = 'address_placeId';
  static const String topic = 'notify';
  static const String onBoardingSkip = 'on_boarding_skip';
  static const String placeOrderData = 'place_order_data';
  static const String orderTpe = 'order_type';
  static const String branch = 'branch';
  static const String cookiesManagement = 'cookies_management';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.unitedKingdom, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.china, languageName: '简体中文', countryCode: 'CN', languageCode: 'zh'),
  ];
}
