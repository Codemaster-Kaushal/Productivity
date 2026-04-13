import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_operation.freezed.dart';
part 'sync_operation.g.dart';

@freezed
class SyncOperation with _$SyncOperation {
  const SyncOperation._();
  const factory SyncOperation({    required String id,
    required String collection,
    required String method,
    required String payload,
    required DateTime createdAt,
    DateTime? syncedAt,
  }) = _SyncOperation;

  factory SyncOperation.fromJson(Map<String, dynamic> json) => _$SyncOperationFromJson(json);
}
