// API: Get all products (no filters)
async function loadAllProducts() {
    try {
        const res = await fetch(`http://localhost:3000/api/products`);
        const products = await res.json();
        console.log("✅ All Products:", products);
        renderProducts(products);
    } catch (error) {
        console.error("❌ Error loading all products:", error);
    }
}


// document.addEventListener("DOMContentLoaded", function () {
//     loadAllProducts(); // Load all products once initially

//     // Add change listeners to gender and fragrance radios
//     document.querySelectorAll('input[name="gender"]').forEach(radio => {
//         radio.addEventListener('change', () => {
//             loadFilteredProducts(); // Load filtered products when radio changes
//         });
//     });

//     document.querySelectorAll('input[name="fragrance"]').forEach(radio => {
//         radio.addEventListener('change', () => {
//             loadFilteredProductsCategory(); // Load filtered products when radio changes
//         });
//     });

// });

document.addEventListener("DOMContentLoaded", function () {
    loadAllProducts(); // Initial load

    // Add change listeners to gender and fragrance radios
    document.querySelectorAll('input[name="gender"], input[name="fragrance"]').forEach(radio => {
        radio.addEventListener('change', handleFilterChange);
    });

    function handleFilterChange() {
        const selectedGender = document.querySelector('input[name="gender"]:checked');
        const selectedFragrance = document.querySelector('input[name="fragrance"]:checked');

        if (selectedGender && selectedFragrance) {
            loadFilteredProductsBoth(); // If both are selected
        } else if (selectedGender) {
            loadFilteredProducts(); // Only gender selected
        } else if (selectedFragrance) {
            loadFilteredProductsCategory(); // Only fragrance selected
        } else {
            loadAllProducts(); // None selected
        }
    }
});



document.addEventListener("DOMContentLoaded", function () {
    const productData = JSON.parse(sessionStorage.getItem('selectedProduct'));

    if (productData) {
        document.getElementById('perfumeID').value = productData.ID;
        document.getElementById('product').value = productData.NAME;
        document.getElementById('price').value = productData.PRICE;

        const quantityInput = document.getElementById('quantity');
        const totalInput = document.getElementById('total');
        const packagingSelect = document.getElementById('packagingType');

        function updateTotal() {
            const quantity = parseInt(quantityInput.value) || 0;

            // Determine packaging cost based on selected option
            let packagingCost = 0;
            const selectedOption = packagingSelect.options[packagingSelect.selectedIndex].text;

            if (selectedOption.includes("Classic")) {
                packagingCost = 0;
            } else if (selectedOption.includes("Gift")) {
                packagingCost = 500;
            } else if (selectedOption.includes("Signature")) {
                packagingCost = 1500;
            }

            const total = (productData.PRICE * quantity) + packagingCost;
            totalInput.value = total.toFixed(2);
        }

        quantityInput.addEventListener('input', updateTotal);
        packagingSelect.addEventListener('change', updateTotal);
    }
});


document.getElementById('orderForm').addEventListener('submit', async function (e) {
    e.preventDefault();

    const formData = new FormData(this);
    const orderData = {
        customerID: parseInt(formData.get('email')),
        perfumeID: parseInt(formData.get('perfumeID')), // corrected from 'perfumeId'
        packagingTypeID: parseInt(formData.get('packagingType')), // selected value (500, 1000, 1500)
        orderedQuantity: parseInt(formData.get('quantity')),
        firstName: formData.get('firstName'),
        lastName: formData.get('lastName'),
        phoneNumber: formData.get('phone'),
        street: parseInt(formData.get('street')),
        mohallah: formData.get('mohalla'),
        city: formData.get('city'),
        province: formData.get('province')
};

console.log(orderData);

    try {
        const response = await fetch('http://localhost:3000/place-order', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(orderData),
        });

        const result = await response.json();

        if (response.ok) {
            alert("Order successfully placed!");
            this.reset();
        } else {
            alert("Error placing the order: " + (result.error || "Unknown error"));
        }
    } catch (error) {
        console.error("Error placing the order:", error);
        alert("An error occurred while processing your order.");
    }
});



// API: Get filtered products by gender and fragrance
async function loadFilteredProducts() {
    const selectedGender = document.querySelector('input[name="gender"]:checked');
    const genderValue = selectedGender.value;


    const queryParams = new URLSearchParams();
    if (genderValue) queryParams.append('gender', genderValue);

    try {
        console.log(genderValue);
        const res = await fetch(`http://localhost:3000/api/perfumegender?${queryParams.toString()}`);
        const products = await res.json();
        console.log("✅ Filtered Products:", products);
        renderProducts(products);
    } catch (error) {
        console.error("❌ Error loading filtered products:", error);
    }
}

async function loadFilteredProductsCategory() {
    const selectedCategory = document.querySelector('input[name="fragrance"]:checked');
    const FragranceValue = selectedCategory.value;


    const queryParams = new URLSearchParams();
    if (FragranceValue) queryParams.append('fragrance', FragranceValue);

    try {
        console.log(FragranceValue);
        const res = await fetch(`http://localhost:3000/api/perfumefragrance?${queryParams.toString()}`);
        const products = await res.json();
        console.log("✅ Filtered Products:", products);
        renderProducts(products);
    } catch (error) {
        console.error("❌ Error loading filtered products:", error);
    }
}

function renderProducts(products) {
    const userID = localStorage.getItem('userID');
    console.log(userID);
    document.getElementById('customerIdValue').textContent = userID;
    const productContainer = document.querySelector('.product-container');
    productContainer.innerHTML = ""; // Clear existing

    products.forEach(product => {
        const productCard = document.createElement("div");
        productCard.classList.add("product-card");

        const PerfumeID = document.createElement("div");
        PerfumeID.classList.add("product-price");
        PerfumeID.innerHTML = product.PERFUMEID;

        const img = document.createElement("img");
        img.src = product.PERFUMEIMAGE;
        img.classList.add("product-image");

        const title = document.createElement("div");
        title.classList.add("product-title");
        title.innerText = product.PERFUMENAME;

        const description = document.createElement("div");
        description.classList.add("product-description");
        description.innerText = product.PERFUMEDESCRIPTION;

        const price = document.createElement("div");
        price.classList.add("product-price");
        price.innerHTML = product.PERFUMEPRICE;

        const buyNow = document.createElement("button");
        buyNow.classList.add("buy-now");
        buyNow.innerText = "Order Now";

        buyNow.onclick = () => {
            const productData = {
                ID: product.PERFUMEID,
                NAME: product.PERFUMENAME,
                PRICE: product.PERFUMEPRICE,
            };
            sessionStorage.setItem('selectedProduct', JSON.stringify(productData));
            window.location.href = "Order-Form.html";
        };

        if (product.PERFUMESTOCK === 0) {
            buyNow.innerText = "Out of Stock";
            buyNow.classList.add("disabled");
            buyNow.style.pointerEvents = "none";
        }

        productCard.appendChild(PerfumeID);
        productCard.appendChild(img);
        productCard.appendChild(title);
        productCard.appendChild(description);
        productCard.appendChild(price);
        productCard.appendChild(buyNow);
        productContainer.appendChild(productCard);
    });
}

function logout() {
    // Clear session/local storage if any (optional)
    localStorage.clear();
    window.location.href = "LoginSignup.html"; // Adjust path if needed
}

async function loadFilteredProductsBoth() {
    const selectedGender = document.querySelector('input[name="gender"]:checked');
    const genderValue = selectedGender.value;
    const selectedCategory = document.querySelector('input[name="fragrance"]:checked');
    const FragranceValue = selectedCategory.value;

    const queryParams = new URLSearchParams();
    if (genderValue && FragranceValue) {
        queryParams.append('gender', genderValue);
        queryParams.append('fragrance', FragranceValue)
    }

    try {
        console.log(genderValue);
        const res = await fetch(`http://localhost:3000/api/perfumegenderFragrance?${queryParams.toString()}`);
        const products = await res.json();
        console.log("✅ Filtered Products:", products);
        renderProducts(products);
    } catch (error) {
        console.error("❌ Error loading filtered products:", error);
    }
}
