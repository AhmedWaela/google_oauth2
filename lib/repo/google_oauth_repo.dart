import 'package:google_oauth2/models/google_oauth_model.dart';

abstract interface class GoogleOAuthRepo {
  Future<void> authWithGoogle({required GoogleOauthModel model});
}

class GoogleOAuthRrepoImpl implements GoogleOAuthRepo {
  @override
  Future<void> authWithGoogle({required GoogleOauthModel model}) async {
    throw UnimplementedError();
  }
}
