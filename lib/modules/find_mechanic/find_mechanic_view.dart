import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hackathon_user_app/model/category.dart';
import 'package:hackathon_user_app/modules/find_mechanic/find_mechanic_viewmodel.dart';
import 'package:hackathon_user_app/modules/find_mechanic/widgets/find_mechanic_body.dart';
import 'package:hackathon_user_app/modules/view.dart';

class FindMechanicView extends StatelessWidget {
  const FindMechanicView(
      {super.key, this.pickedLocation, required this.category});
  final PickResult? pickedLocation;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      builder: (_, viewmodel, __) {
        return FindMechanicBody(
          viewmodel: viewmodel,
          pickedLocation: pickedLocation,
          category: category,
        );
      },
      viewmodel: FindMechanicViewmodel(),
    );
  }
}
