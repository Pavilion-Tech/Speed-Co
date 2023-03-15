import 'package:flutter/material.dart';

import 'image_net.dart';

class ImageZoom extends StatelessWidget {
  ImageZoom(this.image);
  String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: ImageNet(image: image,fit: null,),
        ),
      ),
    );
  }
}
