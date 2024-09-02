///
/// Specifies an uploadable image to Discord
///
class DiscordUploadableImage {
  final String name;

  final String format;

  final List<int> bytes;

  const DiscordUploadableImage({
    required this.bytes,
    required this.format,
    required this.name,
  });
}
