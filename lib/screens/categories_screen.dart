import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_items_provider.dart';
import '../widgets/movie_item.dart';

class CategoySeries extends StatefulWidget {
  final String seriesType;
  final String categoryName;

  CategoySeries(this.seriesType, this.categoryName);

  @override
  _CategoySeriesState createState() => _CategoySeriesState();
}

class _CategoySeriesState extends State<CategoySeries> {
  var initOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.seriesType} ${widget.categoryName} Series"),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: Provider.of<MovieItemsProvider>(context, listen: false)
                .fetchAndSetByCategories(
              widget.seriesType.toLowerCase(),
              widget.categoryName.toLowerCase(),
              initOffset,
            ),
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
    );
  }
}
