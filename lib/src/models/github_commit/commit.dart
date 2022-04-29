import 'package:collection/collection.dart';

import 'author.dart';
import 'committer.dart';
import 'tree.dart';
import 'verification.dart';

class Commit {
  int? color;
  String? branch;
  Author? author;
  Committer? committer;
  String? message;
  Tree? tree;
  String? url;
  int? commentCount;
  Verification? verification;

  Commit({
    this.color,
    this.branch,
    this.author,
    this.committer,
    this.message,
    this.tree,
    this.url,
    this.commentCount,
    this.verification,
  });

  factory Commit.fromJson(
          Map<String, dynamic> json, Map<dynamic, dynamic> adicionalInfo) =>
      Commit(
        branch: adicionalInfo["branchName"] as String?,
        color: adicionalInfo["branchIndex"] as int?,
        author: json['author'] == null
            ? null
            : Author.fromJson(json['author'] as Map<String, dynamic>),
        committer: json['committer'] == null
            ? null
            : Committer.fromJson(json['committer'] as Map<String, dynamic>),
        message: json['message'] as String?,
        tree: json['tree'] == null
            ? null
            : Tree.fromJson(json['tree'] as Map<String, dynamic>),
        url: json['url'] as String?,
        commentCount: json['comment_count'] as int?,
        verification: json['verification'] == null
            ? null
            : Verification.fromJson(
                json['verification'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'author': author?.toJson(),
        'committer': committer?.toJson(),
        'message': message,
        'tree': tree?.toJson(),
        'url': url,
        'comment_count': commentCount,
        'verification': verification?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Commit) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      branch.hashCode ^
      author.hashCode ^
      committer.hashCode ^
      message.hashCode ^
      tree.hashCode ^
      url.hashCode ^
      commentCount.hashCode ^
      verification.hashCode;
}
