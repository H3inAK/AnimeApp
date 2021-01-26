import 'package:flutter/material.dart';
import 'package:movieapp/providers/movie_items_provider.dart';
import 'package:movieapp/widgets/movie_item.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var initOffset = 0;

  @override
  Widget build(BuildContext context) {
    print("build()");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            setState(() {
              initOffset -= 10;
            });
          },
        ),
        title: Text("Anime Series"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              setState(() {
                initOffset += 10;
              });
            },
          ),
        ],
      ),
      // body: Center(
      //   child: OutlineButton(
      //     onPressed: () {
      //       Provider.of<MovieItemsProvider>(context, listen: false)
      //           .fetchAndSetMovieItems("anime");
      //     },
      //     child: Text("test api"),
      //   ),
      // ),
      body: FutureBuilder(
        future: Provider.of<MovieItemsProvider>(context, listen: false)
            .fetchAndSetMovieItems("anime", initOffset),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapShot.error == null) {
            print("ui rendered");
            return Consumer<MovieItemsProvider>(
              builder: (ctx, movieItemsData, _) {
                return GridView.builder(
                  padding: EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5 / 3.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: movieItemsData.movieItems.length,
                  itemBuilder: (ctx, i) {
                    return MovieItemWidget(movieItemsData.movieItems[i].id);
                  },
                );
              },
            );
          } else {
            return Center(child: Text(dataSnapShot.error.toString()));
          }
        },
      ),
    );
  }
}
