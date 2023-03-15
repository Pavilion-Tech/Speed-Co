import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/images/images.dart';


class ImageNet extends StatelessWidget {
  ImageNet({
    required this.image,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.havePlaceholder = true
});

  String image;
  double height;
  double width;
  BoxFit? fit;
  bool havePlaceholder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: image,
        height: height,width: width,
        fit: fit,
        errorWidget: (context, url, error) => Image.asset(Images.holder,fit:fit,width: width,height: height,),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  if(havePlaceholder)
                  Image.asset(Images.holder,fit:fit,width: width,height: height,),
                  CupertinoActivityIndicator()
                ],
              ),
            )
    );
  }
}
