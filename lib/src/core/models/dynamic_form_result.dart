import 'package:http/http.dart' as http;

class DynamicFormResult {
  final Map<String, dynamic> values;
  final List<http.MultipartFile> files;

  DynamicFormResult({required this.values, required this.files});
}
