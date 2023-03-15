import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/order/rate_screen.dart';
import 'package:speed_co/modules/user/menu_screens/order/track_request_screen.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/styles/colors.dart';
import '../../../../models/user/orders_model.dart';
import '../../../../shared/images/images.dart';
import '../../../item_shared/image_zoom.dart';
import 'order_details_appbar.dart';


class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen(this.data,this.status);
  OrderData data;
  String status;
  @override
  Widget build(BuildContext context) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.homeCurve,height: 300,width:double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              OrderDetailsAppBar(data.id!,data.status!,data.itemNumber.toString()),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                            width: 234,height: 200,
                            child:ImageNet(image: data.serviceImage??'',width: 234,height: 266)
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            data.serviceTitle??'',
                            style: TextStyle(color: defaultColorTwo,fontSize: 23,fontWeight: FontWeight.w600),
                          ),
                        ),
                        if(data.status==2)
                        DefaultButton(
                          text: tr('track'),
                            onTap: ()async{
                            cubit.getSingleOrder(data.id??'');
                              await cubit.getCurrentLocation();
                              if(cubit.position!=null){
                                cubit.getDirections(
                                    origin: LatLng(cubit.position!.latitude,cubit.position!.longitude),
                                    destination: LatLng(double.parse(data.providerLatitude!), double.parse(data.providerLongitude!))
                                );
                                navigateTo(context, TrackRequestScreen(data.id!));
                              }
                            },
                          width: size!.width*.8,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '#${data.itemNumber}',
                                      style: TextStyle(color: defaultColorTwo,fontSize: 25,fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      data.createdAt??'',
                                      style: TextStyle(color: defaultColorTwo,fontSize: 9,height: 1),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 47,
                                width: 130,
                                decoration: BoxDecoration(
                                    color: defaultColor,
                                    borderRadius: BorderRadiusDirectional.circular(60)
                                ),
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  status,
                                  style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                        itemBuilder(
                          image: Images.requestDate,
                          text: tr('request_date'),
                          subText: data.date??''
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: itemBuilder(
                            image: Images.requestTime,
                            text: tr('request_time'),
                            subText: data.time??''
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            tr('problem_description'),
                            style: TextStyle(
                                color: defaultColorTwo,fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadiusDirectional.circular(20)
                            ),
                            alignment: AlignmentDirectional.centerStart,
                            padding:const EdgeInsetsDirectional.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.description??'',
                                  style: TextStyle(fontSize: 12,color: defaultColorTwo,height: 2.2),
                                ),
                                const SizedBox(height: 20,),
                                if(data.images!.isNotEmpty)
                                SizedBox(
                                  height: 78,
                                  child: ListView.separated(
                                      itemBuilder: (c,i)=>InkWell(
                                        onTap: (){
                                          navigateTo(context, ImageZoom(data.images![i]));
                                        },
                                        child: Container(
                                          decoration:const BoxDecoration(shape: BoxShape.circle),
                                          height: 76,width: 76,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: ImageNet(image:data.images![i]),
                                        ),
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (c,i)=>const SizedBox(width: 25,),
                                      itemCount: data.images!.length
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if(data.status ==3)
                        DefaultButton(
                            text: tr('rate_review'),
                            onTap: ()=>navigateTo(context, RateScreen(data.providerId??''))
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget itemBuilder({
  required String image,
  required String text,
    String subText = '',
}){
    return Row(
      children: [
        Image.asset(image,width: 16.5,),
        const SizedBox(width: 10,),
        Text(
          text,
          style: TextStyle(
            color: defaultColorTwo,fontWeight: FontWeight.w500
          ),
        ),
        const Spacer(),
        Text(
          subText,
          style: TextStyle(
              color: defaultColorTwo
          ),
        ),
      ],
    );
  }
}
