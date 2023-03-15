import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_states.dart';
import 'package:speed_co/shared/components/components.dart';

import '../../../shared/components/constants.dart';

class PTermsScreen extends StatelessWidget {
  const PTermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderMenuCubit, ProviderMenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      appBar: pDefaultAppBar(context: context,title: tr('terms'),isMenu: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:  ConditionalBuilder(
            condition: ProviderMenuCubit.get(context).staticPageModel!=null,
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
            builder: (context)=> Html(
                data:myLocale == 'en'
                    ? ProviderMenuCubit.get(context).staticPageModel!.data!.termsAndConditiondsEn
                    : ProviderMenuCubit.get(context).staticPageModel!.data!.termsAndConditiondsAr
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
