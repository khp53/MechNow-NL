import 'package:get_it/get_it.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services.dart';
import 'package:hackathon_user_app/services/auth_services/auth_services_firebase.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  dependency.registerLazySingleton<AuthServices>(() => AuthServicesFirebase());

  // Viewmodels
}
