# Payment Backend & Flutter Integration Guide

## Quick Start

### 1. Start the Payment Backend

Navigate to the payment-backend folder and install dependencies:

```bash
cd SE-MHS/payment-backend
npm install
npm start
```

The backend will run on `http://localhost:3001`

### 2. Using the Payment Service in Flutter

The `payment_service.dart` file provides all necessary methods to interact with the payment backend.

## Usage Examples

### Example 1: Initiate and Process Payment

```dart
import 'package:flutter/material.dart';
import '../services/payment_service.dart';

// Initiate payment
final initiateResponse = await PaymentService.initiatePayment(
  amount: 60000, // Rp 60.000
  paymentMethod: 'gopay',
  userId: 'user123',
  eventId: 'event456',
);

if (initiateResponse['success']) {
  final transactionId = initiateResponse['data']['data']['transactionId'];
  print('Transaction ID: $transactionId');
  
  // Process the payment
  final processResponse = await PaymentService.processPayment(
    transactionId: transactionId,
  );
  
  if (processResponse['success']) {
    print('Payment successful!');
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Successful'),
        content: Text('Your payment has been processed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  } else {
    print('Payment failed: ${processResponse['message']}');
    // Show error dialog
  }
} else {
  print('Failed to initiate: ${initiateResponse['message']}');
}
```

### Example 2: Check Transaction Status

```dart
final statusResponse = await PaymentService.getTransactionStatus(
  transactionId: 'transaction-uuid-here',
);

if (statusResponse['success']) {
  final transaction = statusResponse['data']['data'];
  print('Status: ${transaction['status']}');
  print('Amount: ${transaction['amount']}');
}
```

### Example 3: Get User's Payment History

```dart
final historyResponse = await PaymentService.getUserTransactions(
  userId: 'user123',
);

if (historyResponse['success']) {
  final transactions = historyResponse['data']['data'];
  for (var transaction in transactions) {
    print('${transaction['id']}: ${transaction['status']}');
  }
}
```

### Example 4: Cancel a Payment

```dart
final cancelResponse = await PaymentService.cancelPayment(
  transactionId: 'transaction-uuid-here',
);

if (cancelResponse['success']) {
  print('Payment cancelled');
}
```

### Example 5: Check Backend Connection

```dart
final isHealthy = await PaymentService.checkHealth();
if (isHealthy) {
  print('Backend is connected');
} else {
  print('Backend is not responding');
}
```

## Integration into Payment Screen

Update your `payment_finnish_button.dart` to process payments:

```dart
onTap: () async {
  setState(() => _pressing = false);
  
  // Show loading
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 20),
          Text('Processing payment...'),
        ],
      ),
    ),
  );

  // Initiate payment
  final initiateResp = await PaymentService.initiatePayment(
    amount: _total,
    paymentMethod: _selectedMethod ?? 'gopay',
    userId: 'current-user-id',
    eventId: 'current-event-id',
  );

  if (initiateResp['success']) {
    final txnId = initiateResp['data']['data']['transactionId'];
    
    // Process payment
    final processResp = await PaymentService.processPayment(
      transactionId: txnId,
    );

    Navigator.pop(context); // Close loading dialog

    if (processResp['success']) {
      // Payment successful
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymentSuccessScreen(transactionId: txnId),
        ),
      );
    } else {
      // Payment failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Failed'),
          content: Text(processResp['message']),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }
  } else {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(initiateResp['message']),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
},
```

## Network Configuration

### For Android Emulator:
Change the `_baseUrl` in `payment_service.dart`:
```dart
static const String _baseUrl = 'http://10.0.2.2:3001/api';
```

### For iOS Simulator:
```dart
static const String _baseUrl = 'http://localhost:3001/api';
```

### For Physical Device:
Replace with your machine's IP address (e.g., 192.168.x.x):
```dart
static const String _baseUrl = 'http://192.168.1.100:3001/api';
```

## Payment Methods Supported

- `bca` - BCA Bank Transfer
- `gopay` - GoPay Mobile Wallet
- `ovo` - OVO Mobile Wallet
- `card` - Credit/Debit Card

## Database Models

### Transaction Object
```json
{
  "id": "uuid",
  "userId": "user123",
  "eventId": "event456",
  "amount": 60000,
  "paymentMethod": "gopay",
  "status": "completed",
  "createdAt": "2024-05-22T10:30:00Z",
  "updatedAt": "2024-05-22T10:30:05Z"
}
```

### Transaction Statuses
- `pending` - Payment initiated but not yet processed
- `completed` - Payment successfully processed
- `failed` - Payment processing failed
- `cancelled` - Payment was cancelled by user

## API Response Format

All API responses follow this format:

**Success Response:**
```json
{
  "success": true,
  "message": "Operation successful",
  "data": { ... }
}
```

**Error Response:**
```json
{
  "success": false,
  "message": "Error description"
}
```

## Testing

You can test the backend using cURL or Postman:

```bash
# Health check
curl http://localhost:3001/api/health

# Initiate payment
curl -X POST http://localhost:3001/api/payments/initiate \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 60000,
    "paymentMethod": "gopay",
    "userId": "user123"
  }'
```

## Production Considerations

1. **Replace in-memory storage** with a real database (MySQL, PostgreSQL)
2. **Integrate real payment gateway** (Stripe, Midtrans, etc.)
3. **Add authentication** (JWT tokens)
4. **Add environment configuration** (.env file support)
5. **Add logging** (Winston, Morgan)
6. **Add error handling** and validation
7. **Add rate limiting** to prevent abuse
8. **Enable HTTPS** in production
9. **Add transaction encryption**
10. **Add webhook support** for payment notifications
