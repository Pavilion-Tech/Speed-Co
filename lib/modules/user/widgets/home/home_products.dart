import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layouts/user_layout/cubit/user_cubit.dart';
import '../../../../layouts/user_layout/cubit/user_states.dart';
import '../../../item_shared/no_items/no_requests.dart';
import '../item_shared/grid_products.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return ConditionalBuilder(
          condition:cubit.serviceModel!.data!.isNotEmpty,
          fallback: (context)=>NoRequests(isHome:true),
          builder: (context)=> ConditionalBuilder(
            condition: state is! GetHomeLoadingState,
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
            builder: (context)=> GridProduct(data: cubit.serviceModel!.data!,)
          ),
        );
      },
    );
  }
}
