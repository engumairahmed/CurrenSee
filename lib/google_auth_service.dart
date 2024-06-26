
import 'package:currensee/api_tasks.dart';
import 'package:currensee/preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check and store user in your backend database
        await _checkAndStoreUser(user);
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _checkAndStoreUser(User user) async {
    // Make API call to check if user exists in your backend
    final userExists = await uidCheckTask(user.uid);

    if (userExists != null && !userExists) {
      await registerTask(
        user.displayName,
        user.email,
        "",
        user.uid,
      );
    }
  }


  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await removeUser();
  }

}
