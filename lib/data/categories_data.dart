import 'package:flutter/material.dart';
import '../models/link_item.dart';
import '../models/link_category.dart';

final List<LinkCategory> categories = [
  LinkCategory(
    title: 'سامانه‌های آموزشی',
    icon: Icons.school_outlined,
    color: const Color(0xFF6C7BFF),
    bgColor: const Color(0xFFECEEFF),
    links: const [
      LinkItem(
        title: 'سامانه بوستان',
        url: 'https://bustan.tvu.ac.ir',
        shortUrl: 'bustan.tvu.ac.ir',
      ),
      LinkItem(
        title: 'سامانه سمیاد (کلاس مجازی)',
        url: 'https://samyad.tvu.ac.ir',
        shortUrl: 'samyad.tvu.ac.ir',
      ),
      LinkItem(
        title: 'آموزش‌های آزاد خاص دانشگاه (استان گیلان)',
        url: 'https://guilan.tvu.ac.ir/Aedu/',
        shortUrl: 'guilan.tvu.ac.ir/Aedu',
      ),
    ],
  ),
  LinkCategory(
    title: 'تغذیه و خوابگاه',
    icon: Icons.restaurant_outlined,
    color: const Color(0xFFFF9F5A),
    bgColor: const Color(0xFFFFF1E4),
    links: const [
      LinkItem(
        title: 'سامانه صبا (رزرو غذا)',
        url: 'https://saba.tvu.ac.ir',
        shortUrl: 'saba.tvu.ac.ir',
      ),
      LinkItem(
        title: 'سامانه سماد',
        url: 'https://samad.app',
        shortUrl: 'samad.app',
      ),
    ],
  ),
  LinkCategory(
    title: 'امور دانشجویی',
    icon: Icons.badge_outlined,
    color: const Color(0xFF2BC4A8),
    bgColor: const Color(0xFFE3F8F4),
    links: const [
      LinkItem(
        title: 'سامانه سجاد',
        url: 'https://portal.saorg.ir/',
        shortUrl: 'portal.saorg.ir',
      ),
    ],
  ),
  LinkCategory(
    title: 'دانشکده و دانشگاه',
    icon: Icons.account_balance_outlined,
    color: const Color(0xFFB07CFF),
    bgColor: const Color(0xFFF3E9FF),
    links: const [
      LinkItem(
        title: 'دانشگاه ملی مهارت (سایت اصلی)',
        url: 'https://tvu.ac.ir',
        shortUrl: 'tvu.ac.ir',
      ),
      LinkItem(
        title: 'دانشگاه ملی مهارت واحد استان گیلان',
        url: 'https://guilan.tvu.ac.ir',
        shortUrl: 'guilan.tvu.ac.ir',
      ),
      LinkItem(
        title: 'دانشکده پسران رشت (شهید چمران)',
        url: 'https://p-rasht.tvu.ac.ir',
        shortUrl: 'p-rasht.tvu.ac.ir',
      ),
      LinkItem(
        title: 'آموزشکده پسران رستم‌آباد (سیدالشهدا)',
        url: 'https://p-roodbar.tvu.ac.ir',
        shortUrl: 'p-roodbar.tvu.ac.ir',
      ),
      LinkItem(
        title: 'دانشکده صومعه‌سرا (میرزا کوچک)',
        url: 'https://somesara.tvu.ac.ir',
        shortUrl: 'somesara.tvu.ac.ir',
      ),
      LinkItem(
        title: 'آموزشکده پسران انزلی (شهید خدادادی)',
        url: 'https://p-anzali.tvu.ac.ir',
        shortUrl: 'p-anzali.tvu.ac.ir',
      ),
      LinkItem(
        title: 'آموزشکده دختران رشت (دکتر معین)',
        url: 'https://d-rasht.tvu.ac.ir',
        shortUrl: 'd-rasht.tvu.ac.ir',
      ),
      LinkItem(
        title: 'آموزشکده پسران لاهیجان (شهید رجایی)',
        url: 'https://p-lahijan.tvu.ac.ir',
        shortUrl: 'p-lahijan.tvu.ac.ir',
      ),
      LinkItem(
        title: 'آموزشکده پسران آستانه اشرفیه (امام صادق ع)',
        url: 'https://p-astaneashrafiye.tvu.ac.ir',
        shortUrl: 'p-astaneashrafiye.tvu.ac.ir',
      ),
    ],
  ),
];

final List<LinkItem> quickLinks = [
  categories[0].links[0], // بوستان
  categories[0].links[1], // سمیاد
  categories[1].links[0], // صبا
  categories[3].links[2], // دانشکده شهید چمران رشت
];

LinkCategory categoryOf(LinkItem item) {
  return categories.firstWhere((c) => c.links.contains(item));
}

List<MapEntry<LinkItem, LinkCategory>> get allLinks {
  return categories
      .expand((cat) => cat.links.map((link) => MapEntry(link, cat)))
      .toList();
}
