const express = require('express');
const cors = require('cors');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors());
app.use(express.json());

// In-memory database for transactions and events (in production, use a real database)
const transactions = new Map();
const events = new Map();
const paymentMethods = ['bca', 'gopay', 'ovo', 'card'];

// Health check endpoint
app.get('/api/health', (req, res) => {
  res.json({ status: 'Payment backend is running' });
});

// Submit event data with payment
app.post('/api/events/submit', (req, res) => {
  try {
    const { eventName, location, time, date, amount, paymentMethod, userId } = req.body;

    // Validate event data
    if (!eventName || !location || !time || !date) {
      return res.status(400).json({
        success: false,
        message: 'Missing required event fields: eventName, location, time, date'
      });
    }

    // Validate payment data
    if (!amount || !paymentMethod || !userId) {
      return res.status(400).json({
        success: false,
        message: 'Missing required payment fields: amount, paymentMethod, userId'
      });
    }

    if (!paymentMethods.includes(paymentMethod)) {
      return res.status(400).json({
        success: false,
        message: `Invalid payment method. Allowed: ${paymentMethods.join(', ')}`
      });
    }

    // Create event record
    const eventId = uuidv4();
    const eventData = {
      id: eventId,
      eventName,
      location,
      time,
      date,
      createdAt: new Date()
    };
    events.set(eventId, eventData);

    // Create transaction with event reference
    const transactionId = uuidv4();
    const transaction = {
      id: transactionId,
      userId,
      eventId,
      eventName,
      location,
      time,
      date,
      amount,
      paymentMethod,
      status: 'pending',
      createdAt: new Date(),
      updatedAt: new Date()
    };

    transactions.set(transactionId, transaction);

    res.json({
      success: true,
      message: 'Event and payment initiated successfully',
      data: {
        transactionId,
        eventId,
        eventName,
        location,
        time,
        date,
        amount,
        paymentMethod,
        status: 'pending'
      }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error submitting event and payment',
      error: error.message
    });
  }
});

// Initiate payment (legacy endpoint)
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
          paymentMethod: transaction.paymentMethod,
          eventId: transaction.eventId || null,
          eventDetails: transaction.eventId ? {
            eventName: transaction.eventName,
            location: transaction.location,
            time: transaction.time,
            date: transaction.date
          } : null
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

// Get event details
app.get('/api/events/:eventId', (req, res) => {
  try {
    const { eventId } = req.params;

    const event = events.get(eventId);
    if (!event) {
      return res.status(404).json({
        success: false,
        message: 'Event not found'
      });
    }

    res.json({
      success: true,
      data: event
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error retrieving event',
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

// Get all events (admin endpoint)
app.get('/api/admin/events', (req, res) => {
  try {
    const allEvents = Array.from(events.values());
    res.json({
      success: true,
      count: allEvents.length,
      data: allEvents
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error retrieving events',
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
  console.log(`Available endpoints:`);
  console.log(`  POST /api/events/submit - Submit event data with payment`);
  console.log(`  POST /api/payments/initiate - Initiate payment only`);
  console.log(`  POST /api/payments/process - Process payment`);
  console.log(`  GET /api/payments/:transactionId - Get transaction status`);
  console.log(`  GET /api/payments/user/:userId - Get user transactions`);
  console.log(`  GET /api/events/:eventId - Get event details`);
  console.log(`  GET /api/admin/transactions - Get all transactions`);
  console.log(`  GET /api/admin/events - Get all events`);
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
