import 'package:dartz/dartz.dart';
import 'package:google_oauth2_flutter/errors/google_auth_failure.dart';
import 'package:google_oauth2_flutter/utils/google_token_exchanger.dart';
import '../models/google_auth_callback.dart';
import '../models/google_token_exchanger_input_model.dart';

class GoogleAuthCallbackHandler {
  static Future<Either<GoogleAuthFailure, void>> listenForAuthCallback({
    required GoogleAuthCallback googleAuthCallback,
  }) async {
    final authorizationUri = Uri.parse(googleAuthCallback.url);
    final queryParameters = authorizationUri.queryParameters;

    final isAuthorizationCodeReturned = queryParameters.containsKey('code');
    final isErrorOccured = queryParameters.containsKey('error');

    if (isAuthorizationCodeReturned) {
      googleAuthCallback.onLoading();

      final code = queryParameters['code']!;
      final result = await GoogleTokenExchanger.exchangeCode(
        GoogleTokenExchangerInputModel(
          clientId: googleAuthCallback.clientId,
          clientSecret: googleAuthCallback.clientSecret,
          redirectUri: googleAuthCallback.redirectUri,
          codeVerifier: googleAuthCallback.codeVerifier,
          code: code,
          apiUrl: "https://oauth2.googleapis.com/token",
          grantType: "authorization_code",
        ),
      );
      result.fold(
        (l) {
          googleAuthCallback.onError?.call(l);
        },
        (r) {
          googleAuthCallback.onSuccess?.call(r);
        },
      );
      return right(null);
    } else if (isErrorOccured) {
      return left(GoogleAuthFailure.fromResponse(queryParameters));
    }
    return right(null);
  }
}
