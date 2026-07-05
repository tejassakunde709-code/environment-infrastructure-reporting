<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Complaints - Gram Panchayat Portal</title>

    <!-- Modern Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Leaflet CSS & JS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-dark: #1e3a8a;
            --bg-body: #f3f4f6;
            --bg-card: #ffffff;
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
            --radius-md: 12px;
            --radius-lg: 16px;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-body);
            color: var(--text-main);
            padding: 2.5rem 1.5rem;
            min-height: 100vh;
        }

        .container { 
            max-width: 1000px; 
            margin: 0 auto; 
        }

        /* ✅ TOP BAR */
        .top-bar {
            background: var(--bg-card);
            padding: 1.25rem 2rem;
            border-radius: var(--radius-lg);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
        }

        .user-email {
            font-weight: 600;
            color: var(--text-main);
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-icon-circle {
            background: #eff6ff;
            color: var(--primary-blue);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }

        .top-actions {
            display: flex;
            gap: 12px;
        }

        .top-actions a {
            padding: 0.6rem 1.2rem;
            background: white;
            color: var(--text-main);
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s ease;
            border: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .top-actions a.primary-btn {
            background: var(--primary-blue);
            color: white;
            border-color: var(--primary-blue);
        }

        .top-actions a:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-2px);
        }

        .top-actions a.primary-btn:hover {
            background: var(--primary-dark);
        }

        /* ✅ COMPLAINT CARDS */
        .complaint-card {
            background: var(--bg-card);
            padding: 2rem;
            border-radius: var(--radius-lg);
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .complaint-card::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 5px;
            background-color: var(--primary-blue);
        }

        .complaint-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .card-header h3 {
            color: var(--text-main);
            font-size: 1.25rem;
            font-weight: 700;
        }

        .card-header .date {
            color: var(--text-muted);
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-bottom: 1.5rem;
        }

        th, td { 
            padding: 0.75rem 0; 
            border-bottom: 1px solid #f3f4f6; 
            text-align: left;
            vertical-align: top;
        }

        th {
            color: var(--text-muted);
            font-weight: 600;
            width: 25%;
            font-size: 0.9rem;
        }

        td {
            color: var(--text-main);
            font-size: 0.95rem;
            line-height: 1.5;
        }

        tr:last-child td,
        tr:last-child th {
            border-bottom: none;
        }

        /* ✅ STATUS BADGES */
        .status {
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending { background: #fef3c7; color: #d97706; }
        .status-progress { background: #dbeafe; color: #2563eb; }
        .status-resolved { background: #d1fae5; color: #059669; }

        /* ✅ MEDIA LAYOUT (Image + Map) */
        .media-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-top: 1rem;
        }

        .media-box {
            border-radius: var(--radius-md);
            overflow: hidden;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            height: 250px;
        }

        .complaint-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .complaint-img:hover {
            transform: scale(1.03);
        }

        .map {
            height: 100%;
            width: 100%;
            z-index: 1; /* Keep map controls beneath sticky headers */
        }

        /* ✅ BUTTONS */
        .admin-btn {
            margin-top: 1.5rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0.8rem 1.5rem;
            background: #f8fafc;
            color: var(--primary-dark);
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            border: 1px solid #cbd5e1;
            transition: all 0.2s ease;
        }

        .admin-btn:hover {
            background: #f1f5f9;
            border-color: #94a3b8;
            box-shadow: var(--shadow-sm);
        }

        @media (max-width: 768px) {
            .top-bar {
                flex-direction: column;
                gap: 15px;
                text-align: left;
                align-items: flex-start;
            }

            .top-actions {
                flex-direction: column;
                width: 100%;
            }

            .top-actions a {
                width: 100%;
                justify-content: center;
            }

            .media-grid {
                grid-template-columns: 1fr;
            }
            
            .complaint-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>

<body>
<div class="container">

    <!-- ✅ TOP BAR -->
    <div class="top-bar">
        <div class="user-email">
            <div class="user-icon-circle"><i class="fas fa-user"></i></div>
            <span>Logged in as: <strong><%= userEmail %></strong></span>
        </div>
        <div class="top-actions">
            <a href="demo.jsp"><i class="fas fa-home"></i> Dashboard</a>
            <a href="complaintRegister.jsp" class="primary-btn"><i class="fas fa-plus"></i> Report Issue</a>
        </div>
    </div>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/capstone?useSSL=false",
            "root", "");

        ps = con.prepareStatement(
            "SELECT * FROM complaints WHERE user_email=? ORDER BY created_at DESC");
        ps.setString(1, userEmail);
        rs = ps.executeQuery();

        while (rs.next()) {

            String id = rs.getString("id");
            String description = rs.getString("description");
            String latitude = rs.getString("latitude");
            String longitude = rs.getString("longitude");
            String address = rs.getString("address");
            String imageName = rs.getString("image_name");
            String status = rs.getString("status");
            String createdAt = rs.getString("created_at");

            // Status Styling Logic
            String statusClass = "status-pending";
            String statusIcon = "fa-clock";
            
            if ("In Progress".equalsIgnoreCase(status)) {
                statusClass = "status-progress";
                statusIcon = "fa-spinner fa-spin";
            }
            if ("Resolved".equalsIgnoreCase(status)) {
                statusClass = "status-resolved";
                statusIcon = "fa-check-circle";
            }
%>

    <div class="complaint-card">
        
        <div class="card-header">
            <h3>Complaint #<%= id %></h3>
            <div class="date"><i class="far fa-calendar-alt"></i> <%= createdAt %></div>
        </div>

        <table>
            <tr>
                <th><i class="fas fa-map-marker-alt" style="margin-right:6px;"></i> Address</th>
                <td><%= address %></td>
            </tr>
            <tr>
                <th><i class="fas fa-align-left" style="margin-right:6px;"></i> Description</th>
                <td><%= description %></td>
            </tr>
            <tr>
                <th><i class="fas fa-info-circle" style="margin-right:6px;"></i> Status</th>
                <td>
                    <span class="status <%= statusClass %>">
                        <i class="fas <%= statusIcon %>"></i> <%= status %>
                    </span>
                </td>
            </tr>
        </table>

        <!-- ✅ Clean Grid Layout for Image and Map -->
        <div class="media-grid">
            <% if (imageName != null && !imageName.isEmpty()) { %>
                <div class="media-box">
                    <img src="images/<%= imageName %>" class="complaint-img" alt="Complaint Evidence">
                </div>
            <% } %>
            
            <div class="media-box">
                <div id="map-<%= id %>" class="map"></div>
            </div>
        </div>

        <!-- ✅ Admin Response Button -->
        <% if ("In Progress".equalsIgnoreCase(status) || "Resolved".equalsIgnoreCase(status)) { %>
            <a href="viewAdminResponse.jsp?complaintId=<%= id %>" class="admin-btn">
                <i class="fas fa-comments"></i> View Admin Response
            </a>
        <% } %>
    </div>

    <!-- Map Initializer (Logic Untouched, Variable scoped uniquely per loop) -->
    <script>
        const map_<%= id %> = L.map('map-<%= id %>').setView([<%= latitude %>, <%= longitude %>], 15);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map_<%= id %>);
        L.marker([<%= latitude %>, <%= longitude %>]).addTo(map_<%= id %>);
    </script>

<%
        }
    } catch (Exception e) {
        out.println("<div style='color:red; background:white; padding:15px; border-radius:8px;'>Error: " + e.getMessage() + "</div>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

</div>
</body>
</html>