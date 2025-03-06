import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:terrarium_idle/data/repositories/repo.dart';
import 'package:terrarium_idle/data/storage/storage.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'profile'
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class UserRepo extends Repo {
  GetStorage box = GetStorage();
  // đăng nhập
  Future<UserCredential?> loginWithGoogle() async {
    String error = '';
    try {
      if (kIsWeb) {
        await _googleSignIn.signInSilently();
      } else {
        await _googleSignIn.signIn();
      }
    } catch (e) {
      //print(error);
      error = e.toString();
    }
    if (_googleSignIn.currentUser != null) {
      // user = UserData(
      //     : _googleSignIn.currentUser?.email,
      //     id: _googleSignIn.currentUser?.id,
      //     name: _googleSignIn.currentUser?.displayName);
      // await box.write(Storages.dataUser, user.toJson());
      // await box.write(Storages.dataLoginTime, DateTime.now().toString());
      // Once signed in, return the UserCredential
      // Create a new credential
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await _googleSignIn.currentUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        await box.write(Storages.dataUser, {
          'email': userCredential.user?.email,
          'id': userCredential.user?.uid,
          'name': userCredential.user?.displayName
        });
        buildToast(
            status: TypeToast.getSuccess,
            title: 'Đăng nhập thành công'.tr,
            message:
                '${'Chào mừng'.tr} ${userCredential.user?.displayName ?? ''}');
        return userCredential;
      } else {
        buildToast(
            status: TypeToast.getError,
            title: 'Có lỗi xảy ra'.tr,
            message: error);
      }
    } else {
      buildToast(
          status: TypeToast.getError,
          title: 'Có lỗi xảy ra'.tr,
          message: error);
    }
    // log('Đăng nhập, user: ${_googleSignIn.currentUser}');
    // return _googleSignIn.currentUser;
    return null;
  }

  Future<UserCredential?> loginWithApple() async {
    // User? user;
    String error = '';
    // AuthorizationCredentialAppleID? credential;
    // try {
    //   credential = await SignInWithApple.getAppleIDCredential(
    //     scopes: [
    //       AppleIDAuthorizationScopes.email,
    //       AppleIDAuthorizationScopes.fullName,
    //     ],
    //     //nonce: nonce,
    //     // webAuthenticationOptions: WebAuthenticationOptions(
    //     //   clientId: 'com.vqh2602.lavenz',
    //     //   redirectUri: Uri.parse('https://lavenz-d7f47.firebaseapp.com/__/auth/handler'),
    //     // ),
    //   );

    // } catch (e) {
    //   error = e.toString();
    // }
    //print('login apple: ${credential.toString()}');

    // if (credential?.userIdentifier != null) {
    // user = User(
    //     email: credential?.email,
    //     id: credential?.userIdentifier,
    //     name: credential?.givenName);
    // await box.write(Storages.dataUser, user.toJson());
    // await box.write(Storages.dataLoginTime, DateTime.now().toString());
    // // final appleProvider = AppleAuthProvider();
    // // if (kIsWeb) {
    // //   await FirebaseAuth.instance.signInWithPopup(appleProvider);
    // // } else {
    final appleProvider = AppleAuthProvider()
      ..addScope('email')
      ..addScope('fullName');

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithProvider(appleProvider);
    if (userCredential.user != null) {
      await box.write(Storages.dataUser, {
        'email': userCredential.user?.email,
        'id': userCredential.user?.uid,
        'name': userCredential.user?.displayName
      });
      buildToast(
          status: TypeToast.getSuccess,
          title: 'Đăng nhập thành công'.tr,
          message:
              '${'Chào mừng'.tr} ${userCredential.user?.displayName ?? ''}');
      return userCredential;
    } else {
      buildToast(
          status: TypeToast.getError,
          title: 'Có lỗi xảy ra'.tr,
          message: error);
    }
    // // }
    // buildToast(
    //     status: TypeToast.getSuccess,
    //     title: 'Đăng nhập thành công'.tr,
    //     message: '${'Chào mừng'.tr} ${user.name ?? ''}');

    return null;
  }

  Future<UserCredential?> loginWithAnonymous() async {
    // User? user;
    String error = '';

    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    if (userCredential.user != null) {
      await box.write(Storages.dataUser, {
        'email': userCredential.user?.email,
        'id': userCredential.user?.uid,
        'name': userCredential.user?.displayName
      });
      buildToast(
          status: TypeToast.getSuccess,
          title: 'Đăng nhập thành công'.tr,
          message:
              '${'Chào mừng'.tr} ${userCredential.user?.displayName ?? ''}');
      return userCredential;
    } else {
      buildToast(
          status: TypeToast.getError,
          title: 'Có lỗi xảy ra'.tr,
          message: error);
    }
    // // }
    // buildToast(
    //     status: TypeToast.getSuccess,
    //     title: 'Đăng nhập thành công'.tr,
    //     message: '${'Chào mừng'.tr} ${user.name ?? ''}');

    return null;
  }

  // ignore: body_might_complete_normally_nullable
  Future<User?> loginWithTiktok() async {
    // ignore: unused_local_variable
    //   User? user;
    //   try {
    //   final result = await FlutterWebAuth2.authenticate(
    //     url: 'https://open-api.tiktok.com/platform/oauth/connect/',
    //     callbackUrlScheme: 'your_callback_scheme',
    //   );

    //   // Process the authentication result
    //   if (result != null) {
    //     // Extract the access token and other relevant information from the result
    //     // Perform necessary operations like storing the access token securely
    //     // Use the access token to make authenticated API requests
    //   }
    // } catch (e) {
    //   // Handle any authentication errors
    // }
  }
}
