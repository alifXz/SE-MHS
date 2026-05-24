const express = require('express');
const cors = require('cors');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors());
app.use(express.json());

// In-memory database for transactions (in production, use a real database)
const transactions = new Map();
const paymentMethods = ['bca', 'gopay', 'ovo', 'card'];

// Health check endpoint
app.get('/api/health', (req, res) => {
  res.json({ status: 'Payment backend is running' });
});

// Initiate payment
app.post('/api/payments/initiate', (req, res) => {
  try {
    const { amount, paymentMethod, userId, eventId } = req.body;

    // Validate input
    if (!amount || !paymentMethod || !userId) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: amount, paymentMethod, userId'
      });
    }

    if (!paymentMethods.includes(paymentMethod)) {
      return res.status(400).json({
        success: false,
        message: `Invalid payment method. Allowed: ${paymentMethods.join(', ')}`
      });
    }

    // Create transaction
    const transactionId = uuidv4();
    const transaction = {
      id: transactionId,
      userId,
      eventId: eventId || null,
      amount,
      paymentMethod,
      status: 'pending',
      createdAt: new Date(),
      updatedAt: new Date()
    };

    transactions.set(transactionId, transaction);

    res.json({
      success: true,
      message: 'Payment initiated successfully',
      data: {
        transactionId,
        amount,
        paymentMethod,
        status: 'pending'
      }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error initiating payment',
      error: error.message
    });
  }
});

// Process payment (simulate payment gateway)
app.post('/api/payments/process', (req, res) => {
  try {
    const { transactionId } = req.body;

    if (!transactionId) {
      return res.status(400).json({
        success: false,
        message: 'transactionId is required'
      });
    }

    const transaction = transactions.get(transactionId);
    if (!transaction) {
      return res.status(404).json({
        success: false,
        message: 'Transaction not found'
      });
    }

    // Simulate payment processing (70% success rate for demo)
    const isSuccess = Math.random() > 0.3;

    if (isSuccess) {
      transaction.status = 'completed';
      transaction.updatedAt = new Date();
      transactions.set(transactionId, transaction);

      res.json({
        success: true,
        message: 'Payment processed successfully',
        data: {
          transactionId,
          status: 'completed',
          amount: transaction.amount,
          paymentMethod: transaction.paymentMethod
        }
      });
    } else {
      transaction.status = 'failed';
      transaction.updatedAt = new Date();
      transactions.set(transactionId, transaction);

      res.status(400).json({
        success: false,
        message: 'Payment processing failed',
        data: {
          transactionId,
          status: 'failed'
        }
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error processing payment',
      error: error.message
    });
  }
});

// Get transaction status
app.get('/api/payments/:transactionId', (req, res) => {
  try {
    const { transactionId } = req.params;

    const transaction = transactions.get(transactionId);
    if (!transaction) {
      return res.status(404).json({
        success: false,
        message: 'Transaction not found'
      });
    }

    res.json({
      success: true,
      data: transaction
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error retrieving transaction',
      error: error.message
    });
  }
});

// Get user transactions
app.get('/api/payments/user/:userId', (req, res) => {
  try {
    const { userId } = req.params;

    const userTransactions = Array.from(transactions.values())
      .filter(t => t.userId === userId);

    res.json({
      success: true,
      data: userTransactions
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error retrieving transactions',
      error: error.message
    });
  }
});

// Cancel payment
app.post('/api/payments/:transactionId/cancel', (req, res) => {
  try {
    const { transactionId } = req.params;

    const transaction = transactions.get(transactionId);
    if (!transaction) {
      return res.status(404).json({
        success: false,
        message: 'Transaction not found'
      });
    }

    if (transaction.status !== 'pending') {
      return res.status(400).json({
        success: false,
        message: `Cannot cancel transaction with status: ${transaction.status}`
      });
    }

    transaction.status = 'cancelled';
    transaction.updatedAt = new Date();
    transactions.set(transactionId, transaction);

    res.json({
      success: true,
      message: 'Payment cancelled successfully',
      data: transaction
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error cancelling payment',
      error: error.message
    });
  }
});

// Get all transactions (admin endpoint)
app.get('/api/admin/transactions', (req, res) => {
  try {
    const allTransactions = Array.from(transactions.values());
    res.json({
      success: true,
      count: allTransactions.length,
      data: allTransactions
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error retrieving transactions',
      error: error.message
    });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: 'Internal server error',
    error: err.message
  });
});

app.listen(PORT, () => {
  console.log(`Payment backend running on http://localhost:${PORT}`);
  console.log('Available endpoints:');
  console.log('  POST   /api/payments/initiate');
  console.log('  POST   /api/payments/process');
  console.log('  GET    /api/payments/:transactionId');
  console.log('  GET    /api/payments/user/:userId');
  console.log('  POST   /api/payments/:transactionId/cancel');
  console.log('  GET    /api/admin/transactions');
});
