import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/layouts/user_layout/user_layout.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/images/images.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/styles/colors.dart';
import '../../../item_shared/default_button.dart';

class TrackDialog extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20)),
      child: Stack(
        children: [
          Image.asset(Images.background,height: 350,width: double.infinity,fit: BoxFit.cover,),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.track,width: 250,fit: BoxFit.cover,height: 130,),
                Text(
                  '112541',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),
                ),
                Text.rich(
                  TextSpan(
                      text: tr('request_to'),
                      style: TextStyle(color: defaultColorTwo,fontSize: 16),
                      children: [
                        TextSpan(
                            text: 'Air Conditioner Service ',
                            style: TextStyle(color: defaultColorTwo,fontWeight: FontWeight.w700,fontSize: 16),
                            children: [
                              TextSpan(
                                text: tr('is_sent'),
                                style: TextStyle(color: defaultColorTwo,fontSize: 16),
                              )
                            ]
                        ),
                      ]
                  ),
                  textAlign: TextAlign.center,
                  style:const TextStyle(height: 1.5),
                ),
                const SizedBox(height: 20,),
                DefaultButton(
                    text: tr('homepage'),
                    onTap: ()=>navigateAndFinish(context,UserLayout())
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
