import 'package:get_it/get_it.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services_firebase.dart';
import 'package:hackathon_user_app/services/request_services/request_services.dart';
import 'package:hackathon_user_app/services/request_services/request_services_rest.dart';
import 'package:hackathon_user_app/services/user_services/user_services.dart';
import 'package:hackathon_user_app/services/user_services/user_services_firebase.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  dependency.registerLazySingleton<AuthServices>(() => AuthServicesFirebase());
  dependency
      .registerLazySingleton<RequestServices>(() => RequestServicesRest());
  dependency.registerLazySingleton<UserServices>(() => UserServicesFirebase());

  // Viewmodels
}
