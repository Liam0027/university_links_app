import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../services/settings_store.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(18, 18, 18, 8),
          child: Row(
            children: [
              Text(
                'تنظیمات',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
            children: [
              const _SectionLabel(label: 'عمومی'),
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
              const _SectionLabel(label: 'درباره برنامه'),
              const SizedBox(height: 10),
              const _SettingsTile(
                icon: Icons.info_outline,
                color: Color(0xFF2BC4A8),
                bgColor: Color(0xFFE3F8F4),
                title: 'نسخه برنامه',
                trailing: Text(
                  '۱.۰.۰',
                  style: TextStyle(fontSize: 12, color: AppColors.textSub),
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
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: AppColors.textSub,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28325A).withOpacity(0.06),
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
              color: bgColor,
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
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSub,
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
