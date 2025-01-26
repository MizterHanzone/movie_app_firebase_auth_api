import 'dart:convert';

class DetailModel {
  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final List<dynamic> genres;
  final String homepage;
  final int id;
  final String? imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<dynamic> productionCompanies;
  final List<dynamic> productionCountries;
  final DateTime releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  DetailModel({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"],
      belongsToCollection: json["belongs_to_collection"],
      budget: json["budget"] ?? 0,
      genres: List<dynamic>.from(json["genres"] ?? []),
      homepage: json["homepage"] ?? "",
      id: json["id"],
      imdbId: json["imdb_id"],
      originCountry: List<String>.from(json["origin_country"] ?? []),
      originalLanguage: json["original_language"] ?? "en",
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "No overview available.",
      popularity: json["popularity"]?.toDouble() ?? 0.0,
      posterPath: json["poster_path"],
      productionCompanies: List<dynamic>.from(json["production_companies"] ?? []),
      productionCountries: List<dynamic>.from(json["production_countries"] ?? []),
      releaseDate: json["release_date"] != null
          ? DateTime.parse(json["release_date"])
          : DateTime(2000, 1, 1),
      revenue: json["revenue"] ?? 0,
      runtime: json["runtime"] ?? 0,
      spokenLanguages: (json["spoken_languages"] as List<dynamic>?)
          ?.map((x) => SpokenLanguage.fromJson(x))
          .toList() ??
          [],
      status: json["status"] ?? "Unknown",
      tagline: json["tagline"] ?? "",
      title: json["title"] ?? "Untitled",
      video: json["video"] ?? false,
      voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "belongs_to_collection": belongsToCollection,
    "budget": budget,
    "genres": genres,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "origin_country": originCountry,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": productionCompanies,
    "production_countries": productionCountries,
    "release_date": releaseDate.toIso8601String(),
    "revenue": revenue,
    "runtime": runtime,
    "spoken_languages": spokenLanguages.map((x) => x.toJson()).toList(),
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json["english_name"] ?? "",
      iso6391: json["iso_639_1"] ?? "",
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}
