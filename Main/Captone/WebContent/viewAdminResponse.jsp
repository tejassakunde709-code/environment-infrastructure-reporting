<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Updates</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 50%, #90caf9 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        h2 {
            color: #1976d2;
            margin-bottom: 30px;
            font-size: 36px;
            font-weight: 700;
            text-align: center;
            text-shadow: 0 2px 10px rgba(25, 118, 210, 0.2);
        }

        .table-wrapper {
            background: linear-gradient(135deg, #ffffff 0%, #fafcff 100%);
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(25, 118, 210, 0.2);
            overflow: hidden;
            border: 1px solid rgba(25, 118, 210, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: transparent;
        }

        thead {
            background: linear-gradient(135deg, #42a5f5 0%, #2196f3 100%);
        }

        th {
            padding: 20px 16px;
            text-align: left;
            vertical-align: top;
            color: white;
            font-weight: 600;
            font-size: 15px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            border: none;
        }

        td {
            padding: 20px 16px;
            text-align: left;
            vertical-align: top;
            border-bottom: 1px solid #e3f2fd;
            color: #546e7a;
            line-height: 1.6;
        }

        tbody tr {
            transition: all 0.3s ease;
            background: white;
        }

        tbody tr:hover {
            background: linear-gradient(135deg, #f5f9ff 0%, #e8f4fd 100%);
            transform: scale(1.01);
            box-shadow: 0 4px 15px rgba(25, 118, 210, 0.1);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .image-cell {
            text-align: center;
            padding: 25px 16px;
        }

        .admin-image {
            max-width: 280px;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(25, 118, 210, 0.2);
            transition: transform 0.3s ease;
            border: 3px solid #e3f2fd;
        }

        .admin-image:hover {
            transform: scale(1.05);
            box-shadow: 0 12px 30px rgba(25, 118, 210, 0.3);
        }

        .debug-info {
            font-size: 12px;
            color: #1565c0;
            margin-bottom: 12px;
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            padding: 8px 14px;
            border-radius: 8px;
            display: inline-block;
            font-weight: 500;
            border: 1px solid #90caf9;
        }

        .debug-info strong {
            color: #0d47a1;
        }

        .no-image-text {
            color: #90a4ae;
            font-style: italic;
            font-size: 14px;
            padding: 20px;
            display: inline-block;
            background: #f5f9ff;
            border-radius: 8px;
            border: 2px dashed #e3f2fd;
        }

        .error-msg {
            color: #c62828;
            background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
            padding: 20px;
            border-radius: 12px;
            margin: 20px;
            border-left: 5px solid #d32f2f;
            box-shadow: 0 4px 15px rgba(211, 47, 47, 0.2);
        }

        .error-msg strong {
            display: block;
            margin-bottom: 8px;
            font-size: 16px;
        }

        .no-data-cell {
            text-align: center;
            padding: 60px 40px;
            color: #90a4ae;
            font-size: 16px;
            font-style: italic;
            background: linear-gradient(135deg, #f5f9ff 0%, #e8f4fd 100%);
        }

        .no-data-cell::before {
            content: "📭";
            display: block;
            font-size: 48px;
            margin-bottom: 15px;
        }

        td:first-child {
            font-size: 15px;
            color: #37474f;
            font-weight: 500;
        }

        td:last-child {
            font-size: 14px;
            color: #1976d2;
            font-weight: 600;
            white-space: nowrap;
        }

        @media (max-width: 968px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }

            tr {
                margin-bottom: 20px;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(25, 118, 210, 0.15);
            }

            td {
                border: none;
                position: relative;
                padding-left: 50%;
                text-align: right;
            }

            td:before {
                position: absolute;
                left: 16px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                text-align: left;
                font-weight: 600;
                color: #1976d2;
            }

            td:nth-of-type(1):before { content: "Message:"; }
            td:nth-of-type(2):before { content: "Image:"; }
            td:nth-of-type(3):before { content: "Updated At:"; }

            .image-cell {
                text-align: right;
                padding-left: 50%;
            }

            .admin-image {
                max-width: 100%;
            }
        }

        @media (max-width: 768px) {
            h2 {
                font-size: 28px;
            }

            body {
                padding: 20px 15px;
            }

            .table-wrapper {
                border-radius: 16px;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-wrapper {
            animation: fadeIn 0.5s ease-out;
        }

        tbody tr {
            animation: fadeIn 0.6s ease-out;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Admin Messages</h2>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Message</th>
                    <th>Image</th>
                    <th>Updated At</th>
                </tr>
            </thead>
            <tbody>
            <%
                // 1. Get the Complaint ID passed from the previous page's URL (e.g. page.jsp?id=5)
                String complaintId = request.getParameter("id"); 

                String url = "jdbc:mysql://localhost:3306/capstone?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true";
                String user = "root";
                String password = "";

                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");

                try {
                    // 2. Check if an ID was actually passed
                    if (complaintId == null || complaintId.trim().isEmpty()) {
            %>
                        <tr>
                            <td colspan="3" class="no-data-cell">
                                No specific complaint was selected. Please go back and choose a complaint.
                            </td>
                        </tr>
            <%
                    } else {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);

                        // 3. Modifed SQL to filter using WHERE complaint_id = ?
                        // NOTE: If your column name in the database is different (e.g., 'c_id'), change 'complaint_id' below
                        String sql = "SELECT admin_message, admin_image, updated_at FROM admin_updates WHERE complaint_id = ? ORDER BY updated_at DESC";
                        
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, complaintId); // Bind the passed ID to the SQL query
                        
                        rs = ps.executeQuery();

                        boolean hasData = false;

                        while(rs.next()) {
                            hasData = true;
                            String message = rs.getString("admin_message");
                            String imageName = rs.getString("admin_image");
                            Timestamp timestamp = rs.getTimestamp("updated_at");

                            if (message == null) message = "(No message)";
            %>
                            <tr>
                                <td><%= message.replace("\n", "<br>") %></td>
                                <td class="image-cell">
                                    <% if (imageName != null && !imageName.trim().isEmpty()) { %>
                                        <div class="debug-info">Loading: adminImages/<strong><%= imageName %></strong></div>
                                        <img src="adminImages/<%= imageName.trim() %>"
                                             alt="Admin uploaded image"
                                             class="admin-image"
                                             onerror="this.onerror=null; this.src='images/placeholder.jpg'; this.alt='Image not found';">
                                    <% } else { %>
                                        <span class="no-image-text">No image attached</span>
                                    <% } %>
                                </td>
                                <td><%= timestamp != null ? sdf.format(timestamp) : "—" %></td>
                            </tr>
            <%
                        }

                        if (!hasData) {
            %>
                            <tr>
                                <td colspan="3" class="no-data-cell">
                                    No admin updates found for this specific complaint
                                </td>
                            </tr>
            <%
                        }
                    }
                } catch(Exception e) {
            %>
                <tr>
                    <td colspan="3">
                        <div class="error-msg">
                            <strong>Database Error:</strong>
                            <%= e.getMessage() %>
                        </div>
                    </td>
                </tr>
            <%
                    e.printStackTrace();
                } finally {
                    try { if(rs != null) rs.close(); } catch(Exception ignored){}
                    try { if(ps != null) ps.close(); } catch(Exception ignored){}
                    try { if(conn != null) conn.close(); } catch(Exception ignored){}
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>