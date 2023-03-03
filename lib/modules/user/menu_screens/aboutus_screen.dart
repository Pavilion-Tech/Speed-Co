import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:speed_co/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/components/constants.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(context: context, title: tr('about_us')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConditionalBuilder(
                condition: MenuCubit.get(context).staticPageModel!=null,
                fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                builder: (context)=> Html(
                    data:myLocale =='en'
                        ? MenuCubit.get(context).staticPageModel!.data!.aboutUsEn
                        : MenuCubit.get(context).staticPageModel!.data!.aboutUsAr
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
