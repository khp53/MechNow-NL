import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Function()? onPressed;
  final Color buttonColor;
  final Color textColor;
  final bool? loading;
  final Widget? icon;
  final Color? borderColor;
  const CustomButton({
    Key? key,
    this.buttonText,
    this.onPressed,
    required this.buttonColor,
    required this.textColor,
    this.loading,
    this.icon,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading != true
        ? MaterialButton(
            padding: EdgeInsets.zero,
            elevation: 0,
            height: 50,
            minWidth: MediaQuery.of(context).size.width,
            onPressed: onPressed,
            color: buttonColor,
            disabledColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: borderColor != null
                  ? BorderSide(
                      color: borderColor!,
                      width: 2,
                    )
                  : BorderSide.none,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: icon,
                      )
                    : Container(),
                Text(
                  buttonText ?? "",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                ),
              ],
            ),
          )
        : MaterialButton(
            elevation: 0,
            height: 50,
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {},
            color: borderColor != null ? buttonColor : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: borderColor != null
                  ? const BorderSide(
                      color: Color.fromARGB(255, 204, 204, 204),
                      width: 2,
                    )
                  : BorderSide.none,
            ),
            child: Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(color: textColor),
              ),
            ),
          );
  }
}
