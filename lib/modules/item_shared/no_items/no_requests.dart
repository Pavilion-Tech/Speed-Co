import 'package:flutter/material.dart';
import 'package:speed_co/layouts/user_layout/user_layout.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import 'package:speed_co/shared/components/components.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';

class NoRequests extends StatelessWidget {
  NoRequests({this.isHome=false});

  bool isHome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.noRequest,width:isHome?size!.width*.4: size!.width*.8,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              isHome?'No Service Yet':'No Requests yet',
              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),
            ),
          ),
          if(!isHome)
          DefaultButton(
              text: 'Homepage',
              onTap: ()=>navigateAndFinish(context, UserLayout())
          )
        ],
      ),
    );
  }
}
