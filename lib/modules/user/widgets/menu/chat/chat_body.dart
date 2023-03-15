import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/modules/user/widgets/menu/chat/record_item.dart';
import '../../../../../models/chat_model.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../item_shared/image_net.dart';
import '../../../../item_shared/image_zoom.dart';
import '../../../menu_screens/menu_cubit/menu_cubit.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = MenuCubit.get(context);
    return ConditionalBuilder(
        condition: cubit.chatModel!=null,
        fallback: (context)=>const Center(child: CircularProgressIndicator(),),
        builder: (context)=> ConditionalBuilder(
            condition: cubit.chatModel!.data!.messages!.isNotEmpty,
            fallback: (context)=>const SizedBox(),
            builder: (context)=> ListView.separated(
              itemCount: cubit.chatModel!.data!.messages!.length,
              separatorBuilder: (c,i)=>const SizedBox(height: 20,),
              itemBuilder: (c,i)=>ConditionalBuilder(
                  condition: cubit.chatModel!.data!.messages![i].sender != 'user',
                  builder: (c)=>SenderChat(cubit.chatModel!.data!.messages![i]),
                  fallback: (c)=>UserChat(cubit.chatModel!.data!.messages![i])
              ),
            )
        )
    );  }
}

class SenderChat extends StatelessWidget {
  SenderChat(this.messages);
  Messages messages;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   height: 36,width: 36,
        //   decoration: BoxDecoration(shape: BoxShape.circle),
        //   clipBehavior: Clip.antiAliasWithSaveLayer,
        //   child: Image.asset(Images.homePhoto,fit: BoxFit.cover,),
        // ),
        // const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messages.createdAt??'',
              style: TextStyle(fontSize: 11),
            ),
            Container(
              width: size!.width*.7,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                    bottomStart: Radius.circular(20),
                  )
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding:messages.messageType==1?const EdgeInsets.symmetric(horizontal: 15,vertical: 10):null,
              child: ConditionalBuilder(
                condition: messages.messageType==1,
                fallback: (c)=>InkWell(
                    onTap: (){
                      navigateTo(context, ImageZoom(messages.message??''));
                    },
                    child: ImageNet(image: messages.message??'',height: 200,)),
                builder: (c)=> Text(
                  messages.message??'',
                  style: TextStyle(fontSize: 11),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserChat extends StatelessWidget {
  UserChat(this.messages);
  Messages messages;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            messages.createdAt??'',
            style: TextStyle(fontSize: 11),
          ),
          Container(
              width: size!.width*.7,
              decoration: BoxDecoration(
                  color: defaultColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                    bottomStart: Radius.circular(20),
                  )
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding:messages.messageType==1?const EdgeInsets.symmetric(horizontal: 15,vertical: 10):null,
              child: ConditionalBuilder(
                condition: messages.messageType==1,
                fallback: (c)=>InkWell(
                    onTap: (){
                      navigateTo(context, ImageZoom(messages.message??''));
                    },
                    child: ImageNet(image: messages.message??'',height: 200,)),
                builder: (c)=>Text(
                  messages.message??'',
                  style: TextStyle(fontSize: 11,color: Colors.white),
                  textAlign: TextAlign.end,
                ),
              )
          ),
        ],
      ),
    );
  }
}


