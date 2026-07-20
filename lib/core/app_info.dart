/// Central place for app metadata used across settings, update-check,
/// and the "about" section — keeps version/repo info in one spot instead
/// of scattered string literals.
class AppInfo {
  static const String currentVersion = '1.0.0';
  static const String githubOwner = 'Liam0027';
  static const String githubRepo = 'university_links_app';

  static const String githubUrl = 'https://github.com/$githubOwner/$githubRepo';

  static const String githubReleasesApiUrl =
      'https://api.github.com/repos/$githubOwner/$githubRepo/releases/latest';

  static const String privacyPolicyUrl =
      'https://github.com/$githubOwner/$githubRepo/blob/master/PRIVACY.md';
}
