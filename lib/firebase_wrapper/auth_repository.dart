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
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';


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
      await handleMultiProviderRegular(email, password,context,signUp: true);
      _status = AuthStatus.Authenticated;
      _avatarUrl = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      if (e.code == gc.badEmail) {
        displaySnackBar(context, Languages.of(context)!.strBadEmail);
      } else if (e.code == gc.weakPassword) {
        displaySnackBar(context, Languages.of(context)!.strWeakPassword);
      } else if (e.code == gc.emailInUse) {
        displaySnackBar(context, Languages.of(context)!.strEmailInUse);
      }
      return false;
    } catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }
  LoginMethod getProvider(String provider) {
    if (provider == gc.facebook) {
      return LoginMethod.Facebook;
    } else if (provider == gc.google) {
      return LoginMethod.Google;
    }
    return LoginMethod.Regular;
  }

  Future<void> linkWithFacebook(AuthCredential credential) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential thirdPartyCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);
    await FirebaseAuth.instance.signInWithCredential(thirdPartyCredential);
    _auth.currentUser?.linkWithCredential(credential);
  }

  Future<void> linkWithGoogle(AuthCredential credential) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;
    final OAuthCredential thirdPartyCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(thirdPartyCredential);
    _auth.currentUser?.linkWithCredential(credential);
  }
  Future<void> linkRegular(AuthCredential credential,String email,String password) async {
    final AuthCredential thirdPartyCredential = EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.signInWithCredential(thirdPartyCredential);
    _auth.currentUser?.linkWithCredential(credential);
  }
  Future<void> handleMultiProviderRegular(
      String email, String password, BuildContext context,{bool signUp=false}) async {
    List<String> methods = await _auth.fetchSignInMethodsForEmail(email);

    if (methods.length > gc.maxAccounts) {
      displaySnackBar(context, Languages.of(context)!.strTooManyProviders);
    }

      if(methods.isEmpty)
        {
         signUp? await _auth.createUserWithEmailAndPassword(email: email, password: password):throw FirebaseAuthException(code: gc.userNotFound);
          return;
        }
    if (methods.contains(gc.regular)) {
       await _auth.signInWithEmailAndPassword(email: email, password: password);
      return;
    } else {
      final AuthCredential credential =
      EmailAuthProvider.credential(email: email, password: password);
      if (getProvider(methods.first) == LoginMethod.Facebook) {
        await linkWithFacebook(credential);
      }
      if (getProvider(methods.first) == LoginMethod.Google) {
        await linkWithGoogle(credential);
      }
    }
    GoogleAnalytics.instance.logMultipleProviders();
  }


  Future<bool> signIn(String email, String password,BuildContext context) async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await handleMultiProviderRegular( email, password,context);
      _status = AuthStatus.Authenticated;
      _avatarUrl = await getAvatarUrl();
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      if (e.code == gc.badEmail) {
        displaySnackBar(context, Languages.of(context)!.strBadEmail);
      } else if (e.code == gc.userNotFound) {
        displaySnackBar(context, Languages.of(context)!.strUserNotFound);
      } else if (e.code == gc.incorrectPassword) {
        displaySnackBar(context, Languages.of(context)!.strIncorrectPassword);
      }
      return false;
    } catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  Future<void> handleProvidersThirdParty(String? email, AuthCredential credential,
      BuildContext context,String provider) async {
    if (email!=null) {
      List<String> methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isEmpty || methods.contains(provider)) {
        await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        displaySnackBar(context, Languages.of(context)!.strLinkProviderError);
        GoogleAnalytics.instance.logMultipleProviders(providerLinked: provider);
      }
    }
  }

  Future<bool> signInGoogle(BuildContext context) async {
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
     await handleProvidersThirdParty(googleUser?.email,credential,context,gc.google);
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

  Future<bool> signInWithFacebook(BuildContext context) async {
    try {
      final loginResult = await FacebookAuth.instance.login(permissions: gc.permissionFacebook);
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      _status = AuthStatus.Authenticated;
      _avatarUrl = await getAvatarUrl();
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
      if (e.code == gc.credentialExists) {
        displaySnackBar(context, Languages.of(context)!.strLinkProviderError);
        GoogleAnalytics.instance.logMultipleProviders(providerLinked: gc.facebook);
      }
      return false;
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
        displaySnackBar(context, Languages.of(context)!.strChangePasswordSuccess);
      } on FirebaseAuthException catch (e, stackTrace) {
        SentryMonitor().sendToSentry(e, stackTrace);
        if (e.code == gc.weakPassword) {
          displaySnackBar(context, Languages.of(context)!.strWeakPassword);
        }
      } catch (e, stackTrace) {
        SentryMonitor().sendToSentry(e, stackTrace);
        displaySnackBar(context, Languages.of(context)!.strNotSignedIn);
      }
    } else {
      displaySnackBar(context, Languages.of(context)!.strSignInTimeout);
    }
  }
}
