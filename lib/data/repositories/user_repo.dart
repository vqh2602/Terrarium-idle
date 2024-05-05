import 'dart:developer';
import 'package:terrarium_idle/data/local/user.dart';
import 'package:terrarium_idle/data/repositories/repo.dart';
import 'package:terrarium_idle/data/storage/storage.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
  Future<User?> loginWithGoogle() async {
    User? user;
    String error = '';
    try {
      await _googleSignIn.signIn();
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
      // return await FirebaseAuth.instance.signInWithCredential(credential);
      // buildToast(
      //     status: TypeToast.getSuccess,
      //     title: 'Đăng nhập thành công'.tr,
      //     message: '${'Chào mừng'.tr} ${user.name ?? ''}');
    } else {
      buildToast(
          status: TypeToast.getError,
          title: 'Có lỗi xảy ra'.tr,
          message: error);
    }
    log('Đăng nhập, user: ${_googleSignIn.currentUser}');
    return user;
  }

  Future<User?> loginWithApple() async {
    User? user;
    String error = '';
    AuthorizationCredentialAppleID? credential;
    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        //nonce: nonce,
        // webAuthenticationOptions: WebAuthenticationOptions(
        //   clientId: 'com.vqh2602.lavenz',
        //   redirectUri: Uri.parse('https://lavenz-d7f47.firebaseapp.com/__/auth/handler'),
        // ),
      );
    } catch (e) {
      error = e.toString();
    }
    //print('login apple: ${credential.toString()}');

    if (credential?.userIdentifier != null) {
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
      // //   await FirebaseAuth.instance.signInWithProvider(appleProvider);
      // // }
      // buildToast(
      //     status: TypeToast.getSuccess,
      //     title: 'Đăng nhập thành công'.tr,
      //     message: '${'Chào mừng'.tr} ${user.name ?? ''}');
    } else {
      buildToast(
          status: TypeToast.getError,
          title: 'Có lỗi xảy ra'.tr,
          message: error);
    }
    log('Đăng nhập, user: ${_googleSignIn.currentUser}');
    return user;
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
