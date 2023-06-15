import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import '../../../../shared/images/images.dart';
import '../../widgets/menu/chat/chat_appbar.dart';
import '../../widgets/menu/chat/chat_body.dart';
import '../../widgets/menu/chat/chat_bottom.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(this.id,this.orderId);

  String id;
  String orderId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Timer timer;
  @override
  void initState() {
    timer = Timer(Duration(seconds: 5), () {
      MenuCubit.get(context).chat(widget.orderId);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppBar(context, widget.id),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<MenuCubit, MenuStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                ConditionalBuilder(
                    condition: MenuCubit.get(context).chatModel!=null,
                    fallback: (context)=>Expanded(child: const Center(child:  CircularProgressIndicator())),
                    builder: (context)=> ChatBody()
                ),
                ConditionalBuilder(
                    condition: MenuCubit.get(context).chatModel!=null,
                    fallback: (context)=>SizedBox(),
                    builder: (context)=> ChatBottom(MenuCubit.get(context).chatModel!.data!.id!)
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
