import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/movie_item.dart';

class MovieItemProvier with ChangeNotifier {
  MovieItem _movieItem = MovieItem();

  MovieItem get movieItem {
    return _movieItem;
  }

  Future<void> fetchAndSetMovieItem(int id) async {
    try {
      final response = await http.get("https://kitsu.io/api/edge/anime/$id");

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        final responseData = jsonDecode(response.body);
        _movieItem = MovieItem.fromJson(responseData['data']);
        notifyListeners();
      } else {
        throw Exception("Failed to fetch data!");
      }
    } catch (e) {
      throw (e);
    }
  }
}
