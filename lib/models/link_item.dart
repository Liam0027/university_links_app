class LinkItem {
  final String title;
  final String url;
  final String shortUrl;
  final String? logoUrl;

  const LinkItem({
    required this.title,
    required this.url,
    required this.shortUrl,
    this.logoUrl,
  });

  String get effectiveLogoUrl {
    if (logoUrl != null) return logoUrl!;
    final uri = Uri.tryParse(url);
    final domain = uri?.host ?? '';
    return 'https://www.google.com/s2/favicons?domain=$domain&sz=128';
  }
}
