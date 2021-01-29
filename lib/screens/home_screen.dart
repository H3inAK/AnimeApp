import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../themes/theme_service.dart';
import '../models/data.dart';
import './search_screen.dart';
import './all_movie_series.dart';
import './popular_movie_series.dart';
import './trending_series.dart';
import './categories_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data> cardList = <Data>[
    Data(
      title: "All anime Series",
      widget: AllMovieSeriesScreen("Anime"),
    ),
    Data(
      title: "All manga Series",
      widget: AllMovieSeriesScreen("Manga"),
    ),
    Data(
      title: "Popular Anime Series",
      widget: PopularMovieSeries("Anime"),
    ),
    Data(
      title: "Popular Manga Series",
      widget: PopularMovieSeries("Manga"),
    ),
    Data(
      title: "Trending Anime Series",
      widget: TrendingSeries("Anime"),
    ),
    Data(
      title: "Trending Manga Series",
      widget: TrendingSeries("Manga"),
    ),
    Data(
      title: "Adventure Anime Series",
      widget: CategoySeries("Anime", "Adventure"),
    ),
    Data(
      title: "Romance Anime Series",
      widget: CategoySeries("Anime", "Romance"),
    ),
    Data(
      title: "Action Anime Series",
      widget: CategoySeries("Anime", "Action"),
    ),
    Data(
      title: "Adventure Manga Series",
      widget: CategoySeries("Manga", "Adventure"),
    ),
    Data(
      title: "Romance Manga Series",
      widget: CategoySeries("Manga", "Romance"),
    ),
    Data(
      title: "Action Manga Series",
      widget: CategoySeries("Manga", "Action"),
    ),
    Data(
      title: "Search Anime Series",
      widget: SearchScreen(),
    ),
  ];

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
                        onPressed: () async {
                          var themeName =
                              ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? 'dark'
                                  : 'light';
                          print(themeName);
                          var service = await ThemeService.instance
                            ..save(themeName);
                          var theme = service.getByName(themeName);

                          ThemeSwitcher.of(context).changeTheme(
                            theme: theme,
                            reverseAnimation:
                                ThemeProvider.of(context).brightness ==
                                        Brightness.dark
                                    ? true
                                    : false,
                          );
                        },
                        icon: ThemeProvider.of(context).brightness ==
                                Brightness.dark
                            ? Icon(Icons.wb_sunny, size: 25)
                            : Icon(Icons.brightness_3, size: 25),
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
            'FoxAnime',
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          itemCount: cardList.length,
          itemBuilder: (ctx, i) {
            return Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => cardList[i].widget,
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  cardList[i].title,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ),
      ),
    );
  }
}
