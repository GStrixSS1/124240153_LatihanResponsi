import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/character_model.dart';
import '../services/favorite_service.dart';

class FavoriteController extends GetxController {
  final RxList<CharacterModel> favorites = <CharacterModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    isLoading.value = true;
    try {
      final list = await FavoriteService.getFavorites();
      favorites.assignAll(list);
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavorite(int characterId) {
    return favorites.any((c) => c.id == characterId);
  }

  Future<void> toggleFavorite(CharacterModel character) async {
    final alreadyFav = isFavorite(character.id);

    if (alreadyFav) {
      await FavoriteService.removeFavorite(character.id);
      favorites.removeWhere((c) => c.id == character.id);

      Get.closeAllSnackbars();
      Get.snackbar(
        'Favorit Dihapus',
        '${character.name} dihapus dari daftar favorit.',
        backgroundColor: Colors.redAccent.withAlpha(230),
        colorText: Colors.white,
        icon: const Icon(Icons.favorite_border, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } else {
      await FavoriteService.addFavorite(character);
      favorites.add(character);

      Get.closeAllSnackbars();
      Get.snackbar(
        'Favorit Ditambahkan',
        '${character.name} berhasil ditambahkan ke favorit!',
        backgroundColor: const Color(0xFF00E599),
        colorText: Colors.black,
        icon: const Icon(Icons.favorite, color: Colors.redAccent),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  Future<void> removeFavoriteOnSwipe(CharacterModel character) async {
    await FavoriteService.removeFavorite(character.id);
    favorites.removeWhere((c) => c.id == character.id);

    Get.closeAllSnackbars();
    Get.snackbar(
      'Favorit Dihapus',
      '${character.name} berhasil dihapus dari daftar favorit.',
      backgroundColor: Colors.redAccent.withAlpha(230),
      colorText: Colors.white,
      icon: const Icon(Icons.delete_sweep, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
