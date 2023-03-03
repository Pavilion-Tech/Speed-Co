import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderShimmer extends StatelessWidget {
  const OrderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (c,i)=> Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10),
                color: Colors.grey.shade300
            ),
          ),
        ),
        padding:const EdgeInsets.all(20),
        separatorBuilder: (c,i)=>const SizedBox(height: 20,),
        itemCount: 8
    );
  }
}
