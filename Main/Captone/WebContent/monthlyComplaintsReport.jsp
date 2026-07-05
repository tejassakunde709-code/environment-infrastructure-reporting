<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // --- AUTHENTICATION LOGIC (UNCHANGED) ---
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("adminName");
    String avatar = adminName != null ? adminName.substring(0,1).toUpperCase() : "A";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Monthly Complaints Record - Admin Dashboard</title>

<!-- Fonts & Icons -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    /* SHARED CSS VARIABLES & LAYOUT */
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

    /* HEADER & SIDEBAR (Matches Dashboard) */
    .header { height: var(--header-height); background: var(--white); position: fixed; top: 0; left: 0; right: 0; z-index: 100; display: flex; justify-content: space-between; align-items: center; padding: 0 2rem; border-bottom: 1px solid var(--border-color); box-shadow: var(--shadow-sm); padding-left: calc(var(--sidebar-width) + 2rem); }
    .header-title { font-size: 1.25rem; font-weight: 600; color: var(--text-dark); display: flex; align-items: center; gap: 10px; }
    .admin-info { display: flex; align-items: center; gap: 20px; }
    .admin-profile { display: flex; align-items: center; gap: 12px; }
    .avatar { width: 40px; height: 40px; background: var(--primary-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 18px; }
    .admin-text { display: flex; flex-direction: column; line-height: 1.2; }
    .admin-text b { font-size: 0.9rem; color: var(--text-dark); }
    .admin-text small { font-size: 0.8rem; color: var(--text-gray); }
    
    .sidebar { width: var(--sidebar-width); background: var(--white); position: fixed; top: 0; bottom: 0; left: 0; border-right: 1px solid var(--border-color); z-index: 101; padding-top: var(--header-height); }
    .sidebar-logo { height: var(--header-height); position: absolute; top: 0; width: 100%; display: flex; align-items: center; padding-left: 1.5rem; font-size: 1.2rem; font-weight: 700; color: var(--primary-color); border-bottom: 1px solid var(--border-color); }
    .sidebar-menu { padding: 1.5rem 1rem; display: flex; flex-direction: column; gap: 0.5rem; }
    .sidebar a { display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--text-gray); text-decoration: none; border-radius: 8px; font-weight: 500; transition: all 0.2s ease; }
    .sidebar a:hover { background: #f1f5f9; color: var(--primary-color); }
    .sidebar a.active { background: #eff6ff; color: var(--primary-color); font-weight: 600; }

    .main { margin-left: var(--sidebar-width); margin-top: var(--header-height); padding: 2rem; }
    .card { background: var(--white); padding: 1.5rem; border-radius: 12px; border: 1px solid var(--border-color); box-shadow: var(--shadow-sm); margin-bottom: 2rem; }
    .card h3 { font-size: 1.1rem; color: var(--text-dark); margin-bottom: 1.5rem; display: flex; align-items: center; gap: 10px; padding-bottom: 0.5rem; border-bottom: 1px solid var(--border-color); }

    /* TABLE STYLES */
    .table-container { overflow-x: auto; }
    .report-table { width: 100%; border-collapse: collapse; min-width: 600px; }
    .report-table th, .report-table td { padding: 14px 16px; text-align: left; border-bottom: 1px solid var(--border-color); }
    .report-table th { background-color: #f8fafc; color: var(--text-gray); font-weight: 600; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 0.5px; }
    .report-table td { font-size: 0.95rem; color: var(--text-dark); }
    .report-table tbody tr:hover { background-color: #f1f5f9; }
    
    .badge { padding: 5px 10px; border-radius: 50px; font-size: 0.8rem; font-weight: 600; }
    .badge-blue { background: #e0f2fe; color: #0284c7; }
    .badge-orange { background: #ffedd5; color: #ea580c; }
    .badge-green { background: #dcfce7; color: #16a34a; }

</style>
</head>

<body>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-logo">
            <i class="fas fa-landmark me-2"></i> Admin Panel
        </div>
        <div class="sidebar-menu">
            <a href="adminDashboard.jsp">
                <i class="fas fa-home"></i> <span>Dashboard</span>
            </a>
            <a href="adminViewComplaint.jsp">
                <i class="fas fa-clipboard-list"></i> <span>Manage Complaints</span>
            </a>
            <a href="monthlyComplaintsReport.jsp" class="active">
                <i class="fas fa-chart-line"></i> <span>Monthly Report</span>
            </a>
            <a href="#">
                <i class="fas fa-certificate"></i> <span>Certificates</span>
            </a>
            <a href="#">
                <i class="fas fa-users"></i> <span>Community</span>
            </a>
        </div>
    </div>

    <!-- HEADER -->
    <div class="header">
        <div class="header-title">
            <span>Overall Monthly Complaints Record</span>
        </div>
        
        <div class="admin-info">
            <div class="admin-profile">
                <div class="avatar"><%= avatar %></div>
                <div class="admin-text">
                    <b><%= adminName %></b>
                    <small>Administrator</small>
                </div>
            </div>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main">
        <div class="card">
            <h3><i class="fas fa-calendar-alt text-primary"></i> Complaints Breakdown By Month & Year</h3>
            
            <div class="table-container">
                <table class="report-table">
                    <thead>
                        <tr>
                            <th>Year</th>
                            <th>Month</th>
                            <th>Total Registered</th>
                            <th>Pending</th>
                            <th>Resolved / Solved</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone", "root", "");
                                
                                // SQL Groups data by Year and Month
                                String sql = "SELECT YEAR(created_at) AS report_year, " +
                                             "MONTHNAME(created_at) AS report_month, " +
                                             "COUNT(*) AS total, " +
                                             "SUM(CASE WHEN status='Pending' THEN 1 ELSE 0 END) AS pending, " +
                                             "SUM(CASE WHEN status='Solved' OR status='Resolved' THEN 1 ELSE 0 END) AS solved " +
                                             "FROM complaints " +
                                             "GROUP BY YEAR(created_at), MONTH(created_at), MONTHNAME(created_at) " +
                                             "ORDER BY YEAR(created_at) DESC, MONTH(created_at) DESC";
                                             
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery(sql);
                                
                                boolean hasData = false;
                                while(rs.next()) {
                                    hasData = true;
                                    String year = rs.getString("report_year");
                                    String month = rs.getString("report_month");
                                    int total = rs.getInt("total");
                                    int pending = rs.getInt("pending");
                                    int solved = rs.getInt("solved");
                        %>
                                    <tr>
                                        <td><b><%= year %></b></td>
                                        <td><%= month %></td>
                                        <td><span class="badge badge-blue"><%= total %> Complaints</span></td>
                                        <td><span class="badge badge-orange"><%= pending %> Pending</span></td>
                                        <td><span class="badge badge-green"><%= solved %> Solved</span></td>
                                    </tr>
                        <%
                                }
                                
                                if(!hasData) {
                                    out.println("<tr><td colspan='5' style='text-align:center; padding:20px; color:gray;'>No complaints record found.</td></tr>");
                                }
                                
                                conn.close();
                            } catch(Exception e) {
                                out.println("<tr><td colspan='5' style='color:red;'>Error Loading Data: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>