import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_cubit.dart';
import 'package:speed_co/layouts/user_layout/cubit/user_states.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/images/images.dart';

import '../../../../shared/components/constants.dart';

class RateScreen extends StatefulWidget {
  RateScreen(this.id);
  String id;
  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  int currentStar = 1;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.background,width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,title: tr('rate_review'),),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemBuilder(1, Images.star1Yes, Images.star1No),
                            itemBuilder(2, Images.star2Yes, Images.star2No),
                            itemBuilder(3, Images.star3Yes, Images.star3No),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            itemBuilder(4, Images.star4Yes, Images.star4No),
                            SizedBox(
                              width: size!.width * .1,
                            ),
                            SizedBox(
                                width: size!.width * .25,
                                child: itemBuilder(5, Images.star5Yes, Images.star5No)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60,bottom: 30),
                          child: Container(
                            width: double.infinity,
                            height: 171,
                            padding:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadiusDirectional.circular(18),
                            ),
                            child: TextFormField(
                              maxLines: 6,
                              controller: controller,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText:tr('comment')),
                            ),
                          ),
                        ),
                        state is! RateLoadingState ?
                        DefaultButton(
                            text:tr('send'),
                            onTap: (){
                              print(widget.id);
                              UserCubit.get(context).rate(
                                  providerId: widget.id,
                                  rate: currentStar,
                                  content: controller.text
                              );
                            }
                        ):const Center(child: CircularProgressIndicator(),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  },
);
  }

  Widget itemBuilder(int index, String imageYes, String imageNo) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        setState(() {
          currentStar = index;
        });
      },
      child: Image.asset(
        currentStar == index ? imageYes : imageNo,
        width: size!.width * .2,
      ),
    );
  }
}
