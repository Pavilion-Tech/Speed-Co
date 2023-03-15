import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/modules/item_shared/no_items/no_requests.dart';
import 'package:speed_co/shared/styles/colors.dart';

import '../widgets/item_shared/grid_products.dart';

class PlaceOrderSheet extends StatelessWidget {
  const PlaceOrderSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            tr('select_service'),
            style: TextStyle(color: defaultColorTwo,fontSize: 12,fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: ConditionalBuilder(
          condition: UserCubit.get(context).serviceModel!.data!.isNotEmpty,
          fallback: (context)=>NoRequests(isHome: true),
          builder: (context)=>GridProduct(isScroll: false,data: UserCubit.get(context).serviceModel!.data!,),
        ))
      ],
    );
  }
}
