import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_states.dart';
import 'package:speed_co/models/user/service_model.dart';
import 'package:speed_co/modules/user/widgets/home/search_widget.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';

import '../../item_shared/no_items/no_requests.dart';
import '../widgets/item_shared/grid_products.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ServiceModel? searchModel = UserCubit.get(context).searchServiceModel;
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(Images.homeCurve, height: 196,
                width: double.infinity,
                fit: BoxFit.cover,),
              Column(
                children: [
                  defaultAppBar(context: context, colorIsDefault: false),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SearchWidget(
                      onChanged: (val){
                        if(val.isNotEmpty){
                          UserCubit.get(context).searchService(val);
                        }else{
                          if(searchModel!=null){
                            searchModel.data!.clear();
                            UserCubit.get(context).emitState();
                          }
                        }
                      },
                    ),
                  ),
                  Expanded(
                      child: ConditionalBuilder(
                        condition: searchModel!=null,
                          fallback: (context)=>const SizedBox(),
                          builder: (context)=>Column(
                            children: [
                              Expanded(
                                child: ConditionalBuilder(
                                  condition: searchModel!.data!.isNotEmpty,
                                    fallback: (context)=>NoRequests(isHome: true),
                                    builder: (context)=> GridProduct(
                                      isScroll: false,
                                      data: searchModel.data!,
                                    )
                                ),
                              ),
                              if(state is SearchLoadingState)
                                const Center(child: CircularProgressIndicator(),)
                            ],
                          )
                      )
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
