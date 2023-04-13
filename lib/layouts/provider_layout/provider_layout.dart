import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_states.dart';
import 'package:speed_co/modules/item_shared/no_items/no_requests.dart';
import 'package:speed_co/modules/user/widgets/shimmers/order_shimmer.dart';
import '../../modules/item_shared/wrong_screens/maintenance_screen.dart';
import '../../modules/provider/widgets/drawer/menu_drawer.dart';
import '../../modules/provider/widgets/home/app_bar.dart';
import '../../modules/provider/widgets/home/categories.dart';
import '../../modules/provider/widgets/home/request_item.dart';
import '../../modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/images/images.dart';

class ProviderLayout extends StatelessWidget {
  ProviderLayout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ProviderCubit.get(context).checkUpdate(context);
    return BlocConsumer<ProviderCubit, ProviderStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context,isUser: false);
        if(MenuCubit.get(context).settingsModel!=null){
          if(MenuCubit.get(context).settingsModel!.data!.isProjectInFactoryMode==2){
            navigateAndFinish(context, MaintenanceScreen());
          }
        }
      },
      builder: (context, state) {
        var cubit = ProviderCubit.get(context);
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
                    child: ConditionalBuilder(
                      condition: cubit.requestModel!=null&&state is! GetRequestLoadingState,
                      fallback: (context)=>OrderShimmer(),
                      builder: (context)=> ConditionalBuilder(
                        condition: cubit.requestModel!.data!.data!.isNotEmpty,
                        fallback: (context)=>NoRequests(isHome: true),
                        builder: (context){
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                    itemBuilder: (c, i) => RequestItem(cubit.requestModel!.data!.data![i]),
                                    padding: EdgeInsetsDirectional.all(20),
                                    controller:cubit.requestScrollController,
                                    separatorBuilder: (c, i) => const SizedBox(height: 30,),
                                    itemCount: cubit.requestModel!.data!.data!.length
                                ),
                              ),
                              if(state is GetRequestLoadingState)
                              const Center(child: CircularProgressIndicator(),)
                            ],
                          );
                        }
                      ),
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
