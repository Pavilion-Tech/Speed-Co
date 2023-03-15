import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/modules/auth/login_screen.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/terms_screen.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../shared/components/components.dart';
import '../../../../splash_screen.dart';
import '../../../item_shared/default_button.dart';
import '../../../item_shared/delete_dialog.dart';
import '../../menu_screens/aboutus_screen.dart';
import '../../menu_screens/contactus_screen.dart';
import '../menu/lang.dart';


class OurApp extends StatelessWidget {
  const OurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemBuilder(
                image: Images.lang,
                title: tr('change_language'),
                onTap:  (){
                  showModalBottomSheet(
                      context: context,
                      shape:const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(30),
                              topStart: Radius.circular(30))
                      ),
                      builder: (context)=> ChangeLangBottomSheet()
                  );
                }
            ),
        const SizedBox(height: 20,),
        itemBuilder(
            image: Images.email,
            title: tr('contact_us'),
            onTap:  (){
              navigateTo(context, ContactUsScreen());
            }
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: itemBuilder(
              image: Images.info,
              title: tr('about_us'),
              onTap:  ()=>navigateTo(context, AboutUsScreen())
          ),
        ),
        itemBuilder(
            image: Images.lock2,
            title: tr('terms'),
            onTap:  ()=>navigateTo(context, TermsScreen())
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            '${tr('version')} $version',
            style:const TextStyle(fontSize: 17),
          ),
        ),
        Column(
          children: [
            InkWell(
                onTap: ()=>openUrl('https://pavilion-teck.com/'),
                child: Image.asset(Images.pavilion,width: 87,height: 20,)),
            const SizedBox(height: 20,),
            Center(
              child: DefaultButton(
                  text:token!=null? tr('logout'):tr('sign_in'),
                  width: size!.width*.5,
                  onTap: (){
                    token!=null
                        ? MenuCubit.get(context).logout(context: context)
                        : navigateTo(context,LoginScreen(haveArrow: true,));
                  }
              ),
            ),
            if(token!=null)
            TextButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context)=>DeleteDialog((){
                        MenuCubit.get(context).logout(context: context,destroy: 2);
                      })
                  );
                },
                child: Text(
                  tr('delete_account'),
                  style: TextStyle(color: defaultColor,fontSize: 17,fontWeight: FontWeight.w500),
                )
            ),
          ],
        )
      ],
    );
  }

  Widget itemBuilder({
    required String image,
    required String title,
    required VoidCallback onTap
  }){
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(image,width:20,height: 20,color: defaultColor,),
          const SizedBox(width: 10,),
          Text(
            title,
            style:const TextStyle(fontSize: 17),
          )

        ],
      ),
    );
  }
}
