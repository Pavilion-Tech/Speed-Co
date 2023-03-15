import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/styles/colors.dart';

class TrackRequestScreen extends StatefulWidget {
  TrackRequestScreen(this.id);
  String id;

  @override
  State<TrackRequestScreen> createState() => _TrackRequestScreenState();
}

class _TrackRequestScreenState extends State<TrackRequestScreen> {

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 20),
        (){
        MenuCubit.get(context).getSingleOrder(widget.id);
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar(context: context,haveChat: false,haveNotification: false),
      body: ConditionalBuilder(
        condition: cubit.position!=null&&cubit.singleOrderModel!=null,
        fallback: (context)=>const Center(child: CircularProgressIndicator(),),
        builder: (context)=> Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
           GoogleMap(
             initialCameraPosition: CameraPosition(
               target: LatLng(cubit.position!.latitude,cubit.position!.longitude),
               zoom: 14
             ),
             polylines: {
               if(cubit.directions!=null)
               Polyline(
                   width: 8,
                   color: defaultColor,
                   polylineId: const PolylineId('polyLine'),
                   points: cubit.directions!.polylinePoints.map((e) =>
                       LatLng(e.latitude, e.longitude)).toList()
               ),
             },
             markers: {
               if(cubit.origin!=null)cubit.origin!,
               if(cubit.distance!=null)cubit.distance!,
             },
           ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(50),
                    topStart: Radius.circular(50),
                  ),
                  image: DecorationImage(image: AssetImage(Images.background,),fit: BoxFit.cover)
              ),
              padding:const EdgeInsetsDirectional.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(cubit.directions!=null)
                  Text(
                    cubit.directions!.totalDistance,
                    style: TextStyle(color: defaultColorTwo,fontSize: 32,fontWeight: FontWeight.w500),
                  ),
                  if(cubit.directions!=null)
                    Text(
                    cubit.directions!.totalDuration,
                    style: TextStyle(color: defaultColorTwo,fontSize: 18,height: 1),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 68,width: 65,
                        decoration:const BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ImageNet(image: cubit.singleOrderModel!.data!.providerImage??'',),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Text(
                          cubit.singleOrderModel!.data!.providerName??'',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: defaultColorTwo,fontSize: 20,fontWeight: FontWeight.w500),
                        ),
                      ),
                      Image.asset(Images.car,width: 34,)

                    ],
                  ),
                  Center(
                    child: InkWell(
                        onTap: (){
                            String phone = cubit.singleOrderModel!.data!.providerPhoneNumber??'';
                            print(phone);
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: phone,
                            );
                            openUrl(launchUri.toString());

                        },
                        child: Image.asset(Images.phone5,width: 44,)),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
