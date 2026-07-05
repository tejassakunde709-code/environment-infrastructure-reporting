<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Official Birth Certificate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #525659; /* Dark background like PDF viewer */
            font-family: 'Times New Roman', serif;
        }
        .a4-container {
            width: 210mm;
            min-height: 297mm;
            padding: 20mm;
            margin: 30px auto;
            background: white;
            box-shadow: 0 0 15px rgba(0,0,0,0.5);
            position: relative;
        }
        .cert-border {
            border: 5px double #003366;
            padding: 30px;
            height: 100%;
            position: relative;
        }
        .govt-header {
            text-align: center;
            color: #003366;
            margin-bottom: 30px;
        }
        .govt-header h2, .govt-header h3, .govt-header h4 { margin: 5px 0; font-weight: bold; }
        .cert-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            text-decoration: underline;
            margin: 20px 0;
            color: #b30000;
        }
        .cert-text { font-size: 16px; line-height: 1.6; text-align: justify; margin-bottom: 20px; }
        .info-table { width: 100%; font-size: 16px; margin-bottom: 30px; }
        .info-table td { padding: 8px; vertical-align: top; }
        .info-table td:nth-child(odd) { font-weight: bold; width: 35%; }
        
        .footer-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 50px;
        }
        .stamp {
            width: 120px;
            height: 120px;
            border: 3px dashed #003366;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            font-size: 12px;
            color: #003366;
            font-weight: bold;
            opacity: 0.8;
            transform: rotate(-15deg);
        }
        .signature { text-align: center; font-weight: bold; color: #003366;}
        .signature img { width: 150px; height: auto; margin-bottom: 10px; }
        
        /* Hide buttons when printing */
        @media print {
            body { background: white; margin: 0; padding: 0; }
            .a4-container { box-shadow: none; margin: 0; padding: 10mm; width: 100%; }
            .no-print { display: none !important; }
        }
    </style>
</head>
<body>

<%
    String appIdParam = request.getParameter("id");
    if(appIdParam == null || appIdParam.trim().isEmpty()) {
        out.println("<h3 class='text-center text-white mt-5'>Invalid Application ID.</h3>");
        return;
    }

    // Capture success/error flags from the Servlet
    String savedStatus = request.getParameter("saved");
    String errorStatus = request.getParameter("error");

    String DB_URL = "jdbc:mysql://localhost:3306/capstone";
    String DB_USER = "root";
    String DB_PASS = "";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        
        // Updates the status to 'Approved' when this page is accessed
        String updateSql = "UPDATE birth_applications SET status = 'Approved' WHERE application_id = ?";
        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
        updateStmt.setInt(1, Integer.parseInt(appIdParam));
        updateStmt.executeUpdate();
        updateStmt.close();

        // Fetch application details
        String sql = "SELECT * FROM birth_applications WHERE application_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(appIdParam));
        rs = pstmt.executeQuery();

        if(rs.next()) {
            String appNo = rs.getString("application_number");
            String appliedOn = rs.getString("applied_on");
            String childName = rs.getString("child_name");
            if(childName == null || childName.trim().isEmpty()) childName = "<i>(Not Named)</i>";
            
            String dob = rs.getString("dob");
            String time = rs.getString("time_of_birth");
            String gender = rs.getString("gender");
            String birthPlace = rs.getString("birth_place");
            String fatherName = rs.getString("father_name");
            String fatherAadhaar = rs.getString("father_aadhaar");
            String motherName = rs.getString("mother_name");
            String motherAadhaar = rs.getString("mother_aadhaar");
            String address = rs.getString("address");
            String village = rs.getString("gram_panchayat");
            String district = rs.getString("district");
            String pincode = rs.getString("pincode");
%>

<!-- Notification Messages (Hidden during print) -->
<% if ("true".equals(savedStatus)) { %>
    <div class="alert alert-success text-center no-print mt-3 mx-auto" style="max-width: 800px;">
        ✅ Certificate successfully saved to the database!
    </div>
<% } else if ("true".equals(errorStatus)) { %>
    <div class="alert alert-danger text-center no-print mt-3 mx-auto" style="max-width: 800px;">
        ⚠️ Error saving certificate. It might already be saved in the database.
    </div>
<% } %>

<div class="text-center mt-3 no-print">
    <button class="btn btn-primary btn-lg" onclick="window.print()">🖨️ Print Certificate</button>
    
    <!-- NEW: Save to Database Button -->
    <form action="SaveCertificateServlet" method="POST" class="d-inline-block m-0">
        <input type="hidden" name="application_id" value="<%= appIdParam %>">
        <button type="submit" class="btn btn-success btn-lg">💾 Save to Database</button>
    </form>

    <a href="admin_view_applications.jsp" class="btn btn-secondary btn-lg">Back to Dashboard</a>
</div>

<div class="a4-container">
    <div class="cert-border">
        
        <div class="govt-header">
            <h3>GOVERNMENT OF INDIA</h3>
            <h4>DEPARTMENT OF HEALTH & FAMILY WELFARE</h4>
            <h5>GRAM PANCHAYAT / NAGAR PARISHAD: <%= village.toUpperCase() %></h5>
        </div>

        <div class="cert-title">BIRTH CERTIFICATE (Form - 5)</div>

        <p class="cert-text">
            (Issued under Section 12/17 of the Registration of Births and Deaths Act, 1969 and Rule 8/13 of the State Registration of Births and Deaths Rules 1999)
            <br><br>
            This is to certify that the following information has been taken from the original record of birth which is the register for Gram Panchayat/Nagar Parishad <strong><%= village %></strong> of Tahsil/Block <strong><%= village %></strong> of District <strong><%= district %></strong> of State/Union Territory <strong>India</strong>.
        </p>

        <table class="info-table">
            <tr>
                <td>Name of Child:</td>
                <td colspan="3"><strong><%= childName.toUpperCase() %></strong></td>
            </tr>
            <tr>
                <td>Sex / Gender:</td>
                <td><%= gender %></td>
                <td>Date of Birth:</td>
                <td><%= dob %></td>
            </tr>
            <tr>
                <td>Time of Birth:</td>
                <td><%= time %></td>
                <td>Place of Birth:</td>
                <td><%= birthPlace %></td>
            </tr>
            <tr>
                <td>Name of Mother:</td>
                <td><%= motherName %> <br><small>(UID: <%= motherAadhaar %>)</small></td>
                <td>Name of Father:</td>
                <td><%= fatherName %> <br><small>(UID: <%= fatherAadhaar %>)</small></td>
            </tr>
            <tr>
                <td>Address of Parents at the time of birth:</td>
                <td colspan="3"><%= address %>, <%= village %>, <%= district %> - <%= pincode %></td>
            </tr>
            <tr>
                <td>Registration / App No:</td>
                <td><%= appNo %></td>
                <td>Date of Registration:</td>
                <td><%= appliedOn.substring(0, 10) %></td>
            </tr>
        </table>

        <div class="footer-section">
            <div class="stamp">
                SEAL OF <br> GRAM PANCHAYAT <br> <%= village.toUpperCase() %>
            </div>
            
            <div class="signature">
                <!-- If you have a real signature image in your images folder, uncomment the line below -->
                <!-- <img src="images/admin_signature.png" alt="Signature"> -->
                <br>
                ___________________________ <br>
                Signature of Issuing Authority <br>
                <strong>Registrar (Birth & Death)</strong> <br>
                Gram Panchayat, <%= village %>
            </div>
        </div>

    </div>
</div>

<%
        } else {
            out.println("<h3 class='text-center text-white mt-5'>Application not found!</h3>");
        }
    } catch(Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e) {}
        try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
        try { if(conn != null) conn.close(); } catch(Exception e) {}
    }
%>

</body>
</html>