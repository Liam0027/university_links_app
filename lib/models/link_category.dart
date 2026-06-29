import 'package:flutter/material.dart';
import 'link_item.dart';

class LinkCategory {
  final String title;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final List<LinkItem> links;

  const LinkCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.links,
  });
}
