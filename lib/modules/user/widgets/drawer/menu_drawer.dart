import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';

import '../../../../../shared/images/images.dart';
import '../../../../shared/components/constants.dart';
import 'account_settings.dart';
import 'our_app.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
        return Drawer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 98,
                    height: 98,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child:cubit.userModel!=null?ImageNet(image: cubit.userModel!.data!.personalPhoto!): SizedBox(),
                  ),
                  if(cubit.userModel!=null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      cubit.userModel!.data!.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if(token != null&&cubit.userModel!=null)
                            AccountSettings(),
                          if(token == null&&cubit.userModel!=null)
                            const SizedBox(height: 20,),
                          OurApp(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
