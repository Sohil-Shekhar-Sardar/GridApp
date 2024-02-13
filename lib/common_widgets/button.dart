import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';


class CommonButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final Color? labelColor;
  final Color? bgColor;
  final double? height;
  final double? width;
  final TextStyle? style;
  final Color? shadowColor;
  final BoxBorder? border;

  const CommonButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.bgColor,
    this.labelColor,
    this.height,
    this.width,
    this.style,
    this.border,
    this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height*0.05,
        width: width ?? MediaQuery.of(context).size.width*0.25,
        decoration: BoxDecoration(
          color: bgColor ?? ColorsForApp.primaryColor,
          borderRadius: BorderRadius.circular(100),
          border: border ??
              Border.all(
                width: 0,
                color: bgColor ?? ColorsForApp.primaryColor,
              ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              color: shadowColor ?? ColorsForApp.shadowColor,
              blurRadius: 5,
              spreadRadius: -2,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: style ??
              TextHelper.size13.copyWith(
                fontFamily: mediumFont,
                color: labelColor ?? ColorsForApp.whiteColor,
              ),
        ),
      ),
    );
  }
}
