# Payment Backend

A simple Express.js backend for handling payments in the KinTkin Flutter application.

## Setup

1. Install dependencies:
```bash
npm install
```

2. Start the server:
```bash
npm start
```

The server will run on `http://localhost:3001`

## API Endpoints

### 1. Health Check
```
GET /api/health
```
Check if the backend is running.

**Response:**
```json
{
  "status": "Payment backend is running"
}
```

### 2. Initiate Payment
```
POST /api/payments/initiate
```

Initialize a new payment transaction.

**Request Body:**
```json
{
  "amount": 60000,
  "paymentMethod": "gopay",
  "userId": "user123",
  "eventId": "event456"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Payment initiated successfully",
  "data": {
    "transactionId": "uuid-here",
    "amount": 60000,
    "paymentMethod": "gopay",
    "status": "pending"
  }
}
```

### 3. Process Payment
```
POST /api/payments/process
```

Process the initiated payment (simulates payment gateway).

**Request Body:**
```json
{
  "transactionId": "uuid-from-initiate"
}
```

**Response (Success):**
```json
{
  "success": true,
  "message": "Payment processed successfully",
  "data": {
    "transactionId": "uuid-here",
    "status": "completed",
    "amount": 60000,
    "paymentMethod": "gopay"
  }
}
```

### 4. Get Transaction Status
```
GET /api/payments/:transactionId
```

Retrieve the status of a specific transaction.

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "uuid-here",
    "userId": "user123",
    "amount": 60000,
    "paymentMethod": "gopay",
    "status": "completed",
    "createdAt": "2024-05-22T...",
    "updatedAt": "2024-05-22T..."
  }
}
```

### 5. Get User Transactions
```
GET /api/payments/user/:userId
```

Retrieve all transactions for a specific user.

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "uuid1",
      "userId": "user123",
      "amount": 60000,
      "status": "completed",
      ...
    },
    ...
  ]
}
```

### 6. Cancel Payment
```
POST /api/payments/:transactionId/cancel
```

Cancel a pending payment transaction.

**Response:**
```json
{
  "success": true,
  "message": "Payment cancelled successfully",
  "data": {
    "id": "uuid-here",
    "status": "cancelled",
    ...
  }
}
```

### 7. Get All Transactions (Admin)
```
GET /api/admin/transactions
```

Retrieve all transactions in the system (admin endpoint).

## Supported Payment Methods
- `bca` - BCA Bank
- `gopay` - GoPay
- `ovo` - OVO
- `card` - Credit/Debit Card

## Architecture

- **Language:** Node.js with Express.js
- **Storage:** In-memory Map (for demo purposes)
- **CORS:** Enabled for Flutter app communication

## Future Enhancements

1. Add real database integration (MySQL, PostgreSQL)
2. Implement real payment gateway integration (Stripe, Midtrans)
3. Add authentication/authorization
4. Add request validation middleware
5. Add logging system
6. Add rate limiting
7. Add transaction webhooks
