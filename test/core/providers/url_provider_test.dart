import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_api/core/constants/hosts.dart';
import 'package:nasa_api/core/providers/url_provider.dart';

void main() {
  final UrlProvider urlProvider = UrlProvider(baseUrl: serverUrl);

  test('Should get a proper formed url', () {
    final Uri url = urlProvider.getUrl('myPath', null);
    expect(url.host, 'api.nasa.gov');
    expect(url.path, '/myPath');
  });

  test('Should get a proper conformed header when needed', () async {
    final Map<String, String> url = await urlProvider.getHeaders();
    expect(url, <String, String>{
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
    });
  });
}
