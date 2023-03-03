import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../splash_screen.dart';
import '../../menu_screens/chat/chat_screen.dart';
import '../../menu_screens/edit_profile/edit_profile_screen.dart';
import '../../menu_screens/order/order_history_screen.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: itemBuilder(
                  image: Images.person,
                  title: tr('profile_info'),
                  onTap: () {
                    navigateTo(context, EditProfileScreen());
                  }),
            ),
            itemBuilder(
                image: Images.orderHistory,
                title: tr('order_history'),
                onTap: () => navigateTo(context, OrderHistoryScreen())),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: itemBuilder(
                  image: Images.support,
                  title: tr('technical_support'),
                  onTap: () => navigateTo(context, ChatScreen())),
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
            title,
            style: const TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}
