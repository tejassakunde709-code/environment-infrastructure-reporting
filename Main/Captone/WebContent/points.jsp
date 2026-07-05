<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // 1. Session Check
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    int userId = (int) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    
    // Variables to hold data
    int totalPoints = 0;
    Connection con = null;
    PreparedStatement psPoints = null;
    PreparedStatement psPosts = null;
    ResultSet rsPoints = null;
    ResultSet rsPosts = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone", "root", "");

        // 2. FETCH TOTAL POINTS
        String sqlPoints = "SELECT total_points FROM user_points WHERE user_id = ?";
        psPoints = con.prepareStatement(sqlPoints);
        psPoints.setInt(1, userId);
        rsPoints = psPoints.executeQuery();

        if (rsPoints.next()) {
            totalPoints = rsPoints.getInt("total_points");
        }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Points | Community</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        /* ============================================
           CSS VARIABLES & RESET
           ============================================ */
        :root {
            --eco-green: #27ae60;
            --eco-dark: #1e8449;
            --eco-light: #2ecc71;
            --soft-bg: #f4f7f6;
            --glass: rgba(255, 255, 255, 0.95);
            --gold: #f39c12;
            --gold-dark: #e67e22;
            --purple: #9b59b6;
            --blue: #3498db;
            --card-shadow: 0 10px 40px rgba(0,0,0,0.1);
            --card-shadow-hover: 0 15px 50px rgba(0,0,0,0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            color: #2c3e50;
            padding-top: 85px;
            min-height: 100vh;
        }

        /* ============================================
           NAVBAR STYLING - GLASSMORPHISM
           ============================================ */
        .navbar {
            background: var(--glass);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            border-bottom: 1px solid rgba(0,0,0,0.08);
            padding: 16px 0;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

        .navbar:hover {
            box-shadow: 0 6px 30px rgba(0,0,0,0.12);
        }

        .navbar-brand { 
            font-weight: 900; 
            background: linear-gradient(135deg, var(--eco-green) 0%, var(--eco-light) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
            font-size: 1.6rem;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .nav-link-custom { 
            font-size: 1.3rem; 
            margin-left: 24px; 
            color: #555; 
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link-custom:hover { 
            color: var(--eco-green); 
            transform: translateY(-3px) scale(1.1);
        }

        .nav-link-custom::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%) scaleX(0);
            width: 30px;
            height: 3px;
            background: var(--eco-green);
            border-radius: 2px;
            transition: transform 0.3s ease;
        }

        .nav-link-custom:hover::after {
            transform: translateX(-50%) scaleX(1);
        }

        /* ============================================
           MAIN CONTAINER
           ============================================ */
        .points-box { 
            max-width: 900px; 
            margin: 50px auto; 
            padding: 0 20px;
        }

        /* ============================================
           SUMMARY CARD - HERO STYLE
           ============================================ */
        .summary-card {
            background: linear-gradient(135deg, var(--eco-green) 0%, var(--eco-dark) 100%);
            border-radius: 28px;
            padding: 50px;
            color: white;
            box-shadow: 0 20px 60px rgba(39, 174, 96, 0.4);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
            margin-bottom: 50px;
            transition: all 0.4s ease;
            animation: slideInDown 0.8s ease;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .summary-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 70px rgba(39, 174, 96, 0.5);
        }

        .summary-card::before {
            content: "";
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .summary-card::after {
            content: "\f005";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            position: absolute;
            right: -30px;
            top: -30px;
            font-size: 12rem;
            opacity: 0.08;
            animation: pulse 3s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
                opacity: 0.08;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.12;
            }
        }

        .summary-content {
            position: relative;
            z-index: 2;
        }

        .summary-card h4 { 
            font-weight: 300; 
            margin-bottom: 8px;
            font-size: 1.2rem;
            opacity: 0.9;
        }

        .summary-card .user-name { 
            font-weight: 800; 
            font-size: 2.2rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            margin-bottom: 12px;
        }

        .summary-message {
            opacity: 0.95;
            font-size: 1rem;
            font-weight: 500;
        }

        .points-display { 
            text-align: right;
            position: relative;
            z-index: 2;
        }

        .points-display p {
            opacity: 0.9;
            font-size: 0.95rem;
            margin: 0;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .points-display h2 { 
            font-size: 4rem; 
            font-weight: 900;
            margin: 10px 0;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.2);
            background: linear-gradient(135deg, #fff 0%, rgba(255,255,255,0.8) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .points-trophy {
            font-size: 3rem;
            margin-bottom: 10px;
            display: inline-block;
            animation: bounce 2s ease-in-out infinite;
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        /* ============================================
           ACTIVITY HISTORY SECTION
           ============================================ */
        .history-title {
            font-weight: 800;
            color: #2c3e50;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            font-size: 1.6rem;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .history-title i { 
            margin-right: 15px; 
            background: linear-gradient(135deg, var(--eco-green) 0%, var(--eco-light) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.8rem;
        }

        /* ============================================
           ACTIVITY CARDS
           ============================================ */
        .activity-card {
            background: white;
            border: none;
            border-radius: 20px;
            padding: 24px;
            margin-bottom: 20px;
            display: flex;
            gap: 24px;
            align-items: center;
            box-shadow: var(--card-shadow);
            transition: all 0.4s ease;
            border-left: 5px solid transparent;
            position: relative;
            overflow: hidden;
            animation: slideInRight 0.6s ease;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .activity-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(39, 174, 96, 0.05) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .activity-card:hover {
            transform: translateX(10px) scale(1.02);
            box-shadow: var(--card-shadow-hover);
            border-left: 5px solid var(--eco-green);
        }

        .activity-card:hover::before {
            opacity: 1;
        }

        .activity-card img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 16px;
            box-shadow: 0 6px 16px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
        }

        .activity-card:hover img {
            transform: scale(1.05) rotate(2deg);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .activity-info { 
            flex-grow: 1;
            position: relative;
            z-index: 2;
        }

        .activity-info h6 { 
            font-weight: 800; 
            margin-bottom: 8px; 
            color: #2c3e50;
            display: flex;
            align-items: center;
            font-size: 1.1rem;
        }

        .activity-info h6 i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .activity-info .caption { 
            font-size: 0.95rem; 
            color: #666; 
            margin-bottom: 8px;
            line-height: 1.5;
        }

        .activity-info .date { 
            font-size: 0.85rem; 
            color: #95a5a6; 
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .activity-info .date i {
            margin-right: 6px;
        }

        /* ============================================
           POINTS BADGE
           ============================================ */
        .points-badge {
            background: linear-gradient(135deg, #e8f6ef 0%, #d5ead7 100%);
            color: var(--eco-green);
            padding: 12px 20px;
            border-radius: 50px;
            font-weight: 900;
            font-size: 1.1rem;
            border: 2px solid rgba(39, 174, 96, 0.2);
            box-shadow: 0 4px 12px rgba(39, 174, 96, 0.2);
            transition: all 0.3s ease;
            white-space: nowrap;
            position: relative;
            z-index: 2;
        }

        .points-badge:hover {
            transform: scale(1.1) rotate(-5deg);
            box-shadow: 0 6px 16px rgba(39, 174, 96, 0.3);
            background: linear-gradient(135deg, var(--eco-green) 0%, var(--eco-light) 100%);
            color: white;
        }

        /* ============================================
           EMPTY STATE
           ============================================ */
        .empty-state {
            background: white;
            border-radius: 20px;
            padding: 80px 40px;
            text-align: center;
            box-shadow: var(--card-shadow);
        }

        .empty-state i {
            font-size: 5rem;
            color: #dfe6e9;
            margin-bottom: 20px;
            display: block;
        }

        .empty-state p {
            color: #95a5a6;
            font-size: 1.1rem;
            font-weight: 500;
        }

        /* ============================================
           ALERT STYLING
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
           FOOTER
           ============================================ */
        .footer-text {
            text-align: center;
            margin-top: 60px;
            padding: 30px 0;
            color: #7f8c8d;
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* ============================================
           RESPONSIVE DESIGN
           ============================================ */
        @media (max-width: 768px) {
            body {
                padding-top: 70px;
            }

            .summary-card { 
                flex-direction: column; 
                text-align: center; 
                gap: 30px;
                padding: 35px;
            }

            .summary-card .user-name {
                font-size: 1.8rem;
            }

            .points-display { 
                text-align: center;
            }

            .points-display h2 {
                font-size: 3rem;
            }

            .activity-card { 
                flex-direction: column; 
                text-align: center;
                padding: 20px;
            }

            .activity-card img { 
                width: 100%; 
                max-width: 300px;
                height: 200px;
            }

            .activity-info h6,
            .activity-info .date {
                justify-content: center;
            }

            .history-title {
                font-size: 1.3rem;
            }

            .nav-link-custom {
                margin-left: 15px;
                font-size: 1.1rem;
            }
        }

        @media (max-width: 480px) {
            .navbar-brand {
                font-size: 1.3rem;
            }

            .summary-card {
                padding: 25px;
            }

            .points-display h2 {
                font-size: 2.5rem;
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
            background: linear-gradient(135deg, var(--eco-green) 0%, var(--eco-light) 100%);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, var(--eco-light) 0%, var(--eco-green) 100%);
        }

        /* ============================================
           LOADING ANIMATION
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
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="community.jsp">🌱 COMMUNITY</a>
        <div class="ms-auto d-flex align-items-center">
            <a href="community.jsp" class="nav-link-custom" title="Home"><i class="fa-solid fa-house"></i></a>
            <a href="demo.jsp" class="nav-link-custom" title="Dashboard"><i class="fa-solid fa-chart-simple"></i></a>
            <a href="createPost.jsp" class="nav-link-custom" title="New Activity"><i class="fa-solid fa-circle-plus"></i></a>
            <a href="profile.jsp" class="nav-link-custom" title="Profile"><i class="fa-solid fa-circle-user"></i></a>
        </div>
    </div>
</nav>

<div class="points-box">

    <!-- POINTS SUMMARY HERO -->
    <div class="summary-card">
        <div class="summary-content">
            <h4>Hello,</h4>
            <div class="user-name"><%= userName %></div>
            <p class="summary-message">Keep contributing to help our planet! 🌍</p>
        </div>
        <div class="points-display">
            <div class="points-trophy">🏆</div>
            <p>Total Balance</p>
            <h2><%= totalPoints %></h2>
            <p>Community Points</p>
        </div>
    </div>

    <!-- ACTIVITY HISTORY LIST -->
    <h5 class="history-title"><i class="fa-solid fa-clock-rotate-left"></i> Activity History</h5>

    <%
        // 3. FETCH ACTIVITY HISTORY (POSTS)
        String sqlPosts = "SELECT * FROM posts WHERE user_id = ? ORDER BY created_at DESC";
        psPosts = con.prepareStatement(sqlPosts);
        psPosts.setInt(1, userId);
        rsPosts = psPosts.executeQuery();

        if (!rsPosts.isBeforeFirst()) {
            out.print("<div class='empty-state'><i class='fa-solid fa-leaf'></i><p>No activities yet. Start contributing today!</p></div>");
        }

        while(rsPosts.next()){
            
            String dbPath = rsPosts.getString("image_path");
            String finalPath = "https://via.placeholder.com/150?text=No+Image"; 

            if(dbPath != null && !dbPath.trim().isEmpty()){
                String filename = dbPath.trim().replace("\\", "/");
                if(filename.contains("/")){
                    filename = filename.substring(filename.lastIndexOf("/") + 1);
                }
                finalPath = "images/" + filename; 
            }
    %>

    <div class="activity-card">
        <img src="<%= finalPath %>" alt="Activity Image" onerror="this.src='https://via.placeholder.com/90?text=Activity'">
        
        <div class="activity-info">
            <h6>
                <% 
                    String type = rsPosts.getString("activity_type");
                    if("Tree Plantation".equals(type)) out.print("<i class='fa-solid fa-tree text-success me-2'></i>");
                    else if("Cleaning Activity".equals(type)) out.print("<i class='fa-solid fa-broom text-warning me-2'></i>");
                    else out.print("<i class='fa-solid fa-circle-check text-primary me-2'></i>");
                    out.print(type); 
                %>
            </h6>
            <p class="caption mb-1"><%= rsPosts.getString("caption") %></p>
            <div class="date"><i class="fa-regular fa-calendar-days me-1"></i> <%= rsPosts.getString("created_at") %></div>
        </div>
        
        <div class="points-badge">
            +<%= rsPosts.getInt("points") %> pts
        </div>
    </div>

    <%
        } // End While Loop

    } catch(Exception e) {
    %>
        <div class="alert alert-danger shadow-sm">
            <i class="fa-solid fa-triangle-exclamation me-2"></i> Error: <%= e.getMessage() %>
        </div>
    <%
    } finally {
        try{ if(rsPoints!=null) rsPoints.close(); }catch(Exception e){}
        try{ if(rsPosts!=null) rsPosts.close(); }catch(Exception e){}
        try{ if(psPoints!=null) psPoints.close(); }catch(Exception e){}
        try{ if(psPosts!=null) psPosts.close(); }catch(Exception e){}
        try{ if(con!=null) con.close(); }catch(Exception e){}
    }
    %>

    <div class="footer-text">
        <small>© 2024 Community Green Program. All rights reserved.</small>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
