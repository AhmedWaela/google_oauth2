class GoogleTokenExchangerInputModel {
  final String? clientId;
  final String clientSecret;
  final String redirectUri;
  final String? codeVerifier;
  final String code;
  final String apiUrl;
  final String? grantType;

  const GoogleTokenExchangerInputModel({
    this.clientId,
    required this.clientSecret,
    required this.redirectUri,
    this.codeVerifier,
    required this.code,
    required this.apiUrl,
    this.grantType,
  });
}