import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/shared/components/components.dart';
import '../../../../models/place_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../item_shared/default_button.dart';
import '../../../item_shared/default_form.dart';

class MapAddressScreen extends StatefulWidget {
  MapAddressScreen(this.position,this.controller,{this.lat,this.lng,this.isDialog = false});
  Position position;
  TextEditingController controller;
  TextEditingController? lat;
  TextEditingController? lng;
  bool isDialog;

  @override
  State<MapAddressScreen> createState() => _MapAddressScreenState();
}

class _MapAddressScreenState extends State<MapAddressScreen> {


  PlaceModel? placeModel;

  bool isLoading = false;
  Dio dio = Dio();

  @override
  initState(){
    widget.lat!.text = widget.position.latitude.toString();
    widget.lng!.text = widget.position.longitude.toString();
    getAddress(latLng: LatLng(widget.position.latitude,widget.position.longitude));
    super.initState();
  }

  Future<void> getAddress({LatLng? latLng}) async {
    setState(() {
      isLoading = true;
    });
    if (latLng != null) {
      List<Placemark> place = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: 'ar');
      Placemark placeMark = place[0];
      widget.controller.text = placeMark.street!;
      widget.controller.text += ', ${placeMark.country!}';
      isLoading = false;
      setState(() { });
    }
  }

  void placeAutoComplete(String text){
    setState(() {
      isLoading = true;
    });
    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json";
    dio.get(
        url,
      queryParameters: {"query":text, "key":googleAPIKey}
    ).then((value) {
      if(value.statusCode == 200){
        setState(() {
          placeModel = PlaceModel.fromJson(value.data);
          isLoading = false;
        });
        debugPrint(value.toString());
      }else{
        print(value.statusMessage);
      }
    }).catchError((e){
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    });
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted)super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target:LatLng(widget.position.latitude,widget.position.longitude),
                  zoom: 14
              ),
            onTap: (LatLng latlng)async{
              await getAddress(latLng: latlng);
              widget.lat!.text = latlng.latitude.toString();
              widget.lng!.text = latlng.longitude.toString();
            },
          ),
          Column(
            children: [
              defaultAppBar(context: context,haveChat: false,haveNotification: false),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 71,
                  width: double.infinity,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(15)
                  ),
                  padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child:TextFormField(
                    onChanged: (val){
                      if(val.isNotEmpty){
                        placeAutoComplete(val);
                      }else{
                        setState(() {
                          placeModel = null;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      suffix: Image.asset(Images.location2,width: 15,),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Type here to Search '
                    ),
                  ),
                ),
              ),
              ConditionalBuilder(
                condition: !isLoading,
                fallback: (c)=>const Expanded(child:  Center(child: CircularProgressIndicator(),)),
                builder: (c)=> ConditionalBuilder(
                  condition: placeModel!=null,
                  fallback: (c)=>const Expanded(child:  SizedBox()),
                  builder: (c)=> Expanded(
                    child: ConditionalBuilder(
                      condition: placeModel!.results!.isNotEmpty,
                      fallback: (c)=>const Expanded(child:  SizedBox()),
                      builder:(c)=> ListView.separated(
                          itemBuilder: (c,i)=>searchWidget(placeModel!.results![i]),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                          itemCount: placeModel!.results!.length
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration:const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                      )
                    ],
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(50),
                      topStart: Radius.circular(50),
                    ),
                    color: Colors.white
                ),
                padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultForm(
                      hint: 'Address Details',
                      controller: widget.controller,
                      suffix: Image.asset(Images.location,width: 12,),
                    ),
                    const SizedBox(height: 20,),
                    DefaultButton(
                        text: 'Save',
                        onTap: (){
                          UserCubit.get(context).emitState();
                          Navigator.pop(context);
                          if(widget.isDialog)Navigator.pop(context);
                        }
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget searchWidget(Results results){
    return InkWell(
      onTap: (){
        setState(() {
          widget.controller.text = results.formattedAddress!;
          placeModel = null;
          widget.lat!.text = results.geometry!.location!.lat.toString();
          widget.lng!.text = results.geometry!.location!.lng.toString();
        });
      },
      child: Container(
        height: 71,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(15)
        ),
        padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: Row(
          children: [
            Image.asset(Images.location2,width: 15,),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${results.formattedAddress}',
                    maxLines: 1,
                    style:const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      '${results.formattedAddress}',
                      maxLines: 1,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
