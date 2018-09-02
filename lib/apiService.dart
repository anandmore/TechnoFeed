import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = "364d218a3b7547ea86d6aff3cf8f3cbe";
String _topUrl =
    "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=";
String _allUrl =
    "https://newsapi.org/v2/everything?sources=ars-technica,crypto-coins-news,engadget,hacker-news,recode,techcrunch,techradar,the-next-web,the-verge,wired&launguage=en&apiKey=";
String _sourceUrl =
    "https://newsapi.org/v2/sources?category=technology&language=en&apiKey=";

Future<List> fetchTopHeadlines() async {
  http.Response response = await http.get(_topUrl + apiKey);
  return (json.decode(response.body)['articles']);
}

Future<List> fetchAllHeadlines() async {
  http.Response response = await http.get(_allUrl + apiKey);
  return (json.decode(response.body)['articles']);
}

Future<List> fetchSources() async {
  http.Response response = await http.get(_sourceUrl + apiKey);
  return (json.decode(response.body)['sources']);
}
