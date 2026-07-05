<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>संपर्क करें | Contact Us - ग्राम स्वच्छता पोर्टल</title>
  
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link rel="preconnect" href="https://cdnjs.cloudflare.com">
  
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  
  <style>
    :root{--primary-blue:#0066cc;--primary-green:#00a651;--accent-orange:#ff6b35;--dark-blue:#003087;--navy:#1a365d;--white:#ffffff;--light-bg:#f8fafc;--card-bg:#ffffff;--text-dark:#1e293b;--text-medium:#64748b;--text-light:#94a3b8;--border-light:#e2e8f0;--shadow-sm:0 1px 3px rgba(0,0,0,0.1);--shadow-md:0 4px 12px rgba(0,0,0,0.08);--shadow-lg:0 10px 25px rgba(0,0,0,0.12);--success:#10b981;--warning:#f59e0b;--danger:#ef4444;}
    *{margin:0;padding:0;box-sizing:border-box;}
    body{font-family:'Poppins','Noto Sans Devanagari',sans-serif;background:linear-gradient(135deg,var(--light-bg) 0%,#e2e8f0 100%);color:var(--text-dark);line-height:1.6;overflow-x:hidden;}
    .govt-topbar{background:linear-gradient(90deg,var(--dark-blue),var(--navy));color:white;padding:8px 0;font-size:13px;font-weight:500;position:relative;z-index:1000;}
    .topbar-content{max-width:1400px;margin:0 auto;padding:0 2rem;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:1rem;}
    .topbar-info{display:flex;align-items:center;gap:2rem;flex-wrap:wrap;}
    .topbar-contact i{margin-right:.5rem;color:var(--primary-green);}
    .main-header{background:var(--white);box-shadow:var(--shadow-md);position:sticky;top:0;z-index:999;border-bottom:4px solid var(--primary-blue);}
    .header-container{max-width:1400px;margin:0 auto;padding:0 2rem;display:flex;align-items:center;justify-content:space-between;height:80px;}
    .logo-section{display:flex;align-items:center;gap:1.5rem;}
    .govt-logo{height:70px;width:auto;border-radius:8px;box-shadow:var(--shadow-sm);transition:transform .3s ease;}
    .govt-logo:hover{transform:scale(1.05);}
    .logo-text{font-size:1.8rem;font-weight:700;color:var(--dark-blue);}
    .logo-text .hindi{font-family:'Noto Sans Devanagari',sans-serif;font-size:1.5rem;color:var(--primary-blue);display:block;font-weight:600;}
    .main-nav{display:flex;gap:2.5rem;align-items:center;}
    .nav-link{color:var(--text-dark);text-decoration:none;font-weight:500;padding:.75rem 0;position:relative;transition:all .3s ease;font-size:.95rem;display:flex;align-items:center;gap:.5rem;}
    .nav-link:hover,.nav-link.active{color:var(--primary-blue);}
    .nav-link.active::after{content:'';position:absolute;bottom:0;left:0;width:100%;height:3px;background:linear-gradient(90deg,var(--primary-blue),var(--primary-green));}
    .lang-switcher{background:rgba(255,255,255,0.1);color:white;border:1px solid rgba(255,255,255,0.3);padding:4px 8px;border-radius:4px;outline:none;cursor:pointer;font-size:12px;}
    .lang-switcher option{color:black;}
    .main-content{max-width:1400px;margin:0 auto;padding:2.5rem 2rem;min-height:calc(100vh - 240px);}
    .contact-hero{background:linear-gradient(135deg,var(--primary-blue),var(--dark-blue));color:white;padding:4rem 2rem;border-radius:20px;margin-bottom:3rem;text-align:center;position:relative;overflow:hidden;}
    .contact-hero::before{content:'';position:absolute;top:0;left:0;right:0;height:6px;background:linear-gradient(90deg,var(--primary-green),var(--accent-orange),var(--primary-green));animation:gradientShift 3s ease infinite;}
    .contact-hero h1{font-size:3rem;font-weight:700;margin-bottom:1rem;}
    .contact-hero .hindi{font-family:'Noto Sans Devanagari',sans-serif;font-size:2.5rem;color:var(--primary-green);}
    .contact-hero p{font-size:1.2rem;max-width:800px;margin:0 auto;opacity:0.95;}
    .contact-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:2rem;margin-bottom:3rem;}
    .contact-card{background:var(--card-bg);border-radius:20px;padding:2.5rem;box-shadow:var(--shadow-md);text-align:center;transition:transform .3s ease,box-shadow .3s ease;border-top:4px solid var(--primary-blue);}
    .contact-card:hover{transform:translateY(-10px);box-shadow:var(--shadow-lg);}
    .contact-icon{width:80px;height:80px;margin:0 auto 1.5rem;border-radius:50%;background:linear-gradient(135deg,var(--primary-blue),var(--primary-green));display:flex;align-items:center;justify-content:center;font-size:2rem;color:white;}
    .contact-card h3{font-size:1.5rem;color:var(--dark-blue);margin-bottom:1rem;font-family:'Noto Sans Devanagari',sans-serif;}
    .contact-card p{color:var(--text-medium);margin-bottom:1rem;line-height:1.8;}
    .contact-card a{color:var(--primary-blue);text-decoration:none;font-weight:600;transition:color .3s;}
    .contact-card a:hover{color:var(--primary-green);}
    .contact-main{display:grid;grid-template-columns:1.2fr 1fr;gap:3rem;margin-bottom:3rem;}
    .contact-form{background:var(--card-bg);border-radius:20px;padding:3rem;box-shadow:var(--shadow-md);}
    .contact-form h2{font-size:2rem;color:var(--dark-blue);margin-bottom:2rem;font-family:'Noto Sans Devanagari',sans-serif;}
    .form-group{margin-bottom:1.5rem;}
    .form-group label{display:block;color:var(--text-dark);font-weight:600;margin-bottom:.5rem;font-family:'Noto Sans Devanagari',sans-serif;}
    .form-group input,.form-group textarea,.form-group select{width:100%;padding:1rem;border:2px solid var(--border-light);border-radius:12px;font-family:inherit;font-size:1rem;transition:all .3s ease;background:var(--light-bg);}
    .form-group input:focus,.form-group textarea:focus,.form-group select:focus{outline:none;border-color:var(--primary-blue);background:white;box-shadow:0 0 0 4px rgba(0,102,204,0.1);}
    .form-group textarea{min-height:150px;resize:vertical;}
    .submit-btn{background:linear-gradient(135deg,var(--primary-blue),var(--dark-blue));color:white;padding:1rem 3rem;border:none;border-radius:12px;font-size:1.1rem;font-weight:600;cursor:pointer;transition:all .3s ease;width:100%;font-family:'Noto Sans Devanagari',sans-serif;}
    .submit-btn:hover{transform:translateY(-2px);box-shadow:var(--shadow-lg);}
    .submit-btn:active{transform:translateY(0);}
    .info-sidebar{display:flex;flex-direction:column;gap:2rem;}
    .info-card{background:var(--card-bg);border-radius:20px;padding:2rem;box-shadow:var(--shadow-md);border-left:4px solid var(--primary-green);}
    .info-card h3{font-size:1.3rem;color:var(--dark-blue);margin-bottom:1.5rem;font-family:'Noto Sans Devanagari',sans-serif;display:flex;align-items:center;gap:.75rem;}
    .info-item{display:flex;align-items:start;gap:1rem;margin-bottom:1.5rem;padding:1rem;background:var(--light-bg);border-radius:12px;}
    .info-item:last-child{margin-bottom:0;}
    .info-item i{font-size:1.3rem;color:var(--primary-green);margin-top:.25rem;min-width:24px;}
    .info-item-content{flex:1;}
    .info-item-content strong{display:block;color:var(--dark-blue);margin-bottom:.25rem;font-size:.95rem;}
    .info-item-content span{color:var(--text-medium);font-size:.9rem;line-height:1.6;}
    .map-section{background:var(--card-bg);border-radius:20px;padding:2rem;box-shadow:var(--shadow-md);margin-bottom:3rem;}
    .map-section h2{font-size:2rem;color:var(--dark-blue);margin-bottom:1.5rem;font-family:'Noto Sans Devanagari',sans-serif;text-align:center;}
    .map-container{border-radius:16px;overflow:hidden;box-shadow:var(--shadow-md);height:450px;background:#e5e5e5;}
    .map-container iframe{width:100%;height:100%;border:none;display:block;}
    .emergency-section{background:linear-gradient(135deg,#fef2f2,#fee2e2);border-radius:20px;padding:3rem;margin-bottom:3rem;border:2px solid var(--danger);}
    .emergency-section h2{font-size:2rem;color:var(--danger);margin-bottom:2rem;font-family:'Noto Sans Devanagari',sans-serif;text-align:center;display:flex;align-items:center;justify-content:center;gap:1rem;}
    .emergency-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:2rem;}
    .emergency-card{background:white;padding:2rem;border-radius:16px;box-shadow:var(--shadow-sm);text-align:center;border:2px solid var(--danger);}
    .emergency-card i{font-size:2.5rem;color:var(--danger);margin-bottom:1rem;}
    .emergency-card h4{font-size:1.2rem;color:var(--dark-blue);margin-bottom:.5rem;font-family:'Noto Sans Devanagari',sans-serif;}
    .emergency-card .phone{font-size:1.5rem;font-weight:700;color:var(--danger);margin-top:.5rem;}
    .emergency-card p{color:var(--text-medium);font-size:.9rem;margin-top:.5rem;}
    .social-section{background:var(--card-bg);border-radius:20px;padding:3rem;box-shadow:var(--shadow-md);text-align:center;}
    .social-section h2{font-size:2rem;color:var(--dark-blue);margin-bottom:2rem;font-family:'Noto Sans Devanagari',sans-serif;}
    .social-links{display:flex;justify-content:center;gap:2rem;flex-wrap:wrap;}
    .social-link{width:80px;height:80px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:2rem;text-decoration:none;transition:all .3s ease;box-shadow:var(--shadow-md);}
    .social-link:hover{transform:translateY(-5px);box-shadow:var(--shadow-lg);}
    .social-link.facebook{background:linear-gradient(135deg,#1877f2,#0a5dc2);color:white;}
    .social-link.twitter{background:linear-gradient(135deg,#1da1f2,#0c85d0);color:white;}
    .social-link.whatsapp{background:linear-gradient(135deg,#25d366,#1da851);color:white;}
    .social-link.email{background:linear-gradient(135deg,#ea4335,#c5221f);color:white;}
    .social-link.youtube{background:linear-gradient(135deg,#ff0000,#cc0000);color:white;}
    .success-message{display:none;background:linear-gradient(135deg,#d1fae5,#a7f3d0);border:2px solid var(--success);color:#065f46;padding:1.5rem;border-radius:12px;margin-bottom:1.5rem;text-align:center;font-weight:600;animation:slideIn .3s ease;}
    .success-message.show{display:block;}
    .govt-footer{background:linear-gradient(180deg,var(--dark-blue),var(--navy));color:white;padding:4rem 0 2rem;margin-top:4rem;}
    .footer-container{max-width:1400px;margin:0 auto;padding:0 2rem;}
    .footer-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:3rem;margin-bottom:2.5rem;}
    .footer-brand{font-size:1.8rem;font-weight:700;color:var(--primary-blue);margin-bottom:1rem;}
    .footer-link{color:rgba(255,255,255,0.8);text-decoration:none;display:block;padding:.5rem 0;transition:color .3s ease;}
    .footer-link:hover{color:var(--primary-green);}
    .footer-bottom{border-top:1px solid rgba(255,255,255,0.1);padding-top:2rem;text-align:center;font-size:.9rem;color:rgba(255,255,255,0.7);}
    @keyframes gradientShift{0%,100%{background-position:0% 50%}50%{background-position:100% 50%}}
    @keyframes slideIn{from{opacity:0;transform:translateY(-20px)}to{opacity:1;transform:translateY(0)}}
    @media(max-width:968px){.contact-main{grid-template-columns:1fr;}.contact-hero h1{font-size:2rem;}.emergency-grid{grid-template-columns:1fr;}.main-nav{display:none;}}
  </style>
</head>
<body>
  <div class="govt-topbar">
    <div class="topbar-content">
      <div class="topbar-info">
        <span><i class="fas fa-building-government"></i> <span data-key="dept_name">ग्राम पंचायत स्वच्छता एवं हरियाली विभाग</span></span>
        <span><i class="fas fa-phone"></i> <span data-key="helpline">हेल्पलाइन</span>: 1800-3000-2000</span>
      </div>
      <div style="display:flex; align-items:center; gap:15px;">
        <select class="lang-switcher" id="langSelector">
            <option value="hi">हिन्दी</option>
            <option value="en">English</option>
            <option value="mr">मराठी</option>
        </select>
        <span><span data-key="date_label">आज का दिनांक</span>: <strong><%= new SimpleDateFormat("d MMMM yyyy", new java.util.Locale("hi", "IN")).format(new java.util.Date()) %></strong></span>
      </div>
    </div>
  </div>

  <header class="main-header">
    <div class="header-container">
      <div class="logo-section">
        <img src="images/Gemini_Generated_Image_k9rvjmk9rvjmk9rv.png" alt="Logo" class="govt-logo">
        <div class="logo-text">
          <span class="hindi" data-key="logo_text">ग्राम स्वच्छता एवं हरियाली</span>
        </div>
      </div>
      
      <nav class="main-nav">
        <a href="index.jsp" class="nav-link"><i class="fas fa-home"></i> <span data-key="nav_home">होम</span></a>
        <a href="about.jsp" class="nav-link"><i class="fas fa-info-circle"></i> <span data-key="nav_about">हमारे बारे में</span></a>
        <a href="report-issue.jsp" class="nav-link"><i class="fas fa-exclamation-triangle"></i> <span data-key="nav_report">शिकायत</span></a>
        <a href="community-feed.jsp" class="nav-link"><i class="fas fa-users"></i> <span data-key="nav_community">समुदाय</span></a>
        <a href="contact.jsp" class="nav-link active"><i class="fas fa-envelope"></i> <span data-key="nav_contact">संपर्क</span></a>
      </nav>
    </div>
  </header>

  <main class="main-content">
    <section class="contact-hero">
      <h1 class="hindi" data-key="hero_title">हमसे संपर्क करें</h1>
      <h1 data-key="hero_title_en">Get In Touch With Us</h1>
      <p data-key="hero_desc">हम आपकी सेवा के लिए हमेशा उपलब्ध हैं। किसी भी प्रश्न, सुझाव या शिकायत के लिए हमसे संपर्क करें।</p>
    </section>

    <section class="contact-grid">
      <div class="contact-card">
        <div class="contact-icon"><i class="fas fa-phone"></i></div>
        <h3 data-key="phone_title">फोन से संपर्क करें</h3>
        <p data-key="phone_desc">सोमवार - शनिवार, 9:00 AM - 5:00 PM</p>
        <p><strong data-key="toll_free">टोल फ्री</strong>: <a href="tel:18003000200">1800-3000-2000</a></p>
        <p><strong data-key="office">कार्यालय</strong>: <a href="tel:02112231100">0211-2231100</a></p>
      </div>
      
      <div class="contact-card">
        <div class="contact-icon"><i class="fas fa-envelope"></i></div>
        <h3 data-key="email_title">ईमेल से संपर्क करें</h3>
        <p data-key="email_desc">24 घंटे के भीतर जवाब मिलेगा</p>
        <p><a href="mailto:panchayat@village.gov.in">panchayat@village.gov.in</a></p>
        <p><a href="mailto:cleangreen@grampanchayat.in">cleangreen@grampanchayat.in</a></p>
      </div>
      
      <div class="contact-card">
        <div class="contact-icon"><i class="fas fa-map-marker-alt"></i></div>
        <h3 data-key="visit_title">सीधे मिलें</h3>
        <p data-key="visit_desc">ग्राम पंचायत कार्यालय</p>
        <p data-key="address">मुख्य बाजार मार्ग<br>गाँव का नाम - 413102<br>महाराष्ट्र, भारत</p>
      </div>
    </section>

    <section class="emergency-section">
      <h2><i class="fas fa-exclamation-triangle"></i> <span data-key="emergency_title">आपातकालीन संपर्क | Emergency Contact</span></h2>
      <div class="emergency-grid">
        <div class="emergency-card">
          <i class="fas fa-ambulance"></i>
          <h4 data-key="em1_title">स्वास्थ्य आपातकाल</h4>
          <div class="phone">108</div>
          <p data-key="em1_desc">एम्बुलेंस सेवा</p>
        </div>
        <div class="emergency-card">
          <i class="fas fa-fire-extinguisher"></i>
          <h4 data-key="em2_title">अग्निशमन विभाग</h4>
          <div class="phone">101</div>
          <p data-key="em2_desc">आग बुझाने की सेवा</p>
        </div>
        <div class="emergency-card">
          <i class="fas fa-shield-alt"></i>
          <h4 data-key="em3_title">पुलिस सहायता</h4>
          <div class="phone">100</div>
          <p data-key="em3_desc">आपातकालीन पुलिस सेवा</p>
        </div>
        <div class="emergency-card">
          <i class="fas fa-exclamation-circle"></i>
          <h4 data-key="em4_title">स्वच्छता आपातकाल</h4>
          <div class="phone">1800-3000-2000</div>
          <p data-key="em4_desc">तुरंत शिकायत दर्ज करें</p>
        </div>
      </div>
    </section>

    <section class="contact-main">
      <div class="contact-form">
        <h2 data-key="form_title">संदेश भेजें | Send Message</h2>
        <div class="success-message" id="successMessage">
          <i class="fas fa-check-circle"></i> <span data-key="success_msg">आपका संदेश सफलतापूर्वक भेज दिया गया है। हम जल्द ही आपसे संपर्क करेंगे।</span>
        </div>
        <form id="contactForm">
          <div class="form-group">
            <label for="name" data-key="name_label">पूरा नाम | Full Name *</label>
            <input type="text" id="name" name="name" required placeholder="अपना नाम दर्ज करें">
          </div>
          <div class="form-group">
            <label for="email" data-key="email_label">ईमेल पता | Email *</label>
            <input type="email" id="email" name="email" required placeholder="example@email.com">
          </div>
          <div class="form-group">
            <label for="phone" data-key="phone_label">मोबाइल नंबर | Phone Number *</label>
            <input type="tel" id="phone" name="phone" required placeholder="+91 XXXXX XXXXX">
          </div>
          <div class="form-group">
            <label for="subject" data-key="subject_label">विषय | Subject *</label>
            <select id="subject" name="subject" required>
              <option value="" data-key="select">चयन करें | Select</option>
              <option value="complaint" data-key="sub1">शिकायत | Complaint</option>
              <option value="suggestion" data-key="sub2">सुझाव | Suggestion</option>
              <option value="inquiry" data-key="sub3">पूछताछ | Inquiry</option>
              <option value="feedback" data-key="sub4">प्रतिक्रिया | Feedback</option>
              <option value="other" data-key="sub5">अन्य | Other</option>
            </select>
          </div>
          <div class="form-group">
            <label for="message" data-key="message_label">संदेश | Message *</label>
            <textarea id="message" name="message" required placeholder="अपना संदेश यहाँ लिखें..."></textarea>
          </div>
          <button type="submit" class="submit-btn">
            <i class="fas fa-paper-plane"></i> <span data-key="submit_btn">संदेश भेजें | Send Message</span>
          </button>
        </form>
      </div>

      <div class="info-sidebar">
        <div class="info-card">
          <h3><i class="fas fa-clock"></i> <span data-key="hours_title">कार्यालय समय</span></h3>
          <div class="info-item">
            <i class="fas fa-calendar-week"></i>
            <div class="info-item-content">
              <strong data-key="weekdays">सोमवार - शुक्रवार</strong>
              <span>9:00 AM - 5:00 PM</span>
            </div>
          </div>
          <div class="info-item">
            <i class="fas fa-calendar-day"></i>
            <div class="info-item-content">
              <strong data-key="saturday">शनिवार</strong>
              <span>9:00 AM - 1:00 PM</span>
            </div>
          </div>
          <div class="info-item">
            <i class="fas fa-calendar-times"></i>
            <div class="info-item-content">
              <strong data-key="sunday">रविवार</strong>
              <span data-key="closed">बंद | Closed</span>
            </div>
          </div>
        </div>

        <div class="info-card">
          <h3><i class="fas fa-users"></i> <span data-key="dept_title">विभाग संपर्क</span></h3>
          <div class="info-item">
            <i class="fas fa-user-tie"></i>
            <div class="info-item-content">
              <strong data-key="sarpanch">सरपंच</strong>
              <span>+91-9876543210</span>
            </div>
          </div>
          <div class="info-item">
            <i class="fas fa-broom"></i>
            <div class="info-item-content">
              <strong data-key="sanitation">स्वच्छता विभाग</strong>
              <span>+91-9876543211</span>
            </div>
          </div>
          <div class="info-item">
            <i class="fas fa-laptop-code"></i>
            <div class="info-item-content">
              <strong data-key="tech_support">तकनीकी सहायता</strong>
              <span>+91-9876543212</span>
            </div>
          </div>
        </div>

        <div class="info-card">
          <h3><i class="fas fa-info-circle"></i> <span data-key="important_info">महत्वपूर्ण सूचना</span></h3>
          <p style="color:var(--text-medium);line-height:1.8;" data-key="info_text">सभी शिकायतों और पूछताछ का जवाब 24-48 घंटों के भीतर दिया जाएगा। आपातकालीन मामलों के लिए कृपया हेल्पलाइन नंबर का उपयोग करें।</p>
        </div>
      </div>
    </section>

    <section class="map-section">
      <h2 data-key="map_title">हमारा स्थान | Our Location</h2>
      <div class="map-container">
        <iframe 
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d60566.12345!2d74.5815!3d18.1524!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc2bf2e67461101%3A0x828d43bf9d9ee343!2sPune%2C%20Maharashtra!5e0!3m2!1sen!2sin!4v1234567890"
          allowfullscreen="" 
          loading="lazy"
          referrerpolicy="no-referrer-when-downgrade">
        </iframe>
      </div>
    </section>

    <section class="social-section">
      <h2 data-key="social_title">हमसे जुड़ें | Follow Us</h2>
      <p style="color:var(--text-medium);margin-bottom:2rem;" data-key="social_desc">सोशल मीडिया पर हमें फॉलो करें और नवीनतम अपडेट पाएं</p>
      <div class="social-links">
        <a href="#" class="social-link facebook" title="Facebook">
          <i class="fab fa-facebook-f"></i>
        </a>
        <a href="#" class="social-link twitter" title="Twitter">
          <i class="fab fa-twitter"></i>
        </a>
        <a href="#" class="social-link whatsapp" title="WhatsApp">
          <i class="fab fa-whatsapp"></i>
        </a>
        <a href="mailto:panchayat@village.gov.in" class="social-link email" title="Email">
          <i class="fas fa-envelope"></i>
        </a>
        <a href="#" class="social-link youtube" title="YouTube">
          <i class="fab fa-youtube"></i>
        </a>
      </div>
    </section>

  </main>

  <footer class="govt-footer">
    <div class="footer-container">
      <div class="footer-grid">
        <div>
          <div class="footer-brand">
            <span data-key="footer_brand">ग्राम स्वच्छता पोर्टल</span>
          </div>
          <p data-key="footer_desc">स्वच्छ भारत मिशन 2.0 के तहत ग्राम पंचायत की आधिकारिक डिजिटल पहल।</p>
          <div style="margin-top:1rem;">
            <a href="#" style="color:var(--primary-green);margin-right:1rem;font-size:1.2rem;"><i class="fab fa-facebook-f"></i></a>
            <a href="#" style="color:var(--primary-green);margin-right:1rem;font-size:1.2rem;"><i class="fab fa-twitter"></i></a>
            <a href="#" style="color:var(--primary-green);font-size:1.2rem;"><i class="fab fa-whatsapp"></i></a>
          </div>
        </div>
        <div>
          <h5 style="font-weight:600;color:var(--primary-blue);margin-bottom:1rem;" data-key="quick_links">त्वरित लिंक</h5>
          <a href="dashboard.jsp" class="footer-link" data-key="f_home">होम</a>
          <a href="about.jsp" class="footer-link" data-key="f_about">हमारे बारे में</a>
          <a href="report-issue.jsp" class="footer-link" data-key="f_report">शिकायत दर्ज करें</a>
          <a href="contact.jsp" class="footer-link" data-key="f_contact">संपर्क करें</a>
        </div>
        <div>
          <h5 style="font-weight:600;color:var(--primary-blue);margin-bottom:1rem;" data-key="contact_us">संपर्क करें</h5>
          <p style="line-height:1.8;">📞 <strong data-key="helpline">हेल्पलाइन</strong>: 1800-3000-2000<br>📧 <strong>Email</strong>: panchayat@village.gov.in<br>🏠 <strong data-key="address_short">पता</strong>: ग्राम पंचायत कार्यालय</p>
        </div>
        <div>
          <h5 style="font-weight:600;color:var(--primary-blue);margin-bottom:1rem;" data-key="resources">संसाधन</h5>
          <a href="#" class="footer-link" data-key="privacy">गोपनीयता नीति</a>
          <a href="#" class="footer-link" data-key="terms">सेवा शर्तें</a>
          <a href="#" class="footer-link" data-key="rti">RTI जानकारी</a>
          <a href="#" class="footer-link" data-key="faq">FAQ</a>
        </div>
      </div>
      <div class="footer-bottom" data-key="copyright">
        © 2025 ग्राम पंचायत, सभी अधिकार सुरक्षित | All Rights Reserved
      </div>
    </div>
  </footer>

  <script>
    // Translations object
    const t = {
      hi: {
        dept_name: "ग्राम पंचायत स्वच्छता एवं हरियाली विभाग",
        helpline: "हेल्पलाइन",
        date_label: "आज का दिनांक",
        logo_text: "ग्राम स्वच्छता एवं हरियाली",
        nav_home: "होम",
        nav_about: "हमारे बारे में",
        nav_report: "शिकायत",
        nav_community: "समुदाय",
        nav_contact: "संपर्क",
        hero_title: "हमसे संपर्क करें",
        hero_title_en: "Get In Touch With Us",
        hero_desc: "हम आपकी सेवा के लिए हमेशा उपलब्ध हैं। किसी भी प्रश्न, सुझाव या शिकायत के लिए हमसे संपर्क करें।",
        phone_title: "फोन से संपर्क करें",
        phone_desc: "सोमवार - शनिवार, 9:00 AM - 5:00 PM",
        toll_free: "टोल फ्री",
        office: "कार्यालय",
        email_title: "ईमेल से संपर्क करें",
        email_desc: "24 घंटे के भीतर जवाब मिलेगा",
        visit_title: "सीधे मिलें",
        visit_desc: "ग्राम पंचायत कार्यालय",
        address: "मुख्य बाजार मार्ग<br>गाँव का नाम - 413102<br>महाराष्ट्र, भारत",
        emergency_title: "आपातकालीन संपर्क | Emergency Contact",
        em1_title: "स्वास्थ्य आपातकाल",
        em1_desc: "एम्बुलेंस सेवा",
        em2_title: "अग्निशमन विभाग",
        em2_desc: "आग बुझाने की सेवा",
        em3_title: "पुलिस सहायता",
        em3_desc: "आपातकालीन पुलिस सेवा",
        em4_title: "स्वच्छता आपातकाल",
        em4_desc: "तुरंत शिकायत दर्ज करें",
        form_title: "संदेश भेजें | Send Message",
        success_msg: "आपका संदेश सफलतापूर्वक भेज दिया गया है। हम जल्द ही आपसे संपर्क करेंगे।",
        name_label: "पूरा नाम | Full Name *",
        email_label: "ईमेल पता | Email *",
        phone_label: "मोबाइल नंबर | Phone Number *",
        subject_label: "विषय | Subject *",
        select: "चयन करें | Select",
        sub1: "शिकायत | Complaint",
        sub2: "सुझाव | Suggestion",
        sub3: "पूछताछ | Inquiry",
        sub4: "प्रतिक्रिया | Feedback",
        sub5: "अन्य | Other",
        message_label: "संदेश | Message *",
        submit_btn: "संदेश भेजें | Send Message",
        hours_title: "कार्यालय समय",
        weekdays: "सोमवार - शुक्रवार",
        saturday: "शनिवार",
        sunday: "रविवार",
        closed: "बंद | Closed",
        dept_title: "विभाग संपर्क",
        sarpanch: "सरपंच",
        sanitation: "स्वच्छता विभाग",
        tech_support: "तकनीकी सहायता",
        important_info: "महत्वपूर्ण सूचना",
        info_text: "सभी शिकायतों और पूछताछ का जवाब 24-48 घंटों के भीतर दिया जाएगा। आपातकालीन मामलों के लिए कृपया हेल्पलाइन नंबर का उपयोग करें।",
        map_title: "हमारा स्थान | Our Location",
        social_title: "हमसे जुड़ें | Follow Us",
        social_desc: "सोशल मीडिया पर हमें फॉलो करें और नवीनतम अपडेट पाएं",
        footer_brand: "ग्राम स्वच्छता पोर्टल",
        footer_desc: "स्वच्छ भारत मिशन 2.0 के तहत ग्राम पंचायत की आधिकारिक डिजिटल पहल।",
        quick_links: "त्वरित लिंक",
        f_home: "होम",
        f_about: "हमारे बारे में",
        f_report: "शिकायत दर्ज करें",
        f_contact: "संपर्क करें",
        contact_us: "संपर्क करें",
        address_short: "पता",
        resources: "संसाधन",
        privacy: "गोपनीयता नीति",
        terms: "सेवा शर्तें",
        rti: "RTI जानकारी",
        faq: "FAQ",
        copyright: "© 2025 ग्राम पंचायत, सभी अधिकार सुरक्षित | All Rights Reserved"
      },
      en: {
        dept_name: "Gram Panchayat Clean & Green Department",
        helpline: "Helpline",
        date_label: "Today's Date",
        logo_text: "Village Clean & Green",
        nav_home: "Home",
        nav_about: "About Us",
        nav_report: "Complaints",
        nav_community: "Community",
        nav_contact: "Contact",
        hero_title: "Contact Us",
        hero_title_en: "Get In Touch With Us",
        hero_desc: "We are always available to serve you. Contact us for any questions, suggestions or complaints.",
        phone_title: "Contact by Phone",
        phone_desc: "Monday - Saturday, 9:00 AM - 5:00 PM",
        toll_free: "Toll Free",
        office: "Office",
        email_title: "Contact by Email",
        email_desc: "Response within 24 hours",
        visit_title: "Visit Us",
        visit_desc: "Gram Panchayat Office",
        address: "Main Market Road<br>Village Name - 413102<br>Maharashtra, India",
        emergency_title: "Emergency Contact",
        em1_title: "Health Emergency",
        em1_desc: "Ambulance Service",
        em2_title: "Fire Department",
        em2_desc: "Fire Fighting Service",
        em3_title: "Police Help",
        em3_desc: "Emergency Police Service",
        em4_title: "Sanitation Emergency",
        em4_desc: "Report Immediately",
        form_title: "Send Message",
        success_msg: "Your message has been sent successfully. We will contact you soon.",
        name_label: "Full Name *",
        email_label: "Email Address *",
        phone_label: "Phone Number *",
        subject_label: "Subject *",
        select: "Select",
        sub1: "Complaint",
        sub2: "Suggestion",
        sub3: "Inquiry",
        sub4: "Feedback",
        sub5: "Other",
        message_label: "Message *",
        submit_btn: "Send Message",
        hours_title: "Office Hours",
        weekdays: "Monday - Friday",
        saturday: "Saturday",
        sunday: "Sunday",
        closed: "Closed",
        dept_title: "Department Contact",
        sarpanch: "Village Head",
        sanitation: "Sanitation Department",
        tech_support: "Technical Support",
        important_info: "Important Information",
        info_text: "All complaints and inquiries will be answered within 24-48 hours. For emergencies, please use the helpline number.",
        map_title: "Our Location",
        social_title: "Follow Us",
        social_desc: "Follow us on social media and get latest updates",
        footer_brand: "Village Cleanliness Portal",
        footer_desc: "Official digital initiative under Swachh Bharat Mission 2.0.",
        quick_links: "Quick Links",
        f_home: "Home",
        f_about: "About Us",
        f_report: "Report Issue",
        f_contact: "Contact Us",
        contact_us: "Contact Us",
        address_short: "Address",
        resources: "Resources",
        privacy: "Privacy Policy",
        terms: "Terms of Service",
        rti: "RTI Information",
        faq: "FAQ",
        copyright: "© 2025 Gram Panchayat. All Rights Reserved"
      },
      mr: {
        dept_name: "ग्रामपंचायत स्वच्छता विभाग",
        helpline: "हेल्पलाइन",
        date_label: "आजची तारीख",
        logo_text: "ग्राम स्वच्छता",
        nav_home: "मुख्यपृष्ठ",
        nav_about: "आमच्याबद्दल",
        nav_report: "तक्रार",
        nav_community: "समुदाय",
        nav_contact: "संपर्क",
        hero_title: "संपर्क साधा",
        hero_title_en: "आमच्याशी संपर्क साधा",
        hero_desc: "आम्ही तुमच्या सेवेसाठी नेहमी उपलब्ध आहोत. कोणत्याही प्रश्न, सूचना किंवा तक्रारीसाठी आमच्याशी संपर्क साधा.",
        phone_title: "फोनवर संपर्क करा",
        phone_desc: "सोमवार - शनिवार, सकाळी ९ ते संध्याकाळी ५",
        toll_free: "टोल फ्री",
        office: "कार्यालय",
        email_title: "ईमेलने संपर्क करा",
        email_desc: "२४ तासांत उत्तर मिळेल",
        visit_title: "भेट द्या",
        visit_desc: "ग्रामपंचायत कार्यालय",
        address: "मुख्य बाजार रोड<br>गावाचे नाव - ४१३१०२<br>महाराष्ट्र, भारत",
        emergency_title: "आपत्कालीन संपर्क",
        em1_title: "आरोग्य आपत्काल",
        em1_desc: "रुग्णवाहिका सेवा",
        em2_title: "अग्निशमन विभाग",
        em2_desc: "आग विझवणे सेवा",
        em3_title: "पोलीस मदत",
        em3_desc: "आपत्कालीन पोलीस सेवा",
        em4_title: "स्वच्छता आपत्काल",
        em4_desc: "लगेच तक्रार नोंदवा",
        form_title: "संदेश पाठवा",
        success_msg: "तुमचा संदेश यशस्वीरित्या पाठवला गेला आहे. आम्ही लवकरच तुमच्याशी संपर्क साधू.",
        name_label: "पूर्ण नाव *",
        email_label: "ईमेल पत्ता *",
        phone_label: "फोन नंबर *",
        subject_label: "विषय *",
        select: "निवडा",
        sub1: "तक्रार",
        sub2: "सूचना",
        sub3: "चौकशी",
        sub4: "अभिप्राय",
        sub5: "इतर",
        message_label: "संदेश *",
        submit_btn: "संदेश पाठवा",
        hours_title: "कार्यालयीन वेळ",
        weekdays: "सोमवार - शुक्रवार",
        saturday: "शनिवार",
        sunday: "रविवार",
        closed: "बंद",
        dept_title: "विभाग संपर्क",
        sarpanch: "सरपंच",
        sanitation: "स्वच्छता विभाग",
        tech_support: "तांत्रिक मदत",
        important_info: "महत्त्वाची माहिती",
        info_text: "सर्व तक्रारी आणि चौकशींचे उत्तर २४-४८ तासांत दिले जाईल. आपत्कालीन प्रकरणांसाठी कृपया हेल्पलाइन नंबर वापरा.",
        map_title: "आमचे स्थान",
        social_title: "आमच्याशी जुडा",
        social_desc: "सोशल मीडियावर आम्हाला फॉलो करा आणि नवीनतम अपडेट मिळवा",
        footer_brand: "ग्राम स्वच्छता पोर्टल",
        footer_desc: "स्वच्छ भारत मिशन २.० अंतर्गत अधिकृत डिजिटल उपक्रम.",
        quick_links: "जलद दुवे",
        f_home: "मुख्यपृष्ठ",
        f_about: "आमच्याबद्दल",
        f_report: "तक्रार नोंदवा",
        f_contact: "संपर्क करा",
        contact_us: "संपर्क करा",
        address_short: "पत्ता",
        resources: "संसाधने",
        privacy: "गोपनीयता धोरण",
        terms: "सेवा अटी",
        rti: "RTI माहिती",
        faq: "FAQ",
        copyright: "© २०२५ ग्रामपंचायत. सर्व हक्क राखीव"
      }
    };

    // Language switcher function
    function changeLang(lang) {
      const els = document.querySelectorAll('[data-key]');
      const trans = t[lang];
      if (!trans) return;
      
      els.forEach(el => {
        const key = el.dataset.key;
        if (trans[key]) el.innerHTML = trans[key];
      });
      
      localStorage.setItem('lang', lang);
    }

    // Initialize language on load
    (function() {
      const lang = localStorage.getItem('lang') || 'hi';
      const sel = document.getElementById('langSelector');
      sel.value = lang;
      sel.onchange = e => changeLang(e.target.value);
      changeLang(lang);
    })();

    // Form submission handler
    document.getElementById('contactForm').addEventListener('submit', function(e) {
      e.preventDefault();
      
      // Show success message
      const successMsg = document.getElementById('successMessage');
      successMsg.classList.add('show');
      
      // Reset form
      this.reset();
      
      // Hide success message after 5 seconds
      setTimeout(() => {
        successMsg.classList.remove('show');
      }, 5000);
      
      // Scroll to success message
      successMsg.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    });
  </script>
</body>
</html>