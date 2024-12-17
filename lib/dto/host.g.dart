// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostDTO _$HostDTOFromJson(Map<String, dynamic> json) => HostDTO(
      apiKey: json['apiKey'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
      hostStatus: json['hostStatus'] as String,
    );

Map<String, dynamic> _$HostDTOToJson(HostDTO instance) => <String, dynamic>{
      'apiKey': instance.apiKey,
      'code': instance.code,
      'description': instance.description,
      'hostStatus': instance.hostStatus,
    };
