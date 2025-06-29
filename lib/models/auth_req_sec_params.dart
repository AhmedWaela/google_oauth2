class AuthReqSecParams {
  final String codeVerifier;
  final String codeChallange;
  final String state;

  const AuthReqSecParams({
    required this.codeVerifier,
    required this.codeChallange,
    required this.state,
  });
}