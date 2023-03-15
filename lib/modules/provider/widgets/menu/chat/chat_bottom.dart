import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_states.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import 'choose_photo_type.dart';

class PChatBottom extends StatelessWidget {
  PChatBottom(this.id);

  String id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderMenuCubit, ProviderMenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProviderMenuCubit.get(context);
        return Row(
          children: [
            Expanded(
                child: Container(
                    height: 63,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: cubit.controller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: tr('type_message'),
                          hintStyle: const TextStyle(
                              fontSize: 13, color: Colors.grey),
                          suffixIcon: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => PChoosePhotoType(id)
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(Images.camera, width: 10,),
                            ),
                          )
                      ),
                    )
                )
            ),
            const SizedBox(width: 5,),
            // state is! SendMessageWithFileLoadingState?
            //  InkWell(
            //    onTap: () async {
            //      var status = await Permission.microphone.request();
            //      if (status != PermissionStatus.granted) {
            //        showToast(msg: 'Microphone permission not granted');
            //        await openAppSettings();
            //      } else {
            //        showDialog(
            //            context: context,
            //            builder: (context) => VoiceDialog()
            //        );
            //      }
            //    },
            //    child: Container(
            //      height: 45,
            //      width: 45,
            //      decoration: BoxDecoration(
            //          color: Colors.white,
            //          borderRadius: BorderRadiusDirectional.circular(15)
            //      ),
            //      alignment: AlignmentDirectional.center,
            //      child: Padding(
            //        padding: const EdgeInsets.all(12.0),
            //        child: Image.asset(Images.microPhone),
            //      ),
            //    ),
            //  ),
            //:const CircularProgressIndicator(),
            const SizedBox(width: 5,),
            state is! SendMessageLoadingState ?
            InkWell(
              onTap: () {
                if (cubit.controller.text.isNotEmpty) {
                  cubit.sendMessage(
                      id: id, type: 1, message: cubit.controller.text);
                }
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(15)
                ),
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.send, color: defaultColor,),
                ),
              ),
            ):const CircularProgressIndicator()
            //     :const CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
