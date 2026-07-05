<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Submitted Successfully</title>
    <!-- Bootstrap CSS for modern UI -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f4f7f6; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            min-height: 100vh;
            margin: 0;
        }
        .success-card {
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0px 10px 30px rgba(0,0,0,0.1);
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        .success-icon {
            font-size: 80px;
            color: #28a745;
            margin-bottom: 20px;
        }
        .app-id-container {
            background-color: #e9ecef;
            border: 2px dashed #0d6efd;
            border-radius: 8px;
            padding: 20px;
            margin: 25px 0;
        }
        .app-id-label {
            font-size: 1rem;
            color: #6c757d;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .app-id-value {
            font-size: 1.8rem;
            font-weight: bold;
            color: #0d6efd;
            word-break: break-all;
        }
        .hint-box {
            background-color: #fff3cd;
            border-left: 5px solid #ffc107;
            color: #856404;
            padding: 15px;
            margin-bottom: 30px;
            border-radius: 4px;
            text-align: left;
            font-size: 0.95rem;
        }
        .btn-custom {
            padding: 10px 30px;
            font-size: 1.1rem;
            border-radius: 50px;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="success-card">
        
        <!-- Success Icon -->
        <div class="success-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-check-circle-fill" viewBox="0 0 16 16">
              <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
            </svg>
        </div>
        
        <h2 class="text-success mb-3">Application Successful!</h2>
        <p class="text-muted">Your application for the Birth Certificate has been successfully registered with the Gram Panchayat.</p>
        
        <!-- Application ID Box -->
        <div class="app-id-container">
            <div class="app-id-label">Your Application ID</div>
            <div class="app-id-value" id="appIdText">
                <!-- Grabbing the ID passed from the Servlet -->
                <%= request.getAttribute("applicationId") != null ? request.getAttribute("applicationId") : "ERROR-ID-NOT-FOUND" %>
            </div>
        </div>

        <!-- Important Hint Box -->
        <div class="hint-box">
            <strong>📸 IMPORTANT:</strong> Please <b>copy</b> this Application ID, write it down, or <b>take a photo/screenshot</b> of this page right now. You will need this ID to track your application status or download your certificate in the future.
        </div>

        <!-- Buttons -->
        <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
            <button onclick="copyAppId()" class="btn btn-outline-primary btn-custom">Copy Application ID</button>
            <!-- Note: Change 'birth_registration.jsp' below to the actual name of your home/form page -->
            <a href="birth_registration.jsp" class="btn btn-primary btn-custom">Return to Home</a>
        </div>

    </div>
</div>

<!-- Simple Script to copy the Application ID to Clipboard -->
<script>
    function copyAppId() {
        var appId = document.getElementById("appIdText").innerText.trim();
        navigator.clipboard.writeText(appId).then(function() {
            alert("Application ID copied to clipboard: " + appId);
        }, function(err) {
            alert("Failed to copy text. Please write it down manually.");
        });
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>