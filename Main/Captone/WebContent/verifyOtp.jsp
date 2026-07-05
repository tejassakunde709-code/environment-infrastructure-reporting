<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
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

        .verify-container {
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

        .verify-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .verify-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.4);
            animation: pulse 2s ease infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 10px 30px rgba(79, 172, 254, 0.4);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 15px 40px rgba(79, 172, 254, 0.6);
            }
        }

        .verify-icon i {
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

        .error {
            background: linear-gradient(135deg, #ff6b6b, #ee5a6f);
            color: white;
            text-align: center;
            padding: 12px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            animation: shake 0.5s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }

        .error i {
            font-size: 16px;
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
            font-size: 18px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            background: white;
            color: #2d3748;
            letter-spacing: 4px;
            text-align: center;
        }

        input:focus {
            outline: none;
            border-color: #4facfe;
            box-shadow: 0 0 0 4px rgba(79, 172, 254, 0.1);
        }

        input:focus + .input-icon {
            color: #4facfe;
        }

        input::placeholder {
            color: #cbd5e0;
            letter-spacing: normal;
        }

        button {
            width: 100%;
            padding: 15px;
            margin: 0;
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.4);
            font-family: 'Poppins', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(79, 172, 254, 0.6);
            background: linear-gradient(135deg, #5fb7ff, #10f7ff);
        }

        button:active {
            transform: translateY(0);
        }

        button i {
            font-size: 18px;
        }

        .info-box {
            background: linear-gradient(135deg, rgba(79, 172, 254, 0.1), rgba(0, 242, 254, 0.1));
            border-left: 4px solid #4facfe;
            padding: 15px 18px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .info-box i {
            color: #4facfe;
            font-size: 18px;
            margin-top: 2px;
        }

        .info-box p {
            color: #4a5568;
            font-size: 13px;
            margin: 0;
            line-height: 1.6;
        }

        .resend-section {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #e2e8f0;
        }

        .resend-text {
            color: #718096;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .resend-link {
            color: #4facfe;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .resend-link:hover {
            color: #00f2fe;
            text-decoration: underline;
        }

        .resend-link i {
            font-size: 12px;
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
            background: #4facfe;
            top: -50px;
            right: -50px;
        }

        .decoration-2 {
            width: 60px;
            height: 60px;
            background: #00f2fe;
            bottom: -30px;
            left: -30px;
        }

        /* Responsive */
        @media (max-width: 480px) {
            .verify-container {
                width: 90%;
                padding: 40px 30px;
                margin: 20px;
            }
            
            h2 {
                font-size: 24px;
            }
            
            .verify-icon {
                width: 70px;
                height: 70px;
            }
            
            .verify-icon i {
                font-size: 30px;
            }
        }
    </style>
</head>
<body>
<div class="verify-container">
    <div class="decoration decoration-1"></div>
    <div class="decoration decoration-2"></div>
    
    <div class="verify-header">
        <div class="verify-icon">
            <i class="fas fa-envelope-open-text"></i>
        </div>
        <h2>Verify OTP</h2>
        <p class="subtitle">Enter the verification code sent to your email</p>
    </div>
    
    <% if(request.getAttribute("error") != null) { %>
        <p class="error">
            <i class="fas fa-exclamation-circle"></i>
            <%= request.getAttribute("error") %>
        </p>
    <% } %>
    
    <div class="info-box">
        <i class="fas fa-info-circle"></i>
        <p>We've sent a 6-digit verification code to your registered email address. Please check your inbox and spam folder.</p>
    </div>
    
    <form action="VerifyOtpServlet" method="post">
        <div class="input-group">
            <div class="input-wrapper">
                <input type="text" name="otp" placeholder="Enter OTP" maxlength="6" required>
                <i class="fas fa-key input-icon"></i>
            </div>
        </div>
        
        <button type="submit">
            <i class="fas fa-check-circle"></i>
            Verify OTP
        </button>
    </form>
    
    <div class="resend-section">
        <p class="resend-text">Didn't receive the code?</p>
        <a href="#" class="resend-link">
            <i class="fas fa-redo"></i>
            Resend OTP
        </a>
    </div>
</div>
</body>
</html>