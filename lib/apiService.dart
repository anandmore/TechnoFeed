import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = "364d218a3b7547ea86d6aff3cf8f3cbe";
String _topUrl =
    "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=";
String _customUrl =
    "https://gist.githubusercontent.com/anandmore/964bcfcd688a60e98f04fc626801be3a/raw/c6eff73a1afbe50eeb2e30bd9fd1da8d17391b09/technofeed.json";
String _sourceUrl =
    "https://newsapi.org/v2/sources?category=technology&language=en&apiKey=";

Future<List> fetchTopHeadlines() async {
  http.Response response = await http.get(_topUrl + apiKey);
  return (json.decode(response.body)['articles']);
}

Future<List> fetchCustomHeadlines() async {
  http.Response response = await http.get(_customUrl);
  return (json.decode(response.body)['articles']);
}

Future<List> fetchSources() async {
  http.Response response = await http.get(_sourceUrl + apiKey);
  return (json.decode(response.body)['sources']);
}
