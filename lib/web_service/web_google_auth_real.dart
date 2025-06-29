import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:google_oauth2/models/google_auth_callback.dart';
import 'package:google_oauth2/models/google_auth_setup.dart';
import 'package:google_oauth2/models/google_auth_url_paarmeters.dart';
import 'package:google_oauth2/utils/auth_req_sec_params_generator.dart';
import 'package:google_oauth2/utils/google_auth_listener.dart';
import 'package:google_oauth2/utils/google_auth_url.dart';

class WebGoogleAuth {
  static Future<void> startSignin({required GoogleAuthSetup setup}) async {
    final secParams = AuthReqSecParamsGen.genAuthReqSecParams();
    html.window.localStorage['code_verifier'] = secParams.codeVerifier;

    final authorizationRequestUri = GoogleAuthUrl.getGoogleAuthUrl(
      parameters: GoogleAuthUrlParameters(
        clientId: setup.clientId,
        redirectUri: setup.redirectUri,
        responseType: "code",
        scopes: setup.scopes,
        codeChallenge: secParams.codeChallange,
        codeChallengeMethod: "S256",
        state: secParams.state,
      ),
    );
    html.window.location.href = authorizationRequestUri;
  }

  static void clearAuthStorage() {
    html.window.localStorage.remove('code_verifier');
  }

  static Future<void> listenToRequestUrl({
    required GoogleAuthSetup setup,
  }) async {
    final codeVerifier = html.window.localStorage['code_verifier'];

    if (codeVerifier == null) {
      debugPrint("code_verifier is missing from localStorage.");
      return;
    }

    await GoogleAuthCallbackHandler.listenForAuthCallback(
      googleAuthCallback: GoogleAuthCallback(
        url: html.window.location.href,
        clientId: setup.clientId,
        clientSecret: setup.clientSecret,
        redirectUri: setup.redirectUri,
        codeVerifier: codeVerifier,
        onSuccess: (accessToken) {
          setup.onSuccess?.call(accessToken);
          clearAuthStorage();
        },
        onError: setup.onError,
        onLoading: () {},
      ),
    );
  }
}
