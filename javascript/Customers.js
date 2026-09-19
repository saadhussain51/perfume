async function fetchCustomers() {
    try {
        const response = await fetch('http://localhost:3000/api/customers');

        if (!response.ok) {
            throw new Error(`HTTP Error: ${response.status}`);
        }

        const orders = await response.json();
        console.log("✅ Orders received (Frontend):", orders);

        const tableBody = document.getElementById('orderTableBody');
        tableBody.innerHTML = ""; // Clear previous rows

        if (!Array.isArray(orders)) {
            throw new Error("❌ Invalid API response: Not an array");
        }

        orders.forEach(order => {
            const totalOrders = order.TOTALORDERS;
            const isZeroOrNull = totalOrders === 0 || totalOrders === null;
            const row = `<tr style="${isZeroOrNull ? 'background-color: red; color: white;' : ''}">
                <td>${order.CUSTOMERID ?? "N/A"}</td>
                <td>${order.CUSTOMERNAME ?? "N/A"}</td>
                <td>${order.PHONE ?? "N/A"}</td>
                <td>${order.CUSTOMERADDRESS ?? "N/A"}</td>
                <td>${order.ACCOUNTCREATIONDATE ?? "N/A"}</td>
                <td>${order.TOTALORDERS?? "N/A"}</td>
            </tr>`;
            tableBody.innerHTML += row;
        });


    } catch (error) {
        console.error("❌ Error fetching orders:", error.message);
        alert(`Failed to fetch orders! ${error.message}`);
    }
}

