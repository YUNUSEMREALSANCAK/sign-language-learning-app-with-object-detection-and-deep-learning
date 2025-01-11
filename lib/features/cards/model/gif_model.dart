class GifModel {
  final String id;
  final String title;
  final String gifUrl;
  final List<String> tags;
  final String category;

  GifModel({
    required this.id,
    required this.title,
    required this.gifUrl,
    required this.tags,
    required this.category,
  });

  factory GifModel.fromJson(Map<String, dynamic> json) {
    return GifModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      gifUrl: json['gif_url'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'gif_url': gifUrl,
      'tags': tags,
      'category': category,
    };
  }
}
