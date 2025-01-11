
import 'package:firebase_auth/firebase_auth.dart';

class Auth{

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance ;


//Register
Future<void> createUser({
    required String email ,
    required String password,

})async{
  _firebaseAuth.createUserWithEmailAndPassword(
      email: email , password: password
  );
}

//Login
  Future<void> SignIn({
    required String email ,
    required String password,

  })async => await _firebaseAuth.signInWithEmailAndPassword(
        email: email , password: password
    );

//Sign out

Future<void> SignOut()async{
  await _firebaseAuth.signOut();

}

}