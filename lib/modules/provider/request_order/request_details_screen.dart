import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/shared/styles/colors.dart';

import '../../../shared/images/images.dart';
import '../widgets/request_order_details/app_bar.dart';
import '../widgets/request_order_details/details.dart';
import '../widgets/request_order_details/problem_desc.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.curve,fit: BoxFit.cover,width: double.infinity,),
          Image.asset(Images.background,color: Colors.white,fit: BoxFit.cover,width: double.infinity,),
          Column(
            children: [
              RequestAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Image.asset(Images.homePhoto2,width: 234,height: 266,fit: BoxFit.cover,),
                      Text(
                        tr('request_for'),
                        style: TextStyle(color: defaultColorTwo,fontSize: 11.5,fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Air Conditioner Service',
                        style: TextStyle(color: defaultColorTwo,fontSize: 17.25,fontWeight: FontWeight.w600,height: 1),
                      ),
                      Details(),
                      ProblemDesc(),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
