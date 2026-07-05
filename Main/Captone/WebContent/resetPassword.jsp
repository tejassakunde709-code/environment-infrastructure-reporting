<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
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
            position: relative;
            overflow: hidden;
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

        .reset-container {
            width: 440px;
            max-width: 100%;
            padding: 50px 45px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            border-radius: 24px;
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

        .reset-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .reset-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #43e97b, #38f9d7);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 10px 30px rgba(67, 233, 123, 0.4);
            animation: pulse 2s ease infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 10px 30px rgba(67, 233, 123, 0.4);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 15px 40px rgba(67, 233, 123, 0.6);
            }
        }

        .reset-icon i {
            font-size: 36px;
            color: white;
        }

        h2 {
            color: #2d3748;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
            text-align: center;
        }

        .subtitle {
            color: #718096;
            font-size: 14px;
            font-weight: 400;
            text-align: center;
            line-height: 1.6;
        }

        form {
            text-align: left;
        }

        .input-group {
            margin-bottom: 25px;
            position: relative;
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
            padding: 14px 16px 14px 46px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            background: white;
            color: #2d3748;
        }

        input:focus {
            outline: none;
            border-color: #43e97b;
            box-shadow: 0 0 0 4px rgba(67, 233, 123, 0.1);
        }

        input:focus + .input-icon {
            color: #43e97b;
        }

        input::placeholder {
            color: #cbd5e0;
        }

        .password-strength {
            margin-top: 8px;
            font-size: 12px;
            color: #718096;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .password-strength i {
            font-size: 10px;
        }

        button {
            width: 100%;
            padding: 15px;
            margin-top: 10px;
            background: linear-gradient(135deg, #43e97b, #38f9d7);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(67, 233, 123, 0.4);
            font-family: 'Poppins', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(67, 233, 123, 0.6);
            background: linear-gradient(135deg, #52f188, #47fce0);
        }

        button:active {
            transform: translateY(0);
        }

        button i {
            font-size: 18px;
        }

        .info-box {
            background: linear-gradient(135deg, rgba(67, 233, 123, 0.1), rgba(56, 249, 215, 0.1));
            border-left: 4px solid #43e97b;
            padding: 15px 18px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .info-box i {
            color: #43e97b;
            font-size: 18px;
            margin-top: 2px;
        }

        .info-box p {
            color: #4a5568;
            font-size: 13px;
            margin: 0;
            line-height: 1.6;
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
            width: 100px;
            height: 100px;
            background: #43e97b;
            top: -50px;
            right: -50px;
        }

        .decoration-2 {
            width: 60px;
            height: 60px;
            background: #38f9d7;
            bottom: -30px;
            left: -30px;
        }

        /* Responsive */
        @media (max-width: 480px) {
            .reset-container {
                width: 90%;
                padding: 40px 30px;
                margin: 20px;
            }
            
            h2 {
                font-size: 24px;
            }
            
            .reset-icon {
                width: 70px;
                height: 70px;
            }
            
            .reset-icon i {
                font-size: 30px;
            }
        }
    </style>
</head>
<body>
<div class="reset-container">
    <div class="decoration decoration-1"></div>
    <div class="decoration decoration-2"></div>
    
    <div class="reset-header">
        <div class="reset-icon">
            <i class="fas fa-shield-alt"></i>
        </div>
        <h2>Reset Password</h2>
        <p class="subtitle">Create a strong new password for your account</p>
    </div>
    
    <div class="info-box">
        <i class="fas fa-info-circle"></i>
        <p>Your password should be at least 8 characters long and include a mix of letters, numbers, and special characters.</p>
    </div>
    
    <form action="ResetPasswordServlet" method="post">
        <div class="input-group">
            <div class="input-wrapper">
                <input type="password" name="password" placeholder="New Password" required>
                <i class="fas fa-lock input-icon"></i>
            </div>
            <div class="password-strength">
                <i class="fas fa-circle"></i>
                Use a strong password
            </div>
        </div>
        
        <div class="input-group">
            <div class="input-wrapper">
                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                <i class="fas fa-lock input-icon"></i>
            </div>
        </div>
        
        <button type="submit">
            <i class="fas fa-check-circle"></i>
            Reset Password
        </button>
    </form>
    
    <div class="footer-text">
        Remember your password? <a href="userSignin.jsp">Back to Login</a>
    </div>
</div>
</body>
</html>