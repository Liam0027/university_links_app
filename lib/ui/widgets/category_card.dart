import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../models/link_category.dart';
import '../pages/category_links_page.dart';

class CategoryCard extends StatelessWidget {
  final LinkCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    final cardBg = isDark
        ? Color.alphaBlend(
            category.color.withOpacity(0.12),
            AppColors.cardBgDark,
          )
        : category.bgColor;

    final iconBg = isDark
        ? category.color.withOpacity(0.18)
        : Colors.white.withOpacity(0.55);

    // Decorative circle color — subtle in both modes
    final circleColor = isDark
        ? category.color.withOpacity(0.08)
        : Colors.white.withOpacity(0.3);

    return Material(
      color: cardBg,
      borderRadius: BorderRadius.circular(18),
      elevation: context.isDark ? 0 : 2,
      shadowColor: const Color(0xFF28325A).withOpacity(0.15),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryLinksPage(category: category),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // Decorative circle
              Positioned(
                bottom: -40,
                left: -30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: circleColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        category.icon,
                        color: category.color,
                        size: 22,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.title,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: context.textPrimary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${category.links.length} لینک',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: category.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
