import 'package:json_annotation/json_annotation.dart';

part 'host.g.dart';

@JsonSerializable()
class HostDTO {
  String apiKey;
  String code;
  String description;
  String hostStatus;

  HostDTO(
      {required this.apiKey,
      required this.code,
      required this.description,
      required this.hostStatus});

  factory HostDTO.fromJson(Map<String, dynamic> json) =>
      _$HostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HostDTOToJson(this);
}
