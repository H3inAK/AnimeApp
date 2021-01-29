import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../themes/theme_service.dart';
import './search_screen.dart';
import './all_movie_series.dart';
import './popular_movie_series.dart';
import './trending_series.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        body: ListView(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          children: [
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => AllMovieSeriesScreen("Anime"),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  "Anime Series",
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => AllMovieSeriesScreen("Manga"),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  "Manga Series",
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => PopularMovieSeries("Anime"),
                    ),
                  );
                },
                title: Text(
                  "Popular Anime Series",
                  style: TextStyle(
                    color: Colors.black54,
                    // fontSize: 18,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => PopularMovieSeries("Manga"),
                    ),
                  );
                },
                title: Text(
                  "Popular Manga Series",
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => TrendingSeries("Anime"),
                    ),
                  );
                },
                title: Text(
                  "Trending Anime Series",
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => TrendingSeries("Manga"),
                    ),
                  );
                },
                title: Text(
                  "Trending Manga Series",
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (ctx) => SearchScreen(),
                    ),
                  );
                },
                title: Text(
                  "Search Implementation",
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
