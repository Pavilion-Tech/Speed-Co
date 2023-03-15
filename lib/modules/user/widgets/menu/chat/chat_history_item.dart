import 'package:flutter/material.dart';
import 'package:speed_co/models/chat_history_model.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu_screens/chat/chat_screen.dart';

class ChatHistoryItem extends StatelessWidget {
  ChatHistoryItem(this.data);
  ChatHistoryData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, ChatScreen(data.itemNumber.toString(),data.id??'')),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Row(
             children: [
               Expanded(
                 child: Text(
                   '${data.providerName??''}#${data.itemNumber??''}',
                   style: TextStyle(color: defaultColorTwo,fontWeight: FontWeight.w700,fontSize: 16),
                 ),
               ),
               Text(
                 data.createdAt??'',
                 style: TextStyle(color: defaultColorTwo,fontSize: 8),
               ),
             ],
           ),
            Text(
              data.messages?[0].message??'',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: defaultColorTwo,fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }
}
