import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/components.dart';
import '../../widgets/menu/chat/chat_history_item.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:defaultAppBar(context: context,title: tr('chat_history'),haveChat: false),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (c,i)=>ChatHistoryItem(),
                padding:const EdgeInsetsDirectional.all(20),
                separatorBuilder: (c,i)=>Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 30),
                  child: Container(
                    color: Colors.grey.shade400,
                    height: 1,
                    width: double.infinity,
                  ),
                ),
                itemCount: 3
            ),
          )
        ],
      ),
    );  }
}
