import 'package:firebase_auth/firebase_auth.dart';
import 'package:ritrageindiacalls/functionalities/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() => firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn() => firebaseMethods.signIn();

  Future<bool> authenticateUser(FirebaseUser user) => firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(FirebaseUser currentUser) => firebaseMethods.addDataToDb(currentUser);

  Future<void> signOut() => firebaseMethods.signOut();
}