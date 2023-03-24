import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:speed_co/shared/styles/colors.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../item_shared/default_button.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  List<String> images = [
    Images.gmail2,
    Images.whats2,
    Images.face2,
    Images.twitter2,
    Images.insta2,
  ];
  TextEditingController subjectController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context,title: tr('contact_us'),isMenu: true),
      body: BlocConsumer<MenuCubit,MenuStates>(
        listener: (c,s){
          if(s is ContactSuccessState)Navigator.pop(context);
        },
        builder: (c,s){
          var cubit = MenuCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(cubit.settingsModel!=null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        itemBuilder(
                            image: images[0],
                            onTap:(){
                              final Uri params = Uri(
                                scheme: 'mailto',
                                path: cubit.settingsModel?.data?.projectEmailAddress??'',
                              );
                              final url = params.toString();
                              openUrl(url);
                            }
                        ),
                        itemBuilder(
                            image: images[1],
                            onTap:(){
                              String phone = cubit.settingsModel?.data?.projectWhatsAppNumber ?? '';
                              String waUrl = 'https://wa.me/$phone';
                              openUrl(waUrl);
                            }
                        ),
                        itemBuilder(
                            image: images[2],
                            onTap:(){
                              openUrl(cubit.settingsModel?.data?.projectFacebookLink??'');
                            }
                        ),
                        itemBuilder(
                            image: images[3],
                            onTap:(){
                              openUrl(cubit.settingsModel?.data?.projectTwitterLink??'');
                            }
                        ),
                        itemBuilder(
                            image: images[4],
                            onTap:(){
                              openUrl(cubit.settingsModel?.data?.projectInstagramLink??'');
                            }
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                      //  height: 60,
                        width: double.infinity,
                        padding:const EdgeInsetsDirectional.only(start: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(10),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: subjectController,
                          validator: (val){
                            if(val!.isEmpty)return tr('subject_empty');
                          },
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: tr('subject')
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding:const EdgeInsetsDirectional.only(start: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(10),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        controller: descController,
                        validator: (val){
                          if(val!.isEmpty)return tr('desc_empty');
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: tr('your_message')
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    s is! ContactLoadingState ?
                    DefaultButton(
                        text: tr('send_message'),
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            cubit.contactUs(
                                subject: subjectController.text,
                                message: descController.text
                            );
                          }
                        }
                    ):const Center(child: CircularProgressIndicator(),)
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget itemBuilder({
  required String image,
  required VoidCallback onTap
}){
    return InkWell(
      onTap: onTap,
        child: Image.asset(image,width: 20,height: 20,color: defaultColor,));
  }
}
