import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_items_provider.dart';
import '../widgets/movie_item.dart';

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
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 340,
            child: TextField(
              autofocus: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "search any series you want ...",
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(top: 2),
                prefixIcon: const Icon(Icons.search),
              ),
              controller: textEditingController,
              onSubmitted: (value) {
                setState(() {
                  _startSearching = true;
                });
              },
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 5),
          //   width: MediaQuery.of(context).size.width * 0.75,
          //   child: TextField(
          //     onChanged: (value) => _filterSearchResult(value),
          //     controller: textEditingController,
          //     autofocus: true,
          //     textAlign: TextAlign.left,
          //     style: const TextStyle(color: Colors.black),
          //     textAlignVertical: TextAlignVertical.center,
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.only(top: 4),
          //       prefixIcon: const Icon(
          //         Icons.search,
          //         color: Colors.black26,
          //       ),
          //       hintText: "search country by name .....",
          //       hintStyle: const TextStyle(color: Colors.black38),
          //       fillColor: Colors.grey[100],
          //       filled: true,
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         borderSide: BorderSide.none,
          //       ),
          //     ),
          //   ),
          // ),
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
