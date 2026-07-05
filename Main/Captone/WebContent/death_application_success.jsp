<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Application Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f4f7f6; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
        .card { padding: 40px; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); text-align: center; }
        .app-id { background: #e9ecef; border: 2px dashed #343a40; padding: 20px; font-size: 1.8rem; font-weight: bold; color: #343a40; margin: 20px 0; }
        .hint-box { background: #fff3cd; border-left: 5px solid #ffc107; padding: 15px; text-align: left; }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center">
    <div class="card col-md-8">
        <h2 class="text-dark">Application Successful!</h2>
        <p>Your application is submitted and is currently <b>Pending Approval</b>.</p>
        <div class="app-id" id="appId"><%= request.getAttribute("applicationId") %></div>
        <div class="hint-box"><b>📸 IMPORTANT:</b> Copy or screenshot this Application ID. You will need it to track your status and download the certificate.</div>
        <div class="mt-4">
            <button onclick="navigator.clipboard.writeText(document.getElementById('appId').innerText); alert('Copied!');" class="btn btn-outline-dark">Copy ID</button>
            <a href="user_view_death_certificate.jsp" class="btn btn-dark">Track Status</a>
        </div>
    </div>
</div>
</body>
</html>