import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/modules/provider/auth/sgin_up_screen.dart';
import 'package:speed_co/modules/user/auth/sgin_up_screen.dart';
import 'package:speed_co/shared/images/images.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../item_shared/default_button.dart';

class JoinAsScreen extends StatelessWidget {
  const JoinAsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,backgroundColor: Colors.transparent,
      ),
      body:Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(Images.background),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr('welcome'),
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 44),
                ),
                Text(
                  tr('welcome_desc'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: DefaultButton(
                    onTap: (){
                      isUser = true;
                      navigateTo(context, SignUpScreen(haveArrow: true,));
                    },
                    text: tr('ask_service'),
                  ),
                ),
                DefaultButton(
                  onTap: (){
                    isProvider = true;
                    navigateTo(context, ProviderSignUpScreen(haveArrow: true,));
                  },
                  text: tr('provide_service'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
