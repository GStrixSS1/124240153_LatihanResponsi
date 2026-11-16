class EpisodeModel {
  final int id;
  final String name;
  final String airDate;
  final String episode;

  EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      airDate: json['air_date'] ?? '',
      episode: json['episode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'air_date': airDate,
      'episode': episode,
    };
  }
}

