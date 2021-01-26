import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../themes/theme_config.dart';
import '../models/movie_item.dart';
import '../providers/movie_item_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<MovieItem> _futureMovie;
  int initMovie = 1;

  Future<MovieItem> _fetchMovie() async {
    try {
      final response = await http.get("https://kitsu.io/api/edge/anime/25");

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        final responseData = jsonDecode(response.body);
        return MovieItem.fromJson(responseData['data']);
      } else {
        throw Exception("Failed to fetch data!");
      }
    } catch (e) {
      throw (e);
    }
    // try {
    //   Dio dio = Dio();
    //   final response = await dio.get(
    //     'https://kitsu.io/api/edge/anime/25',
    //     options: Options(
    //       contentType: "application/json; charset=utf-8",
    //       responseType: ResponseType.json,
    //     ),
    //   );
    //   print(response.statusCode);

    //   if (response.statusCode == 200) {
    //     print(response.data);
    //     print(response.data is Map);
    //     return MovieItem.fromJson(response.data['data'] as Map<String, dynamic>);
    //   } else {
    //     print("something went wrong!");
    //   }
    // } catch (error, stacktrace) {
    //   print("exception occured: $error stackTrace: $stacktrace");
    // }
  }

  @override
  void initState() {
    _futureMovie = _fetchMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: ThemeSwitcher(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? darkTheme
                                : lightTheme,
                            reverseAnimation:
                                ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? true
                                    : false,
                          );
                        },
                        icon: Icon(Icons.brightness_3, size: 25),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Home',
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<void>(
                future: Provider.of<MovieItemProvier>(context, listen: false)
                    .fetchAndSetMovieItem(initMovie),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("loading"),
                    );
                  } else if (dataSnapshot.error == null) {
                    return Consumer<MovieItemProvier>(
                      builder: (ctx, movieData, _) => ListView(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 6,
                        ),
                        children: [
                          Text(
                            movieData.movieItem.title,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Row(
                            children: [
                              Text("Realsed on " +
                                  DateFormat().format(DateTime.parse(
                                      movieData.movieItem.endDate))),
                              Spacer(),
                              Chip(
                                backgroundColor: Colors.amber.withOpacity(0.94),
                                label: Text(movieData.movieItem.status),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            child: Image.network(
                              movieData.movieItem.coverImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                initialRating: (double.parse(
                                            movieData.movieItem.averageRating) /
                                        10) /
                                    2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1),
                                itemBuilder: (ctx, i) {
                                  return Container(
                                    height: 20,
                                    width: 16,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                  );
                                },
                                onRatingUpdate: null,
                              ),
                              Chip(
                                backgroundColor: Colors.amber.withOpacity(0.9),
                                label: Row(
                                  children: [
                                    Icon(Icons.favorite),
                                    Text(movieData.movieItem.favouriateCount
                                        .toString()),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(movieData.movieItem.description),
                          Text("age rating : " +
                              movieData.movieItem.ageRatingGuide),
                          Text("episodes : " +
                              movieData.movieItem.episodeCount.toString() +
                              " to " +
                              movieData.movieItem.episodeLenght.toString()),
                          Text("favouriates : " +
                              movieData.movieItem.favouriateCount.toString()),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("loading"),
                    );
                  }
                },
              ),
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  OutlineButton(
                    onPressed: () {
                      Provider.of<MovieItemProvier>(context, listen: false)
                          .fetchAndSetMovieItem(
                              initMovie == 1 ? 1 : (initMovie -= 1));
                    },
                    child: Icon(Icons.arrow_left),
                  ),
                  Spacer(),
                  OutlineButton(
                    onPressed: () {
                      Provider.of<MovieItemProvier>(context, listen: false)
                          .fetchAndSetMovieItem(initMovie += 1);
                    },
                    child: Icon(Icons.arrow_right),
                  ),
                ],
              ),
            ),
          ],
        ),
        // body: Center(
        //   child: OutlineButton(
        //     onPressed: () async {
        //       final response =
        //           await Dio().get("https://kitsu.io/api/edge/anime/1");
        //       print(response.data);
        //     },
        //     onPressed: _fetchMovies,
        //     child: Text("fetch data"),
        //   ),
        // ),
      ),
    );
  }
}
