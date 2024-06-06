import 'package:flutter/material.dart';
import 'package:todo_list/core/utils/colors.dart';


class CustomButtonContainer extends StatelessWidget {
  double? width;
  double? height;
  final Widget buttonWidget;
  final BoxDecoration? decoration;

  CustomButtonContainer(this.buttonWidget,
      { this.width,  this.height,this.decoration,Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ??50,
      decoration: decoration,
      padding: EdgeInsets.zero,
      child: buttonWidget,
    );
  }
}
class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backGroundColor;
  final double elevation;
  final double borderRadius;
  final double width;
  final double height;
  final BoxDecoration? decoration;

  const CustomButton(
      {Key? key,
        required this.child,
        required this.onPressed,
        this.backGroundColor =  ColorCode.primary,
        this.elevation = 1,
        this.borderRadius = 9,
        this.decoration,
        this.width = double.infinity,
        this.height = 50
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButtonContainer(
      height: height,
      width: width,
      TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backGroundColor,
          elevation: elevation,
        ),
        child: child,
      ),
      decoration: decoration,
    );
  }
}