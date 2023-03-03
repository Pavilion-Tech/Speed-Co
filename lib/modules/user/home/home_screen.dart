import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import 'package:speed_co/modules/user/home/place_order_sheet.dart';
import 'package:speed_co/modules/user/widgets/home/search_widget.dart';
import 'package:speed_co/modules/user/widgets/shimmers/home_shimmer.dart';
import 'package:speed_co/shared/images/images.dart';
import '../widgets/home/category_widget.dart';
import '../widgets/home/home_products.dart';
import '../widgets/home/top_home.dart';
import '../widgets/item_shared/grid_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return ConditionalBuilder(
      condition: cubit.categoriesModel!=null&&cubit.adsModel!=null&&cubit.serviceModel!=null,
      fallback: (context)=>HomeShimmer(),
      builder: (context)=>  Stack(
        children: [
          Stack(
            children: [
              Image.asset(Images.homeCurve),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TopHome(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SearchWidget(readOnly: true),
                      ),
                      CategoryWidget(),
                      HomeProducts()
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: DefaultButton(
                  text: tr('place_new'),
                  onTap: (){
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(50),
                            topStart: Radius.circular(50),
                          )
                        ),
                        builder: (context)=>PlaceOrderSheet()
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
