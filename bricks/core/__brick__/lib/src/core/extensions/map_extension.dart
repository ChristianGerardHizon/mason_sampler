extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> transform(dynamic Function(dynamic) transform) {
    return map((key, value) {
      return MapEntry(key, transform(value));
    });
  }
}
