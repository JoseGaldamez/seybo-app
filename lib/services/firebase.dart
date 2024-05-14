import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:radioseiboapp/models/news.model.dart';

Future<List<NewsFirebase>> getNotasFromFirebase() async {
  final response = await http.get(
    Uri.parse('https://seybo-app-default-rtdb.firebaseio.com/news.json'),
  );

  if (response.statusCode == 200) {
    final List<NewsFirebase> listNews = [];
    Map data = jsonDecode(response.body);
    data.forEach((key, value) {
      final news = NewsFirebase.fromJson(value);
      listNews.add(news);
    });
    return listNews;
  } else {
    throw Exception('Failed to load news from Firebase');
  }
}
