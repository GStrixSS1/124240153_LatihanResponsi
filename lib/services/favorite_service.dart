import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_model.dart';

class FavoriteService {
  static const String prefFavoritesKey = 'rick_morty_favorite_characters';

  static Future<List<CharacterModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(prefFavoritesKey) ?? [];
    return rawList.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return CharacterModel.fromJson(map);
    }).toList();
  }

  static Future<void> addFavorite(CharacterModel character) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getFavorites();
    if (!list.any((c) => c.id == character.id)) {
      list.add(character);
      final rawList = list.map((c) => jsonEncode(c.toJson())).toList();
      await prefs.setStringList(prefFavoritesKey, rawList);
    }
  }

  static Future<void> removeFavorite(int characterId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getFavorites();
    list.removeWhere((c) => c.id == characterId);
    final rawList = list.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(prefFavoritesKey, rawList);
  }

  static Future<bool> isFavorite(int characterId) async {
    final list = await getFavorites();
    return list.any((c) => c.id == characterId);
  }
}
