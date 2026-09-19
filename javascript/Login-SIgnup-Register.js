function setRole(role) {
  const managerFields = document.getElementById('managerIdGroup');
  const buttons = document.querySelectorAll('.role-btn');

  buttons.forEach(btn => btn.classList.remove('active'));

  if (role === 'customer') {
    managerFields.style.display = 'none';
    buttons[0].classList.add('active');
  } else {
    managerFields.style.display = 'flex';
    buttons[1].classList.add('active');
  }
}

function toggleRegister(show) {
  const modal = document.getElementById('registerModal');
  modal.style.display = show ? 'flex' : 'none';
}

function isValidEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

function customerLogin() {
  const username = document.querySelector('.login-box input[placeholder="Username"]').value.trim();
  const password = document.querySelector('.login-box input[placeholder="Password"]').value.trim();

  if (!isValidEmail(username)) {
    alert('Please enter a valid email address.');
    return;
  }

//   if (password.length < 8) {
//     alert('Password must be at least 8 characters long.');
//     return;
//   }

 fetch('http://localhost:3000/api/customer/login', {  // <-- Update this URL to the correct one
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ username, password })
})
.then(res => res.json())
.then(data => {
  if (data.success) {
    localStorage.setItem('userID', data.userId);
    console.log(data.userId);
    window.location.href = 'J..html';
  } else {
    alert(data.message || 'Login failed.');
  }
})
.catch(err => {
  console.error('Error:', err);
  alert('An error occurred during login.');
});

}

function managerLogin() {
  const managerId = document.getElementById('managerId').value.trim();
  const username = document.querySelector('.login-box input[placeholder="Username"]').value.trim();
  const password = document.querySelector('.login-box input[placeholder="Password"]').value.trim();

  if (!managerId) {
    alert('Please enter Manager ID.');
    return;
  }

  if (!isValidEmail(username)) {
    alert('Please enter a valid email address.');
    return;
  }

//   if (password.length < 8) {
//     alert('Password must be at least 8 characters long.');
//     return;
//   }

  fetch('http://localhost:3000/api/manager/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ managerId, username, password })
  })
    .then(res => res.json())
    .then(data => {
      if (data.success) {
        alert('Manager login successful!');
        console.log(data);
        window.location.href = 'Admin.html';
      } else {
        alert(data.message || 'Login failed.');
      }
    })
    .catch(err => {
      console.error('Error:', err);
      alert('An error occurred during login.');
    });
}

function register() {
  const inputs = document.querySelectorAll('#registerModal .input-group input');
  const username = inputs[0].value.trim();
  const password = inputs[1].value.trim();
  const confirmPassword = inputs[2].value.trim();

  if (!isValidEmail(username)) {
    alert('Please enter a valid email address.');
    return;
  }

  if (password.length < 8) {
    alert('Password must be at least 8 characters long.');
    return;
  }

  if (password !== confirmPassword) {
    alert('Passwords do not match.');
    return;
  }

  fetch('http://localhost:3000/api/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
  })
    .then(res => res.json())
    .then(data => {
      if (data.success) {
        alert('Registration successful!');
        console.log(data);
        toggleRegister(false);
      } else {
        alert(data.message || 'Registration failed.');
      }
    })
    .catch(err => {
      console.error('Error:', err);
      alert('An error occurred during registration.');
    });
}

// Handle login button click
document.querySelector('.login-box .login-btn').addEventListener('click', () => {
  const isManager = document.querySelector('.role-btn:nth-child(2)').classList.contains('active');
  if (isManager) {
    managerLogin();
  } else {
    customerLogin();
  }
});

// Handle register button in modal
document.querySelector('#registerModal .login-btn').addEventListener('click', register);

// Optional: Close modal if clicked outside
window.addEventListener('click', function (event) {
  const modal = document.getElementById('registerModal');
  if (event.target === modal) {
    toggleRegister(false);
  }
});