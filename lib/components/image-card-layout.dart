import 'package:covid/components/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageCardLayout extends StatefulWidget {
  final SvgPicture image;
  final TextBox title;
  final TextBox description;
  final bool showArrow;

  const ImageCardLayout({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    this.showArrow = false,
  }) : super(key: key);

  @override
  _ImageCardLayoutState createState() => _ImageCardLayoutState();
}

class _ImageCardLayoutState extends State<ImageCardLayout> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.image,
        SizedBox(width: 15),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title,
              widget.description,
            ],
          ),
        ),
        SizedBox(width: 15),
        widget.showArrow ? Icon(Icons.keyboard_arrow_right) : Container()
      ],
    );
  }
}
