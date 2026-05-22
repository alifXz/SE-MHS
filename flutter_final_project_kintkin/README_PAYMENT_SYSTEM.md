# 🏦 Payment System - Backend & Flutter Integration

A complete payment backend system with Flutter integration for the KinTkin mobile application.

## 📁 What's Included

### Backend
- **Location:** `SE-MHS/payment-backend/`
- **Technology:** Node.js + Express.js
- **Features:**
  - Payment initiation
  - Payment processing
  - Transaction status tracking
  - Payment history
  - Cancel operations
  - Admin endpoints

### Flutter Service
- **Location:** `SE-MHS/flutter_final_project_kintkin/lib/services/payment_service.dart`
- **Features:**
  - Easy-to-use API client
  - All payment operations
  - Error handling
  - Health checks

### Example Widget
- **Location:** `SE-MHS/flutter_final_project_kintkin/lib/widgets/payment_example_widget.dart`
- **Features:**
  - Complete example implementation
  - UI with all payment operations
  - Error handling UI
  - Status display

### Documentation
- **SETUP.md** - Step-by-step setup instructions
- **PAYMENT_INTEGRATION_GUIDE.md** - Integration examples
- **payment-backend/README.md** - API documentation
- **payment-backend/api-test.http** - API test requests

## 🚀 Quick Start (5 minutes)

### 1. Start the Backend

```bash
cd SE-MHS/payment-backend
npm install
npm start
```

You should see:
```
Payment backend running on http://localhost:3001
```

### 2. Test Backend Connection

Open in browser:
```
http://localhost:3001/api/health
```

Expected response:
```json
{
  "status": "Payment backend is running"
}
```

### 3. View Example Widget

The example widget is ready to use. You can navigate to it or copy its code into your payment screen.

```
SE-MHS/flutter_final_project_kintkin/lib/widgets/payment_example_widget.dart
```

## 📚 Documentation

1. **For Setup Instructions:** Read `payment-backend/SETUP.md`
2. **For API Details:** Read `payment-backend/README.md`
3. **For Integration Code:** Read `PAYMENT_INTEGRATION_GUIDE.md`
4. **For Examples:** Check `payment_example_widget.dart`

## 🔗 API Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/api/health` | Health check |
| POST | `/api/payments/initiate` | Start payment |
| POST | `/api/payments/process` | Process payment |
| GET | `/api/payments/:id` | Get status |
| GET | `/api/payments/user/:id` | User history |
| POST | `/api/payments/:id/cancel` | Cancel payment |
| GET | `/api/admin/transactions` | All transactions |

## 💳 Supported Payment Methods

- `bca` - BCA Bank Transfer
- `gopay` - GoPay Mobile Wallet
- `ovo` - OVO Mobile Wallet
- `card` - Credit/Debit Card

## 🎯 Usage Example

```dart
// Initiate payment
final response = await PaymentService.initiatePayment(
  amount: 60000,
  paymentMethod: 'gopay',
  userId: 'user123',
  eventId: 'event456',
);

if (response['success']) {
  final txnId = response['data']['data']['transactionId'];
  
  // Process payment
  final result = await PaymentService.processPayment(
    transactionId: txnId,
  );
  
  if (result['success']) {
    print('Payment successful!');
  }
}
```

## 🗂️ Project Structure

```
SE-MHS/
├── payment-backend/
│   ├── server.js                    # Main server
│   ├── package.json                 # Dependencies
│   ├── SETUP.md                     # Setup guide
│   ├── README.md                    # API docs
│   ├── api-test.http               # API tests
│   ├── docker-compose.yml          # Docker setup
│   └── Dockerfile                  # Docker image
│
├── flutter_final_project_kintkin/
│   └── lib/
│       ├── services/
│       │   └── payment_service.dart # API client
│       └── widgets/
│           ├── payment_example_widget.dart  # Example UI
│           └── ... (other widgets)
│
├── PAYMENT_INTEGRATION_GUIDE.md    # Integration guide
└── README.md                       # This file
```

## 🧪 Testing

### Using cURL
```bash
curl -X POST http://localhost:3001/api/payments/initiate \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 60000,
    "paymentMethod": "gopay",
    "userId": "user123"
  }'
```

### Using REST Client Extension
Open `payment-backend/api-test.http` and click "Send Request"

### Using Postman
Import the requests from `api-test.http`

## 🔄 Development Workflow

**Terminal 1 - Backend:**
```bash
cd SE-MHS/payment-backend
npm start
```

**Terminal 2 - Flutter App:**
```bash
cd SE-MHS/flutter_final_project_kintkin
flutter run
```

## ⚙️ Configuration

Edit `.env` in payment-backend folder:
```env
PORT=3001
NODE_ENV=development
```

## 🌐 Network Configuration

### Android Emulator
```dart
static const String _baseUrl = 'http://10.0.2.2:3001/api';
```

### iOS Simulator
```dart
static const String _baseUrl = 'http://localhost:3001/api';
```

### Physical Device
```dart
static const String _baseUrl = 'http://192.168.X.X:3001/api';
```

## 🐳 Docker

Run with Docker Compose:
```bash
cd SE-MHS/payment-backend
docker-compose up
```

## 📦 Dependencies

### Backend
- express@4.18.2
- cors@2.8.5
- uuid@9.0.0
- dotenv@16.0.3

### Flutter
- http@1.1.0

## ❌ Troubleshooting

### Backend won't start
- Check if port 3001 is already in use
- Try changing PORT in .env
- Ensure Node.js is installed: `node --version`

### Flutter app can't connect
- Verify backend is running
- Check network configuration in payment_service.dart
- For emulator: Use `10.0.2.2` not `localhost`
- Clear Flutter cache: `flutter clean`

### CORS errors
- Backend has CORS enabled
- Restart backend and Flutter app
- Clear browser cache if testing in web

## 🚀 Next Steps

1. ✅ Backend is set up
2. ✅ Payment service is ready
3. ⬜ Integrate into your payment screen
4. ⬜ Update payment button to use the service
5. ⬜ Test end-to-end payment flow
6. ⬜ Connect to real payment gateway (production)

## 🔒 Production Considerations

Before deploying to production:

1. **Database:** Replace in-memory storage with real database
2. **Payment Gateway:** Integrate with Stripe, Midtrans, or similar
3. **Authentication:** Add JWT tokens
4. **Validation:** Add comprehensive input validation
5. **Encryption:** Encrypt sensitive data
6. **Logging:** Add request/transaction logging
7. **Monitoring:** Set up error tracking
8. **HTTPS:** Enable SSL/TLS
9. **Rate Limiting:** Add rate limiting
10. **Testing:** Add comprehensive tests

## 📞 Support & Resources

- [Express.js Docs](https://expressjs.com/)
- [Flutter HTTP Package](https://pub.dev/packages/http)
- [REST API Best Practices](https://restfulapi.net/)

## 📝 File Checklist

- ✅ Backend Server (`payment-backend/server.js`)
- ✅ Package Configuration (`payment-backend/package.json`)
- ✅ Environment Template (`payment-backend/.env.example`)
- ✅ API Documentation (`payment-backend/README.md`)
- ✅ Setup Guide (`payment-backend/SETUP.md`)
- ✅ API Tests (`payment-backend/api-test.http`)
- ✅ Docker Setup (`payment-backend/docker-compose.yml`)
- ✅ Docker Image (`payment-backend/Dockerfile`)
- ✅ Flutter Service (`flutter_final_project_kintkin/lib/services/payment_service.dart`)
- ✅ Example Widget (`flutter_final_project_kintkin/lib/widgets/payment_example_widget.dart`)
- ✅ Integration Guide (`PAYMENT_INTEGRATION_GUIDE.md`)
- ✅ This README

## 🎉 You're All Set!

Your payment backend is ready to use. Start with the setup guide and refer to the documentation as needed.

Happy coding! 🚀
