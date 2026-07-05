<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // --- 1. AUTHENTICATION & ROLE DETECTION ---
    String userName = "Guest";
    String currentUserRole = null; // "USER" or "ADMIN"
    String avatarLetter = "G";

    // CHECK ADMIN SESSION
    if (session.getAttribute("adminId") != null) {
        currentUserRole = "ADMIN";
        // Get Admin Name (fallback to generic if null)
        String admName = (String) session.getAttribute("adminName");
        userName = (admName != null) ? admName : "Administrator";
    } 
    // CHECK USER SESSION
    else if (session.getAttribute("userId") != null) {
        currentUserRole = "USER";
        // Get User Name
        String uName = (String) session.getAttribute("userName");
        userName = (uName != null) ? uName : "Citizen";
    } 
    // NO SESSION -> REDIRECT
    else {
        response.sendRedirect("roleSelection.jsp");
        return;
    }

    // Get first letter for Avatar
    if(userName != null && userName.length() > 0) {
        avatarLetter = userName.substring(0,1).toUpperCase();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Community Feed - <%= userName %></title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        /* ============================================
           GLOBAL STYLES
           ============================================ */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: linear-gradient(to bottom, #fafafa 0%, #f0f0f0 100%); font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; color: #262626; min-height: 100vh; }

        /* ============================================
           TOP NAVIGATION
           ============================================ */
        .top-nav { background: #fff; border-bottom: 1px solid #dbdbdb; height: 60px; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .nav-container { max-width: 975px; margin: 0 auto; width: 100%; display: flex; justify-content: space-between; align-items: center; padding: 0 20px; height: 100%; }
        .logo { font-family: 'Arial Rounded MT Bold', Arial, sans-serif; font-size: 1.75rem; font-weight: bold; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; text-decoration: none; letter-spacing: -0.5px; }
        .nav-icons i { font-size: 24px; margin: 0 12px; cursor: pointer; transition: all 0.3s ease; color: #262626; }
        .nav-icons i:hover { color: #667eea; transform: scale(1.15); }
        .logout-link { color: #ed4956 !important; font-weight: 700 !important; font-size: 14px !important; transition: all 0.3s ease; }
        .logout-link:hover { color: #c13584 !important; }

        /* ============================================
           LEFT SIDEBAR MENU
           ============================================ */
        .sidebar { position: fixed; width: 250px; height: 100vh; padding: 30px 20px; border-right: 1px solid #dbdbdb; background: #fff; box-shadow: 2px 0 8px rgba(0,0,0,0.05); }
        .sidebar a { display: flex; align-items: center; padding: 14px 16px; color: #262626; text-decoration: none; font-size: 16px; font-weight: 500; margin-bottom: 8px; transition: all 0.3s ease; border-radius: 12px; position: relative; overflow: hidden; }
        .sidebar a::before { content: ''; position: absolute; left: 0; top: 0; height: 100%; width: 4px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); transform: scaleY(0); transition: transform 0.3s ease; }
        .sidebar a:hover { background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%); transform: translateX(5px); }
        .sidebar a:hover::before { transform: scaleY(1); }
        .sidebar a i { font-size: 24px; margin-right: 16px; width: 24px; transition: all 0.3s ease; }
        .sidebar a:hover i { color: #667eea; }

        /* ============================================
           POST CARD STYLING
           ============================================ */
        .feed-container { max-width: 600px; margin: 30px auto; }
        .post-card { background: #fff; border: 1px solid #dbdbdb; border-radius: 16px; margin-bottom: 24px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.08); transition: all 0.4s ease; animation: fadeInUp 0.6s ease; }
        .post-card:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(0,0,0,0.12); }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        
        .post-header { padding: 16px; display: flex; align-items: center; background: linear-gradient(to bottom, #fff 0%, #fafafa 100%); }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); margin-right: 14px; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 16px; color: #fff; border: 3px solid #fff; box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3); }
        .username { font-weight: 700; font-size: 15px; text-decoration: none; color: #262626; transition: color 0.3s ease; }
        .username:hover { color: #667eea; }
        .post-header .bi-three-dots { cursor: pointer; transition: all 0.3s ease; }
        .post-header .bi-three-dots:hover { color: #667eea; transform: scale(1.2); }
        
        .post-img { width: 100%; height: auto; max-height: 600px; object-fit: cover; display: block; background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); }
        .post-body { padding: 16px; }
        .post-actions { display: flex; gap: 18px; margin-bottom: 12px; align-items: center; }
        .post-actions i { font-size: 26px; cursor: pointer; transition: all 0.3s ease; color: #262626; }
        .post-actions i:hover { transform: scale(1.2); }
        .post-actions .bi-heart:hover { color: #ed4956; }
        .action-btn { background: none; border: none; padding: 0; color: #262626; cursor: pointer; }
        
        .likes-count { font-weight: 700; font-size: 14px; margin-bottom: 8px; }
        .post-caption { font-size: 14px; line-height: 20px; margin-bottom: 8px; }
        .post-caption .fw-bold { font-weight: 700 !important; margin-right: 4px; }
        .post-date { font-size: 10px; text-transform: uppercase; letter-spacing: 0.5px; color: #8e8e8e; margin-bottom: 12px; }
        
        .comment-section { margin-top: 12px; font-size: 14px; max-height: 200px; overflow-y: auto; }
        .single-comment { margin-bottom: 6px; padding: 6px 0; line-height: 20px; }
        .comment-username { font-weight: 700; margin-right: 6px; color: #262626; }
        
        .comment-input-area { border-top: 1px solid #efefef; padding: 14px 16px; display: flex; align-items: center; background: #fafafa; transition: all 0.3s ease; }
        .comment-input-area:hover { background: #fff; }
        .comment-input { border: none; outline: none; flex-grow: 1; font-size: 14px; background: transparent; padding: 8px; }
        .comment-submit { background: linear-gradient(135deg, #0095f6 0%, #0077cc 100%); border: none; color: #fff; font-weight: 700; font-size: 14px; padding: 8px 20px; border-radius: 8px; transition: all 0.3s ease; cursor: pointer; }
        .comment-submit:hover { background: linear-gradient(135deg, #0077cc 0%, #005fa3 100%); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0, 149, 246, 0.4); }

        /* ============================================
           RIGHT SIDEBAR
           ============================================ */
        .right-sidebar { padding: 30px 20px; position: sticky; top: 80px; }
        .profile-summary { display: flex; align-items: center; margin-bottom: 30px; padding: 16px; background: #fff; border-radius: 16px; border: 1px solid #dbdbdb; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .profile-summary .avatar { width: 56px; height: 56px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); margin-right: 16px; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 24px; color: #fff; border: 3px solid #fff; box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3); }
        .profile-summary .fw-bold { font-size: 15px; color: #262626; }
        .profile-summary .text-muted { font-size: 12px; color: #8e8e8e; }
        .footer-text { color: #c7c7c7; font-size: 11px; line-height: 1.8; margin-top: 50px; }
        
        .text-success { background: linear-gradient(135deg, #00c853 0%, #00e676 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; font-weight: 700 !important; }
        
        /* SCROLLBAR */
        ::-webkit-scrollbar { width: 10px; }
        ::-webkit-scrollbar-track { background: #f5f5f5; }
        ::-webkit-scrollbar-thumb { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 10px; }

        @media (max-width: 991px) { .sidebar { display: none; } .feed-container { margin: 20px auto; } .post-card { border-radius: 0; } }
    </style>
</head>

<body>

<!-- TOP NAV: DYNAMIC LINK BASED ON ROLE -->
<nav class="top-nav">
    <div class="nav-container">
        <!-- If Admin -> index1.jsp, If User -> index.jsp -->
        <a href="<%= currentUserRole.equals("ADMIN") ? "index1.jsp" : "index.jsp" %>" class="logo">🌱 Community</a>
        
        <div class="d-flex align-items-center gap-3 nav-icons">
            <a href="<%= currentUserRole.equals("ADMIN") ? "index1.jsp" : "index.jsp" %>" style="color:inherit;"><i class="bi bi-house-door-fill"></i></a>
            
            <% if(currentUserRole.equals("USER")) { %>
                <a href="createPost.jsp" style="color:inherit;"><i class="bi bi-plus-square"></i></a>
            <% } %>
            
            <i class="bi bi-compass"></i>
            <a href="logout.jsp" class="logout-link text-decoration-none">Logout</a>
        </div>
    </div>
</nav>

<div class="container-fluid">
<div class="row">

<!-- LEFT SIDEBAR: DYNAMIC CONTENT BASED ON ROLE -->
<div class="col-md-3 d-none d-md-block p-0">
    <div class="sidebar">
        
        <% if(currentUserRole.equals("ADMIN")) { %>
            <!-- =========================== -->
            <!-- ADMIN PERSPECTIVE MENU      -->
            <!-- =========================== -->
            <a href="index1.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
            <a href="manageComplaints.jsp"><i class="bi bi-list-check"></i> Manage Complaints</a>
            <a href="usersList.jsp"><i class="bi bi-people-fill"></i> User Management</a>
            <a href="reports.jsp"><i class="bi bi-bar-chart-fill"></i> View Reports</a>
            <a href="#"><i class="bi bi-gear-fill"></i> System Settings</a>

        <% } else { %>
            <!-- =========================== -->
            <!-- USER PERSPECTIVE MENU       -->
            <!-- =========================== -->
            <a href="index.jsp"><i class="bi bi-house-door-fill"></i> Home</a>
            <a href="profile.jsp"><i class="bi bi-person-circle"></i> Profile</a>
            <a href="createPost.jsp"><i class="bi bi-plus-square"></i> Create Post</a>
            <a href="points.jsp"><i class="bi bi-star-fill"></i> Points & Rewards</a>
            <a href="#"><i class="bi bi-gear-fill"></i> Settings</a>
        <% } %>
        
    </div>
</div>

<!-- CENTER FEED (SAME LOGIC FOR BOTH) -->
<div class="col-md-6 col-lg-5">
<div class="feed-container">

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

PreparedStatement psComment = null;
ResultSet rsComment = null;

try {
    // Database Connection
    Class.forName("com.mysql.jdbc.Driver"); // Using modern driver
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/capstone","root","");

    // Fetch Posts Logic (Unchanged)
    ps = con.prepareStatement(
        "SELECT p.*, " +
        "(SELECT COUNT(*) FROM likes WHERE post_id = p.post_id) AS likeCount " +
        "FROM posts p ORDER BY created_at DESC"
    );

    rs = ps.executeQuery();

    while(rs.next()) {
        int currentPostId = rs.getInt("post_id");
        
        // Handle image path normalization
        String dbPath = rs.getString("image_path");
        String imageSrc = null;

        if (dbPath != null && !dbPath.trim().isEmpty()) {
            String filename = dbPath.trim().replace("\\", "/");
            int lastSlashPos = filename.lastIndexOf('/');
            if (lastSlashPos >= 0) {
                filename = filename.substring(lastSlashPos + 1);
            }
            imageSrc = "images/" + filename;
        }
%>

<div class="post-card">
    <!-- Post Header -->
    <div class="post-header justify-content-between">
        <div class="d-flex align-items-center">
            <div class="user-avatar"><%= rs.getString("user_name").substring(0,1).toUpperCase() %></div>
            <div>
                <a href="#" class="username"><%= rs.getString("user_name") %></a>
                <div class="text-muted" style="font-size:11px;">
                    <%= rs.getString("activity_type") %> • 
                    <span class="text-success fw-bold">+<%= rs.getInt("points") %> pts</span>
                </div>
            </div>
        </div>
        <i class="bi bi-three-dots"></i>
    </div>

    <!-- Post Image -->
    <% if (imageSrc != null) { %>
        <img src="<%= imageSrc %>" class="post-img" alt="Post content">
    <% } %>

    <!-- Post Body -->
    <div class="post-body">
        <div class="post-actions">
            <!-- Allow Like only if user is logged in (handled by servlet usually) -->
            <form action="LikeServlet" method="post" style="display:inline;">
                <input type="hidden" name="postId" value="<%= currentPostId %>">
                <button class="action-btn"><i class="bi bi-heart"></i></button>
            </form>
            <i class="bi bi-chat"></i>
            <i class="bi bi-send"></i>
            <i class="bi bi-bookmark ms-auto"></i>
        </div>

        <div class="likes-count"><%= rs.getInt("likeCount") %> likes</div>

        <!-- Caption -->
        <div class="post-caption">
            <span class="fw-bold"><%= rs.getString("user_name") %></span>
            <%= rs.getString("caption") %>
        </div>
        
        <div class="post-date"><%= rs.getString("created_at") %></div>

        <!-- Comments -->
        <div class="comment-section">
            <%
                try {
                    String commentSql = "SELECT * FROM comments WHERE post_id = ? ORDER BY created_at ASC";
                    psComment = con.prepareStatement(commentSql);
                    psComment.setInt(1, currentPostId);
                    rsComment = psComment.executeQuery();

                    boolean hasComments = false;
                    while(rsComment.next()) {
                        hasComments = true;
            %>
                        <div class="single-comment">
                            <span class="comment-username"><%= rsComment.getString("user_name") %></span> 
                            <%= rsComment.getString("comment_text") %>
                        </div>
            <%
                    }
                    if(!hasComments){
            %>
                        <div class="text-muted small">No comments yet.</div>
            <%
                    }
                } catch(Exception e) {
                    out.println("<small class='text-danger'>Error loading comments</small>");
                } finally {
                    if(rsComment != null) rsComment.close();
                    if(psComment != null) psComment.close();
                }
            %>
        </div>
    </div>

    <!-- Comment Input -->
    <form action="CommentServlet" method="post" class="comment-input-area">
        <input type="hidden" name="postId" value="<%= currentPostId %>">
        <input class="comment-input" name="comment" placeholder="Add a comment as <%= userName %>..." required>
        <button type="submit" class="comment-submit">Post</button>
    </form>
</div>

<%
    } 
} catch(Exception e) {
%>
    <div class="alert alert-danger" style="margin:20px;">Error Loading Feed: <%= e.getMessage() %></div>
<%
} finally {
    try { if (rs != null) rs.close(); } catch(Exception ignored) {}
    try { if (ps != null) ps.close(); } catch(Exception ignored) {}
    try { if (con != null) con.close(); } catch(Exception ignored) {}
}
%>

</div>
</div>

<!-- RIGHT SIDEBAR: PROFILE SUMMARY (DYNAMIC) -->
<div class="col-md-3 d-none d-lg-block">
    <div class="right-sidebar">
        <!-- Shows whoever is logged in (Admin or User) -->
        <div class="profile-summary">
            <div class="avatar">
                <%= avatarLetter %>
            </div>
            <div>
                <div class="fw-bold"><%= userName %></div>
                <div class="text-muted">
                    <% if(currentUserRole.equals("ADMIN")) { %>
                        <span style="color:#0066cc; font-weight:bold;">Official Admin</span>
                    <% } else { %>
                        Active Citizen
                    <% } %>
                </div>
            </div>
            <a href="logout.jsp" class="ms-auto text-primary text-decoration-none">Switch</a>
        </div>
        
        <div class="suggestions-header">
            <span class="text-muted">Suggested for you</span>
            <span class="text-dark">See All</span>
        </div>
        
        <p class="footer-text">
            Community Guidelines • Privacy • Terms • Locations • Language
            <br><br>
            © 2025 GRAM PANCHAYAT COMMUNITY
        </p>
    </div>
</div>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>