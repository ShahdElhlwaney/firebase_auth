


import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  const ImageComponent({Key? key, required this.widget
    , required this.height, required this.width}) : super(key: key);
  final Widget widget;
  final double height,width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor
      ),
      child:widget
    );
  }
}
