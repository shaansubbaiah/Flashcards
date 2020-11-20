import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfiretest/database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await DatabaseService().getUid(userCredential.user.uid);
      return "Signed In";
    } catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await DatabaseService().addUserData(userCredential.user.uid);
      return "Signed Up";
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> deleteUser(passwordValue) async {
    bool status = true;
    final User user = this._firebaseAuth.currentUser;
    AuthCredential credential = EmailAuthProvider.credential(
        email: user.email, password: passwordValue);
    await user.reauthenticateWithCredential(credential).then((value) {
      value.user.delete().then((res) {
        print("user deleted");
      });
    }).catchError((onError) {
      print(onError);
      status = false;
    });

    return status ? true : false;
  }
}
