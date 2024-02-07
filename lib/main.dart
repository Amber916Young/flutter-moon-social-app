import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moon/localization/app_localization.dart';
import 'package:moon/src/core/constant/app_constants.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/src/core/helper/app_focus_helper.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/provider/language_provider.dart';
import 'package:moon/src/core/route/app_router.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'di_container.dart' as di;
import 'src/core/provider/localization_provider.dart';
import 'src/core/provider/theme_provider.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  if (ResponsiveHelper.isMobilePhone()) {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: 'food-delivery',
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: 'food-delivery',
    );
  }
  await di.init();
  int? orderID;
  try {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
      );
    }
    final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      orderID = remoteMessage.notification!.titleLocKey != null ? int.parse(remoteMessage.notification!.titleLocKey!) : null;
    }
    // await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  } catch (e) {
    debugPrint('error ===> $e');
  }
  timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
    ],
    child: MyApp(orderId: orderID, isWeb: !kIsWeb),
  ));
}

class MyApp extends StatefulWidget {
  final int? orderId;
  final bool isWeb;

  const MyApp({Key? key, required this.orderId, required this.isWeb}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoRouter? _appRouter;
  Future<bool>? _future;
  List<Locale> locals = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FlutterSmartDialog.init();
      }
    });
  }

  Future<bool> _getScreenDataAsync() async {
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            AppFocusHelper.instance.requestUnfocus();
          },
          child: FutureBuilder<bool>(
            initialData: null,
            future: (_future ??= _getScreenDataAsync()),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!) {
                return Consumer2<ThemeProvider, LocalizationProvider>(
                  builder: (context, themeProvider, localizationProvider, child) {
                    _appRouter ??= appRouter(navigatorKey);

                    return MaterialApp.router(
                      scaffoldMessengerKey: snackbarKey,
                      debugShowCheckedModeBanner: false,
                      routeInformationProvider: _appRouter!.routeInformationProvider,
                      routeInformationParser: _appRouter!.routeInformationParser,
                      routerDelegate: _appRouter!.routerDelegate,
                      supportedLocales: locals,
                      localizationsDelegates: const [
                        AppLocalization.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      locale: localizationProvider.locale,
                      onGenerateTitle: (context) => localizationProvider.appName,
                      theme: themeProvider.darkTheme ? FlexThemeData.dark(scheme: FlexScheme.amber) : FlexThemeData.light(scheme: FlexScheme.amber),
                      builder: (context, child) {
                        return ScaffoldMessenger(
                          key: scaffoldMessengerKey,
                          child: FlutterSmartDialog(
                              child: Scaffold(
                            body: child!,
                          )),
                        );
                      },
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
late AndroidNotificationChannel channel;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final snackbarKey = GlobalKey<ScaffoldMessengerState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;

  static NavigatorState? get navigator => navigatorKey.currentState;
}
