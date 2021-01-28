import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:movieapp/providers/movie_items_provider.dart';
import 'package:movieapp/tests/search.dart';
import 'package:provider/provider.dart';

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
                          setState(() {
                            timeDilation = 3.0;
                          });
                          ThemeSwitcher.of(context).changeTheme(
                            theme: theme,
                            reverseAnimation:
                                ThemeProvider.of(context).brightness ==
                                        Brightness.dark
                                    ? true
                                    : false,
                          );
                          setState(() {
                            timeDilation = 1.0;
                          });
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
                      builder: (ctx) => TestScreen("Anime"),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  "Anime Series",
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
                      builder: (ctx) => TestScreen("Manga"),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  "Manga Series",
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
                      builder: (ctx) => TestPage("Anime"),
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
                      builder: (ctx) => TestPage("Manga"),
                    ),
                  );
                },
                title: Text(
                  "Popular Manga Series",
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
                      builder: (ctx) => TrendingSeries("Anime"),
                    ),
                  );
                },
                title: Text(
                  "Trending Anime Series",
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
                      builder: (ctx) => TrendingSeries("Manga"),
                    ),
                  );
                },
                title: Text(
                  "Trending Manga Series",
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
                      builder: (ctx) => SearchScreen(),
                    ),
                  );
                },
                title: Text(
                  "Search Implementation",
                  style: TextStyle(
                    color: Colors.black54,
                    // fontSize: 18,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            // OutlineButton(
            //   onPressed: () {
            //     Provider.of<MovieItemsProvider>(context, listen: false)
            //         .searchAndSetSeries("attack on");
            //   },
            //   child: Text("test api"),
            // ),
          ],
        ),
      ),
    );
  }
}
