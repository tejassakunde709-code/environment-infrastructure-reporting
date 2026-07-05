<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");

    if (userName == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Village Clean & Green - Dashboard</title>

  <!-- Google Fonts: Poppins -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

  <style>
    /* Base Reset & Variables */
    *, *::before, *::after {
      box-sizing: border-box;
    }
    * {
      margin: 0;
      padding: 0;
    }
    html {
      height: 100%;
    }
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      height: 100vh;
      overflow: hidden;
      position: relative;
    }
    body::before {
      content: '';
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background:
        radial-gradient(circle at 20% 80%, rgba(120,119,198,0.3) 0%, transparent 50%),
        radial-gradient(circle at 80% 20%, rgba(255,255,255,0.1) 0%, transparent 50%),
        radial-gradient(circle at 40% 40%, rgba(120,219,226,0.2) 0%, transparent 50%);
      z-index: -1;
      animation: bgShift 20s ease-in-out infinite;
    }

    /* ================== APP LAYOUT ================== */
    .app-wrapper {
      height: 100vh;
      display: grid;
      grid-template:
        "header header" 80px
        "sidebar main" 1fr
        "sidebar footer" 60px
        / 280px 1fr;
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }

    body.sidebar-collapsed .app-wrapper {
      grid-template:
        "header header" 80px
        "sidebar main" 1fr
        "sidebar footer" 60px
        / 80px 1fr;
    }

    /* ================== TOP NAVBAR ================== */
    .top-navbar {
      grid-area: header;
      background: rgba(255,255,255,0.97);
      backdrop-filter: blur(30px);
      border-bottom: 1px solid rgba(255,255,255,0.2);
      z-index: 100;
      padding: 0 32px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      box-shadow: 0 8px 32px rgba(0,0,0,0.12);
      position: sticky;
      top: 0;
    }

    .navbar-left {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .sidebar-toggle {
      background: linear-gradient(135deg, rgba(47,177,123,0.2), rgba(39,165,107,0.2));
      border: 2px solid rgba(47,177,123,0.3);
      color: #2FB17B;
      width: 48px;
      height: 48px;
      border-radius: 16px;
      cursor: pointer;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 18px;
    }

    .sidebar-toggle:hover {
      background: linear-gradient(135deg, #2FB17B, #27a56b);
      color: white;
      transform: rotate(90deg) scale(1.05);
      box-shadow: 0 8px 25px rgba(47,177,123,0.4);
    }

    .logo {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 26px;
      font-weight: 700;
      background: linear-gradient(135deg, #2FB17B, #27a56b);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .logo i {
      font-size: 34px;
      filter: drop-shadow(0 4px 12px rgba(47,177,123,0.5));
    }

    .navbar-right {
      display: flex;
      align-items: center;
      gap: 24px;
    }

    .user-info {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 10px 20px;
      background: linear-gradient(135deg, rgba(47,177,123,0.15), rgba(39,165,107,0.15));
      border-radius: 25px;
      color: #0A2540;
      font-weight: 500;
      border: 1px solid rgba(47,177,123,0.2);
    }

    .user-avatar {
      width: 42px;
      height: 42px;
      border-radius: 50%;
      background: linear-gradient(135deg, #2FB17B, #27a56b);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 18px;
      color: white;
      font-weight: 600;
      box-shadow: 0 4px 12px rgba(47,177,123,0.4);
    }

    .logout-btn {
      background: linear-gradient(135deg, #FF6B6B, #FF8E8E);
      color: white;
      border: none;
      padding: 12px 28px;
      border-radius: 25px;
      font-weight: 600;
      font-size: 14px;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 8px;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      box-shadow: 0 6px 20px rgba(255,107,107,0.4);
    }

    .logout-btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 12px 30px rgba(255,107,107,0.6);
    }

    /* ================== SIDEBAR ================== */
    .sidebar {
      grid-area: sidebar;
      background: linear-gradient(180deg, rgba(10,37,64,0.98) 0%, rgba(26,64,119,0.95) 100%);
      backdrop-filter: blur(25px);
      border-right: 1px solid rgba(255,255,255,0.15);
      padding: 100px 0 30px;
      overflow-y: auto;
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
      position: relative;
      scrollbar-width: thin;
      scrollbar-color: rgba(47,177,123,0.4) transparent;
    }

    body.sidebar-collapsed .sidebar {
      padding: 100px 0 30px 0;
    }

    .sidebar::-webkit-scrollbar {
      width: 6px;
    }

    .sidebar::-webkit-scrollbar-track {
      background: transparent;
    }

    .sidebar::-webkit-scrollbar-thumb {
      background: rgba(47,177,123,0.4);
      border-radius: 3px;
    }

    .sidebar::-webkit-scrollbar-thumb:hover {
      background: rgba(47,177,123,0.6);
    }

    .sidebar-nav {
      display: flex;
      flex-direction: column;
      gap: 8px;
      padding: 0 20px;
    }

    .nav-item {
      display: flex;
      align-items: center;
      gap: 16px;
      padding: 18px 24px;
      color: rgba(255,255,255,0.85);
      font-weight: 500;
      font-size: 15px;
      cursor: pointer;
      position: relative;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      border-radius: 0 20px 20px 0;
      overflow: hidden;
    }

    .nav-item::before {
      content: '';
      position: absolute;
      left: 0;
      top: 0;
      bottom: 0;
      width: 4px;
      background: linear-gradient(180deg, #2FB17B, #27a56b);
      transform: scaleY(0);
      transition: transform 0.3s ease;
    }

    .nav-item:hover {
      background: rgba(47,177,123,0.2);
      color: #fff;
      transform: translateX(6px);
      box-shadow: 0 8px 25px rgba(47,177,123,0.3);
    }

    .nav-item:hover::before {
      transform: scaleY(1);
    }

    .nav-item.active {
      background: linear-gradient(135deg, rgba(47,177,123,0.3), rgba(39,165,107,0.3));
      color: #fff;
      box-shadow: 0 8px 25px rgba(47,177,123,0.4);
    }

    .nav-item.active::before {
      transform: scaleY(1);
      box-shadow: 0 0 20px rgba(47,177,123,0.6);
    }

    .nav-item i {
      font-size: 20px;
      width: 24px;
      text-align: center;
      flex-shrink: 0;
      transition: transform 0.3s ease;
    }

    .nav-item:hover i {
      transform: scale(1.1);
    }

    .nav-label {
      transition: all 0.3s ease;
    }

    body.sidebar-collapsed .nav-label {
      opacity: 0;
      visibility: hidden;
      width: 0;
    }

    body.sidebar-collapsed .nav-item {
      justify-content: center;
      padding: 18px 16px;
    }

    .sidebar-footer {
      margin-top: auto;
      padding: 24px 20px;
      color: rgba(255,255,255,0.4);
      font-size: 12px;
      text-align: center;
      border-top: 1px solid rgba(255,255,255,0.1);
    }

    /* ================== MAIN CONTENT ================== */
    main {
      grid-area: main;
      overflow-y: auto;
      padding: 120px 40px 40px;
      scrollbar-width: thin;
      scrollbar-color: rgba(47,177,123,0.5) transparent;
    }

    body.sidebar-collapsed main {
      padding-left: 120px;
    }

    main::-webkit-scrollbar {
      width: 8px;
    }

    main::-webkit-scrollbar-track {
      background: transparent;
    }

    main::-webkit-scrollbar-thumb {
      background: rgba(47,177,123,0.5);
      border-radius: 4px;
    }

    main::-webkit-scrollbar-thumb:hover {
      background: rgba(47,177,123,0.7);
    }

    /* Hero Section */
    .hero {
      background: rgba(255,255,255,0.95);
      backdrop-filter: blur(20px);
      border-radius: 24px;
      padding: 60px 80px;
      text-align: center;
      margin-bottom: 60px;
      box-shadow: 0 20px 60px rgba(0,0,0,0.15);
      border: 1px solid rgba(255,255,255,0.3);
      position: relative;
      overflow: hidden;
    }

    .hero::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: linear-gradient(45deg, transparent, rgba(47,177,123,0.05), transparent);
      animation: shine 3s infinite;
    }

    .hero h1 {
      font-size: 48px;
      font-weight: 700;
      background: linear-gradient(135deg, #0A2540, #1A4077);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      margin-bottom: 20px;
      line-height: 1.2;
    }

    .hero p {
      font-size: 20px;
      color: #556975;
      font-weight: 400;
      max-width: 600px;
      margin: 0 auto;
      line-height: 1.6;
    }

    /* Stats Row */
    .stats-row {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 28px;
      margin-bottom: 60px;
    }

    .stat-card {
      background: rgba(255,255,255,0.92);
      backdrop-filter: blur(18px);
      border-radius: 24px;
      padding: 36px 28px;
      text-align: center;
      border: 1px solid rgba(255,255,255,0.4);
      box-shadow: 0 12px 40px rgba(0,0,0,0.1);
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
      position: relative;
      overflow: hidden;
    }

    .stat-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 5px;
      background: linear-gradient(90deg, #2FB17B, #27a56b, #2FB17B);
      background-size: 200% 100%;
      animation: gradientShift 2s ease infinite;
    }

    .stat-card:hover {
      transform: translateY(-12px) scale(1.02);
      box-shadow: 0 28px 60px rgba(47,177,123,0.35);
    }

    .stat-number {
      font-size: 40px;
      font-weight: 700;
      background: linear-gradient(135deg, #2FB17B, #27a56b);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      margin-bottom: 10px;
    }

    .stat-label {
      color: #556975;
      font-weight: 500;
      font-size: 15px;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    /* Dashboard Cards */
    .dashboard-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
      gap: 36px;
    }

    .dashboard-card {
      background: rgba(255,255,255,0.95);
      backdrop-filter: blur(22px);
      border-radius: 28px;
      padding: 44px 36px;
      text-align: center;
      cursor: pointer;
      border: 1px solid rgba(255,255,255,0.4);
      box-shadow: 0 18px 55px rgba(0,0,0,0.14);
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
      position: relative;
      overflow: hidden;
    }

    .dashboard-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 6px;
      background: linear-gradient(90deg, transparent, #2FB17B, transparent);
      transform: scaleX(0);
      transition: transform 0.4s ease;
    }

    .dashboard-card:hover::before {
      transform: scaleX(1);
    }

    .dashboard-card:hover {
      transform: translateY(-18px) scale(1.03);
      box-shadow: 0 35px 85px rgba(47,177,123,0.45);
      border-color: rgba(47,177,123,0.4);
    }

    .card-icon {
      font-size: 68px;
      margin-bottom: 28px;
      background: linear-gradient(135deg, #2FB17B, #27a56b, #1A4077);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      filter: drop-shadow(0 10px 25px rgba(47,177,123,0.35));
      transition: all 0.4s ease;
    }

    .dashboard-card:hover .card-icon {
      filter: drop-shadow(0 0 35px rgba(47,177,123,0.7));
      transform: scale(1.12) rotate(8deg);
    }

    .dashboard-card h3 {
      font-size: 26px;
      font-weight: 600;
      color: #0A2540;
      margin-bottom: 14px;
      transition: color 0.3s ease;
    }

    .dashboard-card:hover h3 {
      color: #2FB17B;
    }

    .dashboard-card p {
      color: #556975;
      font-size: 16px;
      line-height: 1.7;
      margin: 0;
    }

    /* ================== PROFESSIONAL FOOTER ================== */
    footer {
      grid-area: footer;
      background: linear-gradient(180deg, #0A2540 0%, #1A4077 100%);
      backdrop-filter: blur(20px);
      border-top: 3px solid #2FB17B;
      box-shadow: 0 -4px 20px rgba(10,37,64,0.6);
      padding: 24px 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      color: rgba(255,255,255,0.9);
      font-size: 14px;
      font-weight: 500;
      position: relative;
      overflow: hidden;
    }

    footer::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 1px;
      background: linear-gradient(90deg, transparent, rgba(47,177,123,0.6), transparent);
    }

    .footer-left {
      display: flex;
      align-items: center;
      gap: 16px;
    }

    .footer-logo {
      height: 36px;
      width: auto;
      filter: drop-shadow(0 2px 8px rgba(47,177,123,0.4));
      border-radius: 8px;
    }

    .footer-brand {
      font-size: 16px;
      font-weight: 600;
      color: #2FB17B;
    }

    .footer-right {
      display: flex;
      align-items: center;
      gap: 24px;
    }

    .footer-nav {
      display: flex;
      gap: 20px;
      align-items: center;
    }

    .footer-nav a {
      color: rgba(255,255,255,0.85);
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s ease;
      padding: 8px 12px;
      border-radius: 6px;
    }

    .footer-nav a:hover {
      color: #2FB17B;
      background: rgba(47,177,123,0.15);
      transform: translateY(-1px);
    }

    .footer-divider {
      color: rgba(255,255,255,0.4);
      font-weight: 400;
    }

    .social-icons {
      display: flex;
      gap: 12px;
    }

    .social-icons a {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 36px;
      height: 36px;
      background: rgba(255,255,255,0.1);
      color: #2FB17B;
      border: 1px solid rgba(47,177,123,0.3);
      border-radius: 50%;
      font-size: 16px;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      text-decoration: none;
    }

    .social-icons a:hover {
      background: linear-gradient(135deg, #2FB17B, #27a56b);
      color: white;
      transform: translateY(-3px) scale(1.1);
      box-shadow: 0 8px 25px rgba(47,177,123,0.4);
    }

    /* ================== ANIMATIONS ================== */
    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(50px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes fadeInScale {
      from { opacity: 0; transform: scale(0.8); }
      to { opacity: 1; transform: scale(1); }
    }

    @keyframes shine {
      0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
      100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
    }

    @keyframes bgShift {
      0%, 100% { transform: rotate(0deg); }
      50% { transform: rotate(180deg); }
    }

    @keyframes gradientShift {
      0%, 100% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
    }

    .hero { animation: fadeInUp 1s ease 0.2s both; }
    .stats-row .stat-card:nth-child(1) { animation: fadeInUp 0.8s ease 0.4s both; }
    .stats-row .stat-card:nth-child(2) { animation: fadeInUp 0.8s ease 0.5s both; }
    .stats-row .stat-card:nth-child(3) { animation: fadeInUp 0.8s ease 0.6s both; }
    .dashboard-grid .dashboard-card:nth-child(1) { animation: fadeInScale 0.8s ease 0.8s both; }
    .dashboard-grid .dashboard-card:nth-child(2) { animation: fadeInScale 0.8s ease 0.9s both; }
    .dashboard-grid .dashboard-card:nth-child(3) { animation: fadeInScale 0.8s ease 1s both; }
    .dashboard-grid .dashboard-card:nth-child(4) { animation: fadeInScale 0.8s ease 1.1s both; }
    .dashboard-grid .dashboard-card:nth-child(5) { animation: fadeInScale 0.8s ease 1.2s both; }
    .dashboard-grid .dashboard-card:nth-child(6) { animation: fadeInScale 0.8s ease 1.3s both; }

    /* ================== RESPONSIVE ================== */
    @media (max-width: 1200px) {
      .dashboard-grid {
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 28px;
      }
    }

    @media (max-width: 992px) {
      .app-wrapper {
        grid-template:
          "header" 80px
          "main" 1fr
          "footer" 60px
          / 1fr;
      }
      .sidebar {
        position: fixed;
        left: 0;
        top: 80px;
        bottom: 0;
        width: 280px;
        transform: translateX(-100%);
        z-index: 999;
      }
      body.sidebar-open .sidebar {
        transform: translateX(0);
      }
      body.sidebar-open::before {
        content: '';
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background: rgba(0,0,0,0.5);
        z-index: 998;
      }
      main {
        padding: 100px 24px 40px;
      }
      .hero {
        padding: 40px 32px;
      }
      .hero h1 {
        font-size: 36px;
      }
      footer {
        flex-direction: column;
        gap: 16px;
        text-align: center;
        padding: 24px 20px;
      }
      .footer-right {
        order: -1;
        width: 100%;
        justify-content: center;
      }
    }

    @media (max-width: 768px) {
      main {
        padding: 100px 20px 40px;
      }
      .stats-row {
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
      }
      .hero {
        padding: 32px 24px;
      }
      .hero h1 {
        font-size: 28px;
      }
      .top-navbar {
        padding: 0 20px;
      }
    }

    @media (max-width: 480px) {
      .stats-row {
        grid-template-columns: 1fr;
      }
      .user-info {
        display: none;
      }
      main {
        padding: 100px 16px 40px;
      }
      .footer-nav {
        flex-direction: column;
        gap: 12px;
      }
    }

    /* Accessibility */
    @media (prefers-reduced-motion: reduce) {
      *, *::before, *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
      }
    }
  </style>
</head>
<body>
  <div class="app-wrapper">
    <!-- TOP NAVBAR -->
    <header class="top-navbar">
      <div class="navbar-left">
        <button class="sidebar-toggle" id="sidebarToggle" aria-label="Toggle sidebar">
          <i class="fas fa-bars"></i>
        </button>
        <div class="logo">
          <i class="fas fa-leaf"></i>
          <span>Village Clean & Green</span>
        </div>
      </div>
      <div class="navbar-right">
        <div class="user-info">
          <div class="user-avatar" id="userAvatar">V</div>
          <span id="headerUserName">Welcome, Villager</span>
        </div>
        <button class="logout-btn" onclick="logout()">
          <i class="fas fa-sign-out-alt"></i>
          Logout
        </button>
      </div>
    </header>

    <!-- SIDEBAR -->
    <nav class="sidebar" id="sidebar" role="navigation" aria-label="Main navigation">
      <div class="sidebar-nav">
        <div class="nav-item active" role="button" tabindex="0" onclick="goTo('dashboard.jsp')" onkeypress="handleNavKey(event, 'dashboard.jsp')">
          <i class="fas fa-tachometer-alt" aria-hidden="true"></i>
          <span class="nav-label">Dashboard</span>
        </div>
        <div class="nav-item" role="button" tabindex="0" onclick="goTo('report-issue.jsp')" onkeypress="handleNavKey(event, 'report-issue.jsp')">
          <i class="fas fa-exclamation-triangle" aria-hidden="true"></i>
          <span class="nav-label">Report Issue</span>
        </div>
        <div class="nav-item" role="button" tabindex="0" onclick="goTo('my-reports.jsp')" onkeypress="handleNavKey(event, 'my-reports.jsp')">
          <i class="fas fa-list-check" aria-hidden="true"></i>
          <span class="nav-label">My Reports</span>
        </div>
        <div class="nav-item" role="button" tabindex="0" onclick="goTo('clean-activity.jsp')" onkeypress="handleNavKey(event, 'clean-activity.jsp')">
          <i class="fas fa-broom" aria-hidden="true"></i>
          <span class="nav-label">Clean Activity</span>
        </div>
        <div class="nav-item" role="button" tabindex="0" onclick="goTo('tree-plantation.jsp')" onkeypress="handleNavKey(event, 'tree-plantation.jsp')">
          <i class="fas fa-seedling" aria-hidden="true"></i>
          <span class="nav-label">Tree Plantation</span>
        </div>
        <div class="nav-item" role="button" tabindex="0" onclick="goTo('community-feed.jsp')" onkeypress="handleNavKey(event, 'community-feed.jsp')">
          <i class="fas fa-users" aria-hidden="true"></i>
          <span class="nav-label">Community Feed</span>
        </div>
        <div class="nav-item" role="button" tabindex="0" onclick="goTo('profile.jsp')" onkeypress="handleNavKey(event, 'profile.jsp')">
          <i class="fas fa-user-circle" aria-hidden="true"></i>
          <span class="nav-label">Profile</span>
        </div>
      </div>
      <div class="sidebar-footer">
        © 2025 Village Clean & Green
      </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main role="main">
      <!-- Hero Section -->
      <section class="hero" aria-labelledby="heroTitle">
        <h1 id="heroTitle">Welcome to Your Village Dashboard</h1>
        <p>Transform your village with clean initiatives, tree planting, and community collaboration.</p>
      </section>

      <!-- Stats Row -->
      <section class="stats-row" aria-label="Village statistics">
        <div class="stat-card">
          <div class="stat-number" data-target="124">0</div>
          <div class="stat-label">Issues Resolved</div>
        </div>
        <div class="stat-card">
          <div class="stat-number" data-target="256">0</div>
          <div class="stat-label">Trees Planted</div>
        </div>
        <div class="stat-card">
          <div class="stat-number" data-target="89%">0%</div>
          <div class="stat-label">Cleanliness Score</div>
        </div>
      </section>

      <!-- Dashboard Cards -->
      <section class="dashboard-grid" aria-label="Quick actions">
        <article class="dashboard-card" tabindex="0" onclick="goTo('report-issue.jsp')" onkeypress="handleCardKey(event, 'report-issue.jsp')">
          <div class="card-icon fas fa-exclamation-triangle"></div>
          <h3>Report Issue</h3>
          <p>Report garbage, damaged roads, or any environmental concerns instantly.</p>
        </article>
        <article class="dashboard-card" tabindex="0" onclick="goTo('my-reports.jsp')" onkeypress="handleCardKey(event, 'my-reports.jsp')">
          <div class="card-icon fas fa-list-check"></div>
          <h3>My Reports</h3>
          <p>Track the status and progress of all your submitted reports.</p>
        </article>
        <article class="dashboard-card" tabindex="0" onclick="goTo('clean-activity.jsp')" onkeypress="handleCardKey(event, 'clean-activity.jsp')">
          <div class="card-icon fas fa-broom"></div>
          <h3>Clean Activity</h3>
          <p>Share your cleanup efforts and inspire the community.</p>
        </article>
        <article class="dashboard-card" tabindex="0" onclick="goTo('tree-plantation.jsp')" onkeypress="handleCardKey(event, 'tree-plantation.jsp')">
          <div class="card-icon fas fa-seedling"></div>
          <h3>Tree Plantation</h3>
          <p>Participate in tree planting drives and green initiatives.</p>
        </article>
        <article class="dashboard-card" tabindex="0" onclick="goTo('community-feed.jsp')" onkeypress="handleCardKey(event, 'community-feed.jsp')">
          <div class="card-icon fas fa-users"></div>
          <h3>Community Feed</h3>
          <p>See what your neighbors are doing to keep the village clean.</p>
        </article>
        <article class="dashboard-card" tabindex="0" onclick="goTo('profile.jsp')" onkeypress="handleCardKey(event, 'profile.jsp')">
          <div class="card-icon fas fa-user-circle"></div>
          <h3>Your Profile</h3>
          <p>View your badges, stats, and contribution leaderboard.</p>
        </article>
      </section>
    </main>

    <!-- PROFESSIONAL FOOTER -->
    <footer role="contentinfo" aria-label="Footer information">
      <div class="footer-left">
        <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjM2IiB2aWV3Qm94PSIwIDAgMTIwIDM2IiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8cmVjdCB3aWR0aD0iMTIwIiBoZWlnaHQ9IjM2IiByeD0iOCIgZmlsbD0iIzFGQjgwQyIvPgo8cGF0aCBkPSJNMCAxMmgxMjBWMjhIMHoiIGZpbGw9IiMyRkIxN0IiLz4KPHRleHQgeD0iMTIiIHk9IjI1IiBmb250LWZhbWlseT0iJ1BvcHBpbnMsIHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMTQiIGZvbnQtd2VpZ2h0PSI2MDAiIGZpbGw9IiNGRkYiPlZDRy88L3RleHQ+Cjwvc3ZnPgo=" alt="Village Clean & Green Logo" class="footer-logo">
        <span class="footer-brand">Village Clean & Green</span>
        <span>© 2025. All rights reserved.</span>
      </div>
      <div class="footer-right">
        <nav class="footer-nav" aria-label="Footer navigation">
          <a href="#" tabindex="0">Privacy Policy</a>
          <span class="footer-divider">|</span>
          <a href="#" tabindex="0">Terms of Service</a>
          <span class="footer-divider">|</span>
          <a href="#" tabindex="0">Contact Us</a>
        </nav>
        <div class="social-icons">
          <a href="https://facebook.com" aria-label="Facebook" target="_blank" rel="noopener">
            <i class="fab fa-facebook-f"></i>
          </a>
          <a href="https://twitter.com" aria-label="Twitter" target="_blank" rel="noopener">
            <i class="fab fa-twitter"></i>
          </a>
          <a href="https://instagram.com" aria-label="Instagram" target="_blank" rel="noopener">
            <i class="fab fa-instagram"></i>
          </a>
          <a href="https://linkedin.com" aria-label="LinkedIn" target="_blank" rel="noopener">
            <i class="fab fa-linkedin-in"></i>
          </a>
        </div>
      </div>
    </footer>
  </div>

  <script>
    const sidebarToggle = document.getElementById('sidebarToggle');
    const body = document.body;

    sidebarToggle.addEventListener('click', () => {
      body.classList.toggle('sidebar-collapsed');
    });

    function goTo(page) {
      window.location.href = page;
    }

    function logout() {
      window.location.href = 'logout.jsp';
    }

    const animateStats = () => {
      const stats = document.querySelectorAll('.stat-number');
      stats.forEach(stat => {
        const target = parseInt(stat.getAttribute('data-target'));
        let count = 0;
        const inc = target / 100;
        const timer = setInterval(() => {
          count += inc;
          if (count >= target) {
            count = target;
            clearInterval(timer);
          }
          stat.textContent = Math.floor(count) + (target === 89 ? '%' : '');
        }, 20);
      });
    };

    window.onload = () => {
      setTimeout(animateStats, 800);
    };
  </script>
</body>
</html>