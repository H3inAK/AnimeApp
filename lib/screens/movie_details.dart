import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/movie_items_provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String movieId;

  MovieDetailsScreen(this.movieId);

  @override
  Widget build(BuildContext context) {
    var displayedMovieDetail =
        Provider.of<MovieItemsProvider>(context).findById(movieId);
    print(displayedMovieDetail.id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 6,
        ),
        children: [
          Text(
            displayedMovieDetail.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(
            children: [
              displayedMovieDetail.endDate != null
                  ? Text(
                      "Realsed on " +
                          DateFormat("dd/MM/yy").format(
                            DateTime.parse(displayedMovieDetail.endDate),
                          ),
                    )
                  : Text("No Release"),
              Spacer(),
              Chip(
                backgroundColor: Colors.amber.withOpacity(0.94),
                label: Text(displayedMovieDetail.status),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 200,
            child: displayedMovieDetail.coverImage.isNotEmpty
                ? Hero(
                    tag: displayedMovieDetail.id,
                    child: Image.network(
                      displayedMovieDetail.coverImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text("cover image couldn't be loaded!"),
                      ),
                    ),
                  )
                : Text("No Cover Photo"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBar.builder(
                initialRating: displayedMovieDetail.averageRating != null
                    ? (double.parse(displayedMovieDetail.averageRating) / 10) /
                        2
                    : 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1),
                itemBuilder: (ctx, i) {
                  return Container(
                    height: 20,
                    width: 16,
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                  );
                },
                onRatingUpdate: null,
              ),
              Chip(
                backgroundColor: Colors.amber.withOpacity(0.9),
                label: Row(
                  children: [
                    Icon(Icons.favorite),
                    Text(displayedMovieDetail.favouriateCount.toString()),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          Text(displayedMovieDetail.description),
          SizedBox(height: 20),
          Text(
            "Age rating Guide     : " +
                displayedMovieDetail.ageRatingGuide.toString(),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.amber,
                  fontSize: 16,
                ),
          ),
          Text(
            "Total episodes : " + displayedMovieDetail.episodeLenght.toString(),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.amber,
                  fontSize: 16,
                ),
          ),
          SizedBox(height: 30),
          RaisedButton.icon(
            onPressed: () async {
              final url =
                  "https://www.youtube.com/watch?v=${displayedMovieDetail.youtubeId}";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            color: Colors.red,
            icon: Icon(Icons.play_arrow),
            label: Text("START WATCHING"),
          ),
        ],
      ),
    );
  }
}
