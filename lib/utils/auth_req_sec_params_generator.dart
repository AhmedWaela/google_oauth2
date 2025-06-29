
import 'package:google_oauth2_flutter/models/auth_req_sec_params.dart';
import 'package:google_oauth2_flutter/utils/code_verifer_generator.dart';
import 'package:google_oauth2_flutter/utils/generate_state.dart';

import 'code_challange_generator.dart';

class AuthReqSecParamsGen {
  static AuthReqSecParams genAuthReqSecParams() {
    final codeVerifier = generateCodeVerifier();
    final codeChallenge = CodeChallengeGenerator.generateCodeChallenge(codeVerifier);
    final state = generateState();
    return AuthReqSecParams(
      codeVerifier: codeVerifier,
      codeChallange: codeChallenge,
      state: state,
    );
  }
}