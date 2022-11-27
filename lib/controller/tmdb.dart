import 'package:tmdb_dart/tmdb_dart.dart';

Future tmdb() async {
  TmdbService service = TmdbService("7e438eba5e1c995839ac0bacf9f33f23");
  await service.initConfiguration();

  //var pagedTvResult = await service.tv.getAiringToday();
  var pageMovieResult = await service.movie.getPopular(page: 1, settings: const MovieSearchSettings(language: "it"));

  for (var film in pageMovieResult.results) {
    print(film.title);
    print(film.posterPath);

    
  }
}
