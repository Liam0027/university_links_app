import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../data/categories_data.dart';
import '../../models/link_item.dart';
import '../../models/link_category.dart';
import '../widgets/quick_link_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<MapEntry<LinkItem, LinkCategory>> get _results {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return [];
    return allLinks.where((entry) {
      return entry.key.title.toLowerCase().contains(q) ||
          entry.key.shortUrl.toLowerCase().contains(q) ||
          entry.key.url.toLowerCase().contains(q) ||
          entry.value.title.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    final hasQuery = _query.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 18, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF28325A).withOpacity(0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              size: 18, color: AppColors.textSub),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              onChanged: (v) => setState(() => _query = v),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'جستجوی سامانه یا سایت...',
                                hintStyle: TextStyle(
                                    fontSize: 13, color: AppColors.textSub),
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          if (hasQuery)
                            InkWell(
                              onTap: () {
                                _controller.clear();
                                setState(() => _query = '');
                              },
                              child: const Icon(Icons.close,
                                  size: 18, color: AppColors.textSub),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: !hasQuery
                  ? const _SearchHint()
                  : results.isEmpty
                      ? const _NoResults()
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                          itemCount: results.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) => QuickLinkTile(
                            item: results[index].key,
                            category: results[index].value,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchHint extends StatelessWidget {
  const _SearchHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search,
                size: 40, color: AppColors.textSub.withOpacity(0.5)),
            const SizedBox(height: 12),
            const Text(
              'نام سامانه یا بخشی از آدرس سایت را وارد کنید',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.textSub),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off,
              size: 40, color: AppColors.textSub.withOpacity(0.5)),
          const SizedBox(height: 12),
          const Text(
            'هیچ نتیجه‌ای پیدا نشد',
            style: TextStyle(fontSize: 13, color: AppColors.textSub),
          ),
        ],
      ),
    );
  }
}
