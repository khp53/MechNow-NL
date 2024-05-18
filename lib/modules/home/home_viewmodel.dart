import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon_user_app/model/category.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';

class HomeViewmodel extends Viewmodel {
  HomeViewmodel() {
    // Add your initialization code here
  }
  static const kInitialPosition = LatLng(-33.8567844, 151.213108);

  List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Car Mechanic',
      image: 'assets/images/mechanic.png',
    ),
    CategoryModel(
      id: '2',
      name: 'Locksmith',
      image: 'assets/images/locksmith.png',
    ),
    CategoryModel(
      id: '3',
      name: 'Plumber',
      image: 'assets/images/plumber.png',
    ),
    CategoryModel(
      id: '4',
      name: 'Roofer',
      image: 'assets/images/roofer.png',
    ),
    CategoryModel(
      id: '5',
      name: 'Electrician',
      image: 'assets/images/electrician.png',
    ),
    CategoryModel(
      id: '6',
      name: 'Heater Repair',
      image: 'assets/images/heat.png',
    ),
    CategoryModel(
      id: '6',
      name: 'Carpenter',
      image: 'assets/images/carpenter.png',
    ),
  ];
}
