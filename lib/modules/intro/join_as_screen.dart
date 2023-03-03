import 'package:flutter/material.dart';
import 'package:speed_co/modules/auth/login_screen.dart';
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
                  'Welcome',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 44),
                ),
                Text(
                  'Register as a service provider or customer, one application brings you together, many great services and features are waiting for you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: DefaultButton(
                    onTap: (){
                      isUser = true;
                      navigateTo(context, SignUpScreen());
                    },
                    text: 'Ask for service',
                  ),
                ),
                DefaultButton(
                  onTap: (){
                    isProvider = true;
                    navigateTo(context, ProviderSignUpScreen());
                  },
                  text: 'Provide service',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
