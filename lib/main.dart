import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './themes/theme_service.dart';
import './providers/movie_item_provider.dart';
import './providers/movie_items_provider.dart';
import './screens/home_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.grey.withOpacity(0.0),
      // statusBarBrightness: Brightness.light,
    ),
  );
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
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              // this provider will be need later
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
              theme: ThemeProvider.of(context),
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
