async function fetchPerfumes() {
    try {
        const response = await fetch('http://localhost:3000/api/perfumes');

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
            // const row = `<tr>
          const quantityStr = order.Quantity ?? "0ml";
          const totalStock = Number(quantityStr.replace(/[^\d.]/g, '')); // removes 'ml', etc.
          const isLowStock = totalStock <= 500;

            console.log(isLowStock);
            const row = `<tr style="${isLowStock ? 'background-color: red; color: white;' : ''}">
                <td>${order.PERFUMEID ?? "N/A"}</td>
                <td>${order.PERFUMENAME ?? "N/A"}</td>
                <td>${order.PERFUMEDESCRIPTION ?? "N/A"}</td>
                <td>${order.PERFUMEPRICE ?? "N/A"}</td>
                <td>${order.Quantity ?? "N/A"}</td>
                <td>${order.CATEGORYNAME ?? "N/A"}</td>
                <td>${order.GENDERNAME ?? "N/A"}</td>
                <td>${order.LASTINGHOURS ?? "N/A"}</td>
            </tr>`;
            tableBody.innerHTML += row;
        });

    } catch (error) {
        console.error("❌ Error fetching orders:", error.message);
        alert(`Failed to fetch orders! ${error.message}`);
    }
}


