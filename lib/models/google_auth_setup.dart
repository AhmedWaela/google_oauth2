import 'package:flutter/material.dart';
import 'package:google_oauth2/errors/google_auth_failure.dart';
import 'google_tokens.dart';

class GoogleAuthSetup {
  /// The client id from google cloud console in web client
  final String clientId;

  /// The client secret from google cloud console in web client
  final String clientSecret;

  /// The user resources that you want access via access token
  final List<String> scopes;

  /// The redirect url that you defined in google cloud console
  final String redirectUri;

  /// This attribute prefilling email field if application know user
  final String? loginHint;

  /// This callabck executed after get access token and you can access Google Tokens (access token,id token)
  final Function(GoogleTokens tokens)? onSuccess;

  /// This callback executed if error if ocured during oauth process
  final Function(GoogleAuthFailure)? onError;

  /// The Web view appBar Title
  final String appBarTitle;

  /// Determine whether appbar title in center or not
  final bool centerTitle;

  /// The widget that will display during loading
  final Widget loadingWidget;

  /// The widget that will display after success
  final Widget successWidget;

  /// The widget that will displat if error occurred
  final Widget failureWidget;

  const GoogleAuthSetup({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUri,
    this.loginHint,
    this.onError,
    this.onSuccess,
    this.scopes = const [
      "https://www.googleapis.com/auth/userinfo.profile",
      "https://www.googleapis.com/auth/userinfo.email",
    ],
    this.appBarTitle = "Google Authorization",
    this.centerTitle = false,
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.successWidget = const Center(
      child: Text("Google Authorization Success"),
    ),
    this.failureWidget = const Center(
      child: Text("Google Authrizarion Failed"),
    ),
  });
}
