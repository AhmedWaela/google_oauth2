import 'dart:math';

String generateCodeVerifier({int length = 64}) {
  const String chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
  final Random random = Random.secure();

  if (length < 43 || length > 128) {
    throw ArgumentError('code_verifier length must be between 43 and 128');
  }

  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}