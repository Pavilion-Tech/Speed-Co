import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/images/images.dart';

class NoNotifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.noNotification,width: size!.width*.8,),
          const SizedBox(height: 20,),
          Text(
            tr('no_notifications_yet'),
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),
          ),
        ],
      ),
    );
  }
}
