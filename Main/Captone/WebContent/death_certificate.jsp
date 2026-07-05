<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String appId = request.getParameter("appId");
    if(appId == null) { response.sendRedirect("user_view_death_certificate.jsp"); return; }
    String dName="", mDate="", mTime="", mPlace="", issueDate="", age="", relationName="";
    
    try {
        Class.forName("com.mysql.jdbc.Driver"); Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone", "root", "");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM death_applications WHERE application_number=? AND status='Approved'");
        ps.setString(1, appId); ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            dName = rs.getString("deceased_name"); age = rs.getString("age"); relationName = rs.getString("father_husband_name");
            mDate = rs.getString("death_date"); mTime = rs.getString("time_of_death"); mPlace = rs.getString("death_place");
            issueDate = rs.getDate("application_date").toString();
        } else { return; }
    } catch(Exception e) {}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Death Certificate - <%= appId %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #525659; display: flex; flex-direction: column; align-items: center; padding: 20px; font-family: 'Times New Roman', serif; }
        .certificate-container { background: white; width: 800px; min-height: 1050px; padding: 40px; border: 15px solid #343a40; outline: 5px solid grey; outline-offset: -20px; position: relative; margin-top: 10px; }
        .cert-header { text-align: center; color: #343a40; margin-bottom: 30px; }
        .cert-title { font-size: 45px; font-weight: bold; text-transform: uppercase; letter-spacing: 2px; }
        .cert-body { font-size: 22px; text-align: center; line-height: 2; margin-top: 40px; }
        .name-highlight { font-size: 28px; font-weight: bold; text-decoration: underline; }
        .footer-signatures { display: flex; justify-content: space-between; margin-top: 100px; }
        .sign-line { border-top: 2px solid #000; width: 200px; text-align: center; padding-top: 5px; font-weight: bold; }
        @media print { body { background: white; padding: 0; } .no-print { display: none !important; } .certificate-container { border: 15px solid #343a40 !important; width: 100%; height: 100%; margin: 0; } }
    </style>
</head>
<body>
<div class="w-100 d-flex flex-column align-items-center">
    
    <div class="text-center mb-3 no-print" style="width: 800px;">
        <% String savedStatus = request.getParameter("saved"); if("true".equals(savedStatus)) { %>
            <div class="alert alert-success fw-bold">✅ Certificate saved to Issued Database!</div>
        <% } else if ("exists".equals(savedStatus)) { %>
            <div class="alert alert-warning fw-bold">⚠️ Certificate already exists in database.</div>
        <% } %>
        <div class="d-flex justify-content-center gap-3">
            <button onclick="window.print()" class="btn btn-primary btn-lg">🖨️ Print Certificate</button>
            <form action="SaveDeathCertificateServlet" method="POST"><input type="hidden" name="appId" value="<%= appId %>">
                <button type="submit" class="btn btn-dark btn-lg">💾 Save to Database</button>
            </form>
        </div>
    </div>

    <div class="certificate-container">
        <div class="cert-header"><h2>GOVERNMENT OF INDIA</h2><h3>Department of Panchayat Raj</h3><h1 class="cert-title mt-4">Death Certificate</h1></div>
        <div class="cert-body">
            <p>This is to certify that the following information has been taken from the original record of death which is the register for Gram Panchayat.</p>
            <p>Name of Deceased: <span class="name-highlight"><%= dName %></span> (Age: <%= age %>)</p>
            <p>Son/Wife/Daughter of: <b><%= relationName %></b></p>
            <p>Passed away on <b><%= mDate %></b> at <b><%= mTime %></b></p>
            <p>Place of Death: <b><%= mPlace %></b>.</p>
        </div>
        <div class="mt-5" style="font-size: 16px;"><p><b>Application No:</b> <%= appId %></p><p><b>Date of Issue:</b> <%= issueDate %></p></div>
        <div class="footer-signatures">
            <div class="sign-line">Local Authority</div><div class="sign-line text-dark"><b>SEAL</b></div><div class="sign-line">Signature of Registrar</div>
        </div>
    </div>
</div>
</body>
</html>