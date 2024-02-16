// Snack bar for showing error message
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? border;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  final Color? cursorColor;
  final InputDecoration? decoration;
  final bool? filled;
  final Color? fillColor;
  final bool? isRequired;
  final double? height;
  final double? width;
  final int? maxLength;
  final TextDirection? textDirection;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? textInputFormatter;
  final int? maxLines;
  final void Function(String?)? onSaved;
  final void Function(String)? onChange;
  final void Function(String)? onSubmitted;
  final Function()? onTap;
  final bool readOnly;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization? textCapitalization;
  final bool isShowCounterText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Color? hintTextColor;
  final Color? borderColor;
  final Color? focusedBorderColor;

  const CustomTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.height,
    this.textInputAction,
    this.keyboardType,
    this.filled,
    this.fillColor,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.border,
    this.padding,
    this.cursorColor,
    this.decoration,
    this.onSaved,
    this.validator,
    this.width,
    this.maxLength,
    this.textDirection,
    this.textInputFormatter,
    this.floatingLabelBehavior,
    this.maxLines,
    this.onChange,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.autovalidateMode,
    this.errorText,
    this.isRequired = false,
    this.textCapitalization,
    this.isShowCounterText = false,
    this.labelStyle,
    this.style,
    this.hintTextColor,
    this.borderColor,
    this.focusedBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatters = (textInputFormatter != null && textInputFormatter!.isNotEmpty) ? [NoSpaceInputFormatter(), ...textInputFormatter!] : [NoSpaceInputFormatter()];
    return SizedBox(
      // height: height ?? 55,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText == null || labelText!.isEmpty
              ? Container()
              : RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: labelText != null && labelText!.isNotEmpty ? labelText!: '',
              style: labelStyle,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            style: style ??
                TextHelper.size15.copyWith(
                  fontFamily: mediumFont,
                  color: ColorsForApp.blackColor,
                ),
            cursorColor: cursorColor ?? ColorsForApp.primaryColor,
            onSaved: onSaved,
            autofocus: false,
            onChanged: onChange,
            onFieldSubmitted: onSubmitted,
            obscureText: obscureText ?? false,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            maxLength: maxLength,
            textDirection: textDirection,
            textInputAction: textInputAction ?? TextInputAction.next,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            maxLines: maxLines ?? 1,
            validator: validator,
            onTap: onTap,
            readOnly: readOnly,
            enableSuggestions: true,
            autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            decoration: decoration ??
                InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: borderColor ?? ColorsForApp.grayScale500.withOpacity(0.3),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: borderColor ?? ColorsForApp.grayScale500.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: focusedBorderColor ?? ColorsForApp.primaryColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  counterText: isShowCounterText ? null : '',
                  labelStyle: TextHelper.size16,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  hintStyle: TextHelper.size14.copyWith(
                    color: hintTextColor ?? ColorsForApp.grayScale500,
                  ),
                  errorText: errorText,
                  fillColor: fillColor ?? ColorsForApp.hintColor,
                  filled: filled,
                ),
          ),
        ],
      ),
    );
  }
}

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == ' ') {
      return oldValue;
    }
    final trimmedText = newValue.text.trimLeft();

    return TextEditingValue(
      text: trimmedText,
      selection: TextSelection.collapsed(offset: newValue.selection.baseOffset),
    );
  }
}

class FiftyMultiplierFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int selectionIndex = newValue.selection.end;

    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    int value = int.parse(newText);
    value = (value ~/ 50) * 50;

    return TextEditingValue(
      text: '$value',
      selection: TextSelection.collapsed(
        offset: min(value.toString().length, selectionIndex),
      ),
    );
  }
}


// Snack bar for showing error message
errorSnackBar({String title = 'Failure', String? message}) {
  Get.log('\x1B[91m[$title] => $message\x1B[0m', isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.TOP,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 700),
    ),
  );
}

// Snack bar for showing success message
successSnackBar({String title = 'Success', String? message}) {
  Get.log('\x1B[92m[$title] => $message\x1B[0m');
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green.withOpacity(0.80),
      icon: const Icon(Icons.task_alt_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 700),
    ),
  );
}
