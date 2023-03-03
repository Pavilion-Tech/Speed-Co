import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ImageButtom extends StatelessWidget {
  ImageButtom({
    this.onTap,
    required this.title,
    required this.image
  });

  VoidCallback? onTap;
  String image;
  String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(3),
            color: Colors.white
        ),
        alignment: AlignmentDirectional.center,
        padding:const  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Row(
          children: [
            Image.asset(image,color: HexColor('#5791BC'),width: 20,),
            const SizedBox(width: 5,),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,fontSize: 12,color: HexColor('#5791BC')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
