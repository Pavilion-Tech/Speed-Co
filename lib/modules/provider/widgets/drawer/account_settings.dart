import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../splash_screen.dart';
import '../../../../layouts/provider_layout/cubit/provider_cubit.dart';
import '../../../user/menu_screens/chat/chat_screen.dart';
import '../../../user/menu_screens/edit_profile/edit_profile_screen.dart';
import '../../menu_screens/edit_profile_screen.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(ProviderCubit.get(context).providerModel!=null)
        Text(
          ProviderCubit.get(context).providerModel!.data!.name??'',
          style:const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: itemBuilder(
                  image: Images.person,
                  title: 'profile_info',
                  onTap: () {
                    if(ProviderCubit.get(context).providerModel!=null)
                      navigateTo(context, PEditProfileScreen());
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget itemBuilder(
      {required String image,
      required String title,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image,
            width: 20,
            height: 20,
            color: defaultColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            tr(title),
            style: const TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}
