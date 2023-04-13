import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/shared/bloc_observer.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/firebase_helper/firebase_options.dart';
import 'package:speed_co/shared/firebase_helper/notification_helper.dart';
import 'package:speed_co/shared/network/local/cache_helper.dart';
import 'package:speed_co/shared/network/remote/dio.dart';
import 'package:speed_co/shared/styles/colors.dart';
import 'package:speed_co/splash_screen.dart';
import 'modules/auth/auth_cubit/auth_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
    NotificationHelper();
    fcmToken = await  FirebaseMessaging.instance.getToken();
  }catch(e){
    print(e.toString());
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await CacheHelper.init();
  DioHelper.init1();
  intro = CacheHelper.getData(key: 'intro');
  userId = CacheHelper.getData(key: 'userId');
  token = CacheHelper.getData(key: 'token');
  pToken = CacheHelper.getData(key: 'pToken');
  pToken = CacheHelper.getData(key: 'pToken');
  String? local  = CacheHelper.getData(key: 'locale');
  if(local !=null){
    myLocale = local;
  }else{
    Platform.localeName.contains('ar')
        ?myLocale = 'ar'
        :myLocale = 'en';
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
  print(version);
  BlocOverrides.runZoned(
        () {
      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          useOnlyLangCode: true,
          path: 'assets/langs',
          fallbackLocale: const Locale('en'),
          startLocale: Locale(myLocale),
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()..checkInterNet()..getHomeData()..getDate(),),
        BlocProvider(create: (context) => AuthCubit()..checkInterNet(),),
        BlocProvider(create: (context) => MenuCubit()..checkInterNet()..getUser()..getOrders()..getSettings()..getStaticPages(),),
        BlocProvider(create: (context) => ProviderCubit()..checkInterNet()..getRequests()..getProvider()),
        BlocProvider(create: (context) => ProviderMenuCubit()..checkInterNet()..getSettings()..getStaticPages()..chatHistory(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          progressIndicatorTheme: ProgressIndicatorThemeData(color: defaultColor),
          appBarTheme: AppBarTheme(
              systemOverlayStyle:const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              iconTheme: IconThemeData(color:defaultColorFour)
          ),
          fontFamily: 'Cairo',
        ),
        home:const SplashScreen(),
      ),
    );
  }
}