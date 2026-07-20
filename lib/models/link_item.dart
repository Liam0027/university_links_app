class LinkItem {
  final String title;
  final String url;
  final String shortUrl;

  /// Path to a bundled asset image (e.g. 'assets/logos/tvu.png'). All logos
  /// are bundled locally — no network request is made for images.
  final String? localLogo;

  const LinkItem({
    required this.title,
    required this.url,
    required this.shortUrl,
    this.localLogo,
  });
}
