import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/layouts/provider_layout/provider_layout.dart';
import 'package:speed_co/layouts/user_layout/user_layout.dart';
import '../../../../layouts/user_layout/cubit/user_cubit.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/styles/colors.dart';
import '../../../item_shared/default_button.dart';

class ChangeLangBottomSheet extends StatelessWidget {
  ChangeLangBottomSheet({this.isUser = true});

  bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsetsDirectional.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tr('change_language'),
            style:const TextStyle(
              fontSize: 20,fontWeight: FontWeight.w500
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 30),
            child: Text(
              tr('change_language_sure'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,fontWeight: FontWeight.w500,color: defaultColorFour
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Container(
                    height: 51,
                    width:double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(60),
                        color: defaultColor
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      tr('discard'),
                      style:const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                  child: DefaultButton(
                      text: tr('apply'),
                      onTap: (){
                        myLocale = myLocale == 'en'? 'ar':'en';
                        context.setLocale(Locale(myLocale));
                        CacheHelper.saveData(key: 'locale', value: myLocale);
                        if(isUser){
                          navigateAndFinish(context, UserLayout());
                        }else{
                          navigateAndFinish(context, ProviderLayout());
                        }
                      }
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
