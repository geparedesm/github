import 'package:collection/collection.dart';

class Tree {
  String? sha;
  String? url;

  Tree({this.sha, this.url});

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        sha: json['sha'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'sha': sha,
        'url': url,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Tree) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => sha.hashCode ^ url.hashCode;
}
