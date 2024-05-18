import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return bottomSheet(theme, child);
  }

  bottomSheet(
    ThemeData theme,
    Widget child,
  ) {
    return Get.bottomSheet(
      Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Wrap(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SvgPicture.asset(
                  "assets/svgs/line.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
