import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speed_co/shared/components/components.dart';
import 'package:speed_co/shared/components/constants.dart';
import 'package:speed_co/shared/images/images.dart';
import 'package:speed_co/shared/network/local/cache_helper.dart';

import '../../shared/styles/colors.dart';
import 'join_as_screen.dart';

class IntroModel{
  String image;
  String title;
  String desc;
  IntroModel({
    required this.title,
    required this.image,
    required this.desc,
});
}

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  List<IntroModel> listIntro = [
    IntroModel(
      image: Images.intro1,
      title: 'All the services you need and more in one application',
      desc: 'request services and receive orders in an integrated market of various services.'
    ),
    IntroModel(
        image: Images.intro2,
        title: 'Many requests are waiting for you.',
        desc: 'and many services that you are looking for, everything has become easier now, your unique digital companion for all services'
    ),
  ];

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 750,
            child: PageView.builder(
                itemCount: listIntro.length,
                controller: controller,
                itemBuilder: (c,i)=>Column(
                  children: [
                    Image.asset(listIntro[i].image),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          Text(
                            listIntro[i].title,
                            textAlign: TextAlign.center,
                            style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 22,height: 1),
                          ),
                          Text(
                            listIntro[i].desc,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SmoothPageIndicator(
                    controller: controller, // PageController
                    count: listIntro.length,
                    effect: ExpandingDotsEffect(
                        activeDotColor: defaultColor,
                        dotWidth: 7,
                        dotHeight: 7,
                        spacing: 5,
                        dotColor: Colors.grey.shade300
                    ), // your preferred effect
                    onDotClicked: (index) {}
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: TextButton(
                      onPressed: (){
                        if(controller.page == 1.0){
                          intro = true;
                          CacheHelper.saveData(key: 'intro', value: intro);
                          navigateAndFinish(context,const JoinAsScreen());
                        }else{
                          controller.animateTo(
                              controller.position.maxScrollExtent,
                              duration:const Duration(milliseconds: 500),
                              curve: Curves.easeInOutSine
                          );
                        }
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 16),
                      )
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
