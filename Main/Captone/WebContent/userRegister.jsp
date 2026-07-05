<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Gram Panchayat Portal</title>
    <!-- Modern Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-hover: #1d4ed8;
            --bg-color: #f3f4f6;
            --card-bg: #ffffff;
            --text-dark: #1f2937;
            --text-muted: #6b7280;
            --border-color: #d1d5db;
            --input-focus: #bfdbfe;
            --error-bg: #fef2f2;
            --error-text: #ef4444;
            --error-border: #fca5a5;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            background-image: radial-gradient(#cbd5e1 1px, transparent 1px);
            background-size: 30px 30px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }

        .register-wrapper {
            width: 100%;
            max-width: 480px;
            position: relative;
        }

        .back-home {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 1rem;
            transition: color 0.2s ease;
        }

        .back-home:hover {
            color: var(--primary-blue);
        }

        .register-card {
            background: var(--card-bg);
            padding: 2.5rem;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            border: 1px solid rgba(255, 255, 255, 0.5);
        }

        .card-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .icon-circle {
            width: 60px;
            height: 60px;
            background: #eff6ff;
            color: var(--primary-blue);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin: 0 auto 1rem;
        }

        .card-header h2 {
            color: var(--text-dark);
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }

        .card-header p {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .error-alert {
            background: var(--error-bg);
            border: 1px solid var(--error-border);
            color: var(--error-text);
            padding: 0.75rem 1rem;
            border-radius: 8px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
        }

        .input-group {
            margin-bottom: 1.25rem;
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 1rem;
            transition: color 0.3s ease;
            pointer-events: none;
        }

        .input-group input {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 2.75rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.95rem;
            color: var(--text-dark);
            transition: all 0.2s ease;
            background-color: #fff;
            outline: none;
        }

        .input-group input::placeholder {
            color: #9ca3af;
        }

        .input-group input:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px var(--input-focus);
        }

        .input-group input:focus + .input-icon {
            color: var(--primary-blue);
        }

        .submit-btn {
            width: 100%;
            background: var(--primary-blue);
            color: white;
            border: none;
            padding: 0.875rem;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }

        .submit-btn:hover {
            background: var(--primary-hover);
        }

        .submit-btn:active {
            transform: scale(0.98);
        }

        .footer-text {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.95rem;
            color: var(--text-muted);
        }

        .footer-text a {
            color: var(--primary-blue);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }

        .footer-text a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .register-card {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>

<div class="register-wrapper">
    <!-- Back to Home Button -->
    <a href="index.jsp" class="back-home">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>

    <div class="register-card">
        <div class="card-header">
            <div class="icon-circle">
                <i class="fas fa-user-plus"></i>
            </div>
            <h2>Create an Account</h2>
            <p>Join the Gram Panchayat portal today</p>
        </div>
        
        <!-- Error Handling Logic (Untouched) -->
        <% if(request.getAttribute("error") != null) { %>
            <div class="error-alert">
                <i class="fas fa-exclamation-circle"></i>
                <span><%= request.getAttribute("error") %></span>
            </div>
        <% } %>
        
        <!-- Registration Form (Action & Input names untouched) -->
        <form action="UserRegisterServlet" method="post">
            
            <div class="input-group">
                <input type="text" name="name" placeholder="Full Name" required>
                <i class="fas fa-user input-icon"></i>
            </div>
            
            <div class="input-group">
                <input type="email" name="email" placeholder="Email Address" required>
                <i class="fas fa-envelope input-icon"></i>
            </div>
            
            <div class="input-group">
                <input type="text" name="mobile" placeholder="Mobile Number" required>
                <i class="fas fa-phone input-icon"></i>
            </div>
            
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
                <i class="fas fa-lock input-icon"></i>
            </div>
            
            <div class="input-group">
                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                <i class="fas fa-check-circle input-icon"></i>
            </div>
            
            <button type="submit" class="submit-btn">
                Create Account
                <i class="fas fa-arrow-right" style="font-size: 0.85rem; margin-left: 4px;"></i>
            </button>
        </form>
        
        <p class="footer-text">
            Already have an account? <a href="userSignin.jsp">Sign In</a>
        </p>
    </div>
</div>

</body>
</html>