class GoogleAuthFailure {
  final String message;

  const GoogleAuthFailure({required this.message});


  factory GoogleAuthFailure.fromResponse(dynamic e) {
    String errorDescription = "An unexpected error occurred.";
    switch (e["error_description"]) {
      case "Invalid grant_type: ":
        errorDescription =
            "The grant type parameter is invalid or missing. Ensure the 'grant_type' field in the request body is set to 'authorization_code'.";
        break;

      case "Missing code verifier.":
        errorDescription =
            "The code verifier parameter is missing. Ensure you include a valid 'code_verifier' in the request body.";
        break;

      case "Missing parameter: redirect_uri":
        errorDescription =
            "The redirect URI parameter is missing. Ensure the 'redirect_uri' is provided and matches the URI used during the authorization request.";
        break;
      case "client_secret is missing.":
        errorDescription =
            "The client secret parameter is missing. Ensure you include the 'client_secret' field in the request body and that it matches the secret provided in your OAuth2 credentials.";
        break;
      case "Could not determine client ID from request.":
        errorDescription =
            "The client ID could not be determined from the request. Ensure you include the 'client_id' field in the request body and that it matches the client ID provided in your OAuth2 credentials.";
        break;
      case "Missing required parameter: code":
        errorDescription =
            "The authorization code parameter is missing. Ensure you include the 'code' field in the request body, which is obtained after user authentication.";
        break;
      default:
        errorDescription = e["error_description"];
        break;
    }

    return GoogleAuthFailure(message: errorDescription);
  }
}
