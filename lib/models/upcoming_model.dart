import 'dart:convert';

class UpComingModel {
  final Dates dates;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  UpComingModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  UpComingModel copyWith({
    Dates? dates,
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      UpComingModel(
        dates: dates ?? this.dates,
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory UpComingModel.fromRawJson(String str) =>
      UpComingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpComingModel.fromJson(Map<String, dynamic> json) => UpComingModel(
    dates: Dates.fromJson(json["dates"]),
    page: json["page"] ?? 0,
    results: List<Result>.from(
        json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"] ?? 0,
    totalResults: json["total_results"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "dates": dates.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  Dates copyWith({
    DateTime? maximum,
    DateTime? minimum,
  }) =>
      Dates(
        maximum: maximum ?? this.maximum,
        minimum: minimum ?? this.minimum,
      );

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum":
    "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    "minimum":
    "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };
}

class Result {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Result copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) =>
      Result(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"] ?? "",
    genreIds: List<int>.from(json["genre_ids"].map((x) => x ?? 0)),
    id: json["id"] ?? 0,
    originalLanguage: json["original_language"] ?? "",
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    popularity: json["popularity"]?.toDouble() ?? 0.0,
    posterPath: json["poster_path"] ?? "",
    releaseDate: DateTime.parse(json["release_date"] ?? "2000-01-01"),
    title: json["title"] ?? "",
    video: json["video"] ?? false,
    voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date":
    "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
