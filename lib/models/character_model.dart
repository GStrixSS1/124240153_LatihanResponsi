class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String origin;
  final String location;
  final String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? 'unknown',
      species: json['species'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      origin: json['origin'] is Map
          ? (json['origin']['name'] ?? 'Unknown')
          : (json['origin']?.toString() ?? 'Unknown'),
      location: json['location'] is Map
          ? (json['location']['name'] ?? 'Unknown')
          : (json['location']?.toString() ?? 'Unknown'),
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
    };
  }
}

