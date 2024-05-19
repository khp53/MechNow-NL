import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon_user_app/dependencies/dependency_injection.dart';
import 'package:hackathon_user_app/model/category.dart';
import 'package:hackathon_user_app/modules/auth/auth_view.dart';
import 'package:hackathon_user_app/modules/notification/fcm_notification_viewmodel.dart';
import 'package:hackathon_user_app/modules/viewmodel.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services.dart';
import 'package:hackathon_user_app/services/user_services/user_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeViewmodel extends Viewmodel {
  HomeViewmodel() {
    getUserData();
  }
  UserServices get _userServices => dependency();
  AuthServices get _authServices => dependency();

  bool _isMechanic = false;
  String _username = '';

  bool get isMechanic => _isMechanic;
  set isMechanic(bool value) {
    _isMechanic = value;
    turnIdle();
  }

  String get username => _username;
  set username(String value) {
    _username = value;
    turnIdle();
  }

  checkUserType() async {
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

  getUserData() async {
    await _userServices.getUserData();
    await checkUserType();
    await getUsername();
    await registerNotification();
  }

  getUsername() async {
    var userBox = await Hive.openBox('user');
    username = await userBox.get('name') ?? '';
    print(username);
  }

  logout() async {
    await _authServices.signOut();
    // clean local db
    var userBox = await Hive.openBox('user');
    await userBox.clear();
    Get.offAll(
      () => const AuthView(
        isLogin: true,
      ),
      transition: Transition.downToUp,
    );
  }
}
