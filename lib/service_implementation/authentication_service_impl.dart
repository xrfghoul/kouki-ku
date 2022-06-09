import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:kokiku/model/user.dart';
import 'package:kokiku/service/authentication_service.dart';

import '../utils/storage_utils.dart';

class AuthenticationServiceImpl extends AuthenticationApi {
  final _auth = fa.FirebaseAuth.instance;
  final _fs = FirebaseFirestore.instance;

  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<User?> register(User user,
      {required String password, Uint8List? image}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      if (credential.user?.uid == null) {
        throw Exception("Error Register");
      }
      if (image != null) {
        final imageUrl =
            await StorageUtils.uploadImage(image, credential.user?.uid ?? '');
        user = user.copyWith(image: imageUrl);
      }
      user = user.copyWith(id: credential.user?.uid);
      await _fs.collection('users').doc(user.id).set(user.toMap());
      return user;
    } on fa.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw Exception("Invalid Email");
        case 'email-already-in-use':
          throw Exception("Email already in use");
        case 'operation-not-allowed':
          throw Exception("Operation not Allowed");
        case 'weak-password':
          throw Exception("Weak Password");
        default:
          throw Exception("Something is Wrong on Registering ${e.code}");
      }
    }
  }

  @override
  Future<User?> signIn(
      {required String email, required String password}) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (credential.user?.uid != null) {
      return await getUserInfo(credential.user!.uid);
    } else {
      throw Exception('User Not Found');
    }
    // }
    // on fa.FirebaseAuthException catch(e){
    //   switch (e.code){
    //     case 'invalid-email':
    //     case 'user-disabled':
    //     case 'user-not-found':
    //     case 'wrong-password':
    //     default:
    //   }
    // }
    // catch(e){
    // }
  }

  Future<User?> getUserInfo(String uid) async {
    final doc = await _fs.collection('users').doc(uid).get();
    if (doc.data() == null) {
      return null;
    }
    return User.fromMap(doc.data()!);
  }

  @override
  Future<String?> signOut() async {
    final credential = await _auth.signOut();
    return 'Signout Success';
  }

  @override
  Future<User?> silentLogin() async {
    final user = await _auth.authStateChanges().first;
    if (user != null) {
      return await getUserInfo(user.uid);
    }
    return null;
  }
}
