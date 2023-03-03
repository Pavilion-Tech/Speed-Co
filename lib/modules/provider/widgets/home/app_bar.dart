import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../user/menu_screens/notification_screen.dart';
import '../../menu_screens/notification_screen.dart';

class PHomeAppBar extends StatelessWidget {
  const PHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:InkWell(
            onTap: ()=>Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(Images.dots,width:2,height: 16,),
            ),
          ),
          actions: [
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 30),
              child: InkWell(
                  onTap: ()=>navigateTo(context, PNotificationScreen()),
                  child: Image.asset(Images.notification,width: 20)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20,left: 20,bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('hello'),
                      style: TextStyle(color: Colors.white,fontSize: 39),
                    ),
                    Text(
                      'Ahmed',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white,fontSize: 39,fontWeight: FontWeight.w600,height: .7),
                    ),
                  ],
                ),
              ),
              Container(
                height: 90,width: 90,
                decoration:const BoxDecoration(shape:BoxShape.circle),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(Images.homePhoto,fit: BoxFit.cover,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
