import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/shared/components/components.dart';

import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';

class PNotificationScreen extends StatelessWidget {
  //NoNotifications()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pDefaultAppBar(context: context,title: tr('notification')),
      body: ListView.separated(
          itemBuilder: (c,i)=>itemBuilder(),
          padding: const EdgeInsets.all(20),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          itemCount: 3
      ),
    );
  }
  Widget itemBuilder(){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: Colors.grey.shade200
          ),
          alignment: AlignmentDirectional.center,
          padding: EdgeInsetsDirectional.only(
              start: 85,
              end: 30,
              top: 20,bottom: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '112233',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color:defaultColorTwo,fontSize: 16,fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    '2 Hours ago',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color:defaultColorTwo,fontSize: 8),
                  ),
                ],
              ),
              Text(
                'Air Conditioner Service',
               // overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Positioned(
            left: 5,
            child: Image.asset(Images.homePhoto2,height: 74,width: 65,fit: BoxFit.cover,))
      ],
    );
  }

}
