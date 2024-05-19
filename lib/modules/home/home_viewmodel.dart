import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon_user_app/model/category.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeViewmodel extends Viewmodel {
  HomeViewmodel() {
    // Add your initialization code here
    checkUserType();
  }

  bool _isMechanic = false;

  bool get isMechanic => _isMechanic;
  set isMechanic(bool value) {
    _isMechanic = value;
    turnIdle();
  }

  void checkUserType() async {
    var userBox = await Hive.openBox('user');
    var userType = userBox.get('role');
    if (userType == 'generalUser') {
      isMechanic = false;
    } else {
      isMechanic = true;
    }
  }

  static const kInitialPosition = LatLng(-33.8567844, 151.213108);

  List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Car Mechanic',
      image: 'assets/images/mechanic.png',
      type: 'automobileMechanic',
    ),
    CategoryModel(
      id: '2',
      name: 'Locksmith',
      image: 'assets/images/locksmith.png',
      type: 'locksmith',
    ),
    CategoryModel(
      id: '3',
      name: 'Plumber',
      image: 'assets/images/plumber.png',
      type: 'plumber',
    ),
    CategoryModel(
      id: '4',
      name: 'Roofer',
      image: 'assets/images/roofer.png',
      type: 'roofer',
    ),
    CategoryModel(
      id: '5',
      name: 'Electrician',
      image: 'assets/images/electrician.png',
      type: 'electrician',
    ),
    CategoryModel(
      id: '6',
      name: 'Heater Repair',
      image: 'assets/images/heat.png',
      type: 'heaterRepair',
    ),
    CategoryModel(
      id: '6',
      name: 'Carpenter',
      image: 'assets/images/carpenter.png',
      type: 'carpenter',
    ),
  ];
}
