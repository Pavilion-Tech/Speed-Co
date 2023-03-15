import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import 'package:speed_co/shared/styles/colors.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../auth/auth_cubit/auth_cubit.dart';
import '../../auth/auth_cubit/auth_states.dart';
import '../../auth/login_screen.dart';
import '../../item_shared/default_form.dart';
import '../../user/widgets/item_shared/map_address_screen.dart';
import 'choose_photo_type.dart';

class ProviderSignUpScreen extends StatelessWidget {
   ProviderSignUpScreen({Key? key}) : super(key: key);

   TextEditingController addressController = TextEditingController();
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController fileController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController latController = TextEditingController();
   TextEditingController lngController = TextEditingController();
   var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
  listener: (context, state) {
    if(isConnect!=null)checkNet(context,isUser: false);
    if(state is CreateProviderSuccessState)
      navigateAndFinish(context, LoginScreen());
  },
  builder: (context, state) {
    var cubit = AuthCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 270,
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(Images.curve,fit: BoxFit.cover,width: double.infinity,),
                  Image.asset(Images.background,color: Colors.white,fit: BoxFit.cover,width: double.infinity,),
                  Text(
                    tr('sign_up'),
                    style:const TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          DefaultForm(
                            controller: nameController,
                            hint: tr('name'),
                            validator: (val){
                              if(val.isEmpty)return tr('name_empty');
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: DefaultForm(
                              controller: phoneController,
                              hint: tr('phone'),
                              filteringTextInputFormatter: true,
                              textLength: 10,
                              type: TextInputType.phone,
                              validator: (val){
                                if(val.length < 10)return tr('password_poor');
                                if(val.isEmpty)return tr('phone_empty');
                              },
                              suffix: Image.asset(
                                Images.flag,
                                width: 9,
                              ),
                            ),
                          ),
                          DefaultForm(
                            hint: tr('location'),
                            isRead: true,
                            controller: addressController,
                            validator: (val){
                              if(val.isEmpty)return tr('location_empty');
                            },
                            onTap: () async {
                              await AuthCubit.get(context)
                                  .getCurrentLocation();
                              if (AuthCubit.get(context).position != null) {
                                navigateTo(
                                    context,
                                    MapAddressScreen(
                                      AuthCubit.get(context).position!,
                                      addressController,
                                      lat: latController,
                                      lng: lngController,
                                    ));
                              }
                            },
                            suffix: Image.asset(
                              Images.addLocation,
                              width: 9,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: DefaultForm(
                              hint: tr('email'),
                              controller: emailController,
                              validator: (val){
                                if(val.isEmpty)return tr('email_empty');
                                if(!val.contains('@'))return tr('email_invalid');
                                if(!val.contains('.'))return tr('email_invalid');
                              },
                              type: TextInputType.emailAddress,
                              suffix: Image.asset(Images.mail,width: 9,),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: DefaultForm(
                                  hint: tr('file'),
                                  controller: fileController,
                                  onTap: (){
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context)=>PAuthChoosePhotoType()
                                    );
                                  },
                                  validator: (val){
                                    if(val.isEmpty)return tr('file_empty');
                                  },
                                  isRead: true,
                                ),
                              ),
                              const SizedBox(width: 25,),
                              InkWell(
                                onTap: (){
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context)=>PAuthChoosePhotoType()
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: defaultColor,
                                  child: Image.asset(Images.uploadImage,width: 17,),
                                ),
                              )
                            ],
                          ),
                          if(cubit.image!=null)
                          Builder(
                            builder:(context){
                              Future.delayed(Duration.zero,(){
                                fileController.text = cubit.image!.path;
                              });
                              return Padding(
                                padding:const EdgeInsets.symmetric(vertical: 20),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image.file(File(cubit.image!.path)),
                                    IconButton(
                                      onPressed: (){
                                        cubit.image = null;
                                        fileController.text = '';
                                        cubit.justEmit();
                                      },
                                      icon:const Icon(Icons.delete,color: Colors.red,size: 30,),
                                    )
                                  ],
                                ),
                              );
                            }
                          )

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child:state is! CreateProviderLoadingState ? DefaultButton(
                        text:tr('sign_up'),
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            AuthCubit.get(context).createProvider(
                                phone: phoneController.text,
                                name: nameController.text,
                                email: emailController.text,
                                lat: latController.text,
                                lng: lngController.text
                            );
                          }
                        },
                      ):const Center(child: CircularProgressIndicator(),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr('have_account'),
                          style:const TextStyle(color: Colors.black,fontSize: 10),
                        ),
                        TextButton(
                            onPressed: (){
                              navigateAndFinish(context, LoginScreen());
                            },
                            child: Text(
                              tr('back'),
                              style:const TextStyle(fontSize: 10,fontWeight: FontWeight.w600),
                            )
                        )
                      ],
                    ),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  },
);
  }
}
