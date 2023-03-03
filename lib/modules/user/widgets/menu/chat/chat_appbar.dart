import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget chatAppBar(context){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      onPressed: ()=>Navigator.pop(context),
      icon:const Icon(Icons.arrow_back,color: Colors.black,),
    ),
    title: Text(tr('technical_support'),
      style:const TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
  );
}
