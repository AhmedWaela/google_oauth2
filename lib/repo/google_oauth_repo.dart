import 'package:google_oauth2/models/google_oauth_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';

abstract interface class GoogleOAuthRepo {
  Future<void> authWithGoogle({required GoogleOauthModel model});
}

class GoogleOAuthRrepoImpl implements GoogleOAuthRepo {
  final WebviewController? controller;
  final WebViewController? mobileController;

  GoogleOAuthRrepoImpl({
    required this.controller,
    required this.mobileController,
  });
  @override
  Future<void> authWithGoogle({required GoogleOauthModel model}) async {
    throw UnimplementedError();
  }
}
