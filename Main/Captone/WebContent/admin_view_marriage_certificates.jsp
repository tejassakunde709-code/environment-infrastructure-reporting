<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Database Credentials
    String dbURL = "jdbc:mysql://localhost:3306/capstone";
    String dbUser = "root"; 
    String dbPass = "";
    
    // Logic to Approve
    if (request.getParameter("approveId") != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
            PreparedStatement ps = con.prepareStatement("UPDATE marriage_applications SET status='Approved' WHERE application_number=?");
            ps.setString(1, request.getParameter("approveId"));
            ps.executeUpdate();
            con.close();
            // Redirect to refresh the page cleanly
            response.sendRedirect("admin_view_marriage_certificates.jsp");
            return;
        } catch(Exception e) {}
    }

    // Logic to Reject
    if (request.getParameter("rejectId") != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
            PreparedStatement ps = con.prepareStatement("UPDATE marriage_applications SET status='Rejected' WHERE application_number=?");
            ps.setString(1, request.getParameter("rejectId"));
            ps.executeUpdate();
            con.close();
            response.sendRedirect("admin_view_marriage_certificates.jsp");
            return;
        } catch(Exception e) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Marriage Certificates</title>

    <!-- External Libraries for Modern UI -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --bg-body: #f1f5f9;
            --bg-surface: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
            
            --status-pending-bg: #fef3c7;
            --status-pending-text: #b45309;
            --status-approved-bg: #dcfce7;
            --status-approved-text: #15803d;
            --status-rejected-bg: #fee2e2;
            --status-rejected-text: #b91c1c;
            
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --success: #10b981;
            --success-hover: #059669;
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
            min-height: 100vh;
            padding: 30px 20px;
        }

        .dashboard-container { 
            max-width: 1500px; 
            margin: auto; 
        }

        /* Header Section */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            background: var(--bg-surface);
            padding: 24px 32px;
            border-radius: 12px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            border: 1px solid var(--border-color);
        }

        .header-left h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-main);
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 4px;
        }

        .header-left h1 i {
            color: var(--primary);
        }

        .header-left p {
            color: var(--text-muted);
            font-size: 14px;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background-color: #f8fafc;
            color: var(--text-main);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.2s;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-home:hover {
            background-color: #e2e8f0;
            border-color: #cbd5e1;
        }

        /* Table Container */
        .table-wrapper {
            background: var(--bg-surface);
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            border: 1px solid var(--border-color);
            overflow: hidden;
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            white-space: nowrap;
        }

        .data-table thead {
            background-color: #f8fafc;
            border-bottom: 1px solid var(--border-color);
        }

        .data-table th {
            padding: 16px 24px;
            font-size: 12px;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .data-table tbody tr {
            border-bottom: 1px solid var(--border-color);
            transition: background-color 0.2s;
        }

        .data-table tbody tr:hover {
            background-color: #f8fafc;
        }

        .data-table tbody tr:last-child {
            border-bottom: none;
        }

        .data-table td {
            padding: 16px 24px;
            font-size: 14px;
            vertical-align: middle;
        }

        /* Typography & Cells inside Table */
        .cell-main {
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 4px;
            display: block;
        }

        .cell-sub {
            font-size: 13px;
            color: var(--text-muted);
            display: block;
            margin-top: 2px;
        }

        /* Status Badges */
        .badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .badge-pending { background: var(--status-pending-bg); color: var(--status-pending-text); }
        .badge-approved { background: var(--status-approved-bg); color: var(--status-approved-text); }
        .badge-rejected, .badge-denied { background: var(--status-rejected-bg); color: var(--status-rejected-text); }

        /* Document Links */
        .doc-stack {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .doc-link {
            font-size: 12px;
            font-weight: 500;
            color: var(--primary);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 8px;
            background: #e0e7ff;
            border-radius: 6px;
            transition: background 0.2s;
            width: fit-content;
        }

        .doc-link:hover { background: #c7d2fe; }
        .doc-link.groom { color: #1e40af; background: #dbeafe; }
        .doc-link.groom:hover { background: #bfdbfe; }
        .doc-link.bride { color: #9d174d; background: #fce7f3; }
        .doc-link.bride:hover { background: #fbcfe8; }
        .doc-link.photo { color: #065f46; background: #d1fae5; }
        .doc-link.photo:hover { background: #a7f3d0; }

        /* Action Buttons */
        .action-stack {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn-action {
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }

        .btn-approve { background: var(--success); color: white; }
        .btn-approve:hover { background: var(--success-hover); }
        
        .btn-reject { background: var(--danger); color: white; }
        .btn-reject:hover { background: var(--danger-hover); }
        
        .btn-view { background: var(--primary); color: white; }
        .btn-view:hover { background: var(--primary-hover); }
        
        .btn-disabled { background: #e2e8f0; color: #94a3b8; cursor: not-allowed; }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }
        .empty-state i {
            font-size: 48px;
            color: #cbd5e1;
            margin-bottom: 16px;
        }

        /* Form inline reset */
        .inline-form {
            margin: 0;
            padding: 0;
            display: inline-block;
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <!-- Top Header Navigation Area -->
    <div class="header">
        <div class="header-left">
            <h1><i class="fa-solid fa-ring"></i> Gram Panchayat Admin Dashboard</h1>
            <p>Manage and process Marriage Certificate applications</p>
        </div>
        <div class="header-right">
            <a href="index1.jsp" class="btn-home">
                <i class="fa-solid fa-house"></i> Go to Home Page
            </a>
        </div>
    </div>

    <!-- Horizontal Data Table -->
    <div class="table-wrapper">
        <table class="data-table">
            <thead>
                <tr>
                    <th>App No. & Date</th>
                    <th>Couple Details</th>
                    <th>Marriage Details</th>
                    <th>Uploaded Documents</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    Statement stmt = con.createStatement();
                    
                    // Fetching latest applications first
                    ResultSet rs = stmt.executeQuery("SELECT * FROM marriage_applications ORDER BY application_date DESC");
                    
                    boolean hasData = false;
                    
                    while(rs.next()) {
                        hasData = true;
                        String status = rs.getString("status");
                        String appId = rs.getString("application_number");
                        
                        // Set dynamic badge class
                        String badgeClass = "badge-pending";
                        if("Approved".equalsIgnoreCase(status)) badgeClass = "badge-approved";
                        else if("Rejected".equalsIgnoreCase(status)) badgeClass = "badge-rejected";
                %>
                <tr>
                    <!-- Application ID & Date Applied -->
                    <td>
                        <span class="cell-main"><i class="fa-solid fa-hashtag" style="color:#94a3b8; font-size: 12px;"></i> <%= appId %></span>
                        <span class="cell-sub"><i class="fa-regular fa-calendar" style="margin-right:4px;"></i> <%= rs.getDate("application_date") %></span>
                    </td>
                    
                    <!-- Couple Names -->
                    <td>
                        <span class="cell-sub"><b style="color: #1e40af;">Groom:</b> <%= rs.getString("groom_name") %></span>
                        <span class="cell-sub"><b style="color: #9d174d;">Bride:</b> <%= rs.getString("bride_name") %></span>
                    </td>
                    
                    <!-- Marriage Details -->
                    <td>
                        <span class="cell-main"><i class="fa-regular fa-calendar-check" style="color:#94a3b8; margin-right:4px;"></i> <%= rs.getString("marriage_date") %></span>
                        <span class="cell-sub"><i class="fa-regular fa-clock" style="margin-right:4px;"></i> <%= rs.getString("time_of_marriage") %></span>
                    </td>
                    
                    <!-- View Uploaded Documents -->
                    <td>
                        <div class="doc-stack">
                            <a href="<%= rs.getString("doc_marriage_proof_path") %>" target="_blank" class="doc-link">
                                <i class="fa-solid fa-file-contract"></i> Marriage Proof
                            </a>
                            <a href="<%= rs.getString("doc_joint_photo_path") %>" target="_blank" class="doc-link photo">
                                <i class="fa-solid fa-image"></i> Joint Photo
                            </a>
                            <a href="<%= rs.getString("doc_groom_id_path") %>" target="_blank" class="doc-link groom">
                                <i class="fa-solid fa-id-card"></i> Groom ID
                            </a>
                            <a href="<%= rs.getString("doc_bride_id_path") %>" target="_blank" class="doc-link bride">
                                <i class="fa-solid fa-id-card"></i> Bride ID
                            </a>
                        </div>
                    </td>
                    
                    <!-- Status Badge -->
                    <td>
                        <span class="badge <%= badgeClass %>"><%= status %></span>
                    </td>
                    
                    <!-- Action Buttons -->
                    <td>
                        <div class="action-stack">
                            <% if(status.equals("Pending")) { %>
                                <!-- Note: Wrapped exactly in forms to keep POST logic perfectly intact -->
                                <form method="POST" class="inline-form">
                                    <input type="hidden" name="approveId" value="<%= appId %>">
                                    <button type="submit" class="btn-action btn-approve" onclick="return confirm('Are you sure you want to APPROVE this marriage certificate?');">
                                        <i class="fa-solid fa-check"></i> Approve
                                    </button>
                                </form>
                                <form method="POST" class="inline-form">
                                    <input type="hidden" name="rejectId" value="<%= appId %>">
                                    <button type="submit" class="btn-action btn-reject" onclick="return confirm('Are you sure you want to REJECT this application?');">
                                        <i class="fa-solid fa-xmark"></i> Reject
                                    </button>
                                </form>
                            <% } else if(status.equals("Approved")) { %>
                                <a href="marriage_certificate.jsp?appId=<%= appId %>" class="btn-action btn-view" target="_blank">
                                    <i class="fa-solid fa-certificate"></i> View Certificate
                                </a>
                            <% } else { %>
                                <button class="btn-action btn-disabled" disabled>
                                    <i class="fa-solid fa-ban"></i> Action Taken
                                </button>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <% 
                    }
                    
                    if(!hasData) {
                %>
                <tr>
                    <td colspan="6">
                        <div class="empty-state">
                            <i class="fa-regular fa-folder-open"></i>
                            <h3>No applications found</h3>
                            <p>There are currently no marriage certificate applications available.</p>
                        </div>
                    </td>
                </tr>
                <%
                    }
                    
                    con.close(); 
                } catch(Exception e) { 
                %>
                <tr>
                    <td colspan="6">
                        <div class="empty-state" style="color: var(--danger);">
                            <i class="fa-solid fa-triangle-exclamation" style="color: var(--danger);"></i>
                            <h3>Error Loading Data</h3>
                            <p><%= e.getMessage() %></p>
                        </div>
                    </td>
                </tr>
                <% 
                } 
                %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>