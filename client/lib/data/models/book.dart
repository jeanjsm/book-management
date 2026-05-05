class Book {
  final int? id;
  final String code;
  final String title;
  final int number;
  final String author;
  final String paidPrice;
  final String labelPrice;
  final String? barcode;
  final String? coverUrl;
  final String createdAt;
  final String updatedAt;

  Book({
    this.id,
    required this.code,
    required this.title,
    required this.number,
    required this.author,
    this.paidPrice = '0.0',
    this.labelPrice = '0.0',
    this.barcode,
    this.coverUrl,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int?,
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      number: json['number'] as int? ?? 0,
      author: json['author'] as String? ?? '',
      paidPrice: json['paidPrice']?.toString() ?? '0.0',
      labelPrice: json['labelPrice']?.toString() ?? '0.0',
      barcode: json['barcode'] as String?,
      coverUrl: json['coverUrl'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'code': code,
      'title': title,
      'number': number,
      'author': author,
      'paidPrice': paidPrice,
      'labelPrice': labelPrice,
      if (barcode != null) 'barcode': barcode,
      if (coverUrl != null) 'coverUrl': coverUrl,
    };
  }

  Book copyWith({
    int? id,
    String? code,
    String? title,
    int? number,
    String? author,
    String? paidPrice,
    String? labelPrice,
    String? barcode,
    String? coverUrl,
    String? createdAt,
    String? updatedAt,
  }) {
    return Book(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      number: number ?? this.number,
      author: author ?? this.author,
      paidPrice: paidPrice ?? this.paidPrice,
      labelPrice: labelPrice ?? this.labelPrice,
      barcode: barcode ?? this.barcode,
      coverUrl: coverUrl ?? this.coverUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
