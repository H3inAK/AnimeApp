class Attributes {
  final String canonicalTitle;
  final String description;
  final String averageRating;
  final String ageRatingGuide;
  final String posterImage;
  final String coverImage;
  final int episodeLength;
  final String status;
  final int userCount;
  final int favoritesCount;
  final String startDate;
  final String endDate;
  final String youtubeVideoId;

  Attributes({
    this.canonicalTitle,
    this.description,
    this.averageRating,
    this.ageRatingGuide,
    this.posterImage,
    this.coverImage,
    this.episodeLength,
    this.status,
    this.userCount,
    this.favoritesCount,
    this.startDate,
    this.endDate,
    this.youtubeVideoId,
  });
}

class MovieItem {
  final String id;
  final String type;
  final Attributes attributes;

  MovieItem({
    this.id,
    this.type,
    this.attributes,
  });

  MovieItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        attributes = Attributes(
          canonicalTitle: json['attributes']['canonicalTitle'],
          description: json['attributes']['description'],
          averageRating: json['attributes']['averageRating'],
          ageRatingGuide: json['attributes']['ageRatingGuide'],
          posterImage: json['attributes']['posterImage']['small'],
          coverImage: json['attributes']['coverImage'] != null
              ? json['attributes']['coverImage']['small']
              : "",
          episodeLength: json['attributes']['episodeLength'],
          status: json['attributes']['status'],
          userCount: json['attributes']['userCount'],
          favoritesCount: json['attributes']['favoritesCount'],
          startDate: json['attributes']['startDate'],
          endDate: json['attributes']['endDate'],
          youtubeVideoId: json['attributes']['youtubeVideoId'],
        );
}
