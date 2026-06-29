import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String trailing;
  final VoidCallback? onTrailingTap;

  const SectionTitle({
    super.key,
    required this.title,
    required this.trailing,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: onTrailingTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              trailing,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
