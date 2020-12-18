import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfiretest/database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

// To avoid the platform exception when trying to log in with an email
// that is not registered, follow the info at:
// github.com/FirebaseExtended/flutterfire/issues/3303#issuecomment-687560133
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (e.code == 'user-not-found') {
        return "user-not-found";
      } else if (e.code == 'wrong-password') {
        return "wrong-password";
      } else {
        print(e);
        return "user-not-found";
      }
    }
    return "Signed In";
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
      if (e.code == 'email-already-in-use') {
        return "email exists";
      }
      return "error";
    }
  }

  Future deleteUser(passwordValue) async {
    final User user = this._firebaseAuth.currentUser;
    AuthCredential credential = EmailAuthProvider.credential(
        email: user.email, password: passwordValue);
    await user.reauthenticateWithCredential(credential).then((value) {
      DatabaseService().deleteAccount().then((res) {
        value.user.delete().then((value) {
          print("user deleted");
        }).catchError((onError) {
          print("error");
        });
      }).catchError((onError) {
        print("error");
      });
    }).catchError((onError) {
      print("error");
    });
    return;
  }

  Future<bool> checkPassword(String oldPassword) async {
    try {
      final User user = await this._firebaseAuth.currentUser;

      AuthCredential credential = EmailAuthProvider.credential(
          email: user.email, password: oldPassword);
      var authResult = await user.reauthenticateWithCredential(credential);
      return authResult != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void editPassword(String newPassword) async {
    try {
      final User user = this._firebaseAuth.currentUser;
      await user.updatePassword(newPassword);
    } catch (e) {
      print(e);
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      await this._firebaseAuth.sendPasswordResetEmail(email: email);
      return "Successful";
    } catch (e) {
      return "error";
    }
  }
}
