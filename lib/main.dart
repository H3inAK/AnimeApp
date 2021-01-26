import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './themes/theme_config.dart';
import './providers/movie_item_provider.dart';
import './providers/movie_items_provider.dart';
import './tests/test_api.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.grey.withOpacity(0.0),
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? lightTheme : darkTheme;
    return ThemeProvider(
      initTheme: initTheme,
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              // will be need later
              ChangeNotifierProvider(
                create: (ctx) => MovieItemProvier(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => MovieItemsProvider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              // will used animated theme switcher later
              // theme: ThemeProvider.of(context),
              theme: ThemeData.dark(),
              home: TestScreen(),
            ),
          );
        },
      ),
    );
  }
}
