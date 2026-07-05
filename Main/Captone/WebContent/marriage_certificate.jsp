<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String appId = request.getParameter("appId");
    if(appId == null) { response.sendRedirect("user_view_marriage_certificate.jsp"); return; }
    
    String gName="", bName="", mDate="", mTime="", mPlace="", issueDate="";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone", "root", "");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM marriage_applications WHERE application_number=? AND status='Approved'");
        ps.setString(1, appId);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            gName = rs.getString("groom_name");
            bName = rs.getString("bride_name");
            mDate = rs.getString("marriage_date");
            mTime = rs.getString("time_of_marriage");
            mPlace = rs.getString("marriage_place");
            issueDate = rs.getDate("application_date").toString();
        } else {
            out.println("<h3 style='text-align:center; color:red; margin-top:50px;'>Certificate not found or not approved yet!</h3>");
            return;
        }
    } catch(Exception e) {}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Marriage Certificate - <%= appId %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #525659; display: flex; flex-direction: column; align-items: center; padding: 20px; font-family: 'Times New Roman', serif; }
        .certificate-container { 
            background: white; 
            width: 800px; 
            min-height: 1050px; 
            padding: 40px; 
            border: 15px solid #d81b60; 
            outline: 5px solid gold; 
            outline-offset: -20px;
            position: relative;
            margin-top: 10px;
        }
        .cert-header { text-align: center; color: #d81b60; margin-bottom: 30px; }
        .cert-title { font-size: 45px; font-weight: bold; text-transform: uppercase; letter-spacing: 2px; }
        .cert-body { font-size: 22px; text-align: center; line-height: 2; margin-top: 40px; }
        .name-highlight { font-size: 28px; font-weight: bold; color: #b71c1c; font-style: italic; }
        .footer-signatures { display: flex; justify-content: space-between; margin-top: 100px; }
        .sign-line { border-top: 2px solid #000; width: 200px; text-align: center; padding-top: 5px; font-weight: bold; }
        @media print {
            body { background: white; padding: 0; }
            .no-print { display: none !important; }
            .certificate-container { border: 15px solid #d81b60 !important; width: 100%; height: 100%; margin: 0; }
        }
    </style>
</head>
<body>

<div class="w-100 d-flex flex-column align-items-center">
    
    <!-- Action Buttons and Alerts (Hidden when Printing) -->
    <div class="text-center mb-3 no-print" style="width: 800px;">
        
        <!-- Alerts for Save Status -->
        <% String savedStatus = request.getParameter("saved"); 
           if("true".equals(savedStatus)) { %>
            <div class="alert alert-success fw-bold">✅ Certificate successfully saved to the Issued Database!</div>
        <% } else if ("exists".equals(savedStatus)) { %>
            <div class="alert alert-warning fw-bold">⚠️ This certificate is already saved in the database.</div>
        <% } else if ("error".equals(savedStatus)) { %>
            <div class="alert alert-danger fw-bold">❌ Error saving certificate. Please try again.</div>
        <% } %>

        <div class="d-flex justify-content-center gap-3">
            <button onclick="window.print()" class="btn btn-primary btn-lg">🖨️ Print Certificate</button>
            
            <!-- Save to Database Form -->
            <form action="SaveMarriageCertificateServlet" method="POST">
                <input type="hidden" name="appId" value="<%= appId %>">
                <button type="submit" class="btn btn-success btn-lg">💾 Save to Database</button>
            </form>
        </div>
    </div>

    <!-- The Certificate Document -->
    <div class="certificate-container">
        <div class="cert-header">
            <h2>GOVERNMENT OF INDIA</h2>
            <h3>Department of Panchayat Raj</h3>
            <h1 class="cert-title mt-4">Marriage Certificate</h1>
        </div>

        <div class="cert-body">
            <p>This is to certify that the marriage between</p>
            <p><span class="name-highlight"><%= gName %></span></p>
            <p>and</p>
            <p><span class="name-highlight"><%= bName %></span></p>
            <p>was solemnly solemnized on <b><%= mDate %></b> at <b><%= mTime %></b></p>
            <p>at <b><%= mPlace %></b>.</p>
            <p class="mt-4">This certificate is issued under the authority of the Gram Panchayat.</p>
        </div>

        <div class="mt-5" style="font-size: 16px;">
            <p><b>Application No:</b> <%= appId %></p>
            <p><b>Date of Issue:</b> <%= issueDate %></p>
        </div>

        <div class="footer-signatures">
            <div class="sign-line">Signature of Groom</div>
            <div class="sign-line text-danger"><b>SEAL</b></div>
            <div class="sign-line">Signature of Registrar</div>
        </div>
    </div>
</div>

</body>
</html>