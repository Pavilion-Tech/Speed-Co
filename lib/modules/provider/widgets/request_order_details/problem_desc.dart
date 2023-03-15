import 'package:flutter/material.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/item_shared/image_zoom.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/styles/colors.dart';

import '../../../../models/provider/request_model.dart';
import '../../../user/menu_screens/chat/chat_screen.dart';
import '../../menu_screens/chat/pchat_screen.dart';

class ProblemDesc extends StatelessWidget {
  ProblemDesc(this.data);
  RequestData data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20,left:20 ,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              ProviderMenuCubit.get(context).chat(data.id!);
              navigateTo(context, PChatScreen(data.itemNumber.toString(),data.id??''));
            },
              child: Image.asset(Images.problemDesc,width: 30,)),
          const SizedBox(height: 10,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color:Colors.grey.shade200,
            ),
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.description??'',
                  style: TextStyle(color: defaultColorTwo,fontSize: 12),
                ),
                const SizedBox(height: 20,),
                if(data.images!.isNotEmpty)
                SizedBox(
                  height: 76,
                  child: ListView.separated(
                      itemBuilder: (c,i)=>InkWell(
                        onTap: (){
                          navigateTo(context, ImageZoom(data.images![i]));
                        },
                        child: Container(
                          height: 76,width: 76,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ImageNet(image: data.images![i],),
                        ),
                      ),
                      separatorBuilder: (c,i)=>const SizedBox(width: 25,),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.images!.length
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
