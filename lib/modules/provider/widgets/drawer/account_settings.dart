import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../splash_screen.dart';
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
        InkWell(
          onTap: () => navigateAndFinish(context, SplashScreen()),
          child: Text(
            tr('sign_in_now'),
            style:const TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: itemBuilder(
                  image: Images.person,
                  title: 'profile_info',
                  onTap: () {
                    navigateTo(context, PEditProfileScreen());
                  }),
            ),
            itemBuilder(
                image: Images.support,
                title: 'technical_support',
                onTap: () {
                  navigateTo(context, ChatScreen());
                }),
            const SizedBox(height: 20,)
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
