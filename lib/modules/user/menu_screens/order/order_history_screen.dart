import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/models/user/orders_model.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/styles/colors.dart';

import '../../../item_shared/no_items/no_requests.dart';
import '../../widgets/shimmers/order_shimmer.dart';
import 'order_detail_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({this.haveAppbar = true});

  bool haveAppbar;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:haveAppbar? defaultAppBar(context: context,title: tr('request_history'),colorIsDefault: false):null,
      body: Stack(
        children: [
          Image.asset(Images.homeCurve),
          SafeArea(
            child: ConditionalBuilder(
              condition: cubit.ordersModel!=null,
              fallback: (context)=>OrderShimmer(),
              builder: (context)=> ConditionalBuilder(
                condition: cubit.ordersModel!.data!.data!.isNotEmpty,
                fallback: (context)=>NoRequests(),
                builder: (context){
                  Future.delayed(Duration.zero,()=>cubit.paginationOrders());
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (c,i)=>itemBuilder(context, cubit.ordersModel!.data!.data![i]),
                            padding:const EdgeInsets.all(20),
                            controller:cubit.orderScrollController,
                            separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                            itemCount:  cubit.ordersModel!.data!.data!.length
                        ),
                      ),
                      if(state is GetOrderLoadingState)
                        const Center(child: CircularProgressIndicator(),)
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }

  Widget itemBuilder(BuildContext context,OrderData data){
    String status = data.status==1
        ?tr('pending'):data.status==2
        ?tr('processing'):data.status==3
        ?tr('completed'):tr('canceled');
    return InkWell(
      onTap: (){
        navigateTo(context, OrderDetailsScreen(data,status));
      },
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10),
                color: Colors.grey.shade200
              ),
              alignment: AlignmentDirectional.center,
              padding: EdgeInsetsDirectional.only(
                start: 85,
                end: 30,
                top: 5
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${data.itemNumber}',
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.description??'',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        status,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color:defaultColor,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: myLocale == 'en'?5:null,
                right: myLocale == 'ar'?5:null,
                child: ImageNet(
                    image:data.serviceImage??'',
                    height: 74,width: 65))
          ],
        ),
      ),
    );
  }
}
