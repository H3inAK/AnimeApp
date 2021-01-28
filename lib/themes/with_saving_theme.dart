import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'theme_config.dart';
import './theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeServise = await ThemeService.instance;
  var initTheme = themeServise.initial;
  runApp(MyApp(theme: initTheme));
}

class MyApp extends StatelessWidget {
  MyApp({this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: theme,
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeProvider.of(context),
          home: MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                        onPressed: () async {
                          var themeName =
                              ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? 'dark'
                                  : 'light';
                          var service = await ThemeService.instance
                            ..save(themeName);
                          var theme = service.getByName(themeName);
                          ThemeSwitcher.of(context).changeTheme(theme: theme);
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
            'Flutter Demo Home Page',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: TextStyle(fontSize: 200),
              ),
              CheckboxListTile(
                title: Text('Slow Animation'),
                value: timeDilation == 5.0,
                onChanged: (value) {
                  setState(() {
                    timeDilation = value ? 5.0 : 1.0;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ThemeSwitcher(
                    clipper: ThemeSwitcherBoxClipper(),
                    builder: (context) {
                      return OutlineButton(
                        child: Text('Box Animation'),
                        onPressed: () async {
                          var themeName =
                              ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? 'dark'
                                  : 'light';
                          var service = await ThemeService.instance
                            ..save(themeName);
                          var theme = service.getByName(themeName);
                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    clipper: ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return OutlineButton(
                        child: Text('Circle Animation'),
                        onPressed: () async {
                          var themeName =
                              ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? 'dark'
                                  : 'light';
                          var service = await ThemeService.instance
                            ..save(themeName);
                          var theme = service.getByName(themeName);
                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeProvider.of(context) == pinkTheme,
                        onChanged: (needPink) async {
                          var service = await ThemeService.instance;
                          ThemeData theme;

                          if (needPink) {
                            service.save('pink');
                            theme = service.getByName('pink');
                          } else {
                            var previousThemeName = service.previousThemeName;
                            service.save(previousThemeName);
                            theme = service.getByName(previousThemeName);
                          }
                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeProvider.of(context) == darkBlueTheme,
                        onChanged: (needDarkBlue) async {
                          var service = await ThemeService.instance;
                          ThemeData theme;

                          if (needDarkBlue) {
                            service.save('darkBlue');
                            theme = service.getByName('darkBlue');
                          } else {
                            var previousThemeName = service.previousThemeName;
                            service.save(previousThemeName);
                            theme = service.getByName(previousThemeName);
                          }

                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeProvider.of(context) == halloweenTheme,
                        onChanged: (needHalloween) async {
                          var service = await ThemeService.instance;
                          ThemeData theme;

                          if (needHalloween) {
                            service.save('halloween');
                            theme = service.getByName('halloween');
                          } else {
                            var previousThemeName = service.previousThemeName;
                            service.save(previousThemeName);
                            theme = service.getByName(previousThemeName);
                          }

                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
