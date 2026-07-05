<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Birth Certificate Application - Gram Panchayat</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --sky:        #0ea5e9;
            --sky-dark:   #0369a1;
            --sky-mid:    #38bdf8;
            --sky-light:  #e0f2fe;
            --sky-pale:   #f0f9ff;
            --teal:       #0d9488;
            --teal-light: #ccfbf1;
            --amber:      #f59e0b;
            --amber-light:#fef3c7;
            --green:      #22c55e;
            --green-dark: #15803d;
            --green-light:#dcfce7;
            --bg-page:    #eef6ff;
            --white:      #ffffff;
            --text:       #0f172a;
            --text-soft:  #475569;
            --text-muted: #94a3b8;
            --border:     #bae6fd;
            --border-soft:#e0f2fe;
            --radius:     14px;
            --radius-sm:  8px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg-page);
            background-image:
                radial-gradient(circle at 15% 10%, rgba(14,165,233,0.12) 0%, transparent 55%),
                radial-gradient(circle at 85% 80%, rgba(13,148,136,0.10) 0%, transparent 55%),
                radial-gradient(circle at 50% 50%, rgba(34,197,94,0.04) 0%, transparent 70%);
            min-height: 100vh;
            padding-bottom: 4rem;
            color: var(--text);
        }

        /* ── BACK LINK ── */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-soft);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            margin: 2rem 0 1.25rem;
            padding: 8px 16px;
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: 50px;
            transition: all 0.25s;
            box-shadow: 0 1px 4px rgba(14,165,233,0.10);
        }
        .back-link:hover {
            color: var(--sky-dark);
            background: var(--sky-light);
            border-color: var(--sky);
            transform: translateX(-3px);
        }

        /* ── MAIN CARD ── */
        .form-card {
            background: var(--white);
            border-radius: 24px;
            border: 1px solid var(--border-soft);
            box-shadow: 0 20px 60px rgba(14,165,233,0.12), 0 4px 16px rgba(0,0,0,0.06);
            overflow: hidden;
            margin-bottom: 2.5rem;
            animation: floatIn 0.55s cubic-bezier(.22,.68,0,1.2) both;
        }

        @keyframes floatIn {
            from { opacity: 0; transform: translateY(24px) scale(0.98); }
            to   { opacity: 1; transform: translateY(0) scale(1); }
        }

        /* ── HERO BANNER ── */
        .hero-banner {
            background: linear-gradient(135deg, #0c4a6e 0%, #0369a1 30%, #0ea5e9 65%, #38bdf8 100%);
            padding: 3rem 2.5rem 5rem;
            position: relative;
            overflow: hidden;
            text-align: center;
        }

        .hero-banner::before {
            content: '';
            position: absolute;
            inset: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.04'%3E%3Ccircle cx='30' cy='30' r='20'/%3E%3Ccircle cx='0' cy='0' r='10'/%3E%3Ccircle cx='60' cy='60' r='10'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }

        /* Floating decorative bubbles */
        .bubble {
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
            animation: drift 6s ease-in-out infinite;
        }
        .bubble-1 { width: 180px; height: 180px; top: -60px; left: -40px; animation-delay: 0s; }
        .bubble-2 { width: 120px; height: 120px; top: 10px; right: -20px; animation-delay: 1.5s; }
        .bubble-3 { width: 80px;  height: 80px;  bottom: 20px; left: 20%;  animation-delay: 3s; }
        .bubble-4 { width: 60px;  height: 60px;  bottom: 30px; right: 25%; animation-delay: 2s; }

        @keyframes drift {
            0%, 100% { transform: translateY(0) scale(1); }
            50%       { transform: translateY(-14px) scale(1.04); }
        }

        .hero-badge {
            position: relative;
            z-index: 2;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.25);
            color: #bae6fd;
            font-size: 0.8rem;
            font-weight: 600;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            padding: 6px 18px;
            border-radius: 50px;
            margin-bottom: 1.25rem;
        }

        .hero-icon-wrap {
            position: relative;
            z-index: 2;
            width: 90px;
            height: 90px;
            background: rgba(255,255,255,0.18);
            backdrop-filter: blur(16px);
            border: 2px solid rgba(255,255,255,0.30);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.25rem;
            box-shadow: 0 8px 32px rgba(0,0,0,0.15);
        }

        .hero-icon-wrap i {
            font-size: 2.2rem;
            color: #fff;
        }

        .hero-title {
            font-family: 'DM Serif Display', serif;
            font-size: 2.1rem;
            color: #ffffff;
            line-height: 1.2;
            position: relative;
            z-index: 2;
            margin-bottom: 0.4rem;
        }

        .hero-subtitle {
            font-size: 1rem;
            color: #bae6fd;
            font-weight: 400;
            position: relative;
            z-index: 2;
            margin-bottom: 0.85rem;
        }

        .hero-note {
            font-size: 0.82rem;
            color: rgba(186,230,253,0.85);
            position: relative;
            z-index: 2;
        }

        /* Curved wave bottom */
        .hero-wave {
            position: absolute;
            bottom: -1px;
            left: 0;
            right: 0;
            z-index: 2;
        }

        /* ── FORM BODY ── */
        .form-body {
            padding: 2.5rem 2.5rem 2rem;
        }

        /* ── SECTION TITLES ── */
        .section-block {
            margin-bottom: 2rem;
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--border-soft);
            position: relative;
        }

        .section-header::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 60px;
            height: 2px;
            background: var(--sky);
            border-radius: 2px;
        }

        .section-num {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--sky), var(--sky-dark));
            color: white;
            font-size: 0.8rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            box-shadow: 0 4px 12px rgba(14,165,233,0.35);
        }

        .section-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            background: var(--sky-light);
            color: var(--sky-dark);
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .section-info { flex: 1; }

        .section-info h5 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text);
            margin: 0;
            line-height: 1.3;
        }

        .section-info small {
            font-size: 0.78rem;
            color: var(--text-muted);
        }

        /* ── INNER PANEL (for Child section ── highlight) ── */
        .child-panel {
            background: linear-gradient(135deg, var(--sky-pale), #f0fffe);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 1.5rem;
            position: relative;
            overflow: hidden;
        }

        .child-panel::before {
            content: '👶';
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 5rem;
            opacity: 0.08;
            pointer-events: none;
        }

        /* Parent duo card */
        .parent-duo {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .parent-card {
            background: var(--sky-pale);
            border: 1px solid var(--border-soft);
            border-radius: var(--radius);
            padding: 1.25rem 1.25rem 1rem;
            position: relative;
        }

        .parent-card.father { border-top: 3px solid #0ea5e9; }
        .parent-card.mother { border-top: 3px solid #ec4899; }

        .parent-label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 700;
            font-size: 0.88rem;
            margin-bottom: 1rem;
        }

        .parent-label.father { color: var(--sky-dark); }
        .parent-label.mother { color: #be185d; }

        .parent-icon {
            width: 30px; height: 30px;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.85rem;
        }

        .parent-icon.father { background: #e0f2fe; color: var(--sky-dark); }
        .parent-icon.mother { background: #fce7f3; color: #be185d; }

        /* ── FORM CONTROLS ── */
        .form-label {
            font-weight: 600;
            font-size: 0.83rem;
            color: var(--text-soft);
            margin-bottom: 0.4rem;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .form-control, .form-select {
            font-family: 'DM Sans', sans-serif;
            padding: 0.7rem 1rem;
            border: 1.5px solid #cbd5e1;
            border-radius: var(--radius-sm);
            font-size: 0.92rem;
            color: var(--text);
            background: #fdfdff;
            transition: all 0.22s ease;
        }

        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--sky);
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(14,165,233,0.14);
        }

        .form-control::placeholder { color: var(--text-muted); font-size: 0.88rem; }

        input[type="file"].form-control { display: none; }

        /* ── CUSTOM FILE UPLOAD ── */
        .file-upload-zone {
            border: 2px dashed #94a3b8;
            border-radius: var(--radius-sm);
            padding: 1.1rem 1rem;
            text-align: center;
            background: #f8fbff;
            cursor: pointer;
            transition: all 0.22s;
            position: relative;
        }

        .file-upload-zone:hover {
            border-color: var(--sky);
            background: var(--sky-pale);
        }

        .file-upload-zone.has-file {
            border-color: var(--green);
            background: var(--green-light);
        }

        .file-upload-zone .upload-icon {
            font-size: 1.4rem;
            color: var(--sky);
            margin-bottom: 0.3rem;
        }

        .file-upload-zone.has-file .upload-icon { color: var(--green-dark); }

        .file-upload-zone .upload-text {
            font-size: 0.8rem;
            color: var(--text-soft);
            font-weight: 500;
        }

        .file-upload-zone .file-name {
            font-size: 0.78rem;
            color: var(--green-dark);
            font-weight: 600;
            margin-top: 2px;
            display: none;
        }

        .file-upload-zone.has-file .file-name { display: block; }
        .file-upload-zone.has-file .upload-text { display: none; }

        /* ── ADDRESS SECTION ── */
        .address-panel {
            background: #f8faff;
            border: 1px solid var(--border-soft);
            border-radius: var(--radius);
            padding: 1.4rem;
        }

        /* ── DOCUMENT UPLOAD SECTION ── */
        .doc-info-pill {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            background: var(--amber-light);
            border: 1px solid #fcd34d;
            border-radius: var(--radius-sm);
            padding: 0.85rem 1.1rem;
            margin-bottom: 1.25rem;
            font-size: 0.84rem;
            color: #92400e;
        }

        .doc-info-pill i { margin-top: 2px; flex-shrink: 0; }

        /* ── DECLARATION BOX ── */
        .declaration-box {
            background: linear-gradient(135deg, var(--sky-pale), #f0fffe);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 1.4rem 1.5rem;
            display: flex;
            align-items: flex-start;
            gap: 14px;
        }

        .form-check-input {
            width: 20px;
            height: 20px;
            border: 2px solid var(--sky);
            border-radius: 5px;
            margin-top: 2px;
            flex-shrink: 0;
            cursor: pointer;
        }

        .form-check-input:checked {
            background-color: var(--sky-dark);
            border-color: var(--sky-dark);
        }

        .form-check-input:focus {
            box-shadow: 0 0 0 4px rgba(14,165,233,0.18);
        }

        .declaration-text {
            font-size: 0.88rem;
            line-height: 1.65;
            color: var(--text-soft);
        }

        .declaration-text strong { color: var(--text); }

        /* ── DIVIDER ── */
        .section-divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--border), transparent);
            margin: 2rem 0;
        }

        /* ── SUBMIT AREA ── */
        .submit-area {
            background: var(--sky-pale);
            border-top: 1px solid var(--border-soft);
            padding: 2rem 2.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-submit {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: linear-gradient(135deg, #0ea5e9, #0369a1);
            color: #fff;
            border: none;
            padding: 0.85rem 2.5rem;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            font-weight: 700;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.25s;
            box-shadow: 0 6px 24px rgba(14,165,233,0.35);
            letter-spacing: 0.02em;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(14,165,233,0.45);
        }

        .btn-submit:active { transform: translateY(0); }

        .btn-reset {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--white);
            color: var(--text-soft);
            border: 1.5px solid #cbd5e1;
            padding: 0.83rem 2rem;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.92rem;
            font-weight: 600;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.22s;
        }

        .btn-reset:hover {
            border-color: var(--sky);
            color: var(--sky-dark);
            background: var(--sky-pale);
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 768px) {
            .form-body { padding: 1.5rem; }
            .submit-area { padding: 1.5rem; }
            .hero-banner { padding: 2rem 1.5rem 4.5rem; }
            .hero-title { font-size: 1.6rem; }
            .parent-duo { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="container py-2">
    <div class="row justify-content-center">
        <div class="col-lg-10">

            <!-- Back Navigation -->
            <a href="index.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>

            <div class="form-card">

                <!-- ── HERO BANNER ── -->
                <div class="hero-banner">
                    <!-- Decorative bubbles -->
                    <div class="bubble bubble-1"></div>
                    <div class="bubble bubble-2"></div>
                    <div class="bubble bubble-3"></div>
                    <div class="bubble bubble-4"></div>

                    <div class="hero-badge">
                        <i class="fas fa-star"></i> e-Gramseva Portal &nbsp;·&nbsp; Official Application
                    </div>

                    <div class="hero-icon-wrap">
                        <i class="fas fa-baby"></i>
                    </div>

                    <h1 class="hero-title">Birth Certificate Application</h1>
                    <p class="hero-subtitle">Application for Issuance of Birth Certificate</p>
                    <p class="hero-note"><i class="fas fa-circle-dot me-1" style="font-size:0.6rem;"></i> Fields marked with <strong style="color:#fff;">*</strong> are mandatory</p>

                    <!-- Wave SVG -->
                    <svg class="hero-wave" viewBox="0 0 1440 60" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M0,40 C360,80 1080,0 1440,40 L1440,60 L0,60 Z" fill="#ffffff"/>
                    </svg>
                </div>

                <!-- ── FORM BODY ── -->
                <div class="form-body">
                    <form action="SubmitBirthApplicationServlet" method="POST" enctype="multipart/form-data">

                        <!-- ── SECTION 1: CHILD DETAILS ── -->
                        <div class="section-block">
                            <div class="section-header">
                                <div class="section-num">1</div>
                                <div class="section-icon"><i class="fas fa-child"></i></div>
                                <div class="section-info">
                                    <h5>Child's Information</h5>
                                    <small>Enter the details of the newborn</small>
                                </div>
                            </div>

                            <div class="child-panel">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                        <input type="date" class="form-control" name="dob" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Time of Birth <span class="text-danger">*</span></label>
                                        <input type="time" class="form-control" name="time_of_birth" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Gender <span class="text-danger">*</span></label>
                                        <select class="form-select" name="gender" required>
                                            <option value="">Select Gender</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Transgender">Transgender</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Name of Child <small class="text-muted fw-normal">(leave blank if not named)</small></label>
                                        <input type="text" class="form-control" name="child_name" placeholder="Enter full name">
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label">Place of Birth <span class="text-danger">*</span></label>
                                        <select class="form-select" name="birth_place" required>
                                            <option value="">Select Place</option>
                                            <option value="Home">House / Home</option>
                                            <option value="Govt Hospital">Government Hospital / PHC</option>
                                            <option value="Private Hospital">Private Hospital</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="section-divider"></div>

                        <!-- ── SECTION 2: PARENTS DETAILS ── -->
                        <div class="section-block">
                            <div class="section-header">
                                <div class="section-num">2</div>
                                <div class="section-icon"><i class="fas fa-user-friends"></i></div>
                                <div class="section-info">
                                    <h5>Parents' Information</h5>
                                    <small>Father's and Mother's details with Aadhaar</small>
                                </div>
                            </div>

                            <div class="parent-duo">
                                <!-- Father Card -->
                                <div class="parent-card father">
                                    <div class="parent-label father">
                                        <div class="parent-icon father"><i class="fas fa-male"></i></div>
                                        Father's Details
                                    </div>
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="father_name" placeholder="Enter father's full name" required>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Aadhaar No. <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="father_aadhaar" pattern="\d{12}" title="12 digit Aadhaar number" placeholder="12-digit Aadhaar" required>
                                        </div>
                                    </div>
                                </div>
                                <!-- Mother Card -->
                                <div class="parent-card mother">
                                    <div class="parent-label mother">
                                        <div class="parent-icon mother"><i class="fas fa-female"></i></div>
                                        Mother's Details
                                    </div>
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="mother_name" placeholder="Enter mother's full name" required>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Aadhaar No. <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="mother_aadhaar" pattern="\d{12}" title="12 digit Aadhaar number" placeholder="12-digit Aadhaar" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="section-divider"></div>

                        <!-- ── SECTION 3: ADDRESS ── -->
                        <div class="section-block">
                            <div class="section-header">
                                <div class="section-num">3</div>
                                <div class="section-icon"><i class="fas fa-map-marker-alt"></i></div>
                                <div class="section-info">
                                    <h5>Address at Time of Birth</h5>
                                    <small>Permanent residential address</small>
                                </div>
                            </div>

                            <div class="address-panel">
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label class="form-label">House No. / Street / Village <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="address" placeholder="Complete address" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Gram Panchayat <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="gram_panchayat" placeholder="Panchayat name" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">District <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="district" placeholder="District name" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Pincode <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="pincode" pattern="\d{6}" title="6 digit pincode" placeholder="6-digit PIN" required>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="section-divider"></div>

                        <!-- ── SECTION 4: APPLICANT DETAILS ── -->
                        <div class="section-block">
                            <div class="section-header">
                                <div class="section-num">4</div>
                                <div class="section-icon"><i class="fas fa-user-edit"></i></div>
                                <div class="section-info">
                                    <h5>Applicant Information</h5>
                                    <small>Person submitting this application</small>
                                </div>
                            </div>

                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">Applicant Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="applicant_name" placeholder="Your full name" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Relation to Child <span class="text-danger">*</span></label>
                                    <select class="form-select" name="relation" required>
                                        <option value="">Select Relation</option>
                                        <option value="Father">Father</option>
                                        <option value="Mother">Mother</option>
                                        <option value="Grandparent">Grandparent</option>
                                        <option value="Guardian">Guardian</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Mobile Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="mobile" pattern="\d{10}" title="10 digit mobile number" placeholder="10-digit mobile no." required>
                                </div>
                            </div>
                        </div>

                        <div class="section-divider"></div>

                        <!-- ── SECTION 5: DOCUMENTS ── -->
                        <div class="section-block">
                            <div class="section-header">
                                <div class="section-num">5</div>
                                <div class="section-icon"><i class="fas fa-file-upload"></i></div>
                                <div class="section-info">
                                    <h5>Upload Required Documents</h5>
                                    <small>Please ensure all documents are clear and legible</small>
                                </div>
                            </div>

                            <div class="doc-info-pill">
                                <i class="fas fa-info-circle mt-1"></i>
                                <span>Accepted formats: <strong>PDF, JPG, PNG</strong>. Maximum file size allowed is <strong>2MB</strong> per document. Ensure files are clearly readable.</span>
                            </div>

                            <div class="row g-3">
                                <!-- Doc 1 -->
                                <div class="col-md-12">
                                    <label class="form-label">1. Proof of Birth <span class="text-danger">*</span> <small class="text-muted fw-normal">(Hospital Discharge Slip / ASHA Worker Letter)</small></label>
                                    <label class="file-upload-zone d-block" id="zone_birth_proof" for="file_birth_proof">
                                        <div class="upload-icon"><i class="fas fa-cloud-upload-alt"></i></div>
                                        <div class="upload-text">Click to browse or drag & drop your file here</div>
                                        <div class="file-name" id="name_birth_proof"></div>
                                        <input class="form-control" type="file" id="file_birth_proof" name="doc_birth_proof" accept=".pdf,.jpg,.jpeg,.png" required onchange="handleFile(this,'zone_birth_proof','name_birth_proof')">
                                    </label>
                                </div>

                                <!-- Doc 2 -->
                                <div class="col-md-6">
                                    <label class="form-label">2. Father's ID Proof <span class="text-danger">*</span> <small class="text-muted fw-normal">(Aadhaar / Voter ID)</small></label>
                                    <label class="file-upload-zone d-block" id="zone_father_id" for="file_father_id">
                                        <div class="upload-icon"><i class="fas fa-id-card"></i></div>
                                        <div class="upload-text">Click to browse file</div>
                                        <div class="file-name" id="name_father_id"></div>
                                        <input class="form-control" type="file" id="file_father_id" name="doc_father_id" accept=".pdf,.jpg,.jpeg,.png" required onchange="handleFile(this,'zone_father_id','name_father_id')">
                                    </label>
                                </div>

                                <!-- Doc 3 -->
                                <div class="col-md-6">
                                    <label class="form-label">3. Mother's ID Proof <span class="text-danger">*</span> <small class="text-muted fw-normal">(Aadhaar / Voter ID)</small></label>
                                    <label class="file-upload-zone d-block" id="zone_mother_id" for="file_mother_id">
                                        <div class="upload-icon"><i class="fas fa-id-card"></i></div>
                                        <div class="upload-text">Click to browse file</div>
                                        <div class="file-name" id="name_mother_id"></div>
                                        <input class="form-control" type="file" id="file_mother_id" name="doc_mother_id" accept=".pdf,.jpg,.jpeg,.png" required onchange="handleFile(this,'zone_mother_id','name_mother_id')">
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="section-divider"></div>

                        <!-- ── DECLARATION ── -->
                        <div class="section-block mb-0">
                            <div class="declaration-box">
                                <input class="form-check-input" type="checkbox" id="declaration" required style="margin-top: 0.3rem;">
                                <label class="declaration-text" for="declaration">
                                    I hereby <strong>declare</strong> that the information provided above is true to the best of my knowledge. I understand that providing <strong>false information</strong> to the Gram Panchayat is a punishable offense under applicable laws.
                                </label>
                            </div>
                        </div>

                    <!-- ── SUBMIT AREA ── -->
                    </form>
                </div>

                <div class="submit-area">
                    <button type="submit" form="birthForm" class="btn-submit" onclick="document.querySelector('form').requestSubmit()">
                        <i class="fas fa-paper-plane"></i> Submit Application
                    </button>
                    <button type="reset" class="btn-reset" onclick="document.querySelector('form').reset(); document.querySelectorAll('.file-upload-zone').forEach(z=>{z.classList.remove('has-file')});">
                        <i class="fas fa-undo"></i> Reset Form
                    </button>
                </div>

            </div><!-- /form-card -->
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function handleFile(input, zoneId, nameId) {
        const zone = document.getElementById(zoneId);
        const nameEl = document.getElementById(nameId);
        if (input.files && input.files[0]) {
            const fileName = input.files[0].name;
            nameEl.textContent = '✔ ' + fileName;
            zone.classList.add('has-file');
        } else {
            zone.classList.remove('has-file');
        }
    }

    // Wire submit button to form
    document.querySelector('.btn-submit').addEventListener('click', function(e) {
        e.preventDefault();
        document.querySelector('form').submit();
    });
</script>
</body>
</html>