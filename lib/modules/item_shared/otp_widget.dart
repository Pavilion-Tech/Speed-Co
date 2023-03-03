import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speed_co/shared/styles/colors.dart';
import '../../../shared/components/constants.dart';

class OTPWidget extends StatelessWidget {
  OTPWidget(this.controller,{this.onFinished});


  VoidCallback? onFinished;
  TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Container(
      height:59,
      width: 59,
      alignment: Alignment.center,
     // padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: defaultColor.withOpacity(.2),
        shape: BoxShape.circle
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: '*',
          hintStyle: TextStyle(color: defaultColor,fontSize: 30,height:2.7),
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if(value.isNotEmpty){
            myLocale =='ar'
                ? FocusManager.instance.primaryFocus!.previousFocus()
                :FocusManager.instance.primaryFocus!.nextFocus();
            if(onFinished!=null)onFinished!();
          }else{
            myLocale =='ar'
                ? FocusManager.instance.primaryFocus!.nextFocus()
                :FocusManager.instance.primaryFocus!.previousFocus();
          }
          },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }


}


