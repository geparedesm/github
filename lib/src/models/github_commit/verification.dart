import 'package:collection/collection.dart';

class Verification {
  bool? verified;
  String? reason;
  String? signature;
  String? payload;

  Verification({this.verified, this.reason, this.signature, this.payload});

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        verified: json['verified'] as bool?,
        reason: json['reason'] as String?,
        signature: json['signature'] as String?,
        payload: json['payload'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'verified': verified,
        'reason': reason,
        'signature': signature,
        'payload': payload,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Verification) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      verified.hashCode ^
      reason.hashCode ^
      signature.hashCode ^
      payload.hashCode;
}
