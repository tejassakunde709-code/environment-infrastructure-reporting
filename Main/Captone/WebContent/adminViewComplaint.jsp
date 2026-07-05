<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String adminEmail = (String) session.getAttribute("adminEmail");
    if (adminEmail == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin - All Complaints</title>

<!-- External Libraries -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --primary: #4f46e5;
        --primary-hover: #4338ca;
        --bg-color: #f3f4f6;
        --card-bg: #ffffff;
        --text-main: #111827;
        --text-muted: #6b7280;
        --border-color: #e5e7eb;
        
        --status-pending-bg: #fee2e2;
        --status-pending-text: #991b1b;
        --status-progress-bg: #fef3c7;
        --status-progress-text: #92400e;
        --status-resolved-bg: #dcfce7;
        --status-resolved-text: #166534;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Inter', sans-serif;
    }

    body {
        background-color: var(--bg-color);
        color: var(--text-main);
        min-height: 100vh;
        padding: 40px 20px;
    }

    .container { 
        max-width: 1400px; 
        margin: auto; 
    }

    /* Header Section */
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        flex-wrap: wrap;
        gap: 20px;
    }

    .header-titles h1 {
        font-size: 32px;
        font-weight: 700;
        color: var(--text-main);
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .header-titles h1 i {
        color: var(--primary);
    }

    .header-titles p {
        color: var(--text-muted);
        font-size: 15px;
        font-weight: 400;
    }

    .back-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: var(--card-bg);
        color: var(--text-main);
        text-decoration: none;
        border-radius: 8px;
        font-weight: 500;
        font-size: 14px;
        border: 1px solid var(--border-color);
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        transition: all 0.2s ease;
    }

    .back-link:hover {
        background: #f9fafb;
        transform: translateY(-1px);
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    /* Filter Controls */
    .controls {
        background: var(--card-bg);
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
        border: 1px solid var(--border-color);
    }

    .controls form {
        display: flex;
        gap: 16px;
        flex-wrap: wrap;
        align-items: center;
    }

    .input-group {
        position: relative;
        flex: 1;
        min-width: 250px;
    }

    .input-group i {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-muted);
    }

    .controls input, .controls select {
        width: 100%;
        padding: 12px 16px 12px 40px;
        border: 1px solid var(--border-color);
        border-radius: 8px;
        font-size: 14px;
        color: var(--text-main);
        transition: all 0.2s ease;
        background: #f9fafb;
    }

    .controls select {
        padding-left: 16px;
        flex: 0 1 200px;
        cursor: pointer;
    }

    .controls input:focus, .controls select:focus {
        outline: none;
        border-color: var(--primary);
        background: #ffffff;
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
    }

    .btn-submit {
        padding: 12px 24px;
        background: var(--primary);
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-submit:hover {
        background: var(--primary-hover);
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
    }

    /* Grid & Cards */
    .complaint-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
        gap: 24px;
    }

    .complaint-card {
        background: var(--card-bg);
        border-radius: 16px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
        border: 1px solid var(--border-color);
        overflow: hidden;
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
    }

    .complaint-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 20px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    }

    .card-header {
        background: #f8fafc;
        padding: 16px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid var(--border-color);
    }

    .complaint-id {
        font-weight: 700;
        color: var(--text-main);
        font-size: 14px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .complaint-date {
        font-size: 13px;
        color: var(--text-muted);
    }

    .status-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .status-pending { background: var(--status-pending-bg); color: var(--status-pending-text); }
    .status-progress { background: var(--status-progress-bg); color: var(--status-progress-text); }
    .status-resolved { background: var(--status-resolved-bg); color: var(--status-resolved-text); }

    .card-body { 
        padding: 20px; 
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .info-row {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }

    .info-label {
        font-size: 12px;
        text-transform: uppercase;
        color: var(--text-muted);
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .info-value {
        font-size: 14px;
        color: var(--text-main);
        line-height: 1.5;
        background: #f9fafb;
        padding: 10px 12px;
        border-radius: 8px;
        border: 1px solid #f3f4f6;
    }

    .media-section {
        display: grid;
        grid-template-columns: 1fr;
        gap: 12px;
        margin-top: 5px;
    }

    .card-image img {
        width: 100%;
        height: 180px;
        object-fit: cover;
        border-radius: 10px;
        border: 1px solid var(--border-color);
    }

    .map-container {
        height: 180px;
        border-radius: 10px;
        border: 1px solid var(--border-color);
        z-index: 1;
    }

    .card-actions {
        padding: 16px 20px;
        background: #f8fafc;
        border-top: 1px solid var(--border-color);
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .action-btn {
        flex: 1;
        text-align: center;
        padding: 10px 16px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 13px;
        text-decoration: none;
        transition: all 0.2s;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn-update {
        background: var(--primary);
        color: white;
    }

    .btn-update:hover {
        background: var(--primary-hover);
    }

    .btn-view {
        background: white;
        color: var(--text-main);
        border: 1px solid var(--border-color);
    }

    .btn-view:hover {
        background: #f1f5f9;
        border-color: #cbd5e1;
    }

    @media (max-width: 768px) {
        .page-header { flex-direction: column; align-items: flex-start; }
        .controls form { flex-direction: column; }
        .input-group, .controls select, .btn-submit { width: 100%; max-width: 100%; }
        .complaint-grid { grid-template-columns: 1fr; }
        .card-actions { flex-direction: column; }
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .complaint-card {
        animation: fadeIn 0.4s ease-out forwards;
    }
</style>
</head>

<body>
<div class="container">

<div class="page-header">
    <div class="header-titles">
        <h1><i class="fa-solid fa-layer-group"></i> All Reported Complaints</h1>
        <p>Admin Control Panel • Viewing complaints from all users</p>
    </div>
    <a href="index1.jsp" class="back-link">
        <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<%
    String searchAddress = request.getParameter("searchAddress");
    String sortBy = request.getParameter("sortBy");

    String orderBy = "created_at DESC";
    if ("oldest".equals(sortBy)) orderBy = "created_at ASC";
    else if ("address".equals(sortBy)) orderBy = "address ASC";
%>

<div class="controls">
    <form method="get">
        <div class="input-group">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" name="searchAddress" placeholder="Search by exact or partial address..."
                   value="<%= searchAddress != null ? searchAddress : "" %>">
        </div>

        <select name="sortBy">
            <option value="">Sort by: Newest First</option>
            <option value="oldest" <%= "oldest".equals(sortBy) ? "selected" : "" %>>Sort by: Oldest First</option>
            <option value="address" <%= "address".equals(sortBy) ? "selected" : "" %>>Sort by: Address (A-Z)</option>
        </select>

        <button type="submit" class="btn-submit">
            <i class="fa-solid fa-filter"></i> Apply Filters
        </button>
    </form>
</div>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/capstone?useSSL=false&serverTimezone=UTC",
                "root", "");

        String sql = "SELECT * FROM complaints WHERE 1=1";
        if (searchAddress != null && !searchAddress.trim().isEmpty()) {
            sql += " AND address LIKE ?";
        }
        sql += " ORDER BY " + orderBy;

        ps = con.prepareStatement(sql);

        if (searchAddress != null && !searchAddress.trim().isEmpty()) {
            ps.setString(1, "%" + searchAddress + "%");
        }

        rs = ps.executeQuery();
%>

<div class="complaint-grid">
<%
    while (rs.next()) {

        String id = rs.getString("id");
        String userEmail = rs.getString("user_email");
        String description = rs.getString("description");
        String latitude = rs.getString("latitude");
        String longitude = rs.getString("longitude");
        String address = rs.getString("address");
        String imageName = rs.getString("image_name");
        String createdAt = rs.getString("created_at");
        String status = rs.getString("status");

        String imagePath = imageName != null ? "images/" + imageName : null;
        String statusClass = status != null ? "status-" + status.toLowerCase() : "";
%>

<div class="complaint-card">
    <div class="card-header">
        <div class="complaint-id">
            <i class="fa-solid fa-hashtag"></i> <%= id %>
            <span class="complaint-date">• <%= createdAt %></span>
        </div>
        <span class="status-badge <%= statusClass %>"><%= status %></span>
    </div>

    <div class="card-body">
        <div class="info-row">
            <span class="info-label"><i class="fa-solid fa-envelope"></i> User Email</span>
            <span class="info-value"><%= userEmail %></span>
        </div>

        <div class="info-row">
            <span class="info-label"><i class="fa-solid fa-location-dot"></i> Address Location</span>
            <span class="info-value"><%= address %></span>
        </div>

        <div class="info-row">
            <span class="info-label"><i class="fa-solid fa-align-left"></i> Description</span>
            <span class="info-value"><%= description %></span>
        </div>

        <div class="media-section">
            <% if (imagePath != null && !imagePath.trim().isEmpty()) { %>
                <div class="card-image">
                    <img src="<%= imagePath %>" alt="Complaint Evidence">
                </div>
            <% } %>

            <div class="map-container" id="map-<%= id %>"></div>
        </div>
    </div>

    <!-- ACTION BUTTONS -->
    <div class="card-actions">
        <% if ("pending".equalsIgnoreCase(status)) { %>
            <a href="updateStatus.jsp?id=<%= id %>" class="action-btn btn-update">
                <i class="fa-solid fa-pen-to-square"></i> Update Status
            </a>
        <% } else if ("progress".equalsIgnoreCase(status)) { %>
            <a href="updateStatus.jsp?id=<%= id %>" class="action-btn btn-update">
                <i class="fa-solid fa-pen-to-square"></i> Update Status
            </a>
            <a href="viewAdminResponse.jsp?id=<%= id %>" class="action-btn btn-view">
                <i class="fa-solid fa-eye"></i> View Response
            </a>
        <% } else if ("resolved".equalsIgnoreCase(status)) { %>
            <a href="viewAdminResponse.jsp?id=<%= id %>" class="action-btn btn-view">
                <i class="fa-solid fa-eye"></i> View Resolution
            </a>
        <% } %>
    </div>
</div>

<script>
    const map<%= id %> = L.map('map-<%= id %>').setView([<%= latitude %>, <%= longitude %>], 15);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    }).addTo(map<%= id %>);
    
    // Adding a nice custom colored marker for a premium feel
    var customIcon<%= id %> = L.icon({
        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41]
    });
    
    L.marker([<%= latitude %>, <%= longitude %>], {icon: customIcon<%= id %>}).addTo(map<%= id %>);
</script>

<%
    }
} catch (Exception e) {
    out.println("<div style='color:red; padding:20px; text-align:center;'>Error occurred: " + e.getMessage() + "</div>");
} finally {
    try { rs.close(); } catch (Exception ignored) {}
    try { ps.close(); } catch (Exception ignored) {}
    try { con.close(); } catch (Exception ignored) {}
}
%>

</div>
</div>
</body>
</html>