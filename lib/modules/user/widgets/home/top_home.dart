import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/models/user/ads_model.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/styles/colors.dart';


class TopHome extends StatelessWidget {
  const TopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return ConditionalBuilder(
      condition: cubit.adsModel!.data!.isNotEmpty,
      fallback: (context)=>SizedBox(),
      builder: (context)=> CarouselSlider(
        items:cubit.adsModel!.data!.map((e) => itemBuilder(e)).toList(),
        options: CarouselOptions(
          height: 180,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayInterval:const Duration(seconds: 10),
          autoPlayAnimationDuration:const Duration(seconds: 1),
          autoPlayCurve: Curves.easeInBack,
          scrollDirection: Axis.horizontal,
          viewportFraction: .9,
          aspectRatio: 3.0,
        ),
      ),
    );
  }

  Widget itemBuilder(AdsData model){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.1),
        borderRadius: BorderRadiusDirectional.circular(25),
        border: Border.all(color: Colors.white)
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 30,top: 20,bottom: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    padding:const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: HexColor('#FFC725'),
                      borderRadius: BorderRadiusDirectional.circular(4.5),
                    ),
                    child: Text(
                      model.title??'',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 11),
                    ),
                  ),
                  Text(
                    model.description??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                  ),
                  if(model.type == 2)
                  InkWell(
                    onTap: (){
                      openUrl(model.link??'');
                    },
                    child: Container(
                      height: 27,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(53.5),
                      ),
                      padding:const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        tr('get_offer'),
                        style: TextStyle(color:defaultColor,fontWeight: FontWeight.w500,fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10,),
          if(model.backgroundImage!.isNotEmpty)
          Expanded(child: ImageNet(image:model.backgroundImage??'',havePlaceholder: false,))
        ],
      ),
    );
  }
}
