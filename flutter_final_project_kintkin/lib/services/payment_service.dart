import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  static const String _baseUrl = 'http://localhost:3001/api';

  // For Android emulator, use: http://10.0.2.2:3001/api
  // For iOS simulator, use: http://localhost:3001/api
  // For physical device, use your machine's IP address

  /// Initialize a new payment transaction
  static Future<Map<String, dynamic>> initiatePayment({
    required int amount,
    required String paymentMethod,
    required String userId,
    String? eventId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/payments/initiate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'paymentMethod': paymentMethod,
          'userId': userId,
          'eventId': eventId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Failed to initiate payment',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Process a payment transaction
  static Future<Map<String, dynamic>> processPayment({
    required String transactionId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/payments/process'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'transactionId': transactionId}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to process payment',
          'data': data,
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Get payment transaction status
  static Future<Map<String, dynamic>> getTransactionStatus({
    required String transactionId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/payments/$transactionId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': 'Transaction not found'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Get all transactions for a user
  static Future<Map<String, dynamic>> getUserTransactions({
    required String userId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/payments/user/$userId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': 'Failed to retrieve transactions'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Cancel a pending payment
  static Future<Map<String, dynamic>> cancelPayment({
    required String transactionId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/payments/$transactionId/cancel'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to cancel payment',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Check if backend is healthy
  static Future<bool> checkHealth() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/health'))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
