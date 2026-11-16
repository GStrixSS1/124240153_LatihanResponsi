import 'package:flutter_test/flutter_test.dart';
import 'package:latihan_responsi/models/character_model.dart';
import 'package:latihan_responsi/models/episode_model.dart';
import 'package:latihan_responsi/models/user_model.dart';

void main() {
  group('Model Serialization Tests', () {
    test('CharacterModel parses JSON and converts to JSON correctly', () {
      final json = {
        'id': 1,
        'name': 'Rick Sanchez',
        'status': 'Alive',
        'species': 'Human',
        'gender': 'Male',
        'origin': {'name': 'Earth (C-137)'},
        'location': {'name': 'Citadel of Ricks'},
        'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      };

      final character = CharacterModel.fromJson(json);

      expect(character.id, 1);
      expect(character.name, 'Rick Sanchez');
      expect(character.status, 'Alive');
      expect(character.origin, 'Earth (C-137)');
      expect(character.location, 'Citadel of Ricks');

      final map = character.toJson();
      expect(map['name'], 'Rick Sanchez');
      expect(map['origin'], 'Earth (C-137)');
    });

    test('EpisodeModel parses JSON correctly', () {
      final json = {
        'id': 1,
        'name': 'Pilot',
        'air_date': 'December 2, 2013',
        'episode': 'S01E01',
      };

      final episode = EpisodeModel.fromJson(json);

      expect(episode.id, 1);
      expect(episode.name, 'Pilot');
      expect(episode.airDate, 'December 2, 2013');
      expect(episode.episode, 'S01E01');
    });

    test('UserModel instantiates with required attributes', () {
      final user = UserModel(
        username: 'rick_c137',
        password: 'password123',
        fullName: 'Rick Sanchez',
      );

      expect(user.username, 'rick_c137');
      expect(user.password, 'password123');
      expect(user.fullName, 'Rick Sanchez');
    });
  });
}

