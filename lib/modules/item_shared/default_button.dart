import 'package:flutter/material.dart';
import 'package:speed_co/shared/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.color,
    this.textColor = Colors.white
});
  String text;
  double width;
  Color? color;
  Color textColor;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 47,
        width: width,
        decoration: BoxDecoration(
          color: color??defaultColor,
          borderRadius: BorderRadiusDirectional.circular(60)
        ),
        alignment: AlignmentDirectional.center,
        child: Text(
          text,
          style: TextStyle(color: textColor,fontWeight: FontWeight.w500,fontSize: 12),
        ),
      ),
    );
  }
}
