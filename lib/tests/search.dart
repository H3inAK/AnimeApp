import 'package:flutter/material.dart';
import 'package:movieapp/providers/movie_items_provider.dart';
import 'package:movieapp/widgets/movie_item.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  var _startSearching = false;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            width: 340,
            child: TextField(
              decoration: InputDecoration(
                hintText: "search any series you want ...",
                border: InputBorder.none,
              ),
              controller: textEditingController,
              onSubmitted: (value) {
                setState(() {
                  _startSearching = true;
                });
              },
            ),
          ),
        ],
      ),
      body: _startSearching
          ? FutureBuilder(
              future: Provider.of<MovieItemsProvider>(context, listen: false)
                  .searchAndSetSeries(textEditingController.text),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (dataSnapshot.error == null) {
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
                          return MovieItemWidget(
                              movieItemsData.movieItems[i].id);
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text(dataSnapshot.error.toString()));
                }
              },
            )
          : Container(),
    );
  }
}
