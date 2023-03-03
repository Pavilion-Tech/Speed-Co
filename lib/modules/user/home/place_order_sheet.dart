import 'package:flutter/material.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
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
            'Select Service',
            style: TextStyle(color: defaultColorTwo,fontSize: 12,fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: GridProduct(isScroll: false,data: UserCubit.get(context).serviceModel!.data!,))
      ],
    );
  }
}
