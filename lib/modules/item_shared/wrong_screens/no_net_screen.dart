import 'package:flutter/material.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../default_button.dart';

class NoNetScreen extends StatelessWidget {
  const NoNetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.background,width: double.infinity,fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.noNet,width: size!.width*.5,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'No Internet Connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
                  ),
                ),
                Text(
                  'Make Sure Your Connection, And Try Again',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                ),
                const SizedBox(height: 20,),
                DefaultButton(text: 'Reload', onTap: (){})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
