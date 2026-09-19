async function fetchCompletedOrders() {
    try {
        const response = await fetch('http://localhost:3000/api/orderc');

        if (!response.ok) {
            throw new Error(`HTTP Error: ${response.status}`);
        }

        const orders = await response.json();
        console.log("✅ Orders received (Frontend):", orders);

        const tableBody = document.getElementById('orderTableBody');
        // tableBody.innerHTML = ""; // Clear previous rows

        if (!Array.isArray(orders)) {
            throw new Error("❌ Invalid API response: Not an array");
        }

        orders.forEach(order => {
            const row = `<tr>
                <td>${order.CUSTOMERID ?? "N/A"}</td>
                <td>${order.Customer_Name ?? "N/A"}</td>
                <td>${order.ORDERID ?? "N/A"}</td>
                <td>${order.PERFUMENAME ?? "N/A"}</td>
                <td>${order.ORDER_DATE ?? "N/A"}</td>
                <td>${order.ORDER_DATE?? "N/A"}</td>
                <td>${order.UNITPRICE ?? "N/A"}</td>
                <td>${order.ORDEREDQUANTITY ?? "N/A"}</td>
                <td>${order.TotalPrice ?? "N/A"}</td>
                <td> ${order.PAYMENTDATE ?? "N/A"}</td>
                <td>
                    <button class="order-status-dropdown view-receipt" onclick="viewReceipt('${order.ORDERID}')">View</button>
                </td>

            </tr>`;
            tableBody.innerHTML += row;
        });

    } catch (error) {
        console.error("❌ Error fetching orders:", error.message);
        alert(`Failed to fetch orders! ${error.message}`);
    }
}

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