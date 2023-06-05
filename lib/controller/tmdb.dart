import 'package:flutter_tv/commons/vars.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class MoviePopular {
  static List<MovieBase> movieResult = [];
  static List<TvBase> serieResult = [];
}

Future tmdbFilm() async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  var pageMovieResult = await service.movie
      .getPopular(page: 1, settings: const MovieSearchSettings(language: "it"));
  MoviePopular.movieResult = pageMovieResult.results;
}

Future tmdbSerie() async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  var pagedTvResult = await service.tv
      .getTopRated(page: 1, settings: const TvSearchSettings(language: "it"));

  MoviePopular.serieResult = pagedTvResult.results;
}

Future tmdbSeriePage(int pagina) async {
  await Future.delayed(const Duration(seconds: 2));
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  var pagedTvResult = await service.tv.getTopRated(
      page: pagina, settings: const TvSearchSettings(language: "it"));

  MoviePopular.serieResult = pagedTvResult.results;
}

Future tmdbFilmPage(int pagina) async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  var pageMovieResult = await service.movie.getPopular(
      page: pagina, settings: const MovieSearchSettings(language: "it"));

  MoviePopular.movieResult = pageMovieResult.results;
}

Future cercaFilmVal(String film) async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  var pageMovieResult = await service.movie.search(film);

  MoviePopular.movieResult = pageMovieResult.results;
}

Future cercaSerieVal(String serie) async {
  TmdbService service = TmdbService(apiKey);
  await service.initConfiguration();

  var pageMovieResult = await service.tv.search(serie);

  MoviePopular.serieResult = pageMovieResult.results;
}
