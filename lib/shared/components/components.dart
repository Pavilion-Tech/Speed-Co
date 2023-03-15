import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/chat/chat_history_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../modules/auth/login_screen.dart';
import '../../modules/item_shared/wrong_screens/no_net_screen.dart';
import '../../modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import '../../modules/user/menu_screens/notification_screen.dart';
import '../../modules/user/widgets/item_shared/map_address_screen.dart';
import '../images/images.dart';
import '../styles/colors.dart';
import 'constants.dart';

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

// Future<XFile?> checkImageSize (XFile? image)async{
//   if(image!=null) {
//     final bytes = (await image.readAsBytes()).lengthInBytes;
//     final kb = bytes / 1024;
//     final mb = kb / 1024;
//     if(mb<5.0){
//       return image;
//     }else {
//       showToast(msg: tr('image_size'));
//       return null;
//     }
//   }
// }

Future<void> openUrl(String url) async {
  print(url);
  if(await canLaunchUrl(Uri.parse(url))){
    await launchUrl(Uri.parse(url));
  }else{
    showToast(msg: 'This Url can\'t launch');
  }
}




Future showToast ({required String msg , bool? toastState})
{
 return Fluttertoast.showToast(
   msg: msg,
   toastLength: Toast.LENGTH_LONG,
   gravity: ToastGravity.BOTTOM,
   timeInSecForIosWeb: 5,
   textColor: Colors.white,
   fontSize: 16.0,
   backgroundColor: toastState != null
       ? toastState ?Colors.yellow[900]
       : Colors.red : Colors.green,
 );
}



checkNet(context,{bool isUser = true}) {
  if (!isConnect!) {
    navigateTo(context,NoNetScreen(isUser: isUser),);
  }
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  bool colorIsDefault = true,
  bool haveChat = true,
  bool isMenu = false,
  bool haveNotification = true,
  bool haveLocation = false,
  String title = ''
}){
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title:!haveLocation? Text(
        title,
      style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
    ):InkWell(
      onTap: ()async{
        await UserCubit.get(context).getCurrentLocation();
        if(UserCubit.get(context).position!=null){
          navigateTo(context, MapAddressScreen(
              UserCubit.get(context).position!,
              UserCubit.get(context).addressController,
            lat: UserCubit.get(context).latController,
            lng: UserCubit.get(context).lngController,

          ));
        }
      },
      child:UserCubit.get(context).addressController.text.isEmpty? Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(Images.location2,color:defaultColor,width: 13.30,height: 15,),
          const SizedBox(width: 10),
          Text(
            tr('location'),
            style: TextStyle(color: defaultColor,fontSize: 11),
          )
        ],
      ):Text(
        UserCubit.get(context).addressController.text,
        textAlign: TextAlign.center,
        style: TextStyle(color: defaultColor,fontSize: 11),
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.arrow_back,color: colorIsDefault?defaultColor: Colors.white,),
        onPressed: (){
          Navigator.pop(context);
          if(isMenu)Navigator.pop(context);
        }    ),
    actions: [
      if(haveChat)
      InkWell(
        onTap: (){
          if(token!=null){
            MenuCubit.get(context).chatHistory();
            navigateTo(context, ChatHistoryScreen());
          }else{
            navigateTo(context, LoginScreen(haveArrow: true,));
          }
        },
          child: Image.asset(Images.chat,width: 24,height: 24,color: colorIsDefault?defaultColor: Colors.white,)),
      if(!haveNotification)
        const SizedBox(width: 30,),
      if(haveNotification)
        Padding(
        padding: EdgeInsetsDirectional.only(end: 30,start: 20),
        child: InkWell(
          onTap: ()=>navigateTo(context, NotificationScreen()),
            child: Image.asset(Images.notification,width: 24,height: 24,color: colorIsDefault?defaultColor: Colors.white,)),
      ),
    ],
  );
}


PreferredSizeWidget pDefaultAppBar({
  required BuildContext context,
  required String title,
  bool isMenu = false
}){
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
    ),
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.arrow_back,color: defaultColor),
      onPressed: (){
        Navigator.pop(context);
        if(isMenu)Navigator.pop(context);
      }
    ),
  );
}
