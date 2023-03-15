import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_states.dart';

import '../../../../shared/images/images.dart';
import '../../../item_shared/default_button.dart';
import '../menu/image_bottom.dart';


class ChoosePhotoPlace extends StatefulWidget {



  @override
  State<ChoosePhotoPlace> createState() => _ChoosePhotoPlaceState();
}

class _ChoosePhotoPlaceState extends State<ChoosePhotoPlace> {

  void chooseImage(ImageSource source, BuildContext context) async {
    var cubit = UserCubit.get(context);
    if(source == ImageSource.camera){
      XFile? file = await cubit.pick();
      cubit.images.add(file!);
      cubit.emitState();
    }else{
      cubit.selectImages();
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
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
              if(cubit.images.isNotEmpty)
              Expanded(child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (c,i)=>Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.file(File(cubit.images[i].path),fit: BoxFit.cover,width: 200,height: 200,),
                      InkWell(
                          onTap: (){
                            cubit.images.removeAt(i);
                            cubit.emitState();
                          },
                          child: Image.asset(Images.delete,color: Colors.red,width: 200,))
                    ],
                  ),
                  separatorBuilder: (c,i)=>const SizedBox(width: 20,),
                  itemCount: cubit.images.length
              )),
              if(cubit.images.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:DefaultButton(
                      text: tr('send'),
                      onTap: (){
                        Navigator.pop(context);
                      }
                      ),
                ),
            ],
          ),
        );
      },
    );
  }
}
