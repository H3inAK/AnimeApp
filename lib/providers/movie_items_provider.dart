import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/movie_item.dart';

class MovieItemsProvider with ChangeNotifier {
  List<MovieItem> _movieItems = List<MovieItem>();

  List<MovieItem> get movieItems {
    return [..._movieItems];
  }

  Future<void> fetchAndSetMovieItems(String category, int offset,
      [int limit = 10]) async {
    final url =
        "https://kitsu.io/api/edge/$category?page[limit]=$limit&page[offset]=$offset";
    final response = await http.get(url);
    final responseData = jsonDecode(response.body)["data"] as List<dynamic>;
    // print(responseData);

    _movieItems.clear();
    responseData.forEach((movieItem) {
      _movieItems.add(MovieItem.fromJson(movieItem));
    });
    _movieItems.forEach((movieItem) {
      print(movieItem.title);
    });
    notifyListeners();
  }

  Future<void> fetchAndSetPopularMovieItems(String category, int offset,
      [int limit = 10]) async {
    final url =
        "https://kitsu.io/api/edge/$category?page[limit]=$limit&page[offset]=$offset&sort=popularityRank";
    final response = await http.get(url);
    final responseData = jsonDecode(response.body)["data"] as List<dynamic>;
    // print(responseData);

    _movieItems.clear();
    responseData.forEach((movieItem) {
      _movieItems.add(MovieItem.fromJson(movieItem));
    });
    _movieItems.forEach((movieItem) {
      print(movieItem.title);
    });
    notifyListeners();
  }

  Future<void> fetchAndSetTrendingSeries(String category, int offset,
      [int limit = 10]) async {
    final url =
        "https://kitsu.io/api/edge/trending/$category?page[limit]=$limit&page[offset]=$offset";
    final response = await http.get(url);
    final responseData = jsonDecode(response.body)["data"] as List<dynamic>;
    // print(responseData);

    _movieItems.clear();
    responseData.forEach((movieItem) {
      _movieItems.add(MovieItem.fromJson(movieItem));
    });
    _movieItems.forEach((movieItem) {
      print(movieItem.title);
    });
    notifyListeners();
  }

  Future<void> searchAndSetSeries(String query) async {
    final url = "https://kitsu.io/api/edge/anime?filter[text]=$query";
    final response = await http.get(url);
    final responseData = jsonDecode(response.body)["data"] as List<dynamic>;
    // print(responseData);

    _movieItems.clear();
    responseData.forEach((movieItem) {
      _movieItems.add(MovieItem.fromJson(movieItem));
    });
    _movieItems.forEach((movieItem) {
      print(movieItem.title);
    });
    notifyListeners();
  }

  MovieItem findById(String id) {
    return _movieItems.firstWhere((movieItem) => movieItem.id == id);
  }

  void changeSignal() {
    notifyListeners();
  }
}
