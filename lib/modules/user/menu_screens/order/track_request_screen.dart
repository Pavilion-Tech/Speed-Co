import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/styles/colors.dart';

class TrackRequestScreen extends StatelessWidget {
  const TrackRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar(context: context,haveChat: false,haveNotification: false),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
         GoogleMap(
           initialCameraPosition: CameraPosition(
             target: LatLng(25.019083,55.121239),
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
                Text(
                  '3.2 KM',
                  style: TextStyle(color: defaultColorTwo,fontSize: 32,fontWeight: FontWeight.w500),
                ),
                Text(
                  '10 Min',
                  style: TextStyle(color: defaultColorTwo,fontSize: 18,height: 1),
                ),
                Row(
                  children: [
                    Container(
                      height: 68,width: 65,
                      decoration:const BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(Images.homePhoto,fit: BoxFit.cover,),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: Text(
                        'Ahmed Ali',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: defaultColorTwo,fontSize: 20,fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        if(cubit.origin!=null) cubit.openMap();
                      },
                        child: Icon(Icons.location_on_outlined,color: defaultColor,size: 40,)),
                    Image.asset(Images.car,width: 34,)

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: (){
                          String phone = '+971562222338';
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: phone,
                          );
                          openUrl(launchUri.toString());
                        },
                        child: Image.asset(Images.phone5,width: 44,)),
                    const SizedBox(width: 20,),
                    InkWell(
                        onTap: () {
                          String phone = '+971562222338';
                          String url() {
                            if (Platform.isAndroid) {
                              return "https://wa.me/$phone/?text=hello"; // new line
                            } else {
                              return "https://api.whatsapp.com/send?phone=$phone"; // new line
                            }
                          }
                          String waUrl = url();
                          openUrl(waUrl);
                        },
                        child: Image.asset(Images.whats5,width: 44,))
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  },
);
  }
}
