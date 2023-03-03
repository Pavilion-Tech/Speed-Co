import 'package:flutter/material.dart';
import 'package:speed_co/modules/user/widgets/menu/chat/record_item.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserChat();
  }
}

class SenderChat extends StatelessWidget {
  const SenderChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 36,width: 36,
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(Images.homePhoto,fit: BoxFit.cover,),
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today 5:23 pm',
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
              padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to',
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserChat extends StatelessWidget {
  const UserChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Today 5:23 pm',
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
            padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: RecordItem(timeColor: Colors.white,)
            // Text(
            //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to',
            //   style: TextStyle(fontSize: 11,color: Colors.white),
            //   textAlign: TextAlign.start,
            // ),
          ),
        ],
      ),
    );
  }
}


