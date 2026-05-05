class ImporterDto {
  final String id;
  final String isbn;
  final String title;
  final String number;
  final String synopsis;
  final String? labelPrice;
  final String? coverUrl;

  ImporterDto({
    required this.id,
    required this.isbn,
    required this.title,
    this.number = '1',
    this.synopsis = '',
    this.labelPrice,
    this.coverUrl,
  });

  factory ImporterDto.fromJson(Map<String, dynamic> json) {
    return ImporterDto(
      id: json['id'] as String? ?? '',
      isbn: json['isbn'] as String? ?? '',
      title: json['title'] as String? ?? '',
      number: json['number'] as String? ?? '1',
      synopsis: json['synopsis'] as String? ?? '',
      labelPrice: json['labelPrice']?.toString(),
      coverUrl: json['coverUrl'] as String?,
    );
  }
}
