import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/core/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType inputType;
  final bool obscureText;
  TextEditingController? controller;
  final bool isHiddenPassword;
  final bool? readOnly;
  final String obscuringCharacter;
  final String hint;
  final String label;
  final Color? filledColor;
  bool enable;
  final Function()? onTap;
  final Color? borderColor;
  final InputDecoration? decoration;
  final Function(String?)? onSave;
  final Function(String?)? onChange;
  final Function(String?)? nextFocus;
  final Function()? onTapShowHidePassword;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  TextInputAction? textInputAction;
  int maxLines;
  int? maxLength;
  Widget? suffixIcon;
  Widget? prefixIcon;
  List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelTextStyle;
  final TextAlignVertical textAlignVertical;
  CustomTextFormField(
      {Key? key,
      required this.hint,
      this.onSave,
      required this.inputType,
      required this.label,
      this.textAlignVertical = TextAlignVertical.center,
      this.onChange,
      this.readOnly,
      this.nextFocus,
      this.validator,
      this.controller,
      this.borderColor,
      this.obscureText = false,
      this.filledColor,
      this.maxLength,
      this.decoration,
      this.focusNode,
      this.maxLines = 1,
      this.isHiddenPassword = false,
      this.obscuringCharacter = "*",
      this.inputFormatters,
      this.enable = true,
      this.onTap,
      this.onTapShowHidePassword,
      this.textInputAction,
      this.suffixIcon,
      this.prefixIcon,
      this.labelTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      controller: controller,
      validator: validator,
      onSaved: onSave,
      onChanged: onChange,
      cursorColor: ColorCode.black,
      showCursor: true,
      onTap: onTap,
      enabled: enable,
      textAlign: TextAlign.start,
      keyboardType: inputType,
      maxLines: maxLines,
      minLines: maxLines >= 1 ? maxLines : 1,
      focusNode: focusNode,
      inputFormatters: inputFormatters ?? [],
      textAlignVertical: textAlignVertical,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText && isHiddenPassword,
      obscuringCharacter: obscuringCharacter,
      textInputAction: textInputAction,
      onFieldSubmitted: nextFocus,
      maxLength: maxLength,
      style: const TextStyle(
        color: ColorCode.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      decoration: decoration ??
          InputDecoration(
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: hint,
              alignLabelWithHint: true,
              hintStyle: const TextStyle(
                color: ColorCode.grey23,
                fontWeight: FontWeight.w400,
                fontSize: 14.5,
              ),
              errorStyle: const TextStyle(
                  fontSize: 12,
                  color: ColorCode.red,
                  fontWeight: FontWeight.w400),
              errorText:
                  validator != null ? null : validator!(controller?.text) ?? "",

              // label: CustomText(
              //     label,
              //     textStyle: TextStyles.textXSmall.copyWith(
              //         fontWeight: FontWeight.w500,
              //         fontSize: 14.sp,
              //         color: ColorCode.primary)
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                borderSide: BorderSide(
                    color: borderColor != null
                        ? borderColor!
                        : filledColor != null
                            ? filledColor!
                            : ColorCode.grey34,
                    width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                borderSide: BorderSide(
                    color:
                        borderColor != null ? borderColor! : ColorCode.grey34,
                    width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                borderSide: BorderSide(
                    color: borderColor != null
                        ? borderColor!
                        : filledColor != null
                            ? filledColor!
                            : ColorCode.grey34,
                    width: 1),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(color: ColorCode.red, width: 1),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(color: ColorCode.red, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                    color:
                        borderColor != null ? borderColor! : ColorCode.grey34,
                    width: 1),
              ),
              fillColor: filledColor ?? ColorCode.grey33,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixIcon: prefixIcon,
              counterText: '',
              suffixIcon: suffixIcon),
    );
  }
}
