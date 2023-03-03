import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(Images.person2,width: 20,),
          Text(
            'Marwan Sayed ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: defaultColorTwo,fontSize: 23,fontWeight: FontWeight.w500),
          ),
          Divider(height: 2,color: Colors.black,),
          const SizedBox(height: 15,),
          Image.asset(Images.phone,width: 20,),
          Row(
            children: [
              Text(
                '+20 1122711137',
                maxLines: 1,
                style: TextStyle(color: defaultColorTwo,fontSize: 19),
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  String phone = '+971562222338';
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: phone,
                  );
                  openUrl(launchUri.toString());
                  },
                  child: Image.asset(Images.phone5,width: 44,)),
              const SizedBox(width: 20,),
              InkWell(
                  onTap: () {
                    String phone = '+971562222338';
                    String url() {
                      if (Platform.isAndroid) {
                        return "https://wa.me/$phone/?text=hello"; // new line
                      } else {
                        return "https://api.whatsapp.com/send?phone=$phone"; // new line
                      }
                    }

                    String waUrl = url();
                    openUrl(waUrl);
                  },
                  child: Image.asset(Images.whats5,width: 44,)
              ),
            ],
          ),
          const SizedBox(height: 5,),
          Divider(height: 2,color: Colors.black,),
          const SizedBox(height: 15,),
          InkWell(
            onTap: ()async{
              String googleUrl =
                  'https://www.google.com/maps/dir/?api=1&origin=25.019083,55.121239&destination=25.019083,55.111239';
              print(googleUrl);
              if (await canLaunch(googleUrl)) {
              await launch(googleUrl);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Images.location2,width: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: defaultColorTwo,fontSize: 13,height: 1),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 2,color: Colors.black,),
          Padding(
            padding: const EdgeInsets.only(top: 15.0,bottom: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(Images.requestDate,width: 20,),
                    Text(
                      '25/12/2023',
                      maxLines: 1,
                      style: TextStyle(color: defaultColorTwo,fontSize: 13),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding:EdgeInsetsDirectional.only(end: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(Images.requestTime,width: 20,),
                      Text(
                        '15:30 PM',
                        maxLines: 1,
                        style: TextStyle(color: defaultColorTwo,fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
