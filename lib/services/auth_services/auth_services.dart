abstract class AuthServices {
  createUserAccount({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String area,
    required String role,
    required String childRole,
  });
  signInWithEmailAndPassword(String email, String password);
  signInWithGoogle();
  signOut();
}
