import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'خانه'),
    (icon: Icons.grid_view_outlined, activeIcon: Icons.grid_view, label: 'دسته‌ها'),
    (icon: Icons.star_border, activeIcon: Icons.star, label: 'علاقه‌مندی'),
    (icon: Icons.settings_outlined, activeIcon: Icons.settings, label: 'تنظیمات'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28325A).withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isActive = index == currentIndex;
          return InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isActive ? item.activeIcon : item.icon,
                    size: 20,
                    color: isActive ? AppColors.primary : AppColors.textSub,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppColors.primary : AppColors.textSub,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isActive)
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
