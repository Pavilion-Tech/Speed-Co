import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_states.dart';
import 'package:speed_co/shared/styles/colors.dart';

import '../../../../models/user/categoies_model.dart';
import '../../../../shared/images/images.dart';
import '../../../item_shared/image_net.dart';

class CategoryWidget extends StatelessWidget {
   CategoryWidget({Key? key}) : super(key: key);

  List<String> images = [
    Images.category1,
    Images.category2,
    Images.category3,
    Images.category4,
  ];
  List<String> titles = [
    'Maintenance',
    'Decoration',
    'Specialized',
    'Constructions ',
  ];
  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemBuilder: (c,i)=>itemBuilder(i,cubit.categoriesModel!.data![i],context),
        separatorBuilder: (c,i)=>const SizedBox(width: 20,),
        itemCount: cubit.categoriesModel!.data!.length,
        padding:const EdgeInsetsDirectional.only(start: 20),
        scrollDirection: Axis.horizontal,
      ),
    );
  },
);
  }

  Widget itemBuilder(int index,CategoriesData model,BuildContext context){
    return InkWell(
      onTap: (){
        UserCubit.get(context).currentCategory = index;
        UserCubit.get(context).getService(model.id??'');
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 90,width: 90,
                decoration: BoxDecoration(
                    color: defaultColor.withOpacity(.2),
                    shape: BoxShape.circle,
                    border:UserCubit.get(context).currentCategory == index?Border.all(color: defaultColor):null
                ),
              ),
              Container(
                height: 88,width: 88,
                decoration:BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ImageNet(image: model.image??''),
              ),
            ],
          ),
          Text(
            model.title??'',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

