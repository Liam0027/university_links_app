import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/categories_data.dart';
import '../models/link_item.dart';
import '../models/link_category.dart';

class FavoritesStore {
  FavoritesStore._();
  static final FavoritesStore instance = FavoritesStore._();

  static const _prefsKey = 'favorite_urls';

  final ValueNotifier<Set<String>> favoriteUrls =
      ValueNotifier<Set<String>>({});

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefsKey) ?? [];
    favoriteUrls.value = saved.toSet();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, favoriteUrls.value.toList());
  }

  bool isFavorite(LinkItem item) => favoriteUrls.value.contains(item.url);

  void toggle(LinkItem item) {
    final updated = Set<String>.from(favoriteUrls.value);
    if (updated.contains(item.url)) {
      updated.remove(item.url);
    } else {
      updated.add(item.url);
    }
    favoriteUrls.value = updated;
    _persist();
  }

  List<MapEntry<LinkItem, LinkCategory>> get favoriteItems {
    return allLinks
        .where((entry) => favoriteUrls.value.contains(entry.key.url))
        .toList();
  }
}
