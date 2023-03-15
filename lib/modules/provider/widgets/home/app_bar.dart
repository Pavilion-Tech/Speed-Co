import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../user/menu_screens/notification_screen.dart';
import '../../menu_screens/chat/pchat_history_screen.dart';
import '../../menu_screens/notification_screen.dart';

class PHomeAppBar extends StatelessWidget {
  const PHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ProviderCubit.get(context);
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
            InkWell(
                onTap: (){
                  ProviderMenuCubit.get(context).chatHistory();
                  navigateTo(context, PChatHistoryScreen());
                },
                child: Image.asset(Images.chat,width: 20)),
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
                      style: TextStyle(color: Colors.white,fontSize: 22),
                    ),
                    Text(
                      cubit.providerModel?.data?.name??'',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600,height: .7),
                    ),
                  ],
                ),
              ),
              Container(
                height: 90,width: 90,
                decoration:const BoxDecoration(shape:BoxShape.circle),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ImageNet(image: ProviderCubit.get(context).providerModel?.data?.personalPhoto??'',),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
