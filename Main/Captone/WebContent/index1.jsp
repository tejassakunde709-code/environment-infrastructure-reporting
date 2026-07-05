<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%
    // --- ADMIN AUTHENTICATION LOGIC ---
    // 2. Check if Admin is logged in
    if (session.getAttribute("adminId") == null) {
        // Not logged in at all -> Go to Role Selection
        response.sendRedirect("roleSelection.jsp");
        return;
    }

    // Get Admin Details (fallback if specific names aren't set)
    String adminName = (String) session.getAttribute("adminName");
    if(adminName == null) adminName = "Admin";
    
    String adminEmail = (String) session.getAttribute("adminEmail");
    if(adminEmail == null) adminEmail = "admin@govt.in";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard - Gram Panchayat E-Portal</title>
    <!-- Modern Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    
    <style>
        :root {
            /* Consistent Theme Colors */
            --primary-blue: #2563eb;
            --primary-dark: #0f172a; /* Slightly darker for admin feel */
            --secondary-blue: #eff6ff;
            --success-green: #10b981;
            --accent-orange: #f59e0b;
            --accent-purple: #8b5cf6;
            --accent-pink: #ec4899;
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --bg-body: #f3f4f6;
            --bg-card: #ffffff;
            --border-color: #e5e7eb;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --radius-md: 12px;
            --radius-lg: 20px;
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
            line-height: 1.6;
            overflow-x: hidden;
        }
        
        /* TOPBAR */
        .topbar {
            background-color: var(--primary-dark);
            color: #fff;
            padding: 10px 0;
            font-size: 13px;
            font-weight: 500;
        }
        .topbar-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .topbar-date {
            background: rgba(255, 255, 255, 0.15);
            padding: 4px 12px;
            border-radius: 20px;
        }

        /* HEADER & NAVIGATION */
        .main-header {
            background: var(--bg-card);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 999;
            border-bottom: 1px solid var(--border-color);
        }
        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 80px;
        }
        .logo-section {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .govt-logo {
            height: 50px;
            border-radius: 8px;
        }
        .logo-text {
            font-size: 1.3rem;
            color: var(--primary-dark);
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        .logo-subtext {
            font-size: 0.75rem;
            color: var(--accent-orange);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .main-nav {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        .nav-link {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .nav-link:hover, .nav-link.active {
            background: var(--secondary-blue);
            color: var(--primary-blue);
        }

        /* PROFILE BUTTON */
        .user-profile-trigger {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.4rem 0.4rem 0.4rem 1rem;
            background: #fff;
            border-radius: 50px;
            cursor: pointer;
            border: 1px solid var(--border-color);
            margin-left: 1rem;
            transition: all 0.2s ease;
            box-shadow: var(--shadow-sm);
        }
        .user-profile-trigger:hover {
            border-color: var(--primary-blue);
            box-shadow: var(--shadow-md);
        }
        .user-avatar-sm {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-dark), #1e3a8a);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        /* SLIDING SIDEBAR */
        #sidePanel {
            position: fixed;
            top: 0;
            right: -400px;
            width: 350px;
            height: 100%;
            background: white;
            box-shadow: -5px 0 25px rgba(0,0,0,0.1);
            z-index: 2001;
            transition: right 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 2.5rem;
            display: flex;
            flex-direction: column;
        }
        #sidePanel.open { right: 0; }
        #overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 2000;
            display: none;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .close-btn {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--text-muted);
            cursor: pointer;
            transition: color 0.2s;
        }
        .close-btn:hover { color: #ef4444; }
        
        .large-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-dark), #1e3a8a);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: 600;
            margin: 0 auto 1rem;
            box-shadow: var(--shadow-md);
        }
        .role-badge {
            background: var(--secondary-blue);
            color: var(--primary-blue);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            display: inline-block;
            margin-top: 8px;
        }
        
        .panel-menu {
            list-style: none;
            margin-top: 2rem;
            flex-grow: 1;
            overflow-y: auto;
        }
        .panel-menu li.menu-header {
            margin: 1.5rem 0 0.5rem 0.5rem;
            font-size: 0.75rem;
            color: var(--text-muted);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .panel-menu li a {
            text-decoration: none;
            color: var(--text-main);
            display: flex;
            align-items: center;
            padding: 12px 16px;
            font-weight: 500;
            border-radius: 10px;
            margin-bottom: 4px;
            transition: all 0.2s;
        }
        .panel-menu li a i {
            width: 24px;
            color: var(--text-muted);
            transition: color 0.2s;
        }
        .panel-menu li a:hover {
            background: var(--bg-body);
            color: var(--primary-blue);
        }
        .panel-menu li a:hover i { color: var(--primary-blue); }
        .panel-menu li a.logout-btn { color: #ef4444; margin-top: 1rem; background: #fef2f2; }
        .panel-menu li a.logout-btn:hover { background: #fee2e2; }
        .panel-menu li a.logout-btn i { color: #ef4444; }

        /* DASHBOARD MAIN LAYOUT */
        .main-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2.5rem 2rem;
        }
        
        /* HERO BANNER */
        .hero-banner {
            background: linear-gradient(135deg, var(--primary-dark) 0%, #1e3a8a 100%);
            color: white;
            padding: 3rem 4rem;
            border-radius: var(--radius-lg);
            margin-bottom: 3rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
        }
        .hero-banner::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(255,255,255,0.08) 0%, rgba(255,255,255,0) 70%);
            border-radius: 50%;
            pointer-events: none;
        }
        .hero-text-content {
            max-width: 65%;
            position: relative;
            z-index: 2;
        }
        .hero-text-content h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
        }
        .hero-text-content p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
        }
        .hero-image {
            width: 30%;
            position: relative;
            z-index: 2;
        }
        .hero-image img {
            width: 100%;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-md);
            border: 4px solid rgba(255,255,255,0.1);
        }

        /* SECTION STYLES */
        .dashboard-section {
            background: var(--bg-card);
            padding: 2.5rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            margin-bottom: 3rem;
            border: 1px solid var(--border-color);
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .section-icon-box {
            background: var(--secondary-blue);
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            color: var(--primary-blue);
        }
        .section-header h2 {
            font-size: 1.5rem;
            color: var(--text-main);
            font-weight: 600;
        }

        /* GRID LAYOUT FOR SERVICES */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        /* MODERN SERVICE CARD */
        .service-card {
            background: var(--bg-card);
            padding: 1.8rem;
            border-radius: var(--radius-md);
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            text-decoration: none;
            color: inherit;
            border: 1px solid var(--border-color);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .service-card::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background-color: var(--primary-blue);
            transition: width 0.3s ease;
        }

        .service-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: transparent;
        }
        
        .service-card:hover::before { width: 6px; }

        .btn-content { z-index: 1; padding-right: 15px; }
        .btn-content h3 {
            font-size: 1.15rem;
            color: var(--text-main);
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        .btn-content p {
            color: var(--text-muted);
            font-size: 0.9rem;
            line-height: 1.4;
        }
        .btn-icon {
            font-size: 2rem;
            padding: 1rem;
            border-radius: 50%;
            background: var(--bg-body);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s ease;
        }
        
        .service-card:hover .btn-icon {
            transform: scale(1.1);
        }

        /* SPECIFIC CARD COLORS */
        .manage-btn::before { background-color: var(--accent-orange); }
        .manage-btn .btn-icon { color: var(--accent-orange); background: #fffbeb; }

        .report-btn::before { background-color: var(--success-green); }
        .report-btn .btn-icon { color: var(--success-green); background: #ecfdf5; }

        .community-btn::before { background-color: var(--primary-blue); }
        .community-btn .btn-icon { color: var(--primary-blue); background: var(--secondary-blue); }

        .cert-birth-btn::before { background-color: #8b5cf6; }
        .cert-birth-btn .btn-icon { color: #8b5cf6; background: #f5f3ff; }

        .cert-marriage-btn::before { background-color: #ec4899; }
        .cert-marriage-btn .btn-icon { color: #ec4899; background: #fdf2f8; }

        .cert-death-btn::before { background-color: #4b5563; }
        .cert-death-btn .btn-icon { color: #4b5563; background: #f3f4f6; }

        /* FOOTER */
        .govt-footer {
            background: var(--primary-dark);
            color: #d1d5db;
            padding: 2rem 0;
            text-align: center;
            font-size: 0.9rem;
            margin-top: auto;
            border-top: 4px solid var(--primary-blue);
        }

        /* Responsive Adjustments */
        @media (max-width: 992px) {
            .hero-banner {
                flex-direction: column;
                padding: 2.5rem;
                text-align: center;
                gap: 2rem;
            }
            .hero-text-content, .hero-image { width: 100%; max-width: 100%; }
            .hero-banner::after { display: none; }
            .main-nav { display: none; }
            .header-container { justify-content: space-between; }
        }
    </style>
</head>
<body>

    <!-- ADMIN SIDE PANEL -->
    <div id="overlay" onclick="closeSidebar()"></div>
    <div id="sidePanel">
        <button class="close-btn" onclick="closeSidebar()"><i class="fas fa-times"></i></button>
        
        <div style="text-align: center; padding-top: 1rem;">
            <div class="large-avatar"><%= adminName.substring(0,1).toUpperCase() %></div>
            <h3 style="color: var(--text-main); font-weight: 600; font-size: 1.25rem;"><%= adminName %></h3>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 0.5rem;"><%= adminEmail %></p>
            <span class="role-badge">OFFICIAL ADMIN</span>
        </div>
        
        <ul class="panel-menu">
            <li><a href="adminDashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard Overview</a></li>
            <li><a href="adminViewComplaint.jsp"><i class="fas fa-tasks"></i> Manage Complaints</a></li>
            <li><a href="usersList.jsp"><i class="fas fa-users-cog"></i> User Management</a></li>
            
            <li class="menu-header">E-Certificates</li>
            <li><a href="admin_view_birth_applications.jsp"><i class="fas fa-baby"></i> Birth Requests</a></li>
            <li><a href="admin_view_marriage_certificates.jsp"><i class="fas fa-heart"></i> Marriage Requests</a></li>
            <li><a href="admin_view_death_certificates.jsp"><i class="fas fa-book-dead"></i> Death Requests</a></li>
            
            <li><a href="logout.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Secure Logout</a></li>
        </ul>
    </div>

    <!-- TOP IDENTIFIER BAR -->
    <div class="topbar">
        <div class="topbar-container">
            <div><i class="fas fa-landmark me-2" style="margin-right: 8px; color: var(--accent-orange);"></i> Department of Village Sanitation & Greenery - ADMIN PORTAL</div>
            <div class="topbar-date">
                <i class="far fa-calendar-alt" style="margin-right: 6px;"></i> 
                Today: <strong><%= new SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %></strong>
            </div>
        </div>
    </div>

    <!-- MAIN NAVIGATION HEADER -->
    <header class="main-header">
        <div class="header-container">
            <div class="logo-section">
                <img src="images/Gemini_Generated_Image_k9rvjmk9rvjmk9rv.png" alt="Govt Logo" class="govt-logo" onerror="this.style.display='none'">
                <div>
                    <div class="logo-text">Gram Panchayat Admin</div>
                    <div class="logo-subtext">Swachhta & Hariyali Control Panel</div>
                </div>
            </div>
            
            <nav class="main-nav">
                <a href="adminDashboard.jsp" class="nav-link active"><i class="fas fa-home" style="margin-right: 6px;"></i> Dashboard</a>
                <a href="adminViewComplaint.jsp" class="nav-link"><i class="fas fa-tasks" style="margin-right: 6px;"></i> Complaints</a>
                <a href="usersList.jsp" class="nav-link"><i class="fas fa-users-cog" style="margin-right: 6px;"></i> Users</a>
            </nav>
            
            <div class="user-profile-trigger" onclick="openSidebar()">
                <div style="font-size: 0.85rem; padding-left: 0.5rem; text-align: right;">
                    <div style="font-weight: 600; color: var(--text-main);"><%= adminName %></div>
                    <div style="color: var(--text-muted); font-size: 0.75rem;">Administrator</div>
                </div>
                <div class="user-avatar-sm"><%= adminName.substring(0,1).toUpperCase() %></div>
            </div>
        </div>
    </header>

    <!-- MAIN DASHBOARD CONTENT -->
    <main class="main-content">
        
        <!-- WELCOME BANNER -->
        <section class="hero-banner">
            <div class="hero-text-content">
                <h1>Welcome Admin, <%= adminName %></h1>
                <p>Manage village complaints, view official reports, and oversee the Swachh Bharat mission progress through this unified administrative dashboard.</p>
            </div>
            <div class="hero-image">
                <img src="images/Gemini_Generated_Image_zf5l61zf5l61zf5l.png" alt="Hero Image" onerror="this.style.display='none'">
            </div>
        </section>

        <!-- SECTION 1: COMPLAINT & COMMUNITY MANAGEMENT -->
        <div class="dashboard-section">
            <div class="section-header">
                <div class="section-icon-box"><i class="fas fa-tasks"></i></div>
                <h2>Complaint & Community Management</h2>
            </div>
            
            <div class="services-grid">
                <a href="adminViewComplaint.jsp" class="service-card manage-btn">
                    <div class="btn-content">
                        <h3>Manage Active Complaints</h3>
                        <p>Review, assign, and resolve reported village issues effectively.</p>
                    </div>
                    <div class="btn-icon"><i class="fas fa-tools"></i></div>
                </a>

               

                <a href="community.jsp" class="service-card community-btn">
                    <div class="btn-content">
                        <h3>Community Oversight</h3>
                        <p>Monitor community posts, announcements, and interactions.</p>
                    </div>
                    <div class="btn-icon"><i class="fas fa-users-cog"></i></div>
                </a>
            </div>
        </div>

        <!-- SECTION 2: E-CERTIFICATE MANAGEMENT -->
        <div class="dashboard-section">
            <div class="section-header">
                <div class="section-icon-box" style="background: #fdf2f8; color: #db2777;"><i class="fas fa-file-signature"></i></div>
                <h2>E-Panchayat Certificate Management</h2>
            </div>

            <div class="services-grid">
                <!-- Birth Certificate Requests -->
                <a href="admin_view_birth_applications.jsp" class="service-card cert-birth-btn">
                    <div class="btn-content">
                        <h3>Birth Certificate Requests</h3>
                        <p>Review documents and generate official birth certificates.</p>
                    </div>
                    <div class="btn-icon"><i class="fas fa-baby"></i></div>
                </a>

                <!-- Marriage Certificate Requests -->
                <a href="admin_view_marriage_certificates.jsp" class="service-card cert-marriage-btn">
                    <div class="btn-content">
                        <h3>Marriage Certificate Requests</h3>
                        <p>Verify applicant details and approve marriage certificates.</p>
                    </div>
                    <div class="btn-icon"><i class="fas fa-heart"></i></div>
                </a>

                <!-- Death Certificate Requests -->
                <a href="admin_view_death_certificates.jsp" class="service-card cert-death-btn">
                    <div class="btn-content">
                        <h3>Death Certificate Requests</h3>
                        <p>Verify medical documents and issue death certificates.</p>
                    </div>
                    <div class="btn-icon"><i class="fas fa-book-dead"></i></div>
                </a>
            </div>
        </div>

    </main>

    <!-- FOOTER -->
    <footer class="govt-footer">
        <div style="max-width: 1400px; margin: 0 auto; padding: 0 2rem;">
            <p>&copy; 2026 Gram Panchayat | Developed by Department of Information Technology</p>
        </div>
    </footer>

    <!-- INTERACTIVE SCRIPTS -->
    <script>
        function openSidebar() {
            const overlay = document.getElementById('overlay');
            const sidePanel = document.getElementById('sidePanel');
            
            overlay.style.display = 'block';
            setTimeout(() => {
                overlay.style.opacity = '1';
                sidePanel.classList.add('open');
            }, 10);
            
            document.body.style.overflow = 'hidden';
        }
        
        function closeSidebar() {
            const overlay = document.getElementById('overlay');
            const sidePanel = document.getElementById('sidePanel');
            
            sidePanel.classList.remove('open');
            overlay.style.opacity = '0';
            
            setTimeout(() => {
                overlay.style.display = 'none';
            }, 300);
            
            document.body.style.overflow = 'auto';
        }
    </script>
</body>
</html>