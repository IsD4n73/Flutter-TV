import 'dart:async';
import 'package:tmdb_dart/tmdb_dart.dart';

Future main(List<String> arguments) async {
  assert(arguments.length == 1);
  TmdbService service = TmdbService(arguments[0]);

  // auto configure api based on default configuration
  // OR custom configure api using setter 'configuration'
  await service.initConfiguration();

  var pagedResult = await service.movie.search("harry");

  for (var movie in pagedResult.results) {
    print("${movie.title} - ${movie.voteAverage}");
  }

  var pagedTvResult = await service.tv.getAiringToday();

  for (var tv in pagedTvResult.results) {
    print("${tv.name} - ${tv.voteAverage}");
  }

  var popular = await service.movie.getPopular();

  for (var movie in popular.results) {
    print("${movie.title} - ${movie.voteAverage}");
  }

  var discover = await service.movie.discover(
    settings: MovieDiscoverSettings(
      primaryReleaseDateGTE: Date(day: 15, month: 9, year: 2010),
      primaryReleaseDateLTE: Date(day: 22, month: 10, year: 2015),
      voteAverageGTE: 5.5,
      withPeople: [108916, 7467],
      sortBy: SortBy.popularity.desc,
      quality: QualitySettings.Custom(
        backdropQuality: AssetQuality.High,
        logoQuality: AssetQuality.High,
        posterQuality: AssetQuality.High,
        profileQuality: AssetQuality.High,
        stillQuality: AssetQuality.High,
      ),
    ),
  );

  for (var movie in discover.results) {
    print("${movie.title} - ${movie.voteAverage} - ${movie.releaseDate}");
  }

  var movie = await service.movie.getDetails(671,
      appendSettings: AppendSettings(
        includeRecommendations: true,
        includeSimilarContent: true,
      ));

  print("${movie.recommendations[0].title}");
  print("${movie.similar[0].title}");

  var tv = await service.tv.getDetails(1399,
      appendSettings: AppendSettings(
        includeRecommendations: true,
        includeSimilarContent: true,
      ));
  print("${tv.originalName} - ${tv.seasons.length}");
  print("${tv.similar[0].originalName} - ${tv.similar[0].firstAirDate}");

  print("Countries: ${(await service.getAllCountries()).length}");
  print("MovieGenres: ${(await service.getAllTvGenres()).length}");
}

// generate many requests
// number of requests is over the allowed threshold
// but thanks to integrated resilience, all the requests are completed successfully
Future resilienceExample(TmdbService service) async {
  var futures = Iterable.generate(100)
      .map((x) => service.movie.search(x.toString()))
      .toList();
  await Future.wait(futures);
}