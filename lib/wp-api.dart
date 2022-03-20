import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchFromUrl(url) async {
  final response = await http.get(Uri.parse(url),
      headers: {"Accept": "application/json"});
  var convertedJsonData = jsonDecode(response.body);
  return convertedJsonData;
}

Future<List> fetchFromFile() async {
  final String response = await rootBundle.loadString('lib/views/category_list.json');
  var convertedJsonData = json.decode(response);
  return convertedJsonData;
}

Future fetchWpPostImage(href) async {
  final response = await http.get(Uri.parse(href),
      headers: {"Accept": "application/json"});
  var convertedJsonData = jsonDecode(response.body);
  return convertedJsonData;
}