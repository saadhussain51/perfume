document.addEventListener("DOMContentLoaded", function () {
    loadOrdersByCustomer();
    });

 async function loadOrdersByCustomer() {
  const customerID = localStorage.getItem('userID');
  if (!customerID) {
    alert("User not logged in");
    return;
  }

  try {
    const response = await fetch(`http://localhost:3000/api/orders?customerID=${customerID}`);
    const orders = await response.json();

    const container = document.getElementById('ordersContainer');
    container.innerHTML = ''; // Clear old data

    orders.forEach(order => {
      const orderDiv = document.createElement('div');
      orderDiv.className = 'order';
      orderDiv.innerHTML = `
        <img src="${order.PERFUMEIMAGE}" alt="${order.PERFUMENAME}">
        <div class="order-details">
          <div class="order-header">
            <span>${order.PERFUMENAME}</span>
            <span class="price">$${order.TOTALPRICE}</span>
          </div>
          <div class="order-description">${order.PERFUMEDESCRIPTION}</div>
          <div class="order-footer">
            <span class="status">${order.ORDERSTATUS}</span>
            <button onclick="viewReceipt('${order.ORDERID}')">View Receipt</button>
          </div>
        </div>
      `;
      container.appendChild(orderDiv);
    });
  } catch (err) {
    console.error("❌ Failed to load orders:", err);
    alert("Error loading orders.");
  }
}

document.addEventListener("DOMContentLoaded", function () {
  loadOrdersByCustomer();
});

async function viewReceipt(orderID) {
      try {
        const res = await fetch(`http://localhost:3000/api/receipt?orderID=${orderID}`);
        const data = await res.json();

        const content = `
          <p><strong>Order ID:</strong> ${data.ORDERID}</p>
          <p><strong>Order Date:</strong> ${data.ORDER_DATE}</p>
          <p><strong>Payment Method:</strong> ${data.PAYMENTMETHOD}</p>
          <p><strong>Status:</strong> ${data.ORDERSTATUS}</p>
          <p><strong>Perfume:</strong> ${data.PERFUMENAME}</p>
          <p><strong>Unit Price:</strong> $${data.UNITPRICE}</p>
          <p><strong>Quantity:</strong> ${data.ORDEREDQUANTITY}</p>
          <p><strong>Packaging:</strong> ${data.PACKAGINGTYPENAME}</p>
          <p><strong>Total:</strong> <strong>$${data.TOTALPRICE}</strong></p>
          <p><strong>Payment Date:</strong> ${data.PAYMENTDATE}</p>
        `;

        document.getElementById('receiptContent').innerHTML = content;
        document.getElementById('receiptPopup').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';

      } catch (err) {
        console.error("❌ Failed to fetch receipt:", err);
        alert("Error loading receipt.");
      }
    }

    function closeReceipt() {
      document.getElementById('receiptPopup').style.display = 'none';
      document.getElementById('overlay').style.display = 'none';
    }