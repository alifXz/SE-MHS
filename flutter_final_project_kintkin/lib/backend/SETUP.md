# Payment Backend Setup Guide

## 📋 Prerequisites

- Node.js 16+ installed
- npm or yarn package manager
- Flutter SDK (for the mobile app)
- Git (optional but recommended)

## 🚀 Quick Start

### Step 1: Navigate to Backend Directory

```bash
cd "SE-MHS/payment-backend"
```

### Step 2: Install Dependencies

```bash
npm install
```

This will install:
- `express` - Web framework
- `cors` - Cross-origin resource sharing
- `uuid` - Unique ID generator
- `dotenv` - Environment variable management

### Step 3: Start the Backend

```bash
npm start
```

You should see:
```
Payment backend running on http://localhost:3001
Available endpoints:
  POST   /api/payments/initiate
  POST   /api/payments/process
  GET    /api/payments/:transactionId
  GET    /api/payments/user/:userId
  POST   /api/payments/:transactionId/cancel
  GET    /api/admin/transactions
```

## ✅ Verify Backend is Running

Open your browser and navigate to:
```
http://localhost:3001/api/health
```

You should see:
```json
{
  "status": "Payment backend is running"
}
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the backend folder:

```env
PORT=3001
NODE_ENV=development
```

Available options:
- `PORT` - Server port (default: 3001)
- `NODE_ENV` - Environment mode (development/production)

## 📱 Flutter Integration

### Step 1: Update Payment Service

The `payment_service.dart` is already created in your Flutter project at:
```
SE-MHS/flutter_final_project_kintkin/lib/services/payment_service.dart
```

### Step 2: Network Configuration

Depending on your development setup, update the base URL in `payment_service.dart`:

#### For Android Emulator:
```dart
static const String _baseUrl = 'http://10.0.2.2:3001/api';
```

#### For iOS Simulator:
```dart
static const String _baseUrl = 'http://localhost:3001/api';
```

#### For Physical Device:
Find your machine's IP address and replace:
```dart
static const String _baseUrl = 'http://192.168.X.X:3001/api';
```

### Step 3: Add http Package to pubspec.yaml

If not already added, add the http package to your Flutter project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

Then run:
```bash
flutter pub get
```

### Step 4: Update Your Payment Screen

See `PAYMENT_INTEGRATION_GUIDE.md` for code examples to integrate payment processing into your payment screen.

## 🧪 Testing Endpoints

### Using cURL

Test health endpoint:
```bash
curl http://localhost:3001/api/health
```

Test payment initiation:
```bash
curl -X POST http://localhost:3001/api/payments/initiate \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 60000,
    "paymentMethod": "gopay",
    "userId": "user123"
  }'
```

### Using VS Code REST Client Extension

1. Install the "REST Client" extension in VS Code
2. Open `api-test.http` file in the backend folder
3. Click "Send Request" above each request to test

### Using Postman

1. Import the requests from `api-test.http`
2. Create requests for each endpoint
3. Test with different payloads

## 📚 API Documentation

For complete API documentation, see `README.md` in the payment-backend folder.

## 🐳 Using Docker (Optional)

### Run with Docker Compose

```bash
docker-compose up
```

Backend will be available at `http://localhost:3001`

### Run with Docker

Build image:
```bash
docker build -t payment-backend .
```

Run container:
```bash
docker run -p 3001:3001 payment-backend
```

## ❌ Troubleshooting

### Backend won't start

**Error:** `Port 3001 already in use`
```bash
# Kill the process using port 3001
# On Windows:
netstat -ano | findstr :3001
taskkill /PID <PID> /F

# On macOS/Linux:
lsof -ti:3001 | xargs kill -9
```

**Solution:** Change the port in `.env`:
```env
PORT=3002
```

### Flutter app can't connect to backend

1. Ensure backend is running: `http://localhost:3001/api/health`
2. Check network configuration in `payment_service.dart`
3. Check firewall settings on your machine
4. For emulator: Ensure you're using `10.0.2.2` not `localhost`

### CORS errors

The backend has CORS enabled for all origins. If you still get CORS errors:
1. Clear Flutter app cache
2. Restart backend
3. Rebuild Flutter app: `flutter clean && flutter pub get`

## 🔄 Development Workflow

### Terminal 1: Run Backend
```bash
cd SE-MHS/payment-backend
npm start
```

### Terminal 2: Run Flutter App
```bash
cd SE-MHS/flutter_final_project_kintkin
flutter run
```

## 📦 Project Structure

```
SE-MHS/
├── payment-backend/          # Backend server
│   ├── server.js             # Main server file
│   ├── package.json          # Dependencies
│   ├── .env.example          # Environment template
│   ├── README.md             # Backend documentation
│   ├── docker-compose.yml    # Docker setup
│   ├── Dockerfile            # Docker image
│   └── api-test.http         # API test requests
│
├── flutter_final_project_kintkin/  # Flutter app
│   └── lib/
│       ├── services/
│       │   └── payment_service.dart  # Payment API client
│       └── Pages/
│           └── payment_screen.dart   # Payment UI
│
└── PAYMENT_INTEGRATION_GUIDE.md    # Integration guide
```

## 🚀 Next Steps

1. ✅ Backend setup complete
2. ✅ Payment service created
3. ⬜ Integrate into payment screen
4. ⬜ Test end-to-end flow
5. ⬜ Production deployment

## 📖 More Resources

- [Express.js Documentation](https://expressjs.com/)
- [Flutter HTTP Package](https://pub.dev/packages/http)
- [REST API Best Practices](https://restfulapi.net/)

## 💬 Support

For issues or questions:
1. Check the README.md in payment-backend folder
2. See PAYMENT_INTEGRATION_GUIDE.md for code examples
3. Review the API endpoints documentation
4. Check troubleshooting section above

## 📝 Notes

- This backend uses in-memory storage (not persistent)
- For production, integrate a real database (MySQL, PostgreSQL, MongoDB)
- Payment processing is simulated (70% success rate for demo)
- For real payments, integrate with payment providers (Stripe, Midtrans)
