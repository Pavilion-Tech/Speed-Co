import 'package:flutter/cupertino.dart';

import '../../shared/images/images.dart';


class ImageNet extends StatelessWidget {
  ImageNet({
    required this.image,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
});

  String image;
  double height;
  double width;
  BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,height: height,width: width,
        fit: fit,
        errorBuilder: (c, Object o, s) {
          return Image.asset(Images.holder,fit:fit,width: width,height: height,);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(Images.holder,fit:fit,width: width,height: height,),
                CupertinoActivityIndicator()
              ],
            ),
          );
        }
    );
  }
}
