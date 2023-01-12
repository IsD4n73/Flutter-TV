// ignore_for_file: non_constant_identifier_names

class SeasonModel {
  int number_of_seasons;
  int number_of_episodes;
  bool in_production;
  List<dynamic> seasons;

  SeasonModel(this.number_of_episodes, this.number_of_seasons, this.seasons,
      this.in_production);

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(json["number_of_episodes"], json["number_of_seasons"],
        json["seasons"], json["in_production"]);
  }
}
