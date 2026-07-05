<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // --- AUTHENTICATION LOGIC (UNCHANGED) ---
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("adminName");
    String adminEmail = (String) session.getAttribute("adminEmail");
    String state = (String) session.getAttribute("state");
    String district = (String) session.getAttribute("district");
    String village = (String) session.getAttribute("village");

    String avatar = adminName != null ? adminName.substring(0,1).toUpperCase() : "A";

    // --- DATABASE CONNECTION & ANALYTICS LOGIC ---
    int totalComplaints = 0;
    int pendingComplaints = 0;
    
    // Variables for Chart.js
    StringBuilder monthLabels = new StringBuilder();
    StringBuilder totalData = new StringBuilder();
    StringBuilder pendingData = new StringBuilder();
    StringBuilder solvedData = new StringBuilder();

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone", "root", "");
        Statement stmt = conn.createStatement();

        // 1. Get Overall Stats for the Top Cards
        ResultSet rsStats = stmt.executeQuery("SELECT COUNT(*) AS total, SUM(CASE WHEN status='Pending' THEN 1 ELSE 0 END) AS pending FROM complaints");
        if(rsStats.next()){
            totalComplaints = rsStats.getInt("total");
            pendingComplaints = rsStats.getInt("pending");
        }

        // 2. Get Month-wise Analytics for the Chart (Current Year)
        String chartQuery = "SELECT MONTHNAME(created_at) AS month_name, " +
                            "COUNT(*) AS t_count, " +
                            "SUM(CASE WHEN status='Pending' THEN 1 ELSE 0 END) AS p_count, " +
                            "SUM(CASE WHEN status='Solved' OR status='Resolved' THEN 1 ELSE 0 END) AS s_count " +
                            "FROM complaints " +
                            "WHERE YEAR(created_at) = YEAR(CURRENT_DATE) " +
                            "GROUP BY MONTH(created_at), MONTHNAME(created_at) " +
                            "ORDER BY MONTH(created_at)";
                            
        ResultSet rsChart = stmt.executeQuery(chartQuery);
        while(rsChart.next()){
            monthLabels.append("\"").append(rsChart.getString("month_name")).append("\",");
            totalData.append(rsChart.getInt("t_count")).append(",");
            pendingData.append(rsChart.getInt("p_count")).append(",");
            solvedData.append(rsChart.getInt("s_count")).append(",");
        }
        
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }

    // Remove trailing commas for JSON array formatting
    if(monthLabels.length() > 0) {
        monthLabels.setLength(monthLabels.length() - 1);
        totalData.setLength(totalData.length() - 1);
        pendingData.setLength(pendingData.length() - 1);
        solvedData.setLength(solvedData.length() - 1);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>

<!-- Fonts & Icons -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    /* ALL YOUR EXISTING CSS REMAINS EXACTLY THE SAME */
    :root {
        --primary-color: #0066cc; 
        --bg-color: #f0f2f5;      
        --white: #ffffff;
        --text-dark: #1e293b;     
        --text-gray: #64748b;     
        --border-color: #e2e8f0;
        --sidebar-width: 260px;
        --header-height: 70px;
        --shadow-sm: 0 1px 3px rgba(0,0,0,0.05);
        --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.1);
        --danger: #ef4444;
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
        font-family: 'Poppins', sans-serif;
        background-color: var(--bg-color);
        color: var(--text-dark);
        min-height: 100vh;
    }

    /* --- HEADER --- */
    .header { height: var(--header-height); background: var(--white); position: fixed; top: 0; left: 0; right: 0; z-index: 100; display: flex; justify-content: space-between; align-items: center; padding: 0 2rem; border-bottom: 1px solid var(--border-color); box-shadow: var(--shadow-sm); padding-left: calc(var(--sidebar-width) + 2rem); }
    .header-title { font-size: 1.25rem; font-weight: 600; color: var(--text-dark); display: flex; align-items: center; gap: 10px; }
    .header-title i { color: var(--primary-color); }
    .admin-info { display: flex; align-items: center; gap: 20px; }
    .admin-profile { display: flex; align-items: center; gap: 12px; }
    .avatar { width: 40px; height: 40px; background: var(--primary-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 18px; }
    .admin-text { display: flex; flex-direction: column; line-height: 1.2; }
    .admin-text b { font-size: 0.9rem; color: var(--text-dark); }
    .admin-text small { font-size: 0.8rem; color: var(--text-gray); }
    .logout-btn { background: transparent; border: 1px solid var(--danger); color: var(--danger); padding: 8px 16px; border-radius: 6px; font-size: 0.85rem; font-weight: 500; cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 6px; }
    .logout-btn:hover { background: var(--danger); color: white; }

    /* --- SIDEBAR --- */
    .sidebar { width: var(--sidebar-width); background: var(--white); position: fixed; top: 0; bottom: 0; left: 0; border-right: 1px solid var(--border-color); z-index: 101; padding-top: var(--header-height); }
    .sidebar-logo { height: var(--header-height); position: absolute; top: 0; width: 100%; display: flex; align-items: center; padding-left: 1.5rem; font-size: 1.2rem; font-weight: 700; color: var(--primary-color); border-bottom: 1px solid var(--border-color); }
    .sidebar-menu { padding: 1.5rem 1rem; display: flex; flex-direction: column; gap: 0.5rem; }
    .sidebar a { display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--text-gray); text-decoration: none; border-radius: 8px; font-weight: 500; transition: all 0.2s ease; }
    .sidebar a:hover { background: #f1f5f9; color: var(--primary-color); }
    .sidebar a.active { background: #eff6ff; color: var(--primary-color); font-weight: 600; }

    /* --- MAIN CONTENT --- */
    .main { margin-left: var(--sidebar-width); margin-top: var(--header-height); padding: 2rem; }

    /* --- CARDS --- */
    .card { background: var(--white); padding: 1.5rem; border-radius: 12px; border: 1px solid var(--border-color); box-shadow: var(--shadow-sm); margin-bottom: 2rem; }
    .card h3 { font-size: 1.1rem; color: var(--text-dark); margin-bottom: 1rem; display: flex; align-items: center; gap: 10px; padding-bottom: 0.5rem; border-bottom: 1px solid var(--border-color); }
    .details-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; }
    .detail-item { font-size: 0.95rem; color: var(--text-gray); }
    .detail-item b { color: var(--text-dark); display: block; margin-bottom: 2px; }

    /* --- STATS GRID --- */
    .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;}
    .stat-box { background: var(--white); padding: 1.5rem; border-radius: 12px; border: 1px solid var(--border-color); box-shadow: var(--shadow-sm); display: flex; align-items: center; gap: 1.5rem; transition: transform 0.3s ease, box-shadow 0.3s ease; cursor: pointer; }
    .stat-box:hover { transform: translateY(-5px); box-shadow: var(--shadow-md); border-color: var(--primary-color); }
    .icon-box { width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
    .bg-blue { background: #e0f2fe; color: #0284c7; }
    .bg-green { background: #dcfce7; color: #16a34a; }
    .bg-purple { background: #f3e8ff; color: #9333ea; }
    .bg-orange { background: #ffedd5; color: #ea580c; }
    .stat-info h2 { font-size: 1.8rem; font-weight: 700; color: var(--text-dark); line-height: 1; margin-bottom: 4px; }
    .stat-info p { font-size: 0.9rem; color: var(--text-gray); font-weight: 500; }

    /* Chart Container CSS */
    .chart-container { position: relative; height: 350px; width: 100%; }

    @media (max-width: 768px) {
        .sidebar { width: 0; overflow: hidden; transition: 0.3s; }
        .header { padding-left: 2rem; }
        .main { margin-left: 0; padding: 1.5rem; }
        .admin-text { display: none; }
    }
</style>
</head>

<body>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-logo">
            <i class="fas fa-landmark me-2"></i> Admin Panel
        </div>
        <div class="sidebar-menu">
            <a href="index1.jsp" class="active">
                <i class="fas fa-home"></i> <span>Dashboard</span>
            </a>
            <a href="adminViewComplaint.jsp">
                <i class="fas fa-clipboard-list"></i> <span>Manage Complaints</span>
            </a>
            <!-- NEW LINK FOR MONTHLY RECORDS -->
            <a href="monthlyComplaintsReport.jsp">
                <i class="fas fa-chart-line"></i> <span>Monthly Report</span>
            </a>
            <a href="admin_view_birth_applications.jsp">
                <i class="fas fa-certificate"></i> <span>Birth Certificates</span>
            </a>
            <a href="admin_view_death_certificates.jsp">
                <i class="fas fa-certificate"></i> <span>Death Certificates</span>
            </a>
            <a href="admin_view_marriage_certificates.jsp">
                <i class="fas fa-certificate"></i> <span>Marriage Certificates</span>
            </a>
            <a href="community.jsp">
                <i class="fas fa-users"></i> <span>Community</span>
            </a>
        </div>
    </div>

    <!-- HEADER -->
    <div class="header">
        <div class="header-title">
            <span>Dashboard Overview</span>
        </div>
        
        <div class="admin-info">
            <div class="admin-profile">
                <div class="avatar"><%= avatar %></div>
                <div class="admin-text">
                    <b><%= adminName %></b>
                    <small>Administrator</small>
                </div>
            </div>
            <button class="logout-btn" onclick="location.href='AdminLogoutServlet'">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main">
        
        <!-- Welcome / Location Card -->
        <div class="card">
            <h3><i class="fas fa-map-marked-alt text-primary"></i> Gram Panchayat Location Details</h3>
            <div class="details-grid">
                <div class="detail-item"><b>State</b> <%= state %></div>
                <div class="detail-item"><b>District</b> <%= district %></div>
                <div class="detail-item"><b>Village</b> <%= village %></div>
                <div class="detail-item"><b>Email</b> <%= adminEmail %></div>
            </div>
        </div>

        <!-- STATS GRID -->
        <div class="stats-grid">
            <!-- Complaints -->
            <div class="stat-box">
                <div class="icon-box bg-blue">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="stat-info">
                    <!-- DYNAMIC COUNT LOADED -->
                    <h2><%= totalComplaints %></h2>
                    <p>Total Complaints</p>
                </div>
            </div>

            <!-- Pending -->
            <div class="stat-box">
                <div class="icon-box bg-orange">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <!-- DYNAMIC PENDING COUNT LOADED -->
                    <h2><%= pendingComplaints %></h2>
                    <p>Pending Complaints</p>
                </div>
            </div>
            
           
        </div>

        <!-- MONTHLY CHART CARD -->
        <div class="card">
            <h3><i class="fas fa-chart-bar"></i> Month-wise Complaints Analytics (<%= java.time.Year.now().getValue() %>)</h3>
            <div class="chart-container">
                <canvas id="complaintsChart"></canvas>
            </div>
        </div>

    </div>

    <!-- Chart.js Setup Script -->
    <script>
        const ctx = document.getElementById('complaintsChart').getContext('2d');
        const complaintsChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [<%= monthLabels.toString() %>], // Injects Java string array
                datasets: [
                    {
                        label: 'Total Complaints',
                        data:[<%= totalData.toString() %>],
                        backgroundColor: 'rgba(54, 162, 235, 0.7)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1,
                        borderRadius: 4
                    },
                    {
                        label: 'Solved/Resolved',
                        data: [<%= solvedData.toString() %>],
                        backgroundColor: 'rgba(75, 192, 192, 0.7)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1,
                        borderRadius: 4
                    },
                    {
                        label: 'Pending',
                        data: [<%= pendingData.toString() %>],
                        backgroundColor: 'rgba(255, 159, 64, 0.7)',
                        borderColor: 'rgba(255, 159, 64, 1)',
                        borderWidth: 1,
                        borderRadius: 4
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { precision: 0 } // Ensures whole numbers only
                    }
                },
                plugins: {
                    legend: {
                        position: 'top',
                    }
                }
            }
        });
    </script>
</body>
</html>