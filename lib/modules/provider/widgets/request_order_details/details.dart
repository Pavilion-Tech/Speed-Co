import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../layouts/provider_layout/cubit/provider_cubit.dart';
import '../../../../models/provider/request_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';

class Details extends StatelessWidget {
  Details(this.data);
  RequestData data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(Images.person2,width: 20,),
          Text(
            data.userName??'',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: defaultColorTwo,fontSize: 23,fontWeight: FontWeight.w500),
          ),
          Divider(height: 2,color: Colors.black,),
          const SizedBox(height: 15,),
          Image.asset(Images.phone,width: 20,),
          Row(
            children: [
              Text(
                data.userPhone??'',
                maxLines: 1,
                style: TextStyle(color: defaultColorTwo,fontSize: 19),
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  String phone = data.userPhone??'';
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: phone,
                  );
                  openUrl(launchUri.toString());
                  },
                  child: Image.asset(Images.phone5,width: 44,)),
            ],
          ),
          const SizedBox(height: 5,),
          Divider(height: 2,color: Colors.black,),
          const SizedBox(height: 15,),
          InkWell(
            onTap: ()async{
              var cubit = ProviderCubit.get(context);
              await cubit.getCurrentLocation();
              if(cubit.position!=null){
                String googleUrl =
                    'https://www.google.com/maps/dir/?api=1&origin=${cubit.position!.latitude},${cubit.position!.longitude}&destination=${data.userLatitude},${data.userLongitude}';
                print(googleUrl);
                if (await canLaunch(googleUrl)) {
                  await launch(googleUrl);
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Images.location2,width: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    data.userAddress??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: defaultColorTwo,fontSize: 13,height: 1),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 2,color: Colors.black,),
          Padding(
            padding: const EdgeInsets.only(top: 15.0,bottom: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(Images.requestDate,width: 20,),
                    Text(
                      data.date??'',
                      maxLines: 1,
                      style: TextStyle(color: defaultColorTwo,fontSize: 13),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding:EdgeInsetsDirectional.only(end: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(Images.requestTime,width: 20,),
                      Text(
                        data.time??'',
                        maxLines: 1,
                        style: TextStyle(color: defaultColorTwo,fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
