import 'dart:convert';

import 'package:collection/collection.dart';

import 'author.dart';
import 'commit.dart';
import 'committer.dart';

class GithubCommit {
  String? sha;
  String? nodeId;
  Commit? commit;
  String? url;
  String? htmlUrl;
  String? commentsUrl;
  Author? author;
  Committer? committer;
  List<dynamic>? parents;

  GithubCommit({
    this.sha,
    this.nodeId,
    this.commit,
    this.url,
    this.htmlUrl,
    this.commentsUrl,
    this.author,
    this.committer,
    this.parents,
  });

  factory GithubCommit.fromJson(
          Map<String, dynamic> json, Map<dynamic, dynamic> adicionalInfo) =>
      GithubCommit(
        sha: json['sha'] as String?,
        nodeId: json['node_id'] as String?,
        commit: (json['commit']) == null
            ? null
            : Commit.fromJson(
                json['commit'] as Map<String, dynamic>, adicionalInfo),
        url: json['url'] as String?,
        htmlUrl: json['html_url'] as String?,
        commentsUrl: json['comments_url'] as String?,
        author: json['author'] == null
            ? null
            : Author.fromJson(json['author'] as Map<String, dynamic>),
        parents: json['parents'].length > 0
            ? json['parents']
            : [
                {"sha": ""}
              ],
        committer: json['committer'] == null
            ? null
            : Committer.fromJson(json['committer'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'sha': sha,
        'node_id': nodeId,
        'commit': commit?.toJson(),
        'url': url,
        'html_url': htmlUrl,
        'comments_url': commentsUrl,
        'author': author?.toJson(),
        'committer': committer?.toJson(),
        'parents': parents,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GithubCommit) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      sha.hashCode ^
      nodeId.hashCode ^
      commit.hashCode ^
      url.hashCode ^
      htmlUrl.hashCode ^
      commentsUrl.hashCode ^
      author.hashCode ^
      committer.hashCode ^
      parents.hashCode;
}
