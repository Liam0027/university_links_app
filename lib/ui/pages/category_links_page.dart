import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../models/link_category.dart';
import '../widgets/quick_link_tile.dart';

class CategoryLinksPage extends StatelessWidget {
  final LinkCategory category;

  const CategoryLinksPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.textMain),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: category.bgColor,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    alignment: Alignment.center,
                    child: Icon(category.icon,
                        color: category.color, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: category.links.isEmpty
                  ? const Center(
                      child: Text('هیچ لینکی در این دسته وجود ندارد.'))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                      itemCount: category.links.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) => QuickLinkTile(
                        item: category.links[index],
                        category: category,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
