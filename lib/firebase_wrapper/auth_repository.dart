// ================= Auth Repository =================
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:balance_me/firebase_wrapper/sentry_repository.dart';
import 'package:cross_file/cross_file.dart';
import 'package:balance_me/global/types.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:balance_me/global/config.dart' as config;
import 'package:balance_me/global/constants.dart' as gc;


class AuthRepository with ChangeNotifier {
  final FirebaseAuth _auth;
  User? _user;
  AuthStatus _status = AuthStatus.Uninitialized;
  String? _avatarUrl;


  final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: config.storageBucketPath);


  AuthRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
    _user = _auth.currentUser;
    _onAuthStateChanged(_user);
  }

  AuthStatus get status => _status;

  User? get user => _user;

  String? get avatarUrl => _avatarUrl;

  Future<bool> signUp(String email, String password, BuildContext context) async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _status = AuthStatus.Authenticated;
      _avatarUrl = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      if (e.code == gc.badEmail) {
        displaySnackBar(context, Languages.of(context)!.badEmail);
      } else if (e.code == gc.weakPassword) {
        displaySnackBar(context, Languages.of(context)!.weakPassword);
      } else if (e.code == gc.emailInUse) {
        displaySnackBar(context, Languages.of(context)!.emailInUse);
      }
      return false;
    } catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn(String email, String password,BuildContext context) async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = AuthStatus.Authenticated;
      _avatarUrl = await getAvatarUrl();
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      if (e.code == gc.badEmail) {
        displaySnackBar(context, Languages.of(context)!.badEmail);
      } else if (e.code == gc.userNotFound) {
        displaySnackBar(context, Languages.of(context)!.loginError);
      } else if (e.code == gc.incorrectPassword) {
        displaySnackBar(context, Languages.of(context)!.incorrectPassword);
      }
      return false;
    } catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInGoogle() async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      _status = AuthStatus.Authenticated;
      _avatarUrl = await getAvatarUrl();
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      _status = AuthStatus.Authenticated;
      _avatarUrl = await getAvatarUrl();
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    _user = null;
    _avatarUrl = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void uploadAvatar(XFile? avatarImage) async {
    if (avatarImage != null && _user != null) {
      Reference storageReference = _storage.ref().child(config.avatarsCollection + '/' + _user!.email.toString());
      UploadTask uploadedAvatar = storageReference.putFile(File(avatarImage.path));
      await uploadedAvatar;
    }
    _avatarUrl = await getAvatarUrl();
    notifyListeners();
  }

  Future<String?> getAvatarUrl() async {
    try {
      if (user != null) {
        Reference storageReference = _storage.ref().child(config.avatarsCollection + '/' + _user!.email.toString());
        return await storageReference.getDownloadURL();
      }
      return null;
    } catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      return null;
    }
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _user = null;
      _status = AuthStatus.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = AuthStatus.Authenticated;
    }
    notifyListeners();
  }

  Future<void> updatePassword(BuildContext context, String newPassword) async {
    if (_user != null) {
      try {
        await _user!.updatePassword(newPassword);
        notifyListeners();
        displaySnackBar(context, Languages.of(context)!.changePasswordSuccess);
      } on FirebaseAuthException catch (e, stackTrace) {
        SentryMonitor().sendToSentry(e, stackTrace);
        if (e.code == gc.weakPassword) {
          displaySnackBar(context, Languages.of(context)!.weakPassword);
        }
      } catch (e, stackTrace) {
        SentryMonitor().sendToSentry(e, stackTrace);
        displaySnackBar(context, Languages.of(context)!.changePasswordError);
      }
    } else {
      displaySnackBar(context, Languages.of(context)!.notSignedIn);
    }
  }
}
