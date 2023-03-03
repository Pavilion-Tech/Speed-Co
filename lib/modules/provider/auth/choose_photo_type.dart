import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../auth/auth_cubit/auth_cubit.dart';
import '../../auth/auth_cubit/auth_states.dart';
import '../../item_shared/default_button.dart';
import '../../user/widgets/menu/image_bottom.dart';


class PAuthChoosePhotoType extends StatefulWidget {



  @override
  State<PAuthChoosePhotoType> createState() => _PAuthChoosePhotoTypeState();
}

class _PAuthChoosePhotoTypeState extends State<PAuthChoosePhotoType> {
  void chooseImage(ImageSource source, BuildContext context) async {
    var cubit = AuthCubit.get(context);
    cubit.image = await cubit.pick(source);
    cubit.justEmit();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context, state) {
      //  if(state is SendMessageSuccessState)Navigator.pop(context);
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(tr('select_image'), style:const TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              Row(
                children: [
                  ImageButtom(
                      onTap: () {
                        chooseImage(ImageSource.gallery, context);
                      },
                      title: tr('browse'),
                      image: Images.browse
                  ),
                  const Spacer(),
                  ImageButtom(
                      onTap: () {
                        chooseImage(ImageSource.camera, context);
                      },
                      title: tr('camera'),
                      image: Images.camera
                  ),
                ],
              ),
              if(cubit.image!=null)
              Expanded(child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.file(File(cubit.image!.path),fit: BoxFit.cover,),
                  InkWell(
                    onTap: (){
                      cubit.image= null;
                      cubit.justEmit();
                    },
                      child: Image.asset(Images.delete,color: Colors.red,width: 30,))
                ],
              )),
              if(cubit.image!=null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:DefaultButton(
                      text: tr('send'),
                      onTap: ()=>Navigator.pop(context)
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
