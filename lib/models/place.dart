class Place {
  const Place({
    required this.id,
    required this.title,
    required this.location,
    required this.likes,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String location;
  final int likes;
  final String imageUrl;
}
