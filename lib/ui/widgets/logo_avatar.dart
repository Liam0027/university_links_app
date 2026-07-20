import 'package:flutter/material.dart';
import '../../models/link_item.dart';
import '../../models/link_category.dart';

class LogoAvatar extends StatelessWidget {
  final LinkItem item;
  final LinkCategory category;

  const LogoAvatar({super.key, required this.item, required this.category});

  @override
  Widget build(BuildContext context) {
    final hasLogo = item.localLogo != null;

    final letterFallback = Text(
      item.title.characters.first,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 15,
        color: category.color,
      ),
    );

    // All logos are bundled assets — no network request is ever made here.
    final logoChild = hasLogo
        ? Image.asset(
            item.localLogo!,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => letterFallback,
          )
        : letterFallback;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        // A real logo sits on plain white: category colors are tinted,
        // and semi-transparent edge pixels in the PNGs pick up that tint
        // and show up as a faint colored halo. The letter fallback still
        // uses the category color so links stay visually grouped.
        color: hasLogo ? Colors.white : category.bgColor,
        borderRadius: BorderRadius.circular(13),
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: logoChild,
      ),
    );
  }
}
