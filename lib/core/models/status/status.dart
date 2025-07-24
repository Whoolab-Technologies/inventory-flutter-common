import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable(explicitToJson: true)
class Status {
  int id;
  String name;
  String code;
  String color;

  Status({
    required this.id,
    required this.name,
    required this.code,
    required this.color,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return _$StatusFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

enum StatusEnum {
  UNKNOWN(1),
  PENDING(2),
  APPROVED(3),
  REJECTED(4),
  PROCESSING(5),
  CANCELLED(6),
  COMPLETED(7),
  PARTIALLY_RECEIVED(8),
  AWAITING_PROC(9),
  IN_TRANSIT(10),
  RECEIVED(11),
  ON_HOLD(12);

  final int id;
  const StatusEnum(this.id);
}
