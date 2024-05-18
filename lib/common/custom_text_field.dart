import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final bool isRequired;
  final Color? borderColor;
  final bool? isFilled;
  final Color? fillColor;
  final Color? inputTextColor;
  final bool isDigit;
  final String hintText;
  final bool isObscured;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? sufix;
  final Function()? onPressed;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final bool? isEnabled;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? number;
  final Iterable<String>? autofillHints;
  final String? lable;
  final bool? isCenterAlign;
  final int? characterLimit;
  final double? topContentPadding;
  final double? bottomContentPadding;
  const CustomTextFormField({
    Key? key,
    this.fillColor = const Color(0xff20295A),
    this.isFilled = false,
    required this.hintText,
    this.controller,
    this.validator,
    required this.isObscured,
    this.prefixIcon,
    this.sufix,
    this.suffixIcon,
    this.onPressed,
    this.onChanged,
    this.isEnabled,
    this.textInputType,
    this.number = 1,
    this.textInputAction,
    this.autofillHints,
    this.onEditingComplete,
    this.lable,
    required this.isDigit,
    this.inputTextColor = const Color(0xff20295A),
    this.borderColor,
    required this.isRequired,
    this.isCenterAlign,
    this.characterLimit,
    this.topContentPadding,
    this.bottomContentPadding,
  }) : super(key: key);

  // String? get _errorText {
  //   final text = controller!.value.text;
  //   if (text.isEmpty && isRequired) {
  //     return 'This field is required!';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: controller!,
      builder: (context, TextEditingValue value, __) {
        return TextFormField(
          cursorColor: theme.colorScheme.secondary,
          inputFormatters: isDigit == true
              ? [FilteringTextInputFormatter.digitsOnly]
              : characterLimit != null
                  ? [LengthLimitingTextInputFormatter(characterLimit)]
                  : null,
          onEditingComplete: onEditingComplete,
          autofillHints: autofillHints,
          maxLines: number,
          minLines: number,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          enabled: isEnabled,
          onChanged: onChanged,
          obscureText: isObscured,
          controller: controller,
          validator: validator,
          textAlignVertical:
              isCenterAlign == true ? TextAlignVertical.center : null,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: inputTextColor,
              ),
          decoration: InputDecoration(
            //errorText: _errorText,
            errorMaxLines: 1,
            errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.error,
                ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: topContentPadding ?? 20,
              bottom: bottomContentPadding ?? 20,
            ),
            filled: isFilled,
            fillColor: fillColor,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: theme.colorScheme.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: theme.colorScheme.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: borderColor ?? const Color(0xFF828282),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: theme.colorScheme.primary,
              ),
            ),
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium!.copyWith(
              color: const Color(0xFF828282),
            ),
            suffix: sufix,
          ),
        );
      },
    );
  }
}
