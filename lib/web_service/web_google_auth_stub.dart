import 'package:google_oauth2/models/google_auth_setup.dart';

class WebGoogleAuth {
  static Future<void> startSignin({required GoogleAuthSetup setup}) async {}
  static Future<void> listenToRequestUrl({
    required GoogleAuthSetup setup,
  }) async {}

 static void clearAuthStorage() {}
}
