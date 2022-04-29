import 'dart:io';

import 'package:http/http.dart' as http;

const baseURL = "https://api.github.com/repos/geparedesm/github/";
const headers = {
  HttpHeaders.userAgentHeader: 'application/vnd.github.v3+json',
  HttpHeaders.acceptHeader: "*/*",
  HttpHeaders.acceptEncodingHeader: "gzip, deflate, br",
  HttpHeaders.connectionHeader: "keep-alive",
  HttpHeaders.authorizationHeader: "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",
};

Future<http.Response> getBranches() async {
  final response = await http.get(
    Uri.parse(baseURL + "branches"),
    headers: headers,
  );
  return response;
}

Future<http.Response> getCommits(int maxPages, String branchName) async {
  final response = await http.get(
    Uri.parse(baseURL + "commits?per_page=$maxPages&sha=$branchName"),
    headers: headers,
  );
  return response;
}
