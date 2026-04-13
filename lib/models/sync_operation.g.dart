// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncOperationImpl _$$SyncOperationImplFromJson(Map<String, dynamic> json) =>
    _$SyncOperationImpl(
      id: json['id'] as String,
      collection: json['collection'] as String,
      method: json['method'] as String,
      payload: json['payload'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$$SyncOperationImplToJson(_$SyncOperationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collection': instance.collection,
      'method': instance.method,
      'payload': instance.payload,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };
