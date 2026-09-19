document.getElementById("submitBtn").addEventListener("click", async () => {

  const perfume = {
    name: document.getElementById("perfumeName").value,
    description: document.getElementById("perfumeDescription").value,
    price: parseInt(document.getElementById("perfumePrice").value),
    stock: parseInt(document.getElementById("perfumeStock").value),
    imagePath: document.getElementById("imagePath").value,
    genderId: parseInt(document.getElementById("genderCategory").value),
    fragranceId: parseInt(document.getElementById("fragranceCategory").value)
  };
console.log(perfume);
//   Basic validation
  if (!perfume.name || !perfume.description || !perfume.price || !perfume.stock || !perfume.imagePath || !perfume.genderId || !perfume.fragranceId) {
    alert("Please fill in all fields.");
    return;
  }

  try {
    const response = await fetch("http://localhost:3000/add-perfume", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(perfume)
    });

    const result = await response.json();
    if (result.success) {
      alert("Perfume added successfully!");
    } else {
      alert("Failed to add perfume: " + result.message);
    }
  } catch (error) {
    console.error("Error:", error);
    alert("An error occurred while adding perfume.");
  }
});
