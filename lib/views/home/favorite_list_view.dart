import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/favorite_controller.dart';
import '../../models/character_model.dart';
import '../../utils/app_theme.dart';
import '../detail/character_detail_view.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (favoriteController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primary),
            );
          }

          if (favoriteController.favorites.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withAlpha(40),
                            blurRadius: 24,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Daftar favorite masih kosong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Jelajahi karakter di tab Characters dan ketuk ikon hati untuk menambahkannya ke daftar favorit Anda.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Favorit: ${favoriteController.favorites.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Geser kartu untuk menghapus',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: favoriteController.favorites.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final character = favoriteController.favorites[index];
                    return _buildDismissibleCard(context, character, favoriteController);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDismissibleCard(
    BuildContext context,
    CharacterModel character,
    FavoriteController favoriteController,
  ) {
    return Dismissible(
      key: Key('fav_${character.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Hapus',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.delete_outline, color: Colors.white, size: 28),
          ],
        ),
      ),
      onDismissed: (direction) {
        favoriteController.removeFavoriteOnSwipe(character);
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Get.to(() => CharacterDetailView(character: character)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    character.image,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 64,
                      height: 64,
                      color: AppTheme.surfaceLight,
                      child: const Icon(Icons.person, color: AppTheme.textMuted),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.getStatusColor(character.status),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${character.status} - ${character.species}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Asal: ${character.origin}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
