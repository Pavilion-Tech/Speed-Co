import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_cubit.dart';
import 'package:speed_co/layouts/provider_layout/cubit/provider_states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';

class PTrackOrderScreen extends StatefulWidget {

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
                Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    Text(
                      '3.2 KM',
                      style: TextStyle(color: defaultColorTwo,fontSize: 32,fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                        onTap: (){
                          if(cubit.origin!=null) cubit.openMap();
                        },
                        child: Icon(Icons.location_on_outlined,color: defaultColor,size: 40,)),
                  ],
                ),
                Text(
                  '10 Min',
                  style: TextStyle(color: defaultColorTwo,fontSize: 18,height: 1),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    itemBuilder(Images.car,0),
                    itemBuilder(Images.walk,1),
                    itemBuilder(Images.bus,2),
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

  Widget itemBuilder(String image, int index){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
        });
      },
        child: Image.asset(image,width: 70,color: currentIndex == index?defaultColor:null));
  }
}
