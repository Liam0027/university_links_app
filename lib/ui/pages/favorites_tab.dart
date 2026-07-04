import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../services/favorites_store.dart';
import '../widgets/quick_link_tile.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
          child: Row(
            children: [
              Text(
                'علاقه‌مندی‌ها',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<Set<String>>(
            valueListenable: FavoritesStore.instance.favoriteUrls,
            builder: (context, _, __) {
              final items = FavoritesStore.instance.favoriteItems;
              if (items.isEmpty) return const _EmptyFavorites();
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => QuickLinkTile(
                  item: items[index].key,
                  category: items[index].value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_border,
                size: 44, color: context.textSecondary.withOpacity(0.5)),
            const SizedBox(height: 12),
            Text(
              'هنوز لینکی به علاقه‌مندی‌ها اضافه نکرده‌اید',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: context.textSecondary),
            ),
            const SizedBox(height: 6),
            Text(
              'با لمس آیکون ستاره کنار هر لینک، آن را اینجا ذخیره کنید',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5,
                color: context.textSecondary.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
