import 'dart:math';

String generateState({int length = 32}) {
  const String chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final Random random = Random.secure();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}
