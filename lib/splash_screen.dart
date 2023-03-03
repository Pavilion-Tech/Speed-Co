import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:speed_co/layouts/user_layout/user_layout.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/images/images.dart';
import 'layouts/provider_layout/provider_layout.dart';
import 'modules/intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    timer = Timer(const Duration(seconds: 4), () {
      if(intro!=null){
          if(pToken!=null){
            navigateAndFinish(context, ProviderLayout());
          }else{
            navigateAndFinish(context, UserLayout());
          }
      }else{
        navigateAndFinish(context, IntroScreen());
      }




    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:HexColor('#F8F8F9'),
      body: Center(child: Image.asset(Images.splash,width: double.infinity,height: 292,)),
    );
  }
}
