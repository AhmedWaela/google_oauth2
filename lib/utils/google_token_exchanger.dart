import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:google_oauth2_flutter/errors/google_auth_failure.dart';
import 'package:google_oauth2_flutter/models/google_token_exchanger_input_model.dart';
import '../../models/google_tokens.dart';
import "package:http/http.dart";

/// This class exchange google authorization code for accessToken
///
/// * This send request to authorization's server in this endpoint https://oauth2.googleapis.com/token with these parameters
///
/// 1- code (authorization code) that returns after user consents to application
///
/// 2- client_id this is from google cloud console from web client
///
/// 3- client_secret this is from google cloud console from web client
///
/// 4- redirect_uri  that detemine how google authorization server sends the response to your app , you must pass uri match with uri in authorized url in google cloud console in web client
///
/// 5- code_verfier that you generate it first you sent it to compare it with code callange
///
/// 6- grant_type that value must be "authorization_code"
///
///  and finally extract access token from response
class GoogleTokenExchanger {
  /// exchange authorization code for access token
  static Future<Either<GoogleAuthFailure, GoogleTokens>> exchangeCode(
    GoogleTokenExchangerInputModel googleTokenExchangerInputModel,
  ) async {
    final response = await post(
      Uri.parse(googleTokenExchangerInputModel.apiUrl),
      headers: {
         "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "code": googleTokenExchangerInputModel.code,
        "client_id": googleTokenExchangerInputModel.clientId,
        "client_secret": googleTokenExchangerInputModel.clientSecret,
        "redirect_uri": googleTokenExchangerInputModel.redirectUri,
        "code_verifier": googleTokenExchangerInputModel.codeVerifier,
        "grant_type": googleTokenExchangerInputModel.grantType,
      },
    );
    if (response.statusCode != 200) {
      return left(GoogleAuthFailure(message: ""));
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return right(
      GoogleTokens(
        idToken: data["id_token"],
        accessToken: data["access_token"],
      ),
    );
  }
}
