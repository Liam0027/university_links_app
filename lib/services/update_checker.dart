import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/app_info.dart';

class UpdateCheckResult {
  final bool updateAvailable;
  final String latestVersion;
  final String? downloadUrl;
  final String? htmlUrl;

  const UpdateCheckResult({
    required this.updateAvailable,
    required this.latestVersion,
    this.downloadUrl,
    this.htmlUrl,
  });
}

class UpdateChecker {
  /// Fetches the latest GitHub release and compares it against
  /// [AppInfo.currentVersion]. Throws on network/parse failure so the
  /// caller can show an appropriate error state.
  static Future<UpdateCheckResult> checkForUpdate() async {
    final response = await http
        .get(
          Uri.parse(AppInfo.githubReleasesApiUrl),
          headers: {'Accept': 'application/vnd.github+json'},
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('GitHub API returned ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final tagName = (data['tag_name'] as String? ?? '').trim();
    final latestVersion = tagName.startsWith('v')
        ? tagName.substring(1)
        : tagName;

    String? apkUrl;
    final assets = data['assets'] as List<dynamic>?;
    if (assets != null) {
      for (final asset in assets) {
        final name = (asset['name'] as String? ?? '').toLowerCase();
        if (name.endsWith('.apk')) {
          apkUrl = asset['browser_download_url'] as String?;
          break;
        }
      }
    }

    return UpdateCheckResult(
      updateAvailable: _isNewer(latestVersion, AppInfo.currentVersion),
      latestVersion: latestVersion,
      downloadUrl: apkUrl,
      htmlUrl: data['html_url'] as String?,
    );
  }

  /// Compares two dotted version strings (e.g. "1.2.0" vs "1.10.0")
  /// numerically, part by part, rather than lexicographically.
  static bool _isNewer(String remote, String local) {
    final remoteParts = remote.split('.').map(_toInt).toList();
    final localParts = local.split('.').map(_toInt).toList();
    final length = remoteParts.length > localParts.length
        ? remoteParts.length
        : localParts.length;

    for (var i = 0; i < length; i++) {
      final r = i < remoteParts.length ? remoteParts[i] : 0;
      final l = i < localParts.length ? localParts[i] : 0;
      if (r != l) return r > l;
    }
    return false;
  }

  static int _toInt(String part) => int.tryParse(part.trim()) ?? 0;
}
