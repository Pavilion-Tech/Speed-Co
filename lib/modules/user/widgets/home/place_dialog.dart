import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/modules/user/widgets/item_shared/map_address_screen.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../item_shared/default_button.dart';

class PlaceOrderDialog extends StatelessWidget {
  const PlaceOrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return Dialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20)),
      child: Padding(
        padding:const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.location,width: 82,height: 82,),
            const SizedBox(height: 25,),
            Text(
              tr('address_sure'),
              style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: DefaultButton(
                  text: tr('choose_address'),
                  onTap: () async {
                    await cubit.getCurrentLocation();
                    if (cubit.position != null) {
                      navigateTo(
                          context,
                          MapAddressScreen(
                            cubit.position!,
                            cubit.addressController,
                            lat: cubit.latController,
                            lng: cubit.lngController,
                          )
                      );
                    }
                  }
                  ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 51,
                width:double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    border: Border.all(color: defaultColor),
                    color: Colors.white
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  tr('cancel_order'),
                  style:TextStyle(color:defaultColor,fontSize: 17,fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
