class PopularSerieModel {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  PopularSerieModel(
      {this.page, this.results, this.totalPages, this.totalResults});

  PopularSerieModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Results {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  Results(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteAverage,
      this.voteCount});

  Results.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    firstAirDate = json['first_air_date'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    name = json['name'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['backdrop_path'] = backdropPath;
    data['first_air_date'] = firstAirDate;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['name'] = name;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
