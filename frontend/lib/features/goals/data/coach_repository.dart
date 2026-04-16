import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';

class CoachRepository {
  CoachRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  Future<String> requestCoachMessage({String? message}) async {
    try {
      final response = await _dioClient.post(
        '/ai/coach',
        data: {
          if (message != null && message.trim().isNotEmpty) 'message': message.trim(),
        },
      );
      final payload = Map<String, dynamic>.from(response.data as Map<String, dynamic>);
      final data = Map<String, dynamic>.from(payload['data'] as Map<String, dynamic>);
      return data['message'] as String? ?? 'Stay consistent and keep moving.';
    } on DioException catch (error) {
      final messageText = error.response?.data is Map<String, dynamic>
          ? (error.response?.data['detail'] as String? ?? 'Unable to reach your coach.')
          : 'Unable to reach your coach.';
      throw Exception(messageText);
    }
  }
}
