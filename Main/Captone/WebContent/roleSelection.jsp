<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login Role Selection - ग्राम स्वच्छता</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  <style>
    :root{--primary-blue:#0066cc;--primary-green:#00a651;--accent-orange:#ff6b35;--dark-blue:#003087;--navy:#1a365d;--white:#ffffff;--light-bg:#f8fafc;--text-dark:#1e293b;--text-medium:#64748b;--shadow-lg:0 10px 25px rgba(0,0,0,0.12);}
    
    *{margin:0;padding:0;box-sizing:border-box;}
    body{font-family:'Poppins','Noto Sans Devanagari',sans-serif;background:#f0f2f5;color:var(--text-dark);height: 100vh; display: flex; flex-direction: column;}
    
    .govt-topbar{background:linear-gradient(90deg,var(--dark-blue),var(--navy));color:white;padding:10px 0;text-align: center; font-size: 14px;}
    
    .selection-container {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem;
    }

    .card-wrapper {
        background: white;
        padding: 3rem;
        border-radius: 20px;
        box-shadow: var(--shadow-lg);
        text-align: center;
        max-width: 900px;
        width: 100%;
    }

    .main-title { font-size: 2rem; color: var(--navy); margin-bottom: 0.5rem; font-weight: 700; }
    .sub-title { color: var(--text-medium); margin-bottom: 3rem; font-size: 1.1rem; }

    .role-options {
        display: flex;
        gap: 2rem;
        justify-content: center;
        flex-wrap: wrap;
    }

    .role-card {
        flex: 1;
        min-width: 280px;
        border: 2px solid #e2e8f0;
        border-radius: 15px;
        padding: 2.5rem;
        cursor: pointer;
        text-decoration: none;
        transition: 0.3s all ease;
        display: flex;
        flex-direction: column;
        align-items: center;
        background: var(--light-bg);
    }

    .role-card:hover {
        transform: translateY(-5px);
        border-color: var(--primary-blue);
        box-shadow: 0 10px 20px rgba(0,102,204,0.15);
    }

    .icon-box {
        width: 80px;
        height: 80px;
        background: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.5rem;
        margin-bottom: 1.5rem;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    }

    .user-card .icon-box { color: var(--primary-green); }
    .admin-card .icon-box { color: var(--primary-blue); }

    .role-card h3 { color: var(--dark-blue); font-size: 1.4rem; margin-bottom: 0.5rem; }
    .role-card p { color: var(--text-medium); font-size: 0.9rem; }
    
    .govt-footer{background:var(--navy);color:white;padding:1.5rem 0;text-align:center;font-size: 0.9rem;}
  </style>
</head>
<body>

    <div class="govt-topbar">
        <i class="fas fa-landmark me-2"></i> ग्राम पंचायत स्वच्छता एवं हरियाली विभाग
    </div>

    <div class="selection-container">
        <div class="card-wrapper">
            <h1 class="main-title">Select Login Role</h1>
            <p class="sub-title">कृपया लॉग इन करने के लिए अपनी भूमिका चुनें / Please select your role to login</p>

            <div class="role-options">
                <!-- USER OPTION -->
                <a href="userLogin.jsp" class="role-card user-card">
                    <div class="icon-box"><i class="fas fa-users"></i></div>
                    <h3>Citizen / User</h3>
                    <p>नागरिक लॉगिन<br>Register complaints & view status</p>
                </a>

                <!-- ADMIN OPTION -->
                <a href="adminLogin.jsp" class="role-card admin-card">
                    <div class="icon-box"><i class="fas fa-user-shield"></i></div>
                    <h3>Admin / Official</h3>
                    <p>अधिकारी लॉगिन<br>Manage complaints & system</p>
                </a>
            </div>
        </div>
    </div>

    <footer class="govt-footer">
        <p>© 2025 ग्राम पंचायत | सूचना प्रौद्योगिकी विभाग द्वारा विकसित</p>
    </footer>

</body>
</html>