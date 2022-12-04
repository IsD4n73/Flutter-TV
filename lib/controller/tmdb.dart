import 'package:flutter_tv/commons/vars.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class MoviePopular {
  static List<MovieBase> movieResult = [];
  static List<TvBase> serieResult = [];
}

Future tmdbFilm() async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  //var pagedTvResult = await service.tv.getAiringToday();
  var pageMovieResult = await service.movie
      .getPopular(page: 1, settings: const MovieSearchSettings(language: "it"));
  MoviePopular.movieResult = pageMovieResult.results;

  // for (var film in pageMovieResult.results) {
  //   print(film.title);
  //   print(film.posterPath);
  // }
}

Future tmdbSerie() async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  var pagedTvResult = await service.tv.getAiringToday(
      page: 1, settings: const TvSearchSettings(language: "it"));

  MoviePopular.serieResult = pagedTvResult.results;

}

Future tmdbSeriePag(int pagina) async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  var pagedTvResult = await service.tv.getAiringToday(
      page: pagina, settings: const TvSearchSettings(language: "it"));

  MoviePopular.serieResult.addAll(pagedTvResult.results);

  // for (var film in pagedTvResult.results) {
  //   print(film.name);
  //   print(film.posterPath);
  //   film.id;
  // }
}

Future tmdbFilmPage(int pagina) async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  //var pagedTvResult = await service.tv.getAiringToday();
  var pageMovieResult = await service.movie
      .getPopular(page: pagina, settings: const MovieSearchSettings(language: "it"));
  MoviePopular.movieResult.addAll(pageMovieResult.results);

  // for (var film in pageMovieResult.results) {
  //   print(film.title);
  //   print(film.posterPath);
  // }
}
