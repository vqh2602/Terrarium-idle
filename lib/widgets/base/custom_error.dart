import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.jpg',
              width: double.infinity * 0.5,
              height: double.infinity * 0.5,
              fit: BoxFit.cover,
            ),
            SText.headlineMedium(
                kDebugMode
                    ? errorDetails.summary.toString()
                    : 'Oups! Hình như đã có lỗi xảy ra!',
                textAlign: TextAlign.center,
                color: kDebugMode ? Colors.red : Colors.black),
            const SizedBox(height: 12),
            const Text(
              kDebugMode
                  ? 'https://docs.flutter.dev/testing/errors'
                  : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
