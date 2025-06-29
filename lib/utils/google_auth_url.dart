import '../models/google_auth_url_paarmeters.dart';

class GoogleAuthUrl {
  static String getGoogleAuthUrl({
    required GoogleAuthUrlParameters parameters,
  }) {
    final authUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
      'client_id': parameters.clientId,
      'redirect_uri': parameters.redirectUri,
      'response_type': parameters.responseType,
      'scope': parameters.scopes.join(" "),
      'code_challenge': parameters.codeChallenge,
      'code_challenge_method': parameters.codeChallengeMethod,
      "state": parameters.state,
      if (parameters.loginHint != null) "login_hint": parameters.loginHint,
    }).toString();
    return authUrl;
  }
}