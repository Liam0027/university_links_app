import 'package:flutter/material.dart';
import '../../data/categories_data.dart';
import '../widgets/category_list_tile.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(18, 18, 18, 8),
          child: Row(
            children: [
              Text(
                'همه دسته‌بندی‌ها',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) =>
                CategoryListTile(category: categories[index]),
          ),
        ),
      ],
    );
  }
}
