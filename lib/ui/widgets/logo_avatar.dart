import 'package:flutter/material.dart';
import '../../models/link_item.dart';
import '../../models/link_category.dart';

class LogoAvatar extends StatelessWidget {
  final LinkItem item;
  final LinkCategory category;

  const LogoAvatar({super.key, required this.item, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: category.bgColor,
        borderRadius: BorderRadius.circular(13),
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Image.network(
          item.effectiveLogoUrl,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Text(
            item.title.characters.first,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: category.color,
            ),
          ),
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;
            return Text(
              item.title.characters.first,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: category.color,
              ),
            );
          },
        ),
      ),
    );
  }
}
