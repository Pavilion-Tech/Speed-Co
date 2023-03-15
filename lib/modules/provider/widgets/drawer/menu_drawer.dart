import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';

import '../../../../../shared/images/images.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../menu_screens/cubit/provider_menu_states.dart';
import 'account_settings.dart';
import 'our_app.dart';

class ProviderMenuDrawer extends StatelessWidget {
  const ProviderMenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderMenuCubit, ProviderMenuStates>(
  listener: (context, state) {
    if(isConnect!=null)checkNet(context,isUser: false);
  },
  builder: (context, state) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(ProviderCubit.get(context).providerModel!=null)
              Container(
                width: 98,height: 98,
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ImageNet(image: ProviderCubit.get(context).providerModel!.data!.personalPhoto??'',),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AccountSettings(),
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
