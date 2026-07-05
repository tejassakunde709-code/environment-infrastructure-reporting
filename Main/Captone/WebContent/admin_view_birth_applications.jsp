<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Birth Applications</title>

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
        }

        .text-danger-custom {
            color: var(--danger);
            font-style: italic;
            font-weight: 400;
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
        .doc-link.father { color: #166534; background: #dcfce7; }
        .doc-link.father:hover { background: #bbf7d0; }
        .doc-link.mother { color: #991b1b; background: #fee2e2; }
        .doc-link.mother:hover { background: #fecaca; }

        /* Action Buttons */
        .action-stack {
            display: flex;
            gap: 8px;
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
        
    </style>
</head>
<body>

<div class="dashboard-container">
    <!-- Top Header Navigation Area -->
    <div class="header">
        <div class="header-left">
            <h1><i class="fa-solid fa-building-columns"></i> Gram Panchayat Admin Dashboard</h1>
            <p>Manage and process Birth Certificate applications</p>
        </div>
        <div class="header-right">
            <!-- NEW HOME BUTTON ADDED HERE -->
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
                    <th>Child Details</th>
                    <th>Parents Details</th>
                    <th>Address & Contact</th>
                    <th>Documents</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection details
                    String DB_URL = "jdbc:mysql://localhost:3306/capstone";
                    String DB_USER = "root";
                    String DB_PASS = "";
                    
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                        
                        // Fetch all applications ordered by newest first
                        String sql = "SELECT * FROM birth_applications ORDER BY applied_on DESC";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        boolean hasData = false;

                        while(rs.next()) {
                            hasData = true;
                            
                            String appId = rs.getString("application_id"); 
                            String appNo = rs.getString("application_number");
                            String appliedOn = rs.getString("applied_on");
                            
                            String childName = rs.getString("child_name");
                            if(childName == null || childName.trim().isEmpty()) {
                                childName = "<span class='text-danger-custom'>Not Named</span>";
                            }
                            
                            String dob = rs.getString("dob");
                            String time = rs.getString("time_of_birth");
                            String gender = rs.getString("gender");
                            
                            String fatherName = rs.getString("father_name");
                            String motherName = rs.getString("mother_name");
                            
                            String village = rs.getString("gram_panchayat");
                            String mobile = rs.getString("mobile");
                            String status = rs.getString("status");

                            // Document Paths
                            String birthProof = rs.getString("doc_birth_proof_path");
                            String fatherId = rs.getString("doc_father_id_path");
                            String motherId = rs.getString("doc_mother_id_path");
                            
                            String badgeClass = status != null ? "badge-" + status.toLowerCase() : "";
                %>
                <tr>
                    <!-- Column 1: Application Info -->
                    <td>
                        <span class="cell-main"><i class="fa-solid fa-hashtag" style="color:#94a3b8; font-size: 12px;"></i> <%= appNo %></span>
                        <span class="cell-sub"><i class="fa-regular fa-calendar" style="margin-right:4px;"></i> <%= appliedOn %></span>
                    </td>

                    <!-- Column 2: Child Details -->
                    <td>
                        <span class="cell-main"><%= childName %></span>
                        <span class="cell-sub">Born: <%= dob %> (<%= time %>)</span>
                        <span class="cell-sub">Gender: <%= gender %></span>
                    </td>

                    <!-- Column 3: Parents -->
                    <td>
                        <span class="cell-sub"><b>F:</b> <%= fatherName %></span>
                        <span class="cell-sub"><b>M:</b> <%= motherName %></span>
                    </td>

                    <!-- Column 4: Location & Contact -->
                    <td>
                        <span class="cell-main"><%= village %></span>
                        <span class="cell-sub"><i class="fa-solid fa-phone" style="font-size: 10px; margin-right:4px;"></i> <%= mobile %></span>
                    </td>

                    <!-- Column 5: Documents horizontally stacked -->
                    <td>
                        <div class="doc-stack">
                            <a href="<%= request.getContextPath() %>/<%= birthProof %>" target="_blank" class="doc-link">
                                <i class="fa-solid fa-file-pdf"></i> Birth Proof
                            </a>
                            <a href="<%= request.getContextPath() %>/<%= fatherId %>" target="_blank" class="doc-link father">
                                <i class="fa-solid fa-id-card"></i> Father ID
                            </a>
                            <a href="<%= request.getContextPath() %>/<%= motherId %>" target="_blank" class="doc-link mother">
                                <i class="fa-solid fa-id-card"></i> Mother ID
                            </a>
                        </div>
                    </td>

                    <!-- Column 6: Status -->
                    <td>
                        <span class="badge <%= badgeClass %>"><%= status %></span>
                    </td>

                    <!-- Column 7: Actions -->
                    <td>
                        <div class="action-stack">
                            <% if("Pending".equalsIgnoreCase(status)) { %>
                                <a href="birth_certificate.jsp?id=<%= appId %>" class="btn-action btn-approve">
                                    <i class="fa-solid fa-check"></i> Approve
                                </a>
                                <button class="btn-action btn-reject">
                                    <i class="fa-solid fa-xmark"></i> Reject
                                </button>
                            <% } else if("Approved".equalsIgnoreCase(status)) { %>
                                <a href="birth_certificate.jsp?id=<%= appId %>" class="btn-action btn-view">
                                    <i class="fa-solid fa-certificate"></i> View Certificate
                                </a>
                            <% } else { %>
                                <button class="btn-action btn-disabled" disabled>
                                    <i class="fa-solid fa-ban"></i> Denied
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
                            <td colspan="7">
                                <div class="empty-state">
                                    <i class="fa-regular fa-folder-open"></i>
                                    <h3>No applications found</h3>
                                    <p>There are currently no birth certificate applications available.</p>
                                </div>
                            </td>
                        </tr>
                <%
                        }

                    } catch(Exception e) {
                %>
                        <tr>
                            <td colspan="7">
                                <div class="empty-state" style="color: var(--danger);">
                                    <i class="fa-solid fa-triangle-exclamation" style="color: var(--danger);"></i>
                                    <h3>Error Loading Data</h3>
                                    <p><%= e.getMessage() %></p>
                                </div>
                            </td>
                        </tr>
                <%
                    } finally {
                        try { if(rs != null) rs.close(); } catch(Exception e) {}
                        try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
                        try { if(conn != null) conn.close(); } catch(Exception e) {}
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>