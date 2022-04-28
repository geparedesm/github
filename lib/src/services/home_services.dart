import 'package:http/http.dart' as http;

const baseURL = "https://api.github.com/repos/geparedesm/github/";
Future<http.Response> getBranches() async {
  final response = await http.get(Uri.parse(baseURL + "branches"));
  return response;
}
