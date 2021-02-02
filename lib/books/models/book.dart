import 'dart:convert';

class Book {
  final String title;
  final String author;
  final String categories;
  final String pages;
  final String description;
  final String added_at;
  final String reading;
  final String image;
  final int rating;
  Book({
    this.title,
    this.author,
    this.categories,
    this.pages,
    this.description,
    this.added_at,
    this.reading,
    this.image,
    this.rating,
  });

  Book copyWith({
    String title,
    String author,
    String categories,
    String pages,
    String description,
    String added_at,
    String reading,
    String image,
    int rating,
  }) {
    return Book(
      title: title ?? this.title,
      author: author ?? this.author,
      categories: categories ?? this.categories,
      pages: pages ?? this.pages,
      description: description ?? this.description,
      added_at: added_at ?? this.added_at,
      reading: reading ?? this.reading,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'categories': categories,
      'pages': pages,
      'description': description,
      'added_at': added_at,
      'reading': reading,
      'image': image,
      'rating': rating,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Book(
      title: map['title'],
      author: map['author'],
      categories: map['categories'],
      pages: map['pages'],
      description: map['description'],
      added_at: map['added_at'],
      reading: map['reading'],
      image: map['image'],
      rating: map['rating']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Book(title: $title, author: $author, categories: $categories, pages: $pages, description: $description, added_at: $added_at, reading: $reading, image: $image, rating: $rating)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Book &&
      o.title == title &&
      o.author == author &&
      o.categories == categories &&
      o.pages == pages &&
      o.description == description &&
      o.added_at == added_at &&
      o.reading == reading &&
      o.image == image &&
      o.rating == rating;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      author.hashCode ^
      categories.hashCode ^
      pages.hashCode ^
      description.hashCode ^
      added_at.hashCode ^
      reading.hashCode ^
      image.hashCode ^
      rating.hashCode;
  }
}