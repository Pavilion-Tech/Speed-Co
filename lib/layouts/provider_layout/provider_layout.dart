import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_states.dart';

import '../../modules/provider/widgets/drawer/menu_drawer.dart';
import '../../modules/provider/widgets/home/app_bar.dart';
import '../../modules/provider/widgets/home/categories.dart';
import '../../modules/provider/widgets/home/request_item.dart';
import '../../modules/user/menu_screens/notification_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/images/images.dart';

class ProviderLayout extends StatelessWidget {
  ProviderLayout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: ProviderMenuDrawer(),
          body: Stack(
            children: [
              Image.asset(
                Images.curve, fit: BoxFit.cover, width: double.infinity,),
              Image.asset(Images.background, color: Colors.white,
                fit: BoxFit.cover,
                width: double.infinity,),
              Column(
                children: [
                  PHomeAppBar(),
                  Categories(),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (c, i) => RequestItem(),
                        padding: EdgeInsetsDirectional.all(20),
                        separatorBuilder: (c, i) => const SizedBox(height: 30,),
                        itemCount: 5
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
