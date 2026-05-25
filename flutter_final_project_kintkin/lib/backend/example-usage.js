// Example: How to use the payment API from a mobile app

const API_BASE = 'http://localhost:3000/api';

// Step 1: Create an order
async function createOrder(amount, description) {
  const response = await fetch(`${API_BASE}/orders`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      amount,
      currency: 'USD',
      description,
    }),
  });
  return response.json();
}

// Step 2: Process payment
async function processPayment(orderId, cardToken) {
  const response = await fetch(`${API_BASE}/orders/${orderId}/pay`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      cardToken,
    }),
  });
  return response.json();
}

// Step 3: Check order status
async function getOrderStatus(orderId) {
  const response = await fetch(`${API_BASE}/orders/${orderId}`);
  return response.json();
}

// Example usage:
async function checkout(amount, cardToken) {
  try {
    // Create order
    const order = await createOrder(amount, 'Mobile app purchase');
    console.log('Order created:', order.id);

    // Process payment
    const result = await processPayment(order.id, cardToken);

    if (result.success) {
      console.log('Payment successful!', result.order.transactionId);
    } else {
      console.log('Payment failed:', result.error);
    }

    // Check status
    const status = await getOrderStatus(order.id);
    console.log('Order status:', status.status);
  } catch (error) {
    console.error('Error:', error);
  }
}

// Usage:
// checkout(99.99, 'tok_test_123');
