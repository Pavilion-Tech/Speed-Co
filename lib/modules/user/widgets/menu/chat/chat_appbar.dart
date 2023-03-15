import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';

PreferredSizeWidget chatAppBar(context,String id){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      onPressed: (){
        MenuCubit.get(context).chatModel=null;
        Navigator.pop(context);
      },
      icon:const Icon(Icons.arrow_back,color: Colors.black,),
    ),
    title: Text('#$id',
      style:const TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
  );
}
