document.addEventListener("DOMContentLoaded", () => {
  fetch("http://localhost:3000/api/dashboard")
    .then(res => res.json())
    .then(data => {
      // Metrics
      document.getElementById("totalRevenue").innerText = `$${data.totalRevenue}`;
      document.getElementById("totalOrders").innerText = data.totalOrders;
      document.getElementById("completedOrders").innerText = data.completedOrders;
      document.getElementById("incompletedOrders").innerText = data.incompletedOrders;
      document.getElementById("cancelledOrders").innerText = data.cancelledOrders;
      document.getElementById("avgOrderValue").innerText = `$${data.avgOrderValue}`;
      document.getElementById("totalPerfumes").innerText = data.totalPerfumes;
      document.getElementById("lowStock").innerText = data.lowStock;

      console.log(data);

      // Top Perfumes
      const perfumeBody = document.getElementById("topPerfumes");
      perfumeBody.innerHTML = ""; // Clear previous content
      data.topPerfumes.forEach(p => {
        const row = `<tr>
        <td>${p[0]}</td>
        <td>${p[1]}</td>
        <td>${p[2]}</td>
        </tr>`;
        perfumeBody.innerHTML += row;
      });

      // Top Customers
      const customerBody = document.getElementById("topCustomers");
      customerBody.innerHTML = "";
      data.topCustomers.forEach(c => {
        const row = `<tr>
        <td>${c[0]}</td>
        <td>${c[1]}</td>
        <td>$${c[2]}</td>
        </tr>`;
        customerBody.innerHTML += row;
      });

      // Top Cities
      const cityBody = document.getElementById("topCities");
      cityBody.innerHTML = "";
      data.topCities.forEach(city => {
        const row = `<tr><td>${city[0]}</td>
        <td>${city[1]}</td>
        </tr>`;
        cityBody.innerHTML += row;
      });
    })
    .catch(err => console.error("Dashboard Load Error:", err));
});
