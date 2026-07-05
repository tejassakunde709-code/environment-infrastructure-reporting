<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gram Panchayat Registration</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 20px;
    position: relative;
    overflow-x: hidden;
}

body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: 
        radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3), transparent 50%),
        radial-gradient(circle at 80% 80%, rgba(252, 70, 107, 0.3), transparent 50%),
        radial-gradient(circle at 40% 20%, rgba(99, 179, 237, 0.3), transparent 50%);
    animation: gradientMove 15s ease infinite;
}

@keyframes gradientMove {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.7; }
}

.container {
    width: 520px;
    max-width: 100%;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    padding: 45px 40px;
    border-radius: 24px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    position: relative;
    z-index: 1;
    border: 1px solid rgba(255, 255, 255, 0.3);
    animation: slideUp 0.6s ease;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.registration-header {
    text-align: center;
    margin-bottom: 35px;
}

.registration-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 20px;
    box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
    animation: pulse 2s ease infinite;
}

@keyframes pulse {
    0%, 100% {
        transform: scale(1);
        box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
    }
    50% {
        transform: scale(1.05);
        box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
    }
}

.registration-icon i {
    font-size: 36px;
    color: white;
}

h2 {
    color: #2d3748;
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 8px;
}

.subtitle {
    color: #718096;
    font-size: 14px;
    font-weight: 400;
}

.input-group {
    margin-bottom: 22px;
    position: relative;
}

label {
    font-weight: 600;
    display: block;
    margin-bottom: 8px;
    color: #2d3748;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 8px;
}

label i {
    color: #667eea;
    font-size: 14px;
}

.input-wrapper {
    position: relative;
}

.input-icon {
    position: absolute;
    left: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: #a0aec0;
    font-size: 16px;
    transition: color 0.3s ease;
}

input {
    width: 100%;
    padding: 13px 16px 13px 46px;
    border: 2px solid #e2e8f0;
    border-radius: 12px;
    font-size: 14px;
    font-family: 'Poppins', sans-serif;
    transition: all 0.3s ease;
    background: white;
    color: #2d3748;
}

input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
}

input:focus + .input-icon {
    color: #667eea;
}

input::placeholder {
    color: #cbd5e0;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

button {
    margin-top: 10px;
    width: 100%;
    padding: 15px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
    font-family: 'Poppins', sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 30px rgba(102, 126, 234, 0.6);
}

button:active {
    transform: translateY(0);
}

button i {
    font-size: 18px;
}

.footer-text {
    text-align: center;
    margin-top: 25px;
    color: #718096;
    font-size: 13px;
}

.footer-text a {
    color: #667eea;
    text-decoration: none;
    font-weight: 600;
}

.footer-text a:hover {
    text-decoration: underline;
}

/* Decorative Elements */
.decoration {
    position: absolute;
    border-radius: 50%;
    opacity: 0.1;
}

.decoration-1 {
    width: 120px;
    height: 120px;
    background: #667eea;
    top: -60px;
    right: -60px;
}

.decoration-2 {
    width: 80px;
    height: 80px;
    background: #764ba2;
    bottom: -40px;
    left: -40px;
}

.decoration-3 {
    width: 60px;
    height: 60px;
    background: #43e97b;
    top: 40%;
    right: -30px;
}

/* Success Animation */
@keyframes successPulse {
    0% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.05);
    }
    100% {
        transform: scale(1);
    }
}

/* Responsive */
@media (max-width: 600px) {
    .container {
        width: 95%;
        padding: 35px 25px;
    }
    
    h2 {
        font-size: 22px;
    }
    
    .form-row {
        grid-template-columns: 1fr;
        gap: 0;
    }
    
    .input-group {
        margin-bottom: 20px;
    }
    
    .registration-icon {
        width: 70px;
        height: 70px;
    }
    
    .registration-icon i {
        font-size: 30px;
    }
}
</style>
</head>
<body>
<div class="container">
    <div class="decoration decoration-1"></div>
    <div class="decoration decoration-2"></div>
    <div class="decoration decoration-3"></div>
    
    <div class="registration-header">
        <div class="registration-icon">
            <i class="fas fa-landmark"></i>
        </div>
        <h2>Gram Panchayat Registration</h2>
        <p class="subtitle">Register your Gram Panchayat to get started</p>
    </div>
    
    <form action="AdminRegisterServlet" method="post">
        <div class="input-group">
            <label>
                <i class="fas fa-building"></i>
                Gram Panchayat Name
            </label>
            <div class="input-wrapper">
                <input type="text" name="grampanchayat_name" placeholder="Enter Gram Panchayat name" required>
                <i class="fas fa-building input-icon"></i>
            </div>
        </div>
        
        <div class="input-group">
            <label>
                <i class="fas fa-envelope"></i>
                Email
            </label>
            <div class="input-wrapper">
                <input type="email" name="email" placeholder="Enter email address" required>
                <i class="fas fa-envelope input-icon"></i>
            </div>
        </div>
        
        <div class="input-group">
            <label>
                <i class="fas fa-lock"></i>
                Password
            </label>
            <div class="input-wrapper">
                <input type="password" name="password" placeholder="Create a strong password" required>
                <i class="fas fa-lock input-icon"></i>
            </div>
        </div>
        
        <div class="form-row">
            <div class="input-group">
                <label>
                    <i class="fas fa-map"></i>
                    State
                </label>
                <div class="input-wrapper">
                    <input type="text" name="state" placeholder="Enter state" required>
                    <i class="fas fa-map input-icon"></i>
                </div>
            </div>
            
            <div class="input-group">
                <label>
                    <i class="fas fa-map-marked-alt"></i>
                    District
                </label>
                <div class="input-wrapper">
                    <input type="text" name="district" placeholder="Enter district" required>
                    <i class="fas fa-map-marked-alt input-icon"></i>
                </div>
            </div>
        </div>
        
        <div class="input-group">
            <label>
                <i class="fas fa-map-marker-alt"></i>
                Village
            </label>
            <div class="input-wrapper">
                <input type="text" name="village" placeholder="Enter village name" required>
                <i class="fas fa-map-marker-alt input-icon"></i>
            </div>
        </div>
        
        <button type="submit">
            <i class="fas fa-user-plus"></i>
            Register
        </button>
    </form>
    
    <div class="footer-text">
        Already registered? <a href="adminLogin.jsp">Login here</a>
    </div>
</div>
</body>
</html>