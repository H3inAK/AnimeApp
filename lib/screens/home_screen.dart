import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../themes/theme_service.dart';
import '../tests/test_api.dart';
import '../tests/test_page.dart';
import '../tests/trending_series.dart';

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
                          // ThemeSwitcher.of(context).changeTheme(theme: theme);
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
            horizontal: 30,
          ),
          children: [
            RaisedButton(
              elevation: 6,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => TestScreen("Anime"),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Anime Series",
                style: TextStyle(
                  color: Colors.black54,
                  // fontSize: 18,
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            RaisedButton(
              elevation: 6,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => TestScreen("Manga"),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Manga Series",
                style: TextStyle(
                  color: Colors.black54,
                  // fontSize: 18,
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            RaisedButton(
              elevation: 6,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => TestPage("Anime"),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Popular Anime Series",
                style: TextStyle(
                  color: Colors.black54,
                  // fontSize: 18,
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            RaisedButton(
              elevation: 6,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => TestPage("Manga"),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Popular Manga Series",
                style: TextStyle(
                  color: Colors.black54,
                  // fontSize: 18,
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            RaisedButton(
              elevation: 6,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => TrendingSeries("Anime"),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Trending Anime Series",
                style: TextStyle(
                  color: Colors.black54,
                  // fontSize: 18,
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            RaisedButton(
              elevation: 6,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => TrendingSeries("Manga"),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Trending Manga Series",
                style: TextStyle(
                  color: Colors.black54,
                  // fontSize: 18,
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
