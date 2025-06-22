import 'package:nanoid/nanoid.dart';

class StringUtils {
  /// Generates an ID like `abc-def-ghi-jkl`, using only lowercase letters and numbers.
  static String generateFormattedId() {
    return nanoid(15);
  }

  /// Generates a short, human-friendly reference ID like `k9x8-q2mj-p4z1`
  static String createFormattedReference() {
    const _alphabet = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const _groupLength = 4;
    const _numGroups = 2;

    final parts = List.generate(
      _numGroups,
      (_) => customAlphabet(_alphabet, _groupLength),
    );
    return parts.join('-');
  }
}
