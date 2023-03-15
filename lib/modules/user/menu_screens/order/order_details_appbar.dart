import 'package:flutter/material.dart';
import 'package:speed_co/modules/user/menu_screens/chat/chat_screen.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../notification_screen.dart';

class OrderDetailsAppBar extends StatelessWidget {
  OrderDetailsAppBar(this.id,this.status,this.itemNumber);
  String id;
  String itemNumber;
  int status;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color:Colors.white,),
        onPressed: ()=>Navigator.pop(context),
      ),
      actions: [
        if(status !=1)
        InkWell(
              onTap: (){
                MenuCubit.get(context).chat(id);
                navigateTo(context, ChatScreen(itemNumber,id));
              },
              child: Image.asset(Images.chat,width: 24,height: 24,color: Colors.white,)),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 30,start: 20),
            child: InkWell(
                onTap: ()=>navigateTo(context, NotificationScreen()),
                child: Image.asset(Images.notification,width: 24,height: 24,color:Colors.white,)),
          ),
      ],
    );
  }
}
