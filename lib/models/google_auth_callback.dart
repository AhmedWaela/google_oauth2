
import 'package:google_oauth2_flutter/errors/google_auth_failure.dart';

import '../../models/google_tokens.dart';

class GoogleAuthCallback {
  final String url;
  final String clientId;
  final String clientSecret;
  final String redirectUri;
  final String codeVerifier;
  final Function(GoogleTokens tokens)? onSuccess;
  final Function(GoogleAuthFailure)? onError;
  final Function() onLoading;

  GoogleAuthCallback({
    required this.url,
    required this.clientId,
    required this.clientSecret,
    required this.redirectUri,
    required this.codeVerifier,
    required this.onSuccess,
    required this.onError,
    required this.onLoading,
  });
}
