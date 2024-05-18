abstract class AuthServices {
  createUserAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String area,
    required String role,
  });
  signInWithEmailAndPassword(String email, String password);
  //Future<User> signInWithGoogle();
  signOut();
}
