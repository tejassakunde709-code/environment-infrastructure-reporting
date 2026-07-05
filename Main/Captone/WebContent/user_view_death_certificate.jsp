<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Death Certificate - Gram Panchayat</title>
    
    <!-- Modern Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --theme-dark: #334155;
            --theme-darker: #1e293b;
            --bg-body: #f3f4f6;
            --bg-card: #ffffff;
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
            --input-focus: #e2e8f0;
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
            color: var(--theme-darker);
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
            background: #f1f5f9;
            color: var(--theme-dark);
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
            border-color: var(--theme-dark);
            box-shadow: 0 0 0 4px var(--input-focus);
        }

        /* Buttons */
        .btn-search {
            background-color: var(--theme-darker);
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
            background-color: #0f172a;
            color: white;
            transform: translateY(-2px);
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
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }
        
        .status-badge.approved { background: #d1fae5; color: #059669; }
        .status-badge.pending { background: #fef3c7; color: #d97706; }

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
                <i class="fas fa-search-location"></i>
            </div>
            <h3>Track Death Certificate</h3>
            <p class="subtitle">Check your application status or download certificate</p>
        </div>

        <form method="GET">
            <div class="input-group-custom">
                <i class="fas fa-file-invoice input-icon"></i>
                <input type="text" name="searchId" class="form-control" placeholder="Enter App ID (e.g., GP-DTH-...)" 
                       value="<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>" required>
            </div>
            <button type="submit" class="btn btn-search">
                <i class="fas fa-search"></i> Search Application
            </button>
        </form>

        <% 
           // --- BACKEND LOGIC REMAINS EXACTLY THE SAME ---
           String searchId = request.getParameter("searchId");
           if(searchId != null && !searchId.trim().isEmpty()) {
               try {
                   Class.forName("com.mysql.jdbc.Driver"); 
                   Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone", "root", "");
                   PreparedStatement ps = con.prepareStatement("SELECT status FROM death_applications WHERE application_number=?");
                   ps.setString(1, searchId); 
                   ResultSet rs = ps.executeQuery();
                   
                   if(rs.next()) {
                       String status = rs.getString("status");
                       boolean isApproved = status.equalsIgnoreCase("Approved");
                       
                       // UI Output logic enhanced with modern classes
                       out.println("<div class='result-box'>");
                       out.println("<p class='text-muted mb-1' style='font-size:0.9rem;'>Status for <strong>" + searchId + "</strong></p>");
                       
                       if(isApproved) {
                           out.println("<div class='status-badge approved'><i class='fas fa-check-circle me-1'></i> " + status + "</div>");
                       } else {
                           out.println("<div class='status-badge pending'><i class='fas fa-clock me-1'></i> " + status + "</div>");
                       }
                       out.println("</div>");

                       if(isApproved) {
                           out.println("<a href='death_certificate.jsp?appId="+searchId+"' target='_blank' class='btn btn-print'>");
                           out.println("<i class='fas fa-download'></i> View / Download Certificate</a>");
                       }
                   } else { 
                       // Error Output
                       out.println("<div class='result-box error'>");
                       out.println("<i class='fas fa-exclamation-circle text-danger fs-3 mb-2'></i>");
                       out.println("<h5 class='text-danger mb-0'>Application Not Found</h5>");
                       out.println("<p class='text-muted mt-2 mb-0' style='font-size:0.85rem;'>Please verify your Application ID and try again.</p>");
                       out.println("</div>");
                   }
                   con.close();
               } catch(Exception e) {
                   // Optional: Print error details if needed
                   // out.println("<div class='alert alert-danger mt-3'>" + e.getMessage() + "</div>");
               }
           }
        %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>