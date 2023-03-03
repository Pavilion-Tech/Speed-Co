import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/shared/styles/colors.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          itemBuilder(
            title: 'pending',
             index: 1
          ),
          itemBuilder(
            title: 'processing',
             index: 2
          ),
          itemBuilder(
            title: 'completed',
             index: 3
          ),
          itemBuilder(
            title: 'canceled',
             index: 4
          ),
        ],
      ),
    );
  }

  Widget itemBuilder({
  required String title,
  required int index,
}){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        height: 29,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8),
          color:currentIndex == index? Colors.white:Colors.grey.shade300
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: AlignmentDirectional.center,
        child: Text(
        tr(title),
          style: TextStyle(color: defaultColor,fontSize: 15,fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
