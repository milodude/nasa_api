import '../constants/hosts.dart';

class UrlProvider {
  UrlProvider({
    String? baseUrl,
  }) {
    baseUri = Uri.parse(baseUrl ?? serverUrl);
  }

  late Uri baseUri;

  Uri getUrl(String path, Map<String, dynamic>? params) {
    return Uri(
        scheme: baseUri.scheme,
        host: baseUri.host,
        port: baseUri.port,
        path: baseUri.path + path,
        queryParameters: params);
  }

  Future<Map<String, String>> getHeaders() async {
    final Map<String, String> headers = <String, String>{};
    headers['Content-type'] = 'application/json';
    headers['Accept'] = '*/*';
    headers['Access-Control-Allow-Origin'] = '*';

    return headers;
  }
}
