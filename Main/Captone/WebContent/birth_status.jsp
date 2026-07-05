<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // --- BACKEND LOGIC REMAINS EXACTLY THE SAME ---
    
    // Get the application number from the form submission (if any)
    String searchAppNumber = request.getParameter("application_number");
    
    // Variables to hold retrieved data
    String applicationId = "";
    String applicationStatus = "";
    String childName = "";
    boolean recordFound = false;

    // Run database query only if an application number was submitted
    if (searchAppNumber != null && !searchAppNumber.trim().isEmpty()) {
        // Database credentials matching your screenshot (XAMPP/localhost defaults)
        String dbURL = "jdbc:mysql://localhost:3306/capstone";
        String dbUser = "root";
        String dbPassword = ""; // Assuming no password for local XAMPP/WAMP

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Fetch details for the specific application number entered by the user
            String query = "SELECT application_id, status, child_name FROM birth_applications WHERE application_number = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, searchAppNumber.trim());
            
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                recordFound = true;
                applicationId = rs.getString("application_id");
                applicationStatus = rs.getString("status");
                childName = rs.getString("child_name");
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<div style='text-align:center; padding:10px; background:#fef2f2; color:#ef4444; border-bottom:1px solid #fca5a5;'>Error connecting to database: " + e.getMessage() + "</div>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Birth Certificate - Gram Panchayat</title>
    
    <!-- Modern Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-dark: #1e3a8a;
            --primary-light: #eff6ff;
            --bg-body: #f3f4f6;
            --bg-card: #ffffff;
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
            --input-focus: #bfdbfe;
            --success-green: #10b981;
            --success-hover: #059669;
            --radius-lg: 16px;
            --shadow-lg: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
        }

        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-body);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }

        .tracking-wrapper {
            width: 100%;
            max-width: 550px;
            position: relative;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: var(--primary-blue);
        }

        .tracking-card {
            background: var(--bg-card);
            padding: 3rem 2.5rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header-section {
            text-align: center;
            margin-bottom: 2rem;
        }

        .icon-circle {
            width: 70px;
            height: 70px;
            background: var(--primary-light);
            color: var(--primary-blue);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1.2rem;
        }

        h3 {
            font-weight: 700;
            color: var(--text-main);
            font-size: 1.5rem;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
        }

        .subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        /* Input Styling */
        .input-group-custom {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            z-index: 10;
        }

        .form-control {
            padding: 0.875rem 1rem 0.875rem 2.75rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            color: var(--text-main);
            background-color: #f9fafb;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            background-color: #ffffff;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px var(--input-focus);
        }

        /* Buttons */
        .btn-search {
            background-color: var(--primary-blue);
            color: white;
            border: none;
            padding: 0.875rem;
            font-weight: 600;
            border-radius: 8px;
            width: 100%;
            font-size: 1rem;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-search:hover {
            background-color: var(--primary-dark);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
        }

        .btn-print {
            background-color: var(--success-green);
            color: white;
            border: none;
            padding: 0.875rem;
            font-weight: 600;
            border-radius: 8px;
            width: 100%;
            font-size: 1rem;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            margin-top: 1rem;
        }

        .btn-print:hover {
            background-color: var(--success-hover);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(16, 185, 129, 0.2);
        }

        /* Dynamic Result Boxes */
        .result-box {
            margin-top: 2rem;
            padding: 1.5rem;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background-color: #f8fafc;
            text-align: center;
            animation: fadeIn 0.3s ease-out;
        }
        
        .result-box.error {
            background-color: #fef2f2;
            border-color: #fecaca;
        }
        
        .status-badge {
            display: inline-block;
            padding: 0.5rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }
        
        .status-badge.approved { background: #d1fae5; color: #059669; border: 1px solid #a7f3d0; }
        .status-badge.pending { background: #fef3c7; color: #d97706; border: 1px solid #fde68a; }
        .status-badge.progress { background: #dbeafe; color: #1d4ed8; border: 1px solid #bfdbfe; }
        .status-badge.rejected { background: #fee2e2; color: #b91c1c; border: 1px solid #fecaca; }

        @media (max-width: 576px) {
            .tracking-card { padding: 2rem 1.5rem; }
        }
    </style>
</head>
<body>

<div class="tracking-wrapper">
    <!-- Back Navigation -->
    <a href="index.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>

    <div class="tracking-card">
        <div class="header-section">
            <div class="icon-circle">
                <i class="fas fa-baby"></i>
            </div>
            <h3>Track Birth Certificate</h3>
            <p class="subtitle">Check your application status or download certificate</p>
        </div>

        <form method="GET" action="birth_status.jsp">
            <div class="input-group-custom">
                <i class="fas fa-file-invoice input-icon"></i>
                <input type="text" class="form-control" id="application_number" name="application_number" 
                       value="<%= (searchAppNumber != null) ? searchAppNumber : "" %>" required
                       placeholder="Enter App ID (e.g., APP-12345)">
            </div>
            <button type="submit" class="btn btn-search">
                <i class="fas fa-search"></i> Search Application
            </button>
        </form>

        <!-- Display Results ONLY if a search was performed -->
        <% if (searchAppNumber != null && !searchAppNumber.trim().isEmpty()) { %>
            <div class="result-box <%= !recordFound ? "error" : "" %>">
                <% if (recordFound) { %>
                    
                    <p class="text-muted mb-2" style="font-size:0.95rem;">
                        Status for Child: <strong style="color: var(--text-main);"><%= (childName != null && !childName.isEmpty()) ? childName : "N/A" %></strong>
                    </p>

                    <!-- Status Rendering -->
                    <% if ("Approved".equalsIgnoreCase(applicationStatus)) { %>
                        <div class="status-badge approved"><i class="fas fa-check-circle me-1"></i> Approved</div>
                        <p class="text-muted mt-3 mb-0" style="font-size:0.85rem;">Your application has been approved! You can now view and print the official certificate.</p>
                        
                        <!-- THE EXACT SAME LINK LOGIC FROM YOUR ORIGINAL CODE -->
                        <a href="birth_certificate.jsp?id=<%= applicationId %>" target="_blank" class="btn btn-print">
                            <i class="fas fa-download"></i> View / Print Certificate
                        </a>

                    <% } else if ("Pending".equalsIgnoreCase(applicationStatus)) { %>
                        <div class="status-badge pending"><i class="fas fa-clock me-1"></i> Pending</div>
                        <p class="text-muted mt-3 mb-0" style="font-size:0.85rem;"><i class="fas fa-info-circle text-warning"></i> This application is currently waiting to be reviewed.</p>

                    <% } else if ("In Progress".equalsIgnoreCase(applicationStatus)) { %>
                        <div class="status-badge progress"><i class="fas fa-spinner fa-spin me-1"></i> In Progress</div>
                        <p class="text-muted mt-3 mb-0" style="font-size:0.85rem;"><i class="fas fa-info-circle text-primary"></i> This application is currently being processed by the Admin.</p>

                    <% } else if ("Rejected".equalsIgnoreCase(applicationStatus)) { %>
                        <div class="status-badge rejected"><i class="fas fa-times-circle me-1"></i> Rejected</div>
                        <p class="text-danger mt-3 mb-0" style="font-size:0.85rem;"><i class="fas fa-exclamation-triangle"></i> This application has been rejected. Please contact the Gram Panchayat.</p>

                    <% } else { %>
                        <div class="status-badge progress"><%= applicationStatus %></div>
                    <% } %>

                <% } else { %>
                    <!-- Error Output -->
                    <i class="fas fa-exclamation-circle text-danger fs-3 mb-2"></i>
                    <h5 class="text-danger mb-0">Application Not Found</h5>
                    <p class="text-muted mt-2 mb-0" style="font-size:0.85rem;">No record found for <strong><%= searchAppNumber %></strong>. Please check and try again.</p>
                <% } %>
            </div>
        <% } %>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>