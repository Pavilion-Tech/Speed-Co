import 'package:flutter/material.dart';
import 'package:speed_co/modules/item_shared/image_zoom.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/styles/colors.dart';

import '../../../user/menu_screens/chat/chat_screen.dart';

class ProblemDesc extends StatelessWidget {
  const ProblemDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20,left:20 ,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              navigateTo(context, ChatScreen());
            },
              child: Image.asset(Images.problemDesc,width: 30,)),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color:Colors.grey.shade200,
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type',
                  style: TextStyle(color: defaultColorTwo,fontSize: 12),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 76,
                  child: ListView.separated(
                      itemBuilder: (c,i)=>InkWell(
                        onTap: (){
                          navigateTo(context, ImageZoom(Images.homePhoto));
                        },
                        child: Container(
                          height: 76,width: 76,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.asset(Images.homePhoto,fit: BoxFit.cover,),
                        ),
                      ),
                      separatorBuilder: (c,i)=>const SizedBox(width: 25,),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
