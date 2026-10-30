import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import 'storage_service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  UserProfile? profile;

  AuthService() {
    _auth.authStateChanges().listen((user) async {
      if (user == null) {
        profile = null;
        notifyListeners();
      } else {
        await _loadProfile(user.uid);
      }
    });
  }

  User? get currentUser => _auth.currentUser;

  Future<void> _loadProfile(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      final data = doc.data();
      if (data != null) {
        profile = UserProfile.fromMap(uid, data);
        notifyListeners();
      }
    } catch (_) {}
  }

  /// كل الدوال ترجّع null إذا نجحت، أو رسالة الخطأ إذا فشلت.
  Future<String?> signUp({
    required String fullName,
    required String username,
    required String email,
    required String address,
    required String password,
    Uint8List? imageBytes,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final photoUrl = imageBytes == null
          ? null
          : await StorageService.uploadAvatar(cred.user!.uid, imageBytes);
      final p = UserProfile(
        uid: cred.user!.uid,
        fullName: fullName.trim(),
        username: username.trim(),
        email: email.trim(),
        address: address.trim(),
        photoUrl: photoUrl,
      );
      await _db.collection('users').doc(p.uid).set(p.toMap());
      profile = p;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return _msg(e);
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _msg(e);
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<String?> sendReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return _msg(e);
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> updateProfile({
    required String fullName,
    required String username,
    required String address,
    Uint8List? imageBytes,
  }) async {
    final p = profile;
    if (p == null) return 'Profile not loaded yet.';
    try {
      final photo = imageBytes != null
          ? await StorageService.uploadAvatar(p.uid, imageBytes)
          : p.photoUrl;
      final updated = UserProfile(
        uid: p.uid,
        fullName: fullName.trim(),
        username: username.trim(),
        email: p.email,
        address: address.trim(),
        photoUrl: photo,
      );
      await _db.collection('users').doc(p.uid).set(updated.toMap());
      profile = updated;
      notifyListeners();
      return null;
    } catch (_) {
      return 'Could not save changes. Please try again.';
    }
  }

  Future<String?> changePassword(String current, String newPass) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) return 'You are not signed in.';
    try {
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: current,
      );
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPass);
      return null;
    } on FirebaseAuthException catch (e) {
      return _msg(e);
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  String _msg(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'network-request-failed':
        return 'No internet connection.';
      case 'requires-recent-login':
        return 'Please log in again and retry.';
      default:
        return e.message ?? 'Authentication error.';
    }
  }
}
