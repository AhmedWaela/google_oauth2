class GoogleAuthUrlParameters {
  final String clientId;
  final String redirectUri;
  final String responseType;
  final List<String> scopes;
  final String codeChallenge;
  final String codeChallengeMethod;
  final String state;
  final String? loginHint;

  const GoogleAuthUrlParameters({
    required this.clientId,
    required this.redirectUri,
    required this.responseType,
    required this.scopes,
    required this.codeChallenge,
    required this.codeChallengeMethod,
    required this.state,
    this.loginHint,
  });
}