import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../models/episode_model.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  static Future<List<CharacterModel>> getCharacters({
    String? status,
    String? name,
  }) async {
    final queryParams = <String, String>{};
    if (status != null && status.isNotEmpty && status.toLowerCase() != 'all') {
      queryParams['status'] = status.toLowerCase();
    }
    if (name != null && name.trim().isNotEmpty) {
      queryParams['name'] = name.trim();
    }

    final uri = Uri.parse('$baseUrl/character').replace(
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'] ?? [];
      return results.map((item) => CharacterModel.fromJson(item)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Gagal memuat data karakter (${response.statusCode})');
    }
  }

  static Future<CharacterModel> getCharacterDetail(int id) async {
    final uri = Uri.parse('$baseUrl/character/$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CharacterModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat detail karakter (${response.statusCode})');
    }
  }

  static Future<List<EpisodeModel>> getEpisodes() async {
    final uri = Uri.parse('$baseUrl/episode');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'] ?? [];
      return results.map((item) => EpisodeModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data episode (${response.statusCode})');
    }
  }
}
