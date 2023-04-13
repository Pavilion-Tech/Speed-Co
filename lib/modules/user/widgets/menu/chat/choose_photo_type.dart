import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../item_shared/default_button.dart';
import '../../../menu_screens/menu_cubit/menu_cubit.dart';
import '../../../menu_screens/menu_cubit/menu_states.dart';
import '../image_bottom.dart';


class ChoosePhotoType extends StatefulWidget {
  ChoosePhotoType(this.id);
  String id;


  @override
  State<ChoosePhotoType> createState() => _ChoosePhotoTypeState();
}

class _ChoosePhotoTypeState extends State<ChoosePhotoType> {
  void chooseImage(ImageSource source, BuildContext context) async {
    var cubit = MenuCubit.get(context);
    cubit.chatImage = await cubit.pick(source);
    cubit.chatImage = await checkImageSize(cubit.chatImage);
    cubit.justEmit();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {
        if(state is SendMessageSuccessState)Navigator.pop(context);
      },
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
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
              if(cubit.chatImage!=null)
              Expanded(child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.file(File(cubit.chatImage!.path),fit: BoxFit.cover,),
                  InkWell(
                    onTap: (){
                      cubit.chatImage= null;
                      cubit.justEmit();
                    },
                      child: Image.asset(Images.delete,color: Colors.red,width: 30,))
                ],
              )),
              if(cubit.chatImage!=null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:state is! SendMessageLoadingState ?DefaultButton(
                      text: tr('send'),
                      onTap: (){
                        cubit.sendMessage(
                            id: widget.id, type: 2
                        );
                      }
                      ):CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
