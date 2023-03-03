import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu_screens/chat/chat_screen.dart';

class ChatHistoryItem extends StatelessWidget {
  const ChatHistoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, ChatScreen()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
           Row(
             children: [
               Expanded(
                 child: Text(
                   '112233',
                   style: TextStyle(color: defaultColorTwo,fontWeight: FontWeight.w700,fontSize: 16),
                 ),
               ),
               Text(
                 '2 Hours ago',
                 style: TextStyle(color: defaultColorTwo,fontSize: 8),
               ),
             ],
           ),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
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
