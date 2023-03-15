import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_states.dart';
import 'package:speed_co/modules/auth/login_screen.dart';
import 'package:speed_co/modules/item_shared/wrong_screens/maintenance_screen.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:speed_co/modules/user/menu_screens/order/order_history_screen.dart';
import 'package:speed_co/modules/user/widgets/item_shared/map_address_screen.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/styles/colors.dart';

import '../../modules/user/home/home_screen.dart';
import '../../modules/user/menu_screens/chat/chat_history_screen.dart';
import '../../modules/user/menu_screens/notification_screen.dart';
import '../../modules/user/widgets/drawer/menu_drawer.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class UserLayout extends StatelessWidget {
  UserLayout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {
    if(isConnect!=null)checkNet(context);
    if(MenuCubit.get(context).settingsModel!=null){
      if(MenuCubit.get(context).settingsModel!.data!.isProjectInFactoryMode==2){
        navigateAndFinish(context, MaintenanceScreen());
      }
    }
  },
  builder: (context, state) {
    return Scaffold(
          extendBodyBehindAppBar: true,
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title:token!=null?InkWell(
              onTap: ()async{
                await cubit.getCurrentLocation();
                if(cubit.position!=null){
                  navigateTo(context, MapAddressScreen(
                      cubit.position!,
                      cubit.addressController,
                    lng: cubit.lngController,
                    lat: cubit.latController,
                  ));
                }
              },
              child:cubit.addressController.text.isEmpty?
              MenuCubit.get(context).addressController.text.isNotEmpty
                  ?Text(
                MenuCubit.get(context).addressController.text,
                style: TextStyle(color: Colors.white,fontSize: 11),
              ):Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(Images.location2,color: Colors.white,width: 13.30,height: 15,),
                  const SizedBox(width: 10),
                  Text(
                    tr('location'),
                    style: TextStyle(color: Colors.white,fontSize: 11),
                  )
                ],
              ):Text(
              cubit.addressController.text,
              style: TextStyle(color: Colors.white,fontSize: 11),
            ),
            ):null,
            leading: InkWell(
              onTap: () => scaffoldKey.currentState!.openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(Images.dots, width: 2, height: 16,),
              ),
            ),
            actions: [
              InkWell(
                  onTap: () {
                    if(token!=null){
                      MenuCubit.get(context).chatHistory();
                      navigateTo(context, ChatHistoryScreen());
                    }else{
                      navigateTo(context, LoginScreen(haveArrow: true,));
                    }
                  },
                  child: Image.asset(Images.chat, width: 24, height: 24,)),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 30, start: 20),
                child: InkWell(
                    onTap: () {
                      token!=null
                          ? navigateTo(context, NotificationScreen())
                          : navigateTo(context, LoginScreen(haveArrow: true,));
                      },
                    child: Image.asset(
                      Images.notification, width: 24, height: 24,)),
              ),
            ],
          ),
          drawer: MenuDrawer(),
          body:cubit.currentIndex==0? HomeScreen():token!=null?OrderHistoryScreen(haveAppbar: false):LoginScreen(),
          bottomNavigationBar: SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        cubit.changeIndex(0);
                      },
                        child: Icon(Icons.home_filled, color: defaultColor, size: 24,)),
                    SizedBox(width: size!.width * .1,),
                    InkWell(
                        onTap: () {
                          cubit.changeIndex(1);
                        },
                        child: Image.asset(Images.menu, color: defaultColor,
                          width: 20,
                          height: 20,)),
                  ],
                ),
              ),
            ),
          ),
        );
  },
);
      },
    );
  }
}
