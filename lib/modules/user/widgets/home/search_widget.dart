import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speed_co/shared/images/images.dart';

import '../../../../shared/components/components.dart';
import '../../home/search_screen.dart';

class SearchWidget extends StatelessWidget {

  SearchWidget({
    this.readOnly = false,
    this.onChanged
});

  bool readOnly;
  ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 53,width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(10)
          ),
        ),
        TextFormField(
          readOnly: readOnly,
          onChanged: onChanged,
          onTap: readOnly?()=>navigateTo(context, SearchScreen()):null,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset(Images.search,width: 1,height: 1,),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: tr('search'),
            hintStyle:const TextStyle(fontSize: 11)
          ),
        )
      ],
    );
  }
}
