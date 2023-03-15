import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../default_button.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({
    required this.releaseNote,
    required this.url,
  });
  String url;
  String releaseNote;
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
                Image.asset(Images.update,width: size!.width*.5,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    tr('update_title'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
                  ),
                ),
                Text(
                  releaseNote,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                ),
                const SizedBox(height: 20,),
                DefaultButton(text: tr('update_now'), onTap: (){
                  openUrl(url);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
