import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/modules/user/menu_screens/notification_screen.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';

import '../../menu_screens/notification_screen.dart';

class RequestAppBar extends StatelessWidget {
  const RequestAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon:const Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: ()=>Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        tr('new_request'),
        style:const TextStyle(color: Colors.white,fontSize: 19.56,fontWeight: FontWeight.w500),
      ),
      actions: [
        IconButton(
            onPressed: ()=>navigateTo(context, PNotificationScreen()),
            icon: Image.asset(Images.notification,width: 20,)
        )
      ],
    );
  }
}
