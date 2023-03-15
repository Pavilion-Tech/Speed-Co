import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/user/widgets/shimmers/order_shimmer.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../item_shared/no_items/no_requests.dart';
import '../../widgets/menu/chat/chat_history_item.dart';
import '../cubit/provider_menu_cubit.dart';
import '../cubit/provider_menu_states.dart';

class PChatHistoryScreen extends StatelessWidget {
  const PChatHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderMenuCubit, ProviderMenuStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context,isUser: false);
      },
      builder: (context, state) {
        var cubit = ProviderMenuCubit.get(context);
        return Scaffold(
          appBar: pDefaultAppBar(
              context: context, title: tr('chat_history')),
          body: ConditionalBuilder(
            condition: cubit.chatHistoryModel!=null&&state is! ChatHistoryLoadingState,
            fallback: (context)=>OrderShimmer(),
            builder: (context)=> ConditionalBuilder(
              condition: cubit.chatHistoryModel!.data!.isNotEmpty,
              fallback: (context)=>NoRequests(isUser:false),
              builder: (context)=> ListView.separated(
                  itemBuilder: (c, i) => PChatHistoryItem(cubit.chatHistoryModel!.data![i]),
                  padding: const EdgeInsetsDirectional.all(20),
                  separatorBuilder: (c, i) =>
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: Container(
                          color: Colors.grey.shade400,
                          height: 1,
                          width: double.infinity,
                        ),
                      ),
                  itemCount: cubit.chatHistoryModel!.data!.length
              ),
            ),
          ),
        );
      },
    );
  }
}
