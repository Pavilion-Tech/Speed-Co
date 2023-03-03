import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../layouts/provider_layout/cubit/provider_cubit.dart';
import '../../item_shared/default_button.dart';
import '../../item_shared/default_form.dart';
import '../../user/widgets/item_shared/map_address_screen.dart';
import '../widgets/menu/choose_profile_photo.dart';


class PEditProfileScreen extends StatelessWidget {
   PEditProfileScreen({Key? key}) : super(key: key);
   TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderMenuCubit, ProviderMenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = ProviderMenuCubit.get(context);
    return Scaffold(
      appBar: pDefaultAppBar(context: context,title: tr('profile_info'),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,width: 180,
                    decoration:const BoxDecoration(shape: BoxShape.circle,color: Colors.white,),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child:cubit.profileImage!=null
                        ?Image.file(File(cubit.profileImage!.path),fit: BoxFit.cover,)
                        : Image.asset(Images.homePhoto,fit: BoxFit.cover,),                  ),
                  Positioned(
                    bottom: 15,
                    right: 10,
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (context)=>PChooseProfilePhotoType()
                        );
                      },
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black54,
                        child: Image.asset(Images.edit,width: 11,height: 11,),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: DefaultForm(
                  hint: tr('name'),
                ),
              ),
              DefaultForm(
                hint: tr('location'),
                isRead: true,
                controller: addressController,
                onTap: ()async{
                  await ProviderCubit.get(context).getCurrentLocation();
                  if(ProviderCubit.get(context).position!=null){
                    navigateTo(context, MapAddressScreen(ProviderCubit.get(context).position!,addressController));
                  }
                },
                suffix: Image.asset(Images.location,width: 9,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: DefaultForm(
                  hint: tr('email'),
                  type: TextInputType.emailAddress,
                  suffix: Image.asset(Images.mail,width: 9,),
                ),
              ),
              DefaultButton(
                  text: tr('save'),
                  onTap: ()=>Navigator.pop(context)
              )
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
