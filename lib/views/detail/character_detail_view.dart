import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/favorite_controller.dart';
import '../../models/character_model.dart';
import '../../utils/app_theme.dart';

class CharacterDetailView extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailView({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: AppTheme.surface,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.background.withAlpha(180),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              Obx(() {
                final isFav = favoriteController.isFavorite(character.id);
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.background.withAlpha(180),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.redAccent : Colors.white,
                      size: 26,
                    ),
                    onPressed: () => favoriteController.toggleFavorite(character),
                  ),
                );
              }),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTheme.surfaceLight,
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 64, color: AppTheme.textMuted),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha(80),
                            Colors.transparent,
                            AppTheme.background,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          character.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.getStatusColor(character.status).withAlpha(40),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppTheme.getStatusColor(character.status),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                              character.status,
                              style: TextStyle(
                                color: AppTheme.getStatusColor(character.status),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${character.species} • ${character.gender}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Informasi Karakter'),
                  const SizedBox(height: 12),
                  _buildInfoTile(
                    icon: Icons.fingerprint,
                    title: 'Spesies',
                    value: character.species,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoTile(
                    icon: Icons.transgender,
                    title: 'Gender',
                    value: character.gender,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoTile(
                    icon: Icons.public,
                    title: 'Origin (Asal)',
                    value: character.origin,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoTile(
                    icon: Icons.location_on,
                    title: 'Location (Lokasi Terakhir)',
                    value: character.location,
                  ),
                  const SizedBox(height: 28),
                  Obx(() {
                    final isFav = favoriteController.isFavorite(character.id);
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFav ? Colors.redAccent : AppTheme.primary,
                          foregroundColor: isFav ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                        label: Text(
                          isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => favoriteController.toggleFavorite(character),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.textLight,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.surfaceLight.withAlpha(128)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
