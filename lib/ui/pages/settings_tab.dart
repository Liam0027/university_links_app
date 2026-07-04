import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../services/settings_store.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
          child: Row(
            children: [
              Text(
                'تنظیمات',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
            children: [
              _SectionLabel(label: 'عمومی'),
              const SizedBox(height: 10),
              ValueListenableBuilder<bool>(
                valueListenable: SettingsStore.instance.notificationsEnabled,
                builder: (context, enabled, _) => _SettingsTile(
                  icon: Icons.notifications_outlined,
                  color: const Color(0xFF6C7BFF),
                  bgColor: const Color(0xFFECEEFF),
                  title: 'اعلان‌ها',
                  trailing: Switch(
                    value: enabled,
                    onChanged: SettingsStore.instance.setNotificationsEnabled,
                    activeColor: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder<bool>(
                valueListenable: SettingsStore.instance.darkModeEnabled,
                builder: (context, enabled, _) => _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  color: const Color(0xFFB07CFF),
                  bgColor: const Color(0xFFF3E9FF),
                  title: 'حالت تیره',
                  trailing: Switch(
                    value: enabled,
                    onChanged: SettingsStore.instance.setDarkModeEnabled,
                    activeColor: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              _SectionLabel(label: 'درباره برنامه'),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.info_outline,
                color: const Color(0xFF2BC4A8),
                bgColor: const Color(0xFFE3F8F4),
                title: 'نسخه برنامه',
                trailing: Text(
                  '۱.۰.۰',
                  style: TextStyle(fontSize: 12, color: context.textSecondary),
                ),
              ),
              const SizedBox(height: 10),
              const _SettingsTile(
                icon: Icons.school_outlined,
                color: Color(0xFFFF9F5A),
                bgColor: Color(0xFFFFF1E4),
                title: 'دانشکده شهید چمران رشت',
                subtitle: 'دانشگاه ملی مهارت - استان گیلان',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: context.textSecondary,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final iconBg = context.isDark ? color.withOpacity(0.18) : bgColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF28325A,
            ).withOpacity(context.isDark ? 0.0 : 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
