import 'package:flutter/material.dart';
import '../services/payment_service.dart';

/// Example widget demonstrating how to use PaymentService
/// This is a reference implementation for integrating payments into your app

class PaymentExampleWidget extends StatefulWidget {
  const PaymentExampleWidget({super.key});

  @override
  State<PaymentExampleWidget> createState() => _PaymentExampleWidgetState();
}

class _PaymentExampleWidgetState extends State<PaymentExampleWidget> {
  bool _isLoading = false;
  String? _transactionId;
  String? _status;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkBackendConnection();
  }

  Future<void> _checkBackendConnection() async {
    final isConnected = await PaymentService.checkHealth();
    if (!isConnected) {
      setState(() {
        _errorMessage =
            'Backend is not connected. Make sure the server is running.';
      });
    }
  }

  Future<void> _initiatePayment() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await PaymentService.initiatePayment(
        amount: 60000,
        paymentMethod: 'gopay',
        userId: 'user123',
        eventId: 'event456',
      );

      if (response['success']) {
        final transactionId = response['data']['data']['transactionId'];
        setState(() {
          _transactionId = transactionId;
          _status = 'Payment initiated. Ready to process.';
        });
      } else {
        setState(() {
          _errorMessage = response['message'];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _processPayment() async {
    if (_transactionId == null) {
      setState(() {
        _errorMessage = 'Please initiate payment first';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await PaymentService.processPayment(
        transactionId: _transactionId!,
      );

      if (response['success']) {
        setState(() {
          _status = 'Payment completed successfully!';
        });
        _showSuccessDialog();
      } else {
        setState(() {
          _errorMessage = response['message'];
        });
        _showErrorDialog(response['message']);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getTransactionStatus() async {
    if (_transactionId == null) {
      setState(() {
        _errorMessage = 'No transaction to check';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await PaymentService.getTransactionStatus(
        transactionId: _transactionId!,
      );

      if (response['success']) {
        final transaction = response['data']['data'];
        setState(() {
          _status =
              'Status: ${transaction['status']}\nAmount: Rp${transaction['amount']}';
        });
      } else {
        setState(() {
          _errorMessage = response['message'];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _cancelPayment() async {
    if (_transactionId == null) {
      setState(() {
        _errorMessage = 'No transaction to cancel';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await PaymentService.cancelPayment(
        transactionId: _transactionId!,
      );

      if (response['success']) {
        setState(() {
          _status = 'Payment cancelled';
          _transactionId = null;
        });
      } else {
        setState(() {
          _errorMessage = response['message'];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your payment has been processed successfully.'),
            const SizedBox(height: 12),
            Text(
              'Transaction ID: $_transactionId',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Example'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Display
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else if (_status != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _status!,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            const SizedBox(height: 20),

            // Transaction ID Display
            if (_transactionId != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Transaction ID:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _transactionId!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // Buttons
            ElevatedButton(
              onPressed: _isLoading ? null : _initiatePayment,
              child: const Text('1. Initiate Payment'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (_isLoading || _transactionId == null)
                  ? null
                  : _processPayment,
              child: const Text('2. Process Payment'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (_isLoading || _transactionId == null)
                  ? null
                  : _getTransactionStatus,
              child: const Text('3. Check Status'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (_isLoading || _transactionId == null)
                  ? null
                  : _cancelPayment,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cancel Payment'),
            ),
            const SizedBox(height: 20),

            // Instructions
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How to use:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('1. Click "Initiate Payment" to start a transaction'),
                  Text('2. Click "Process Payment" to process the transaction'),
                  Text('3. Click "Check Status" to verify the status'),
                  Text(
                    '4. Use "Cancel Payment" to cancel pending transactions',
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Note: Make sure the backend server is running at http://localhost:3001',
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
