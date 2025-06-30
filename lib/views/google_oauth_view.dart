import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_oauth2_flutter/enums/google_auth_state.dart';
import 'package:google_oauth2_flutter/models/google_oauth_model.dart';
import 'package:google_oauth2_flutter/repo/google_oauth_repo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';
import '../../models/google_auth_setup.dart';

/// This view load web page that request from user to grant access to your application and then exchange authorization for access token and you can access it in onSuccess Callback
class GoogleOAuthView extends StatefulWidget {
  const GoogleOAuthView({super.key, required this.setup});

  /// This is Google Auth Setup Model
  final GoogleAuthSetup setup;

  @override
  State<GoogleOAuthView> createState() => _GoogleOAuthViewState();
}

class _GoogleOAuthViewState extends State<GoogleOAuthView> {
  WebviewController? windowsController;
  WebViewController? mobileController;
  GoogleAuthState authState = GoogleAuthState.loading;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (Platform.isWindows) {
      windowsController = WebviewController();
    }
    if (Platform.isAndroid || Platform.isIOS) {
      mobileController = WebViewController();
    }
    await initalizeGoogleWebView();
  }

  Future<void> initalizeGoogleWebView() async {
    final GoogleOAuthRrepoImpl googleAuthRepo = GoogleOAuthRrepoImpl(
      controller: windowsController,
      mobileController: mobileController,
    );
    await googleAuthRepo.authWithGoogle(
      model: GoogleOauthModel(
        onInitalized: () {
          setState(() {
            authState = GoogleAuthState.initalized;
          });
        },
        onLoading: () {
          setState(() {
            authState = GoogleAuthState.loading;
          });
        },
        setup: GoogleAuthSetup(
          clientId: widget.setup.clientId,
          clientSecret: widget.setup.clientSecret,
          redirectUri: widget.setup.redirectUri,
          appBarTitle: widget.setup.appBarTitle,
          centerTitle: widget.setup.centerTitle,
          loginHint: widget.setup.loginHint,
          onError: (failure) {
            setState(() {
              authState = GoogleAuthState.failure;
            });
            widget.setup.onError?.call(failure);
          },
          onSuccess: (tokens) {
            setState(() {
              authState = GoogleAuthState.success;
            });
            widget.setup.onSuccess?.call(tokens);
          },
          scopes: widget.setup.scopes,
        ),
      ),
    );
  }

  Widget getBody() {
    switch (authState) {
      case GoogleAuthState.loading:
        return widget.setup.loadingWidget;
      case GoogleAuthState.success:
        return widget.setup.successWidget;
      case GoogleAuthState.failure:
        return widget.setup.failureWidget;
      case GoogleAuthState.initalized:
        return Center(
          child: Platform.isWindows
              ? Webview(windowsController!)
              : WebViewWidget(controller: mobileController!),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.setup.appBarTitle),
        centerTitle: widget.setup.centerTitle,
      ),
      body: getBody(),
    );
  }

  @override
  void dispose() {
    windowsController?.dispose();
    mobileController = null;
    super.dispose();
  }
}
