<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%
    // --- DATABASE CONFIGURATION ---
    String dbURL = "jdbc:mysql://localhost:3306/capstone";
    String dbUser = "root";
    String dbPass = ""; // Default XAMPP password is empty

    // --- AUTHENTICATION CHECK (Optional: Ensure only Admin sees this) ---
    /*
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("roleSelection.jsp");
        return;
    }
    */
    
    // For counting total users
    int totalUsers = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>User List - Gram Panchayat Admin</title>
  
  <!-- Fonts & Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  
  <style>
    :root {
        --primary-blue: #0066cc;
        --primary-green: #00a651;
        --dark-blue: #003087;
        --navy: #1a365d;
        --light-bg: #f8fafc;
        --text-dark: #1e293b;
        --text-light: #64748b;
        --border-color: #e2e8f0;
        --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Poppins', sans-serif; background: var(--light-bg); color: var(--text-dark); }

    /* --- TOPBAR & HEADER --- */
    .govt-topbar { background: linear-gradient(90deg, var(--dark-blue), var(--navy)); color: white; padding: 10px 2rem; font-size: 0.9rem; display: flex; justify-content: space-between; }
    
    .main-header { background: white; padding: 1rem 2rem; box-shadow: var(--shadow-sm); display: flex; align-items: center; justify-content: space-between; border-bottom: 3px solid var(--primary-blue); }
    .logo-area { display: flex; align-items: center; gap: 1rem; font-weight: 700; color: var(--dark-blue); font-size: 1.2rem; }
    .logo-area i { font-size: 1.5rem; color: var(--primary-green); }
    
    .back-btn { text-decoration: none; color: var(--text-dark); background: #f1f5f9; padding: 8px 15px; border-radius: 5px; font-weight: 500; transition: 0.3s; }
    .back-btn:hover { background: var(--primary-blue); color: white; }

    /* --- MAIN CONTAINER --- */
    .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }

    .page-title { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
    .page-title h1 { color: var(--navy); font-size: 1.8rem; }
    
    /* --- SEARCH BAR --- */
    .search-wrapper { position: relative; max-width: 300px; width: 100%; }
    .search-wrapper input { width: 100%; padding: 10px 15px 10px 40px; border: 1px solid var(--border-color); border-radius: 50px; outline: none; transition: 0.3s; }
    .search-wrapper input:focus { border-color: var(--primary-blue); box-shadow: 0 0 0 3px rgba(0,102,204,0.1); }
    .search-wrapper i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-light); }

    /* --- TABLE STYLING --- */
    .table-container { background: white; border-radius: 12px; box-shadow: var(--shadow-md); overflow: hidden; border: 1px solid var(--border-color); }
    
    table { width: 100%; border-collapse: collapse; text-align: left; }
    
    thead { background: #f8fafc; border-bottom: 2px solid var(--border-color); }
    th { padding: 1rem 1.5rem; font-size: 0.85rem; font-weight: 600; color: var(--text-light); text-transform: uppercase; letter-spacing: 0.5px; }
    
    tbody tr { border-bottom: 1px solid var(--border-color); transition: 0.2s; }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: #f1f8ff; }
    
    td { padding: 1rem 1.5rem; color: var(--text-dark); font-size: 0.95rem; vertical-align: middle; }

    /* --- AVATAR & BADGES --- */
    .user-info { display: flex; align-items: center; gap: 10px; }
    .avatar { width: 40px; height: 40px; border-radius: 50%; background: var(--primary-blue); color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1rem; text-transform: uppercase; }
    .user-text h4 { font-size: 0.95rem; margin-bottom: 2px; }
    .user-text span { font-size: 0.8rem; color: var(--text-light); }

    .badge { padding: 4px 10px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }
    .badge-role { background: #e0f2fe; color: #0369a1; }
    
    .empty-state { padding: 3rem; text-align: center; color: var(--text-light); }

    /* --- RESPONSIVE --- */
    @media (max-width: 768px) {
        .page-title { flex-direction: column; gap: 1rem; align-items: flex-start; }
        th, td { padding: 0.8rem; }
        .mobile-hide { display: none; } /* Hide Date/Mobile on small screens */
    }
  </style>
</head>
<body>

    <!-- Top Bar -->
    <div class="govt-topbar">
        <span><i class="fas fa-landmark me-2"></i> Gram Panchayat Administration</span>
        <span><%= new SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></span>
    </div>

    <!-- Header -->
    <header class="main-header">
        <div class="logo-area">
            <i class="fas fa-users-cog"></i>
            <span>User Management</span>
        </div>
        <a href="index1.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </header>

    <!-- Main Content -->
    <div class="container">
        
        <div class="page-title">
            <h1>Registered Citizens</h1>
            
            <div class="search-wrapper">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search by name or email...">
            </div>
        </div>

        <div class="table-container">
            <table id="userTable">
                <thead>
                    <tr>
                        <th width="5%">ID</th>
                        <th width="35%">User Details</th>
                        <th width="20%">Mobile Number</th>
                        <th width="20%" class="mobile-hide">Joined Date</th>
                        <th width="10%">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                            
                            // Query: Excludes password for security
                            String sql = "SELECT user_id, name, email, mobile, created_at FROM users ORDER BY user_id DESC";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                totalUsers++;
                                int userId = rs.getInt("user_id");
                                String name = rs.getString("name");
                                String email = rs.getString("email");
                                String mobile = rs.getString("mobile");
                                Timestamp createdAt = rs.getTimestamp("created_at");
                                
                                // Format date nicely
                                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
                                String joinDate = (createdAt != null) ? sdf.format(createdAt) : "N/A";
                                
                                // Get Initials for Avatar
                                String initial = (name != null && name.length() > 0) ? name.substring(0, 1) : "U";
                                
                                // Generate a semi-random color for avatar based on ID
                                String[] colors = {"#0066cc", "#00a651", "#ff6b35", "#7c3aed", "#db2777"};
                                String avatarColor = colors[userId % colors.length];
                    %>
                    <tr>
                        <td style="font-weight: bold; color: #64748b;">#<%= userId %></td>
                        <td>
                            <div class="user-info">
                                <div class="avatar" style="background: <%= avatarColor %>;">
                                    <%= initial %>
                                </div>
                                <div class="user-text">
                                    <h4><%= name %></h4>
                                    <span><%= email %></span>
                                </div>
                            </div>
                        </td>
                        <td style="font-family: monospace; font-size: 1rem;"><%= mobile %></td>
                        <td class="mobile-hide"><i class="far fa-calendar-alt" style="margin-right:5px; color:#aaa;"></i> <%= joinDate %></td>
                        <td><span class="badge badge-role">Active</span></td>
                    </tr>
                    <% 
                            } 
                            if(totalUsers == 0) {
                    %>
                        <tr>
                            <td colspan="5" class="empty-state">
                                <i class="fas fa-users-slash" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                                <p>No users found in the database.</p>
                            </td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='5' style='color:red; padding:1rem;'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <div style="margin-top: 1rem; text-align: right; color: var(--text-light); font-size: 0.9rem;">
            Total Registered Users: <strong><%= totalUsers %></strong>
        </div>

    </div>

    <!-- JavaScript for Search Functionality -->
    <script>
        function filterTable() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("userTable");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 1; i < tr.length; i++) { // Start at 1 to skip header
                // Check Name (Column 1) and Email inside it
                td = tr[i].getElementsByTagName("td")[1];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }       
            }
        }
    </script>

</body>
</html>