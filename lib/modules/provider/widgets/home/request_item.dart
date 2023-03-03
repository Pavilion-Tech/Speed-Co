import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../request_order/request_details_screen.dart';
import '../../request_order/track_order.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 15
          )
        ]
      ),
      padding:const EdgeInsetsDirectional.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(Images.person2,width: 20,),
          Text(
            'Marwan Sayed ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: defaultColorTwo,fontSize: 23,fontWeight: FontWeight.w500),
          ),
          Divider(height: 2,color: Colors.black,),
          const SizedBox(height: 15,),
          Image.asset(Images.phone,width: 20,),
          Text(
            '+20 1122711137',
            maxLines: 1,
            style: TextStyle(color: defaultColorTwo,fontSize: 19),
          ),
          Divider(height: 2,color: Colors.black,),
          const SizedBox(height: 15,),
          InkWell(
            onTap: ()async{
              String googleUrl =
                  'https://www.google.com/maps/dir/?api=1&origin=25.019083,55.121239&destination=25.019083,55.111239';
              print(googleUrl);
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Images.location2,width: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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
                      '25/12/2023',
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
                        '15:30 PM',
                        maxLines: 1,
                        style: TextStyle(color: defaultColorTwo,fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: ()=>navigateTo(context, RequestDetailsScreen()),
            child: Center(
              child: Text(
                tr('more_details'),
                maxLines: 1,
                style: TextStyle(color: defaultColor,fontSize: 16,fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          DefaultButton(text: tr('carry_out'), onTap: (){
            ProviderCubit.get(context).getDirection(
                origin: LatLng(25.019083,55.121239),
                destination: LatLng(25.081009, 55.242082)
            );
            navigateTo(context, PTrackOrderScreen());
          })
        ],
      ),
    );
  }

}
