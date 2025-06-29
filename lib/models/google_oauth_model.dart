import 'package:google_oauth2/models/google_auth_setup.dart';

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
