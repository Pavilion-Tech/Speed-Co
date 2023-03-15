import 'package:flutter/material.dart';
import 'package:speed_co/models/chat_history_model.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu_screens/chat/pchat_screen.dart';

class PChatHistoryItem extends StatelessWidget {
  PChatHistoryItem(this.data);
  ChatHistoryData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        ProviderMenuCubit.get(context).chat(data.id??'');
        navigateTo(context, PChatScreen(data.itemNumber.toString(),data.id??''));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Row(
             children: [
               Expanded(
                 child: Text(
                   '#${data.itemNumber??''}',
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
              data.userName??'',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: defaultColorTwo,fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
