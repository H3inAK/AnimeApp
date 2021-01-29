import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_items_provider.dart';
import '../screens/movie_details.dart';

class MovieItemWidget extends StatelessWidget {
  final String movieId;

  MovieItemWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    final displayedMovieItem =
        Provider.of<MovieItemsProvider>(context, listen: false)
            .findById(movieId);

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: GridTile(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MovieDetailsScreen(displayedMovieItem.id),
                ),
              ),
              child: Container(
                width: double.infinity,
                child: Hero(
                  tag: displayedMovieItem.id,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/loading.jpeg'),
                    image:
                        NetworkImage(displayedMovieItem.attributes.posterImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        footer: GridTileBar(
          backgroundColor:
              Theme.of(context).bottomAppBarColor.withOpacity(0.87),
          title: Text(
            displayedMovieItem.attributes.canonicalTitle,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 14,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
