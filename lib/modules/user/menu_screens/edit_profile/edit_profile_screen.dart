import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_states.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../item_shared/default_button.dart';
import '../../../item_shared/default_form.dart';
import '../../widgets/item_shared/map_address_screen.dart';
import '../../widgets/menu/choose_proifle_photo.dart';
import '../menu_cubit/menu_cubit.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController latController = TextEditingController();
   TextEditingController lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(MenuCubit.get(context).userModel!.data!.currentLatitude!.isNotEmpty)
    nameController.text = MenuCubit.get(context).userModel!.data!.name!;
    emailController.text = MenuCubit.get(context).userModel!.data!.email??'';
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {
    if(state is UpdateUserSuccessState)Navigator.pop(context);
  },
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      appBar: defaultAppBar(context: context,title:tr('profile_info'),isMenu: true),
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
                        : ImageNet(image: cubit.userModel!.data!.personalPhoto!),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 10,
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (context)=>ChooseProfilePhotoType()
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
                  controller: nameController,
                ),
              ),
              DefaultForm(
                hint: tr('location'),
                isRead: true,
                controller: cubit.addressController,
                onTap: ()async{
                  await cubit.getCurrentLocation();
                  if(cubit.position!=null){
                    navigateTo(context, MapAddressScreen(
                        cubit.position!,
                      cubit.addressController,
                      lat: latController,
                      lng: lngController,
                    ));
                  }
                },
                suffix: Image.asset(Images.location,width: 9,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: DefaultForm(
                  hint: tr('email'),
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  suffix: Image.asset(Images.mail,width: 9,),
                ),
              ),
              state is! UpdateUserLoadingState?
              DefaultButton(
                  text: tr('save'),
                  onTap: (){
                    cubit.updateUser(
                        name: nameController.text,
                        lat: latController.text,
                        lng: lngController.text,
                        email: emailController.text
                    );
                  }
              ):const Center(child: CircularProgressIndicator(),)
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
