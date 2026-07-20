import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/app_colors.dart';
import '../../core/app_info.dart';
import '../../services/settings_store.dart';
import '../../services/update_checker.dart';

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
              const _UpdateCheckTile(),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.lock_outline_rounded,
                color: const Color(0xFF5AA9E6),
                bgColor: const Color(0xFFE6F2FC),
                title: 'حریم خصوصی',
                subtitle: 'این برنامه چه اطلاعاتی را ذخیره می‌کند',
                trailing: Icon(
                  Icons.open_in_new_rounded,
                  size: 16,
                  color: context.textSecondary,
                ),
                onTap: () => _openUrl(AppInfo.privacyPolicyUrl),
              ),
              const SizedBox(height: 10),
              _SettingsTile(
                icon: Icons.code_rounded,
                color: const Color(0xFF3E4C59),
                bgColor: const Color(0xFFE7EAEE),
                title: 'کد‌ منبع در گیت‌هاب',
                subtitle: 'مشاهده، گزارش مشکل یا مشارکت در توسعه',
                trailing: Icon(
                  Icons.open_in_new_rounded,
                  size: 16,
                  color: context.textSecondary,
                ),
                onTap: () => _openUrl(AppInfo.githubUrl),
              ),
              const SizedBox(height: 10),
              const _SettingsTile(
                icon: Icons.school_outlined,
                color: Color(0xFFFF9F5A),
                bgColor: Color(0xFFFFF1E4),
                title: 'دانشکده شهید چمران رشت',
                subtitle: 'دانشگاه ملی مهارت - استان گیلان',
              ),
              const SizedBox(height: 26),
              const _AboutFooter(),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
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
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconBg = context.isDark ? color.withOpacity(0.18) : bgColor;

    final content = Container(
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

    if (onTap == null) return content;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, child: content),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Update check tile
// ---------------------------------------------------------------------------

enum _UpdateState { idle, checking, upToDate, available, error }

class _UpdateCheckTile extends StatefulWidget {
  const _UpdateCheckTile();

  @override
  State<_UpdateCheckTile> createState() => _UpdateCheckTileState();
}

class _UpdateCheckTileState extends State<_UpdateCheckTile> {
  _UpdateState _state = _UpdateState.idle;
  UpdateCheckResult? _result;

  Future<void> _handleTap() async {
    // If an update was already found, tapping again opens the download
    // instead of re-checking.
    if (_state == _UpdateState.available && _result != null) {
      final url = _result!.downloadUrl ?? _result!.htmlUrl;
      if (url != null) await _openUrl(url);
      return;
    }

    setState(() => _state = _UpdateState.checking);
    try {
      final result = await UpdateChecker.checkForUpdate();
      if (!mounted) return;
      setState(() {
        _result = result;
        _state = result.updateAvailable
            ? _UpdateState.available
            : _UpdateState.upToDate;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _state = _UpdateState.error);
    }
  }

  Widget _trailing(BuildContext context) {
    final versionChip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: context.textSecondary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        AppInfo.currentVersion,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: context.textSecondary,
        ),
      ),
    );

    switch (_state) {
      case _UpdateState.checking:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            versionChip,
            const SizedBox(width: 8),
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        );
      case _UpdateState.upToDate:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            versionChip,
            const SizedBox(width: 8),
            const Icon(
              Icons.check_circle_rounded,
              size: 16,
              color: Color(0xFF2BC4A8),
            ),
          ],
        );
      case _UpdateState.available:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'v${_result!.latestVersion}',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        );
      case _UpdateState.error:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            versionChip,
            const SizedBox(width: 8),
            Icon(Icons.refresh_rounded, size: 16, color: context.textSecondary),
          ],
        );
      case _UpdateState.idle:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            versionChip,
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: context.textSecondary,
            ),
          ],
        );
    }
  }

  String get _subtitle {
    switch (_state) {
      case _UpdateState.checking:
        return 'در حال بررسی بروزرسانی...';
      case _UpdateState.upToDate:
        return 'بروزرسانی جدیدی موجود نیست';
      case _UpdateState.available:
        return 'نسخه جدید موجود است، برای دانلود لمس کنید';
      case _UpdateState.error:
        return 'خطا در بررسی بروزرسانی، دوباره تلاش کنید';
      case _UpdateState.idle:
        return 'برای بررسی بروزرسانی لمس کنید';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SettingsTile(
      icon: Icons.info_outline,
      color: const Color(0xFF2BC4A8),
      bgColor: const Color(0xFFE3F8F4),
      title: 'نسخه برنامه',
      subtitle: _subtitle,
      trailing: _trailing(context),
      onTap: _state == _UpdateState.checking ? null : _handleTap,
    );
  }
}

// ---------------------------------------------------------------------------
// Footer: copyright + unofficial disclaimer
// ---------------------------------------------------------------------------

class _AboutFooter extends StatelessWidget {
  const _AboutFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'این برنامه توسط یک دانشجو به‌صورت مستقل توسعه داده شده و '
          'محصول رسمی دانشگاه ملی مهارت نیست.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.5,
            height: 1.6,
            color: context.textSecondary.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          '© 2026 Alireza Jalili – MultiDev. All rights reserved.\n\nMade with ❤️',
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 10.5,
            height: 1.6,
            color: context.textSecondary.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
