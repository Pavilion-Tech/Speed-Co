import 'package:flutter/material.dart';
import 'package:speed_co/modules/auth/login_screen.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/styles/colors.dart';
import '../../../../models/user/service_model.dart';
import '../../../../shared/components/constants.dart';
import '../../home/place_order_screen.dart';

class GridProduct extends StatelessWidget {
  GridProduct({this.isScroll = true,required this.data});

  bool isScroll;
  List<ServiceData> data;
  late double currentAspect;

  @override
  Widget build(BuildContext context) {
    currentAspect = size!.height >800 ?1.5:1.3;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        physics: isScroll ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.only(bottom: 100),
        itemBuilder: (c, i) => ProductItem(data[i]),
        itemCount: data!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25, mainAxisSpacing: 10,
          childAspectRatio: size!.width / (size!.height / currentAspect),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductItem(this.data);

  ServiceData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        token!=null
            ? navigateTo(context, PlaceOrderScreen(data.id??''))
            : navigateTo(context, LoginScreen(haveArrow: true,));
      },
      child: Container(
        decoration: BoxDecoration(
            color: defaultColor.withOpacity(.3),
            borderRadius: BorderRadiusDirectional.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100.withOpacity(.5),
                blurRadius: 5,
              )
            ]
        ),
        padding: EdgeInsetsDirectional.only(bottom: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ImageNet(image: data.image??'', height: 142, width: 125,havePlaceholder: false),
            const SizedBox(height: 20,),
            Text(
              data.title??'',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}

