import 'package:flutter/material.dart';
import 'package:hackathon_user_app/modules/onboard/onboard_viewmodel.dart';
import 'package:hackathon_user_app/modules/onboard/widgets/onboard_body.dart';
import 'package:hackathon_user_app/modules/view.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView(
        builder: (_, viewmodel, __) {
          return OnboardBody(viewmodel: viewmodel);
        },
        viewmodel: OnboardViewmodel(),
      ),
    );
  }
}
