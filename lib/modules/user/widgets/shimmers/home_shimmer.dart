import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speed_co/shared/components/constants.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: 180,
                  width: size!.width*.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadiusDirectional.circular(25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: 53,width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadiusDirectional.circular(10)
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.separated(
                itemBuilder: (c,i){
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 90,width: 90,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          'Title',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (c,i)=>const SizedBox(width: 20,),
                itemCount: 4,
                padding:const EdgeInsetsDirectional.only(start: 20),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                physics:const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (c,i)=>Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadiusDirectional.circular(25),
                    ),
                  ),
                ),
                itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,mainAxisSpacing: 10,
                  childAspectRatio: size!.width / (size!.height / 1.5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
