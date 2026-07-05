<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    String avatar = userName != null ? userName.substring(0,1).toUpperCase() : "U";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Village Clean & Green — Dashboard</title>

  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Fraunces:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

  <style>
    /* ============================================================
       DESIGN TOKENS
    ============================================================ */
    :root {
      --forest:      #1a3c2e;
      --forest-mid:  #234d3a;
      --forest-soft: #2d6048;
      --accent:      #5cb85c;
      --accent-glow: rgba(92,184,92,0.25);
      --leaf:        #a8d5a2;
      --cream:       #faf7f0;
      --cream-dark:  #f0ebe0;
      --sand:        #e8dfc8;
      --white:       #ffffff;
      --text-dark:   #1a2e1f;
      --text-body:   #3a5244;
      --text-muted:  #7a9e8a;
      --border:      #dde8d8;
      --danger:      #e05252;
      --shadow-sm:   0 1px 4px rgba(26,60,46,0.08);
      --shadow-md:   0 6px 24px rgba(26,60,46,0.13);
      --shadow-lg:   0 16px 48px rgba(26,60,46,0.18);
      --sidebar-w:   270px;
      --sidebar-c:   72px;
      --header-h:    68px;
      --footer-h:    56px;
      --radius:      14px;
      --radius-sm:   9px;
    }

    /* ============================================================
       RESET & BASE
    ============================================================ */
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      font-family: 'Plus Jakarta Sans', sans-serif;
      background: var(--cream);
      color: var(--text-dark);
      height: 100vh;
      overflow: hidden;
    }

    /* ============================================================
       APP SHELL
    ============================================================ */
    .app-wrapper {
      height: 100vh;
      display: grid;
      grid-template:
        "header header" var(--header-h)
        "sidebar main"  1fr
        "sidebar footer" var(--footer-h)
        / var(--sidebar-w) 1fr;
      transition: grid-template-columns 0.35s cubic-bezier(.4,0,.2,1);
    }

    body.sidebar-collapsed .app-wrapper {
      grid-template-columns: var(--sidebar-c) 1fr;
    }

    /* ============================================================
       HEADER
    ============================================================ */
    .top-navbar {
      grid-area: header;
      background: var(--white);
      border-bottom: 1px solid var(--border);
      padding: 0 2rem;
      display: flex;
      align-items: center;
      justify-content: space-between;
      z-index: 200;
      box-shadow: 0 1px 0 var(--border), var(--shadow-sm);
    }

    .navbar-left {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .sidebar-toggle {
      width: 40px; height: 40px;
      border-radius: var(--radius-sm);
      border: 1.5px solid var(--border);
      background: transparent;
      color: var(--text-muted);
      cursor: pointer;
      display: flex; align-items: center; justify-content: center;
      font-size: 1rem;
      transition: all 0.2s;
    }
    .sidebar-toggle:hover {
      background: var(--forest);
      border-color: var(--forest);
      color: var(--white);
      transform: scale(1.05);
    }

    .logo {
      display: flex;
      align-items: center;
      gap: 10px;
      text-decoration: none;
    }
    .logo-icon {
      width: 38px; height: 38px;
      background: linear-gradient(135deg, var(--forest), var(--accent));
      border-radius: 10px;
      display: flex; align-items: center; justify-content: center;
      color: white;
      font-size: 1.05rem;
      box-shadow: 0 4px 12px var(--accent-glow);
    }
    .logo-text {
      font-family: 'Fraunces', serif;
      font-size: 1.15rem;
      font-weight: 700;
      color: var(--forest);
      letter-spacing: -0.3px;
    }
    .logo-text span { color: var(--accent); }

    .navbar-right {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    /* Notification bell */
    .nav-bell {
      width: 40px; height: 40px;
      border-radius: var(--radius-sm);
      border: 1.5px solid var(--border);
      background: transparent;
      color: var(--text-muted);
      cursor: pointer;
      display: flex; align-items: center; justify-content: center;
      position: relative;
      transition: all 0.2s;
    }
    .nav-bell:hover { background: var(--cream-dark); color: var(--forest); }
    .bell-dot {
      position: absolute;
      top: 7px; right: 7px;
      width: 8px; height: 8px;
      background: var(--accent);
      border-radius: 50%;
      border: 2px solid white;
    }

    .user-chip {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 5px 14px 5px 5px;
      border-radius: 50px;
      background: var(--cream);
      border: 1.5px solid var(--border);
      transition: border-color 0.2s;
    }
    .user-chip:hover { border-color: var(--accent); }

    .user-avatar {
      width: 34px; height: 34px;
      border-radius: 50%;
      background: linear-gradient(135deg, var(--forest-soft), var(--accent));
      color: white;
      display: flex; align-items: center; justify-content: center;
      font-weight: 700;
      font-size: 0.9rem;
      letter-spacing: 0.5px;
    }
    .user-details strong {
      display: block;
      font-size: 0.85rem;
      font-weight: 600;
      color: var(--text-dark);
      line-height: 1.2;
    }
    .user-details small {
      font-size: 0.72rem;
      color: var(--text-muted);
      font-weight: 500;
    }

    .logout-btn {
      display: flex; align-items: center; gap: 7px;
      padding: 9px 16px;
      border-radius: var(--radius-sm);
      border: 1.5px solid #fdd;
      background: #fff8f8;
      color: var(--danger);
      font-family: inherit;
      font-size: 0.83rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s;
    }
    .logout-btn:hover {
      background: var(--danger);
      border-color: var(--danger);
      color: white;
      transform: translateY(-1px);
      box-shadow: 0 4px 12px rgba(224,82,82,0.3);
    }

    /* ============================================================
       SIDEBAR
    ============================================================ */
    .sidebar {
      grid-area: sidebar;
      background: var(--forest);
      display: flex;
      flex-direction: column;
      padding: 1.5rem 0.85rem;
      gap: 4px;
      overflow-y: auto;
      overflow-x: hidden;
      transition: all 0.35s cubic-bezier(.4,0,.2,1);
      position: relative;
    }

    /* Decorative leaf watermark */
    .sidebar::before {
      content: '';
      position: absolute;
      bottom: 80px; right: -20px;
      width: 120px; height: 120px;
      background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='rgba(255,255,255,0.04)' d='M17 8C8 10 5.9 16.17 3.82 21.34L5.71 22l1-2.3A4.49 4.49 0 008 20C19 20 22 3 22 3c-1 2-8 2-8 2s2-3 6-3V1c-6 1-9 5-9 5 0 0-3-4-9-4v2c3 0 6 1.79 6 1.79z'/%3E%3C/svg%3E") center/cover no-repeat;
      pointer-events: none;
    }

    .nav-section-label {
      font-size: 0.65rem;
      font-weight: 700;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      color: rgba(255,255,255,0.3);
      padding: 0.75rem 12px 0.3rem;
      white-space: nowrap;
      overflow: hidden;
    }

    .nav-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 11px 14px;
      color: rgba(255,255,255,0.65);
      text-decoration: none;
      border-radius: var(--radius-sm);
      font-weight: 500;
      font-size: 0.9rem;
      transition: all 0.22s;
      white-space: nowrap;
      overflow: hidden;
      position: relative;
    }

    .nav-item::before {
      content: '';
      position: absolute;
      left: 0; top: 50%;
      transform: translateY(-50%);
      width: 3px; height: 0;
      background: var(--accent);
      border-radius: 0 4px 4px 0;
      transition: height 0.22s;
    }

    .nav-item:hover {
      background: rgba(255,255,255,0.08);
      color: white;
    }
    .nav-item:hover::before { height: 55%; }

    .nav-item.active {
      background: rgba(92,184,92,0.18);
      color: var(--leaf);
      font-weight: 600;
    }
    .nav-item.active::before { height: 65%; }

    .nav-item i {
      font-size: 1rem;
      width: 22px;
      text-align: center;
      flex-shrink: 0;
    }

    body.sidebar-collapsed .nav-label,
    body.sidebar-collapsed .nav-section-label { display: none; }
    body.sidebar-collapsed .nav-item {
      justify-content: center;
      padding: 12px;
    }

    /* ============================================================
       MAIN CONTENT
    ============================================================ */
    main {
      grid-area: main;
      padding: 2rem 2rem 1.5rem;
      overflow-y: auto;
      background: var(--cream);
    }

    /* — Page header row — */
    .page-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 1.75rem;
    }
    .page-header-left .breadcrumb {
      font-size: 0.75rem;
      color: var(--text-muted);
      font-weight: 500;
      margin-bottom: 3px;
    }
    .page-header-left .breadcrumb i { margin-right: 4px; }
    .page-header-left h2 {
      font-family: 'Fraunces', serif;
      font-size: 1.65rem;
      font-weight: 700;
      color: var(--text-dark);
      letter-spacing: -0.5px;
    }
    .date-badge {
      display: flex; align-items: center; gap: 7px;
      padding: 8px 16px;
      background: var(--white);
      border: 1.5px solid var(--border);
      border-radius: 50px;
      font-size: 0.8rem;
      font-weight: 500;
      color: var(--text-body);
    }
    .date-badge i { color: var(--accent); }

    /* — Hero Banner — */
    .hero {
      background: linear-gradient(120deg, var(--forest) 0%, var(--forest-soft) 60%, #3a7a55 100%);
      border-radius: var(--radius);
      padding: 2.5rem 2.75rem;
      margin-bottom: 2rem;
      position: relative;
      overflow: hidden;
      box-shadow: var(--shadow-md);
    }

    /* decorative circles */
    .hero::before {
      content: '';
      position: absolute;
      top: -60px; right: -60px;
      width: 240px; height: 240px;
      border-radius: 50%;
      background: rgba(255,255,255,0.06);
    }
    .hero::after {
      content: '';
      position: absolute;
      bottom: -80px; right: 100px;
      width: 200px; height: 200px;
      border-radius: 50%;
      background: rgba(92,184,92,0.12);
    }

    .hero-content { position: relative; z-index: 2; }

    .hero-greeting {
      font-size: 0.8rem;
      font-weight: 600;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--leaf);
      margin-bottom: 8px;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .hero-greeting .dot {
      width: 6px; height: 6px;
      background: var(--accent);
      border-radius: 50%;
      animation: pulse 2s infinite;
    }
    @keyframes pulse {
      0%, 100% { opacity: 1; transform: scale(1); }
      50% { opacity: 0.5; transform: scale(0.7); }
    }

    .hero h1 {
      font-family: 'Fraunces', serif;
      font-size: 2rem;
      font-weight: 700;
      color: var(--white);
      margin-bottom: 0.6rem;
      letter-spacing: -0.5px;
      line-height: 1.2;
    }

    .hero p {
      color: rgba(255,255,255,0.72);
      font-size: 0.97rem;
      max-width: 480px;
      line-height: 1.6;
    }

    .hero-actions {
      margin-top: 1.5rem;
      display: flex;
      gap: 0.75rem;
      flex-wrap: wrap;
    }
    .hero-btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 20px;
      border-radius: var(--radius-sm);
      font-family: inherit;
      font-size: 0.85rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.22s;
      text-decoration: none;
      border: none;
    }
    .hero-btn-primary {
      background: var(--accent);
      color: var(--forest);
      box-shadow: 0 4px 14px var(--accent-glow);
    }
    .hero-btn-primary:hover {
      background: #6dca6d;
      transform: translateY(-2px);
      box-shadow: 0 8px 20px var(--accent-glow);
    }
    .hero-btn-ghost {
      background: rgba(255,255,255,0.12);
      color: white;
      border: 1.5px solid rgba(255,255,255,0.2);
    }
    .hero-btn-ghost:hover {
      background: rgba(255,255,255,0.2);
      transform: translateY(-2px);
    }

    /* Hero illustration */
    .hero-illustration {
      position: absolute;
      right: 2.5rem; top: 50%;
      transform: translateY(-50%);
      font-size: 7rem;
      opacity: 0.15;
      z-index: 1;
      line-height: 1;
    }

    /* — Section title — */
    .section-title {
      font-family: 'Fraunces', serif;
      font-size: 1.2rem;
      font-weight: 700;
      color: var(--text-dark);
      margin-bottom: 1.1rem;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .section-title::after {
      content: '';
      flex: 1;
      height: 1.5px;
      background: var(--border);
      border-radius: 2px;
    }

    /* — Dashboard Grid — */
    .dashboard-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
      gap: 1.2rem;
    }

    .dashboard-card {
      background: var(--white);
      border-radius: var(--radius);
      border: 1.5px solid var(--border);
      padding: 1.75rem 1.5rem;
      cursor: pointer;
      transition: all 0.28s cubic-bezier(.4,0,.2,1);
      position: relative;
      overflow: hidden;
      box-shadow: var(--shadow-sm);
      display: flex;
      flex-direction: column;
      gap: 0.9rem;
    }

    /* card accent line */
    .dashboard-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0;
      height: 3px;
      background: linear-gradient(90deg, var(--forest), var(--accent));
      opacity: 0;
      transition: opacity 0.25s;
    }

    .dashboard-card:hover {
      transform: translateY(-5px);
      box-shadow: var(--shadow-lg);
      border-color: var(--accent);
    }
    .dashboard-card:hover::before { opacity: 1; }

    .card-icon-wrap {
      width: 52px; height: 52px;
      border-radius: 13px;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.3rem;
      transition: transform 0.25s;
    }
    .dashboard-card:hover .card-icon-wrap { transform: scale(1.1) rotate(-5deg); }

    /* Individual card themes */
    .card-theme-red   .card-icon-wrap { background: #fff0f0; color: #e05252; }
    .card-theme-blue  .card-icon-wrap { background: #eff6ff; color: #3b82f6; }
    .card-theme-green .card-icon-wrap { background: #f0fdf4; color: var(--accent); }
    .card-theme-teal  .card-icon-wrap { background: #f0fdfa; color: #14b8a6; }
    .card-theme-amber .card-icon-wrap { background: #fffbeb; color: #f59e0b; }
    .card-theme-indigo .card-icon-wrap { background: #eef2ff; color: #6366f1; }

    .card-body h3 {
      font-size: 1rem;
      font-weight: 700;
      color: var(--text-dark);
      margin-bottom: 5px;
      letter-spacing: -0.2px;
    }
    .card-body p {
      color: var(--text-muted);
      font-size: 0.83rem;
      line-height: 1.55;
    }

    .card-arrow {
      margin-top: auto;
      display: flex;
      align-items: center;
      gap: 5px;
      font-size: 0.78rem;
      font-weight: 600;
      color: var(--text-muted);
      transition: color 0.2s, gap 0.2s;
    }
    .dashboard-card:hover .card-arrow {
      color: var(--forest);
      gap: 8px;
    }

    /* ============================================================
       FOOTER
    ============================================================ */
    footer {
      grid-area: footer;
      background: var(--white);
      border-top: 1.5px solid var(--border);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 2rem;
      font-size: 0.8rem;
      color: var(--text-muted);
    }
    .footer-brand {
      display: flex;
      align-items: center;
      gap: 8px;
      font-weight: 500;
    }
    .footer-brand i { color: var(--accent); }

    .footer-links { display: flex; gap: 0.1rem; }
    .footer-links a {
      color: var(--text-muted);
      text-decoration: none;
      padding: 4px 10px;
      border-radius: 5px;
      transition: all 0.2s;
    }
    .footer-links a:hover {
      background: var(--cream-dark);
      color: var(--forest);
    }

    /* ============================================================
       SCROLL BAR
    ============================================================ */
    main::-webkit-scrollbar,
    .sidebar::-webkit-scrollbar { width: 5px; }
    main::-webkit-scrollbar-track { background: transparent; }
    main::-webkit-scrollbar-thumb {
      background: var(--sand);
      border-radius: 10px;
    }
    .sidebar::-webkit-scrollbar-thumb {
      background: rgba(255,255,255,0.15);
      border-radius: 10px;
    }

    /* ============================================================
       ENTRY ANIMATIONS
    ============================================================ */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(18px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .hero           { animation: fadeUp 0.5s ease both; }
    .dashboard-card { animation: fadeUp 0.5s ease both; }
    .dashboard-card:nth-child(1) { animation-delay: 0.08s; }
    .dashboard-card:nth-child(2) { animation-delay: 0.13s; }
    .dashboard-card:nth-child(3) { animation-delay: 0.18s; }
    .dashboard-card:nth-child(4) { animation-delay: 0.23s; }
    .dashboard-card:nth-child(5) { animation-delay: 0.28s; }
    .dashboard-card:nth-child(6) { animation-delay: 0.33s; }

    /* ============================================================
       RESPONSIVE
    ============================================================ */
    @media (max-width: 992px) {
      .app-wrapper {
        grid-template:
          "header" var(--header-h)
          "main"   1fr
          "footer" var(--footer-h)
          / 1fr;
      }
      .sidebar {
        position: fixed;
        left: -290px; top: var(--header-h); bottom: 0;
        width: var(--sidebar-w);
        z-index: 999;
        box-shadow: var(--shadow-lg);
        transition: left 0.3s cubic-bezier(.4,0,.2,1);
      }
      body.sidebar-open .sidebar { left: 0; }
      .hero-illustration { display: none; }
      .hero { padding: 2rem 1.75rem; }
      main { padding: 1.5rem; }
    }

    @media (max-width: 600px) {
      .logo-text { display: none; }
      .user-details { display: none; }
      .date-badge { display: none; }
      .hero h1 { font-size: 1.55rem; }
      .dashboard-grid { grid-template-columns: 1fr 1fr; }
    }
  </style>
</head>
<body>

<div class="app-wrapper">

  <!-- ===================== HEADER ===================== -->
  <header class="top-navbar">
    <div class="navbar-left">
      <button class="sidebar-toggle" id="sidebarToggleBtn">
        <i class="fas fa-bars"></i>
      </button>

      <a class="logo" href="index.jsp">
        <div class="logo-icon"><i class="fas fa-leaf"></i></div>
        <span class="logo-text">Village <span>Clean&amp;Green</span></span>
      </a>
    </div>

    <div class="navbar-right">
      <button class="nav-bell" title="Notifications">
        <i class="fas fa-bell" style="font-size:0.95rem;"></i>
        <span class="bell-dot"></span>
      </button>

      <div class="user-chip">
        <div class="user-avatar"><%= avatar %></div>
        <div class="user-details">
          <strong><%= userName %></strong>
          <small>Citizen</small>
        </div>
      </div>

      <button class="logout-btn" onclick="location.href='LogoutServlet'">
        <i class="fas fa-sign-out-alt"></i> Logout
      </button>
    </div>
  </header>

  <!-- ===================== SIDEBAR ===================== -->
  <aside class="sidebar">
    <div class="nav-section-label">Navigation</div>

    <a class="nav-item active" href="index.jsp">
      <i class="fas fa-home"></i>
      <span class="nav-label">Dashboard</span>
    </a>
    <a class="nav-item" href="complaintRegister.jsp">
      <i class="fas fa-exclamation-triangle"></i>
      <span class="nav-label">Report Issue</span>
    </a>
    <a class="nav-item" href="myComplaints.jsp">
      <i class="fas fa-list-check"></i>
      <span class="nav-label">My Reports</span>
    </a>
    <a class="nav-item" href="community.jsp">
      <i class="fas fa-users"></i>
      <span class="nav-label">Community Feed</span>
    </a>

    <div class="nav-section-label" style="margin-top:0.5rem;">Account</div>
    <a class="nav-item" href="profile.jsp">
      <i class="fas fa-user"></i>
      <span class="nav-label">Profile</span>
    </a>
  </aside>

  <!-- ===================== MAIN ===================== -->
  <main>

    <!-- Page Header Row -->
    <div class="page-header">
      <div class="page-header-left">
        <div class="breadcrumb"><i class="fas fa-grip-horizontal"></i>Home &rsaquo; Dashboard</div>
        <h2>Dashboard</h2>
      </div>
      <div class="date-badge">
        <i class="fas fa-calendar-day"></i>
        <span id="currentDate">Loading...</span>
      </div>
    </div>

    <!-- Hero Banner -->
    <section class="hero">
      <div class="hero-illustration">🌿</div>
      <div class="hero-content">
        <div class="hero-greeting">
          <span class="dot"></span>
          Good to see you!
        </div>
        <h1>Welcome back, <%= userName %>!</h1>
        <p>Transform your village with clean initiatives, tree planting, and community collaboration. Every action counts.</p>
        <div class="hero-actions">
          <a class="hero-btn hero-btn-primary" href="complaintRegister.jsp">
            <i class="fas fa-plus"></i> Report an Issue
          </a>
          <a class="hero-btn hero-btn-ghost" href="community.jsp">
            <i class="fas fa-users"></i> Community Feed
          </a>
        </div>
      </div>
    </section>

    <!-- Cards Section -->
    <div class="section-title">Quick Actions</div>

    <section class="dashboard-grid">

      <!-- Report Issue -->
      <div class="dashboard-card card-theme-red" onclick="location.href='complaintRegister.jsp'">
        <div class="card-icon-wrap"><i class="fas fa-exclamation-triangle"></i></div>
        <div class="card-body">
          <h3>Report Issue</h3>
          <p>Report garbage, damaged roads, or environmental concerns.</p>
        </div>
        <div class="card-arrow">
          Go to Report <i class="fas fa-arrow-right"></i>
        </div>
      </div>

      <!-- My Reports -->
      <div class="dashboard-card card-theme-blue" onclick="location.href='myComplaints.jsp'">
        <div class="card-icon-wrap"><i class="fas fa-list-check"></i></div>
        <div class="card-body">
          <h3>My Reports</h3>
          <p>Track the status of all your submitted reports.</p>
        </div>
        <div class="card-arrow">
          View Reports <i class="fas fa-arrow-right"></i>
        </div>
      </div>

      <!-- Community Feed -->
      <div class="dashboard-card card-theme-teal" onclick="location.href='community.jsp'">
        <div class="card-icon-wrap"><i class="fas fa-users"></i></div>
        <div class="card-body">
          <h3>Community Feed</h3>
          <p>See what your neighbors are doing to improve the village.</p>
        </div>
        <div class="card-arrow">
          Explore Feed <i class="fas fa-arrow-right"></i>
        </div>
      </div>

      <!-- Tree Plantation -->
      <div class="dashboard-card card-theme-green" onclick="location.href='#'">
        <div class="card-icon-wrap"><i class="fas fa-seedling"></i></div>
        <div class="card-body">
          <h3>Tree Plantation</h3>
          <p>Participate in tree planting drives and events.</p>
        </div>
        <div class="card-arrow">
          Join Drive <i class="fas fa-arrow-right"></i>
        </div>
      </div>

      <!-- Clean Activity -->
      <div class="dashboard-card card-theme-amber" onclick="location.href='#'">
        <div class="card-icon-wrap"><i class="fas fa-broom"></i></div>
        <div class="card-body">
          <h3>Clean Activity</h3>
          <p>Share cleanup activities and inspire others.</p>
        </div>
        <div class="card-arrow">
          Share Activity <i class="fas fa-arrow-right"></i>
        </div>
      </div>

      <!-- Profile -->
      <div class="dashboard-card card-theme-indigo" onclick="location.href='profile.jsp'">
        <div class="card-icon-wrap"><i class="fas fa-user-circle"></i></div>
        <div class="card-body">
          <h3>Your Profile</h3>
          <p>View your profile, badges, and contributions.</p>
        </div>
        <div class="card-arrow">
          View Profile <i class="fas fa-arrow-right"></i>
        </div>
      </div>

    </section>
  </main>

  <!-- ===================== FOOTER ===================== -->
  <footer>
    <div class="footer-brand">
      <i class="fas fa-leaf"></i>
      &copy; 2026 Village Clean &amp; Green. All rights reserved.
    </div>
    <div class="footer-links">
      <a href="#">Privacy Policy</a>
      <a href="#">Terms of Service</a>
      <a href="#">Contact Support</a>
    </div>
  </footer>

</div>

<script>
  /* ── Sidebar toggle ── */
  const toggleBtn = document.getElementById('sidebarToggleBtn');
  const body = document.body;

  toggleBtn.addEventListener('click', () => {
    if (window.innerWidth <= 992) {
      body.classList.toggle('sidebar-open');
    } else {
      body.classList.toggle('sidebar-collapsed');
    }
  });

  /* ── Date badge ── */
  const dateEl = document.getElementById('currentDate');
  if (dateEl) {
    const now = new Date();
    dateEl.textContent = now.toLocaleDateString('en-US', {
      weekday: 'short', day: 'numeric', month: 'short', year: 'numeric'
    });
  }
</script>

</body>
</html>