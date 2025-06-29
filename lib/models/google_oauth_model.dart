import 'package:google_oauth2_flutter/models/google_auth_setup.dart'
    show GoogleAuthSetup;

class GoogleOauthModel {
  final GoogleAuthSetup setup;
  final void Function() onInitalized;
  final void Function() onLoading;

  const GoogleOauthModel({
    required this.setup,
    required this.onInitalized,
    required this.onLoading,
  });
}
