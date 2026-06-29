import 'package:flutter/material.dart';
import '../../data/categories_data.dart';
import '../../models/link_item.dart';
import '../widgets/header.dart';
import '../widgets/section_title.dart';
import '../widgets/category_card.dart';
import '../widgets/quick_link_tile.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onShowAllCategories;

  const HomeTab({super.key, required this.onShowAllCategories});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: HomeHeader()),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(18, 60, 18, 30),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              SectionTitle(
                title: 'دسته‌بندی‌ها',
                trailing: 'مشاهده همه',
                onTrailingTap: onShowAllCategories,
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.15,
                ),
                itemBuilder: (context, index) =>
                    CategoryCard(category: categories[index]),
              ),
              const SizedBox(height: 30),
              SectionTitle(
                title: 'دسترسی سریع',
                trailing: '${quickLinks.length} مورد',
              ),
              const SizedBox(height: 14),
              ...quickLinks.map(
                (LinkItem link) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: QuickLinkTile(
                    item: link,
                    category: categoryOf(link),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
