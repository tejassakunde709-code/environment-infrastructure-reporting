<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 1. Session Check
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    Integer userId    = (Integer) session.getAttribute("userId");
    String userName   = (String) session.getAttribute("userName");

    // Default values
    String fullName     = userName;
    String description  = "Active community member 🌱";
    String profilePhoto = "images/default.png";   // Default fallback

    int postCount   = 0;
    int likeCount   = 0;
    int totalPoints = 0;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone", "root", "");

        // 2. Fetch Profile Info
        ps = con.prepareStatement("SELECT * FROM user_profiles WHERE user_id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();
        if (rs.next()) {
            fullName     = rs.getString("full_name");
            description  = rs.getString("description");
            String dbPhoto = rs.getString("profile_photo");
            if (dbPhoto != null && !dbPhoto.trim().isEmpty()) {
                profilePhoto = dbPhoto; 
            }
        }
        rs.close(); ps.close();

        // 3. Stats: Posts count + points
        ps = con.prepareStatement("SELECT COUNT(*), IFNULL(SUM(points), 0) FROM posts WHERE user_id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();
        if (rs.next()) {
            postCount   = rs.getInt(1);
            totalPoints = rs.getInt(2);
        }
        rs.close(); ps.close();

        // 4. Stats: Likes received count
        ps = con.prepareStatement(
            "SELECT COUNT(*) FROM likes l JOIN posts p ON l.post_id = p.post_id WHERE p.user_id = ?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();
        if (rs.next()) {
            likeCount = rs.getInt(1);
        }

    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception ignored){}
        if (ps != null) try { ps.close(); } catch(Exception ignored){}
        if (con != null) try { con.close(); } catch(Exception ignored){}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile - <%= fullName %></title>
    
    <!-- Fonts and Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        /* ============================================
           CSS VARIABLES & GLOBAL STYLES
           ============================================ */
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --bg-color: #fafafa;
            --card-shadow: 0 10px 40px rgba(0,0,0,0.1);
            --card-shadow-hover: 0 15px 50px rgba(0,0,0,0.15);
            --border-radius: 24px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body { 
            background: linear-gradient(to bottom, #fafafa 0%, #f0f0f0 100%);
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; 
            padding-top: 90px; 
            color: #262626;
            min-height: 100vh;
        }
        
        /* ============================================
           NAVBAR - GLASSMORPHISM STYLE
           ============================================ */
        .navbar { 
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            border-bottom: 1px solid rgba(0,0,0,0.05);
            height: 80px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

        .navbar:hover {
            box-shadow: 0 6px 30px rgba(0,0,0,0.12);
        }

        .navbar-brand { 
            font-weight: 800; 
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
            font-size: 1.5rem;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            transform: translateX(-5px);
        }

        .navbar-brand i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* ============================================
           PROFILE CONTAINER
           ============================================ */
        .profile-box { 
            max-width: 950px; 
            margin: 0 auto; 
            padding: 0 20px; 
        }
        
        /* ============================================
           PROFILE HEADER CARD
           ============================================ */
        .profile-header {
            background: white; 
            border: none;
            border-radius: var(--border-radius);
            padding: 50px; 
            display: flex; 
            gap: 60px; 
            align-items: center;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
            animation: fadeInUp 0.6s ease;
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: var(--primary-gradient);
        }

        .profile-header:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* ============================================
           PROFILE PICTURE
           ============================================ */
        .profile-pic-container { 
            position: relative;
            animation: scaleIn 0.8s ease;
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .profile-pic {
            width: 180px; 
            height: 180px; 
            border-radius: 50%; 
            object-fit: cover;
            border: 6px solid #fff;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            transition: all 0.4s ease;
            position: relative;
        }

        .profile-pic:hover { 
            transform: scale(1.05) rotate(2deg);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.5);
        }

        .profile-pic-container::after {
            content: '';
            position: absolute;
            top: -10px;
            left: -10px;
            right: -10px;
            bottom: -10px;
            border-radius: 50%;
            background: var(--primary-gradient);
            opacity: 0.2;
            z-index: -1;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                opacity: 0.2;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.3;
            }
        }

        /* ============================================
           STATS SECTION
           ============================================ */
        .stats-container {
            display: flex;
            gap: 50px;
            margin: 30px 0;
        }

        .stats-item { 
            text-align: center;
            position: relative;
            padding: 15px 25px;
            border-radius: 16px;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            transition: all 0.3s ease;
        }

        .stats-item:hover {
            transform: translateY(-5px);
            background: var(--primary-gradient);
        }

        .stats-item:hover .stats-value,
        .stats-item:hover .stats-label {
            color: white;
        }

        .stats-value { 
            font-weight: 800; 
            font-size: 2rem; 
            display: block; 
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            transition: all 0.3s ease;
        }

        .stats-label { 
            color: #6c757d; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            letter-spacing: 1.5px;
            font-weight: 600;
            margin-top: 5px;
            display: block;
            transition: all 0.3s ease;
        }
        
        /* ============================================
           DESCRIPTION TEXT
           ============================================ */
        .description-text { 
            font-size: 1.1rem; 
            line-height: 1.8; 
            color: #555;
            font-weight: 400;
        }

        /* ============================================
           EDIT BUTTON
           ============================================ */
        .btn-edit {
            border-radius: 14px;
            padding: 12px 28px;
            font-weight: 700;
            background: var(--primary-gradient);
            border: none;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }

        .btn-edit i {
            transition: transform 0.3s ease;
        }

        .btn-edit:hover i {
            transform: rotate(15deg);
        }

        /* ============================================
           EDIT FORM CARD
           ============================================ */
        #editBox { 
            border-radius: var(--border-radius); 
            border: none; 
            box-shadow: var(--card-shadow); 
            animation: slideDown 0.5s ease-out;
            background: white;
            overflow: hidden;
            position: relative;
        }

        #editBox::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--success-gradient);
        }

        @keyframes slideDown {
            from { 
                opacity: 0; 
                transform: translateY(-30px); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0); 
            }
        }

        #editBox h5 {
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        #editBox .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }

        #editBox .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        #editBox .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }

        /* ============================================
           BUTTONS
           ============================================ */
        .btn-success {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border: none;
            font-weight: 700;
            padding: 12px 30px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.5);
        }

        .btn-light {
            background: #f8f9fa;
            border: 2px solid #dee2e6;
            font-weight: 600;
            padding: 12px 30px;
            transition: all 0.3s ease;
        }

        .btn-light:hover {
            background: #e9ecef;
            border-color: #adb5bd;
        }

        .btn-outline-danger {
            border: 2px solid #dc3545;
            font-weight: 700;
            transition: all 0.3s ease;
        }

        .btn-outline-danger:hover {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border-color: #dc3545;
            transform: scale(1.05);
        }

        /* ============================================
           SECTION TITLE
           ============================================ */
        .section-title {
            font-weight: 800;
            color: #222;
            position: relative;
            display: inline-block;
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 0;
            width: 60px;
            height: 5px;
            background: var(--primary-gradient);
            border-radius: 3px;
        }

        /* ============================================
           BADGE
           ============================================ */
        .badge {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%) !important;
            border: 2px solid #dee2e6;
            font-weight: 700;
            font-size: 0.85rem;
            padding: 10px 20px;
        }

        /* ============================================
           POST CARDS
           ============================================ */
        .post-card { 
            background: white; 
            border: none;
            border-radius: var(--border-radius); 
            margin: 40px 0; 
            overflow: hidden; 
            box-shadow: var(--card-shadow);
            transition: all 0.4s ease;
            animation: fadeInUp 0.6s ease;
        }

        .post-card:hover { 
            transform: translateY(-8px);
            box-shadow: var(--card-shadow-hover);
        }

        .post-header { 
            padding: 24px; 
            background: linear-gradient(to bottom, #fff 0%, #fafafa 100%);
            font-weight: 700;
            border-bottom: 1px solid #f0f0f0;
        }

        .post-header .rounded-circle {
            background: var(--primary-gradient) !important;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            width: 42px !important;
            height: 42px !important;
            font-size: 16px !important;
        }

        .post-image img { 
            width: 100%; 
            height: auto; 
            display: block;
            transition: transform 0.4s ease;
        }

        .post-card:hover .post-image img {
            transform: scale(1.02);
        }

        .post-actions { 
            padding: 20px 24px; 
            border-top: 1px solid #f0f0f0;
            background: #fafafa;
        }

        .post-actions i { 
            font-size: 1.5rem; 
            cursor: pointer; 
            transition: all 0.3s ease;
        }

        .post-actions .bi-heart-fill {
            color: #dc3545;
        }

        .post-actions .bi-heart-fill:hover { 
            transform: scale(1.2);
        }

        .post-actions .bi-chat-dots-fill {
            color: #0d6efd;
        }

        .post-actions .bi-chat-dots-fill:hover {
            transform: scale(1.2);
        }

        /* ============================================
           NO POSTS STATE
           ============================================ */
        .no-posts {
            background: white;
            border-radius: var(--border-radius);
            padding: 80px 40px;
            text-align: center;
            box-shadow: var(--card-shadow);
            color: #6c757d;
            font-size: 1.1rem;
        }

        .no-posts i {
            color: #dee2e6;
            margin-bottom: 20px;
        }

        /* ============================================
           ALERTS
           ============================================ */
        .alert-danger {
            border-radius: 16px;
            border: none;
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.2);
            font-weight: 600;
        }

        /* ============================================
           RESPONSIVE DESIGN
           ============================================ */
        @media (max-width: 768px) {
            body {
                padding-top: 70px;
            }

            .navbar {
                height: 70px;
            }

            .profile-header {
                flex-direction: column;
                text-align: center;
                padding: 30px;
                gap: 30px;
            }

            .stats-container {
                flex-direction: column;
                gap: 20px;
            }

            .stats-item {
                width: 100%;
            }

            .profile-pic {
                width: 140px;
                height: 140px;
            }

            .section-title {
                font-size: 1.5rem;
            }

            #editBox {
                padding: 20px !important;
            }
        }

        /* ============================================
           SCROLLBAR STYLING
           ============================================ */
        ::-webkit-scrollbar {
            width: 12px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-gradient);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }

        /* ============================================
           UTILITY ANIMATIONS
           ============================================ */
        @keyframes shimmer {
            0% {
                background-position: -1000px 0;
            }
            100% {
                background-position: 1000px 0;
            }
        }

        .loading-shimmer {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 1000px 100%;
            animation: shimmer 2s infinite;
        }
    </style>
</head>
<body>

<!-- NAVIGATION BAR -->
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
    <div class="container" style="max-width: 935px;">
        <a class="navbar-brand d-flex align-items-center" href="community.jsp">
            <i class="bi bi-arrow-left-circle-fill me-2 fs-4"></i> Community
        </a>
        <div class="d-flex align-items-center">
             <span class="me-3 fw-medium text-muted">@<%= userName %></span>
             <a href="logout.jsp" class="btn btn-sm btn-outline-danger rounded-pill px-3">Logout</a>
        </div>
    </div>
</nav>

<div class="profile-box">

    <!-- PROFILE HEADER -->
    <div class="profile-header mt-4">
        <div class="profile-pic-container">
            <img src="${pageContext.request.contextPath}/<%= profilePhoto %>"
                 class="profile-pic"
                 alt="Profile"
                 onerror="this.src='${pageContext.request.contextPath}/images/default.png';">
        </div>

        <div class="flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="fw-bold mb-0" style="font-size: 2rem; color: #222;"><%= fullName %></h3>
                <button class="btn btn-primary btn-edit btn-sm"
                        onclick="document.getElementById('editBox').style.display='block'">
                    <i class="bi bi-pencil-square me-2"></i>Edit Profile
                </button>
            </div>

            <div class="stats-container">
                <div class="stats-item">
                    <span class="stats-value"><%= postCount %></span>
                    <span class="stats-label">Posts</span>
                </div>
                <div class="stats-item">
                    <span class="stats-value"><%= likeCount %></span>
                    <span class="stats-label">Likes</span>
                </div>
                <div class="stats-item">
                    <span class="stats-value"><%= totalPoints %></span>
                    <span class="stats-label">Points</span>
                </div>
            </div>

            <p class="description-text mb-0"><%= description %></p>
        </div>
    </div>

    <!-- EDIT FORM -->
    <div id="editBox" class="card p-4 mt-4" style="display:none;">
        <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
            <h5 class="fw-bold mb-4">Edit Profile Settings</h5>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold">Display Name</label>
                    <input class="form-control rounded-3" name="full_name" value="<%= fullName %>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold">New Profile Photo</label>
                    <input type="file" class="form-control rounded-3" name="profile_photo" accept="image/*">
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Bio / Description</label>
                <textarea class="form-control rounded-3" name="description" rows="3"><%= description %></textarea>
            </div>
            <div class="mt-2">
                <button type="submit" class="btn btn-success rounded-3 px-4 fw-bold">Save Changes</button>
                <button type="button" class="btn btn-light rounded-3 ms-2 px-4"
                        onclick="document.getElementById('editBox').style.display='none'">Cancel</button>
            </div>
        </form>
    </div>

    <!-- YOUR POSTS SECTION -->
    <div class="mt-5 mb-4 d-flex align-items-center justify-content-between">
        <h4 class="section-title">Your Timeline</h4>
        <span class="badge bg-light text-dark rounded-pill px-3 py-2 border">Latest Activities</span>
    </div>

    <%
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone", "root", "");

            String sql = 
                "SELECT p.post_id, p.image_path, p.caption, " +
                "COUNT(DISTINCT l.like_id) AS like_count, " +
                "COUNT(DISTINCT c.comment_id) AS comment_count " +
                "FROM posts p " +
                "LEFT JOIN likes l ON p.post_id = l.post_id " +
                "LEFT JOIN comments c ON p.post_id = c.post_id " +
                "WHERE p.user_id = ? " +
                "GROUP BY p.post_id ORDER BY p.post_id DESC";

            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
    %>
            <div class="no-posts shadow-sm">
                <i class="bi bi-camera fs-1 d-block mb-3 text-muted"></i>
                No posts yet. Start sharing your community activities!
            </div>
    <%
            }

            while (rs.next()) {
                String imgPath  = rs.getString("image_path");
                String caption  = rs.getString("caption");
                int likes    = rs.getInt("like_count");
                int comments = rs.getInt("comment_count");
    %>
            <div class="post-card">
                <div class="post-header d-flex align-items-center">
                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-3" style="width:42px; height:42px; font-size:16px; font-weight:bold;">
                        <%= fullName.substring(0,1).toUpperCase() %>
                    </div>
                    <span style="font-weight: 700; font-size: 1.05rem;"><%= fullName %></span>
                </div>
                <div class="post-image">
                    <img src="${pageContext.request.contextPath}/<%= imgPath %>" alt="Post">
                </div>
                <div class="post-actions d-flex align-items-center">
                    <div class="me-4">
                        <i class="bi bi-heart-fill text-danger me-2"></i>
                        <span class="fw-bold" style="font-size: 1rem;"><%= likes %></span>
                    </div>
                    <div>
                        <i class="bi bi-chat-dots-fill text-muted me-2"></i>
                        <span class="fw-bold" style="font-size: 1rem;"><%= comments %></span>
                    </div>
                </div>
                <div class="px-4 pb-4">
                    <% if (caption != null && !caption.trim().isEmpty()) { %>
                        <div class="description-text"><strong class="me-2"><%= fullName %></strong> <%= caption %></div>
                    <% } %>
                </div>
            </div>
    <%
            }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger mt-4'>Error loading timeline: " + e.getMessage() + "</div>");
        } finally {
            if (rs != null) try { rs.close(); } catch(Exception ignored){}
            if (ps != null) try { ps.close(); } catch(Exception ignored){}
            if (con != null) try { con.close(); } catch(Exception ignored){}
        }
    %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
