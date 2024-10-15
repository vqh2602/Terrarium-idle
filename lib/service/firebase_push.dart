import 'dart:convert';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/export.dart';
import 'package:terrarium_idle/firebase_options.dart';

class FirebaseCouldMessage {
  static String? fcmToken;
  static init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // caaps quyeenf thong bao
    // NotificationSettings settings =
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // laays token
    fcmToken = await messaging.getToken();
    debugPrint('fcmToken: $fcmToken');

    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      // if (message.notification != null) {
      //   print('Message also contained a notification: ${message.notification}');
      // }
    });
  }

  static void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {}
  }

  Future<String?> getAccessToken() async {
    // Đọc file JSON của Service Account từ Google Cloud
    // String serviceAccountJson =
    //     await File('path_to_service_account.json').readAsString();
    Map<String, dynamic> serviceAccount = {
      "type": "service_account",
      "project_id": "terrarium-i",
      "private_key_id": "89beaa45f65b9ef8a2bfedd421b04ad40fe0902e",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDDRB0SnPHXaNyj\ne119zTOk93uv2+aJNFYfeKj+cKtNQ+gaFuSqukLNYkhMjLALKX/CtUkfQMU65mFj\nozPySp+svI+VlixlcNUnP6G7btHzY4PEB8wz4eodt2qA9XZ3u7XN95FjB1NgpEmj\nHP79FxA2pKWhNtub68ne/0gyi+jhRZIcM0xZMsl2WIET3Wij+MTaPFD+oIpI3Jz9\n5RPbvVDfwgHrHJWH7YlQl6cyA5/4by+WO0XV59NbNnlc+k+GJ98ZcMxPxquKOomN\nfEsNSaBh/twT3FrMYyp+6WfYW0Bq2jgsDDLNU3/B9p92yAUUs3F3wBbtCyMuwAGY\nlRTaGB37AgMBAAECggEAViEXv8uJYy4mUFgMi351XrkpDg9tlyyGJniW9jBlZv3i\nhYt+jo39BFHrORS/XBUQfSZwm//6XzoaUBQ/SArBdrRvkxg7+fy0kIzhPmcp5XUK\nPHACEwp9tWDfcgWTnUmnbjPapbcoAFNHBdM26BUBulCSnFMxuAtfrmSlCGKtNJux\niBRn2VoetBy2gu2rLupM1LQXYpd9WLAEiAPJ+oqIezAEFtW5I9Ifqwb7YIa01/QS\nrbfuQpjOBgdEMavf7Uj3sfPeIq7TAkCHy/i73R8YYU4c4wWsCyNdva5qxeso1vfi\nhLKAI6eusUNMBrzY4x0FgIk16KCpOUmtEOc68AKGWQKBgQDkVECo8338+CFPXRJS\nToLxD6fAGIPPBJD2Eje5qKvTjXO5xB0pz1EjKmiGnz4w61N2fsJsnb5EFddonpW6\nfJ+7rauPh3FVmdT9ssIMRM+futeZUqU1XhWwz+tabWSSioyv+Bvumy15gF1Yql4B\nrgKfKLwBujh/ZkjUsfRlcNqQwwKBgQDa7hqNWTF3X4WjWK5HOeRnS0dGpB6i1Pu7\nCnCCJk+3AISMRdFUsO9dcCfRTgAhpBVRrxijkOo4vx1GANVLPp1VwPnu6+8kYZHG\nvcKDfOofLy72sNhKcgypGgkvQeZR+B5e0+R2h/RLvVZDDDi1E3knGSusXVbL9B3n\nzFGc5VZqaQKBgFo9BhT/roJE2n1QLkaDKvL0mfqsdaNijZwC1S02ATqpw9veKxx0\nCAAa6ZaS5vRUfPbu4A4nRaQI8coyKsC6MjLtT0l5YQxQsMHXXSOWKmxZXo4FALAX\n0ADCG6TwaPgVc8a0Cu4BPDaxybKaGm8Vg4m9gpg4Lc4D8bLF5e4VbPwbAoGATWaU\n2JhKFswcsS1vIBtlludUYbMwaZ0nCm+ca0ckM6zpL7aXVXvghIZcbXFINpyONPzU\nly9qv3lB3jf5MMsIUQMS2ddsCs67/SmllVsaYsAJuIm5TkiYFUjxKlYAGcbA5gG/\n6fAS/JwJ3VZ6zfn+gUYy3JN7VkwOLp9b0z55mNECgYA+kV6BqNJlQGMeSk0Rx7zs\nRho4ziNBH34/1yhI9n9BF8AOO/4tFiecaQKzKhe3adlYoZGAkYIm0zA66cmeHM26\n67qdNIMPquda//wLuN7C+aTIs+aBD7BmAiU+iBw+s9rAwfYQqKw+/+aGJ2zvLlsS\nQHvZYVXL2jpvLGw5Wyq34Q==\n-----END PRIVATE KEY-----\n",
      "client_email": "push-fcm@terrarium-i.iam.gserviceaccount.com",
      "client_id": "106862884957159320145",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/push-fcm%40terrarium-i.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    // Thông tin để yêu cầu token
    String email = serviceAccount['client_email'];
    String privateKey = serviceAccount['private_key'];
    String tokenUri = serviceAccount['token_uri'];

    // Tạo JWT yêu cầu token
    final iat = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    final exp = iat + 3600; // Token có hiệu lực trong 1 giờ
    String claimSet = jsonEncode({
      'iss': email,
      'scope': 'https://www.googleapis.com/auth/firebase.messaging',
      'aud': tokenUri,
      'iat': iat,
      'exp': exp,
    });

    // Ký JWT với khóa riêng (RS256)
    final jwtHeader = jsonEncode({'alg': 'RS256', 'typ': 'JWT'});
    final jwtBase64 =
        '${base64UrlEncode(utf8.encode(jwtHeader))}.${base64UrlEncode(utf8.encode(claimSet))}';

    // Tạo CustomRSAPrivateKey từ PEM
    final rsaprivateKey = CustomRSAPrivateKey(privateKey);

    // Ký JWT
    final jwtSignature = signJwt(jwtBase64, rsaprivateKey);

    // Kết hợp JWT thành một token hoàn chỉnh
    String jwtToken = '$jwtBase64.$jwtSignature';

    try {
      Dio dio = Dio();
      Response response = await dio.post(tokenUri, data: {
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': jwtToken,
      });

      return response.data['access_token'];
    } catch (e) {
      debugPrint('Error fetching access token: $e');
      return null;
    }
  }

  Future<void> sendNotificationWithAccessToken(
      String fcmToken, String accessToken) async {
    Dio dio = Dio();

    // Cấu hình header Authorization với OAuth 2.0 Access Token
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.headers['Content-Type'] = 'application/json';

    // Dữ liệu thông báo
    Map<String, dynamic> notificationData = {
      'message': {
        'token': fcmToken,
        'notification': {
          'title': 'Thông báo',
          'body': 'Nội dung thông báo từ Firebase Cloud Messaging',
        },
      },
    };

    try {
      // Gửi yêu cầu POST tới FCM API v1
      final response = await dio.post(
        'https://fcm.googleapis.com/v1/projects/your-project-id/messages:send',
        data: notificationData,
      );

      if (response.statusCode == 200) {
        debugPrint("Thông báo đã được gửi tới thiết bị B");
      } else {
        debugPrint("Lỗi khi gửi thông báo: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint("Handling a background message: ${message.messageId}");
}

class CustomRSAPrivateKey {
  late RSAPrivateKey key;

  CustomRSAPrivateKey(String pem) {
    key = CryptoUtils.rsaPrivateKeyFromPem(pem);
  }
}

/// Hàm để ký JWT
String signJwt(String jwtBase64, CustomRSAPrivateKey privateKey) {
  final signer = RSASigner(SHA256Digest(), '0609601');
  signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey.key));

  final signature =
      signer.generateSignature(Uint8List.fromList(utf8.encode(jwtBase64)));
  return base64UrlEncode(signature.bytes);
}
