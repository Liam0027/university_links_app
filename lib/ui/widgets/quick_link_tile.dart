import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/link_utils.dart';
import '../../models/link_item.dart';
import '../../models/link_category.dart';
import '../../services/favorites_store.dart';
import 'logo_avatar.dart';

class QuickLinkTile extends StatelessWidget {
  final LinkItem item;
  final LinkCategory category;
  final bool showFavoriteButton;

  const QuickLinkTile({
    super.key,
    required this.item,
    required this.category,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => openLink(context, item.url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF28325A).withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              LogoAvatar(item: item, category: category),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.shortUrl,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSub,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              if (showFavoriteButton)
                ValueListenableBuilder<Set<String>>(
                  valueListenable: FavoritesStore.instance.favoriteUrls,
                  builder: (context, favorites, _) {
                    final isFav = favorites.contains(item.url);
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => FavoritesStore.instance.toggle(item),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          isFav ? Icons.star : Icons.star_border,
                          size: 18,
                          color: isFav
                              ? const Color(0xFFFFB23F)
                              : AppColors.textSub,
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(width: 4),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.north_east,
                  size: 14,
                  color: AppColors.textSub,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
