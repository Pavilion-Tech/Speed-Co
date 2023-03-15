import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/item_shared/no_items/no_notifications.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/components/constants.dart';

import '../../../models/notification_model.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';

class NotificationScreen extends StatelessWidget {

  //NoNotifications()
  @override
  Widget build(BuildContext context) {
    MenuCubit.get(context).getNotification();
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      appBar: defaultAppBar(context: context,title: tr('notification'),haveNotification: false,haveChat:true),
      body: ConditionalBuilder(
        condition: cubit.notificationModel!=null,
        fallback: (context)=>const Center(child: CircularProgressIndicator(),),
        builder: (context)=> ConditionalBuilder(
          condition: cubit.notificationModel!.data!.data!.isNotEmpty,
          fallback: (context)=>NoNotifications(),
          builder: (context){
            Future.delayed(Duration.zero,(){
              cubit.paginationNotification();
            });
            return ListView.separated(
                itemBuilder: (c,i)=>itemBuilder(cubit.notificationModel!.data!.data![i]),
                controller: cubit.notificationScrollController,
                padding: const EdgeInsets.all(20),
                separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                itemCount: cubit.notificationModel!.data!.data!.length
            );
          }
        ),
      ),
    );
  },
);
  }
  Widget itemBuilder(NotificationData data){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: Colors.grey.shade200
          ),
          alignment: AlignmentDirectional.center,
          padding: EdgeInsetsDirectional.only(
              start: 85,
              end: 30,
              top: 20,bottom: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    data.title??'',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color:defaultColorTwo,fontSize: 16,fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    data.createdAt??'',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color:defaultColorTwo,fontSize: 8),
                  ),
                ],
              ),
              Text(
                data.body??'',
               // overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Positioned(
            left: myLocale =='en'?5:null,
            right: myLocale =='ar'?5:null,
            child: Image.asset(Images.homePhoto2,height: 74,width: 65,fit: BoxFit.cover,))
      ],
    );
  }

}
