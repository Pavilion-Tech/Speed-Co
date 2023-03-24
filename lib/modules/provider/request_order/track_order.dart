import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';

class PTrackOrderScreen extends StatefulWidget {

  PTrackOrderScreen(this.lat,this.lng);
  String lat;
  String lng;

  @override
  State<PTrackOrderScreen> createState() => _PTrackOrderScreenState();
}

class _PTrackOrderScreenState extends State<PTrackOrderScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = ProviderCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: pDefaultAppBar(context: context,title: ''),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target:cubit.position!=null
                    ?LatLng(cubit.position!.latitude,cubit.position!.longitude)
                    : LatLng(25.019083,55.121239),
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
                Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    Text(
                      '${cubit.directions?.totalDistance??''}',
                      style: TextStyle(color: defaultColorTwo,fontSize: 32,fontWeight: FontWeight.w500),
                    ),
                    // InkWell(
                    //     onTap: (){
                    //       if(cubit.origin!=null) cubit.openMap();
                    //     },
                    //     child: Icon(Icons.location_on_outlined,color: defaultColor,size: 40,)),
                  ],
                ),
                Text(
                  '${cubit.directions?.totalDuration??''}',
                  style: TextStyle(color: defaultColorTwo,fontSize: 18,height: 1),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    itemBuilder(Images.car,0,(){
                      setState(() {
                        currentIndex = 0;
                      });
                      cubit.getDirection(
                        mode: 'driving',
                          origin: LatLng(cubit.position!.latitude,cubit.position!.longitude),
                          destination: LatLng(double.parse(widget.lat),double.parse(widget.lng))
                      );
                    }),
                    itemBuilder(Images.walk,1,(){
                      setState(() {
                        currentIndex = 1;
                      });
                      cubit.getDirection(
                        mode: 'walking',
                          origin: LatLng(cubit.position!.latitude,cubit.position!.longitude),
                          destination: LatLng(double.parse(widget.lat),double.parse(widget.lng)
                      ));
                    }),
                    itemBuilder(Images.bus,2,(){
                      setState(() {
                        currentIndex = 2;
                      });
                      cubit.getDirection(
                        mode: 'bicycling',
                          origin: LatLng(cubit.position!.latitude,cubit.position!.longitude),
                          destination: LatLng(double.parse(widget.lat),double.parse(widget.lng)                          )
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
);
  }

  Widget itemBuilder(String image, int index,VoidCallback onTap){
    return InkWell(
      onTap:onTap,
        child: Image.asset(image,width: 70,color: currentIndex == index?defaultColor:null));
  }
}
