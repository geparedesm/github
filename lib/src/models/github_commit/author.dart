import 'package:collection/collection.dart';

class Author {
  String? name;
  String? email;
  DateTime? date;

  Author({this.name, this.email, this.date});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json['name'] as String?,
        email: json['email'] as String?,
        date: json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'date': date?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Author) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ date.hashCode;
}
