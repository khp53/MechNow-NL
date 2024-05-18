import 'package:flutter/material.dart';
import 'package:hackathon_user_app/modules/home/home_viewmodel.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.viewmodel});
  final HomeViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        title: Text(
          'MechNow NL',
          style: theme.textTheme.headlineMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
