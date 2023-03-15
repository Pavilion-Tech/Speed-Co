import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/layouts/provider_layout/provider_layout.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/layouts/user_layout/user_layout.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/shared/components/components.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../default_button.dart';

class NoNetScreen extends StatelessWidget {
  NoNetScreen({this.isUser = true});
  bool isUser;
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
                Image.asset(Images.noNet,width: size!.width*.5,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    tr('no_net_title'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
                  ),
                ),
                Text(
                  tr('no_net_desc'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                ),
                const SizedBox(height: 20,),
                DefaultButton(
                    text: tr('reload'),
                    onTap: (){
                      if(isUser){
                        UserCubit.get(context).getHomeData();
                        UserCubit.get(context).getDate();
                        if(token!=null) MenuCubit.get(context).getUser();
                        navigateAndFinish(context, UserLayout());
                      }else{
                        if(pToken!=null){
                          ProviderCubit.get(context).getRequests();
                          ProviderCubit.get(context).getProvider();
                          navigateAndFinish(context, ProviderLayout());
                        }else{
                          UserCubit.get(context).getDate();
                        UserCubit.get(context).getHomeData();
                          navigateAndFinish(context, UserLayout());

                        }

                      }
                    }
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
