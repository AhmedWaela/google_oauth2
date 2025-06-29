import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_oauth2_flutter/models/google_auth_callback.dart';
import 'package:google_oauth2_flutter/models/google_oauth_model.dart';
import 'package:google_oauth2_flutter/utils/auth_req_sec_params_generator.dart';
import 'package:google_oauth2_flutter/utils/google_auth_listener.dart';
import 'package:google_oauth2_flutter/utils/google_auth_url.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';

import '../models/google_auth_url_paarmeters.dart';

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
    final secParams = AuthReqSecParamsGen.genAuthReqSecParams();
    final authorizationRequestUri = GoogleAuthUrl.getGoogleAuthUrl(
      parameters: GoogleAuthUrlParameters(
        clientId: model.setup.clientId,
        redirectUri: model.setup.redirectUri,
        responseType: "code",
        scopes: model.setup.scopes,
        codeChallenge: secParams.codeChallange,
        codeChallengeMethod: "S256",
        state: secParams.state,
        loginHint: model.setup.loginHint,
      ),
    );
    if (Platform.isWindows) {
      await controller?.initialize();
      await controller?.setBackgroundColor(Colors.transparent);
      controller?.url.listen((url) async {
        await GoogleAuthCallbackHandler.listenForAuthCallback(
          googleAuthCallback: GoogleAuthCallback(
            url: url,
            clientId: model.setup.clientId,
            clientSecret: model.setup.clientSecret,
            redirectUri: model.setup.redirectUri,
            codeVerifier: secParams.codeVerifier,
            onSuccess: model.setup.onSuccess,
            onError: model.setup.onError,
            onLoading: model.onLoading,
          ),
        );
      });
      await controller?.loadUrl(authorizationRequestUri);
    }
    if (Platform.isAndroid) {
      await mobileController?.setJavaScriptMode(JavaScriptMode.unrestricted);
      await mobileController?.setUserAgent(
        "Mozilla/5.0(Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML , like Gecko) Chrome/86.0.4240.198 Mobile Safari/537.36",
      );
      await mobileController?.setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            await GoogleAuthCallbackHandler.listenForAuthCallback(
              googleAuthCallback: GoogleAuthCallback(
                url: url,
                clientId: model.setup.clientId,
                clientSecret: model.setup.clientSecret,
                redirectUri: model.setup.redirectUri,
                codeVerifier: secParams.codeVerifier,
                onSuccess: model.setup.onSuccess,
                onError: model.setup.onError,
                onLoading: model.onLoading,
              ),
            );
          },
        ),
      );
      await mobileController?.loadRequest(Uri.parse(authorizationRequestUri));
    }
    model.onInitalized();
  }
}
