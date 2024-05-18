import 'package:flutter/material.dart';
import 'package:hackathon_user_app/modules/home/home_viewmodel.dart';
import 'package:hackathon_user_app/modules/home/widgets/home_body.dart';
import 'package:hackathon_user_app/modules/view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      builder: (_, viewmodel, __) {
        return HomeBody(viewmodel: viewmodel);
      },
      viewmodel: HomeViewmodel(),
    );
  }
}
