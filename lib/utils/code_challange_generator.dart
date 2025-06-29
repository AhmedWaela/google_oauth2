import 'dart:convert';
import 'package:crypto/crypto.dart';

class CodeChallengeGenerator {
  static String generateCodeChallenge(String codeVerifier) {
    final bytes = sha256.convert(ascii.encode(codeVerifier)).bytes;
    return base64Url.encode(bytes).replaceAll('=', '');
  }
}