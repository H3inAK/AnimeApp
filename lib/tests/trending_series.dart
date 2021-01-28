import 'package:flutter/material.dart';
import 'package:movieapp/providers/movie_items_provider.dart';
import 'package:movieapp/widgets/movie_item.dart';
import 'package:provider/provider.dart';

class TrendingSeries extends StatefulWidget {
  final String seriesType;

  TrendingSeries(this.seriesType);

  @override
  _TrendingSeriesState createState() => _TrendingSeriesState();
}

class _TrendingSeriesState extends State<TrendingSeries> {
  var initOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending ${widget.seriesType} Series"),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: Provider.of<MovieItemsProvider>(context, listen: false)
                .fetchAndSetTrendingSeries(
                    widget.seriesType.toLowerCase(), initOffset),
            builder: (ctx, dataSnapShot) {
              if (dataSnapShot.connectionState == ConnectionState.waiting) {
                // print(MediaQuery.of(context).size.width);
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapShot.error == null) {
                print("ui rendered");
                return Consumer<MovieItemsProvider>(
                  builder: (ctx, movieItemsData, _) {
                    return GridView.builder(
                      padding: EdgeInsets.only(
                        top: 12,
                        left: 12,
                        right: 12,
                        bottom: 80,
                      ),
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
          Positioned(
            height: 50,
            bottom: 10,
            left: 100,
            right: 100,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        if (initOffset != 0) {
                          initOffset -= 10;
                        } else {
                          return;
                        }
                      });
                    },
                  ),
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
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: OutlineButton(
      //     onPressed: () {
      //       Provider.of<MovieItemsProvider>(context, listen: false)
      //           .fetchAndSetMovieItems("anime",);
      //     },
      //     child: Text("test api"),
      //   ),
      // ),
    );
  }
}
