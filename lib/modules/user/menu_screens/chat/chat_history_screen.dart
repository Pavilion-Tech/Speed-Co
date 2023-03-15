import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:speed_co/modules/user/widgets/shimmers/order_shimmer.dart';
import '../../../../shared/components/components.dart';
import '../../../item_shared/no_items/no_requests.dart';
import '../../widgets/menu/chat/chat_history_item.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
              context: context, title: tr('chat_history'), haveChat: false),
          body: ConditionalBuilder(
            condition: cubit.chatHistoryModel!=null&&state is! ChatHistoryLoadingState,
            fallback: (context)=>OrderShimmer(),
            builder: (context)=> ConditionalBuilder(
              condition: cubit.chatHistoryModel!.data!.isNotEmpty,
              fallback: (context)=>NoRequests(),
              builder: (context)=> ListView.separated(
                  itemBuilder: (c, i) => ChatHistoryItem(cubit.chatHistoryModel!.data![i]),
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
