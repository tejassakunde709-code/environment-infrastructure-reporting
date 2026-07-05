<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marriage Certificate Application - Gram Panchayat</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,600;0,700;1,400&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --rose:        #c0395a;
            --rose-dark:   #8f1f3a;
            --rose-soft:   #f9eef1;
            --rose-mid:    #f3d0da;
            --gold:        #c8973a;
            --gold-light:  #fdf6ec;
            --cream:       #fdfaf7;
            --ink:         #1c1118;
            --ink-mid:     #4a3840;
            --ink-soft:    #8a7580;
            --border:      #e8dde2;
            --white:       #ffffff;
            --section-bg:  #f7f2f4;
            --radius:      14px;
            --radius-sm:   8px;
            --shadow-card: 0 8px 40px rgba(100,30,50,0.10), 0 1px 3px rgba(100,30,50,0.06);
            --shadow-btn:  0 4px 18px rgba(192,57,90,0.30);
        }

        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            background: var(--cream);
            background-image:
                radial-gradient(ellipse at 10% 0%, rgba(192,57,90,0.06) 0%, transparent 55%),
                radial-gradient(ellipse at 90% 100%, rgba(200,151,58,0.06) 0%, transparent 55%);
            min-height: 100vh;
            font-family: 'DM Sans', sans-serif;
            color: var(--ink);
            padding-bottom: 5rem;
        }

        /* ── PAGE WRAPPER ── */
        .page-wrap {
            max-width: 860px;
            margin: 0 auto;
            padding: 0 1.25rem;
        }

        /* ── BACK LINK ── */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--ink-soft);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            margin: 2rem 0 1.5rem;
            padding: 0.5rem 1rem 0.5rem 0.75rem;
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: 50px;
            transition: all 0.22s ease;
            width: fit-content;
        }

        .back-link .arrow-circle {
            width: 26px; height: 26px;
            background: var(--rose-soft);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: var(--rose);
            font-size: 0.75rem;
            transition: background 0.22s;
        }

        .back-link:hover {
            color: var(--rose-dark);
            border-color: var(--rose-mid);
            box-shadow: 0 2px 10px rgba(192,57,90,0.10);
        }

        .back-link:hover .arrow-circle { background: var(--rose-mid); }

        /* ── MAIN CARD ── */
        .form-card {
            background: var(--white);
            border-radius: 22px;
            box-shadow: var(--shadow-card);
            border: 1px solid var(--border);
            overflow: hidden;
            animation: cardIn 0.5s cubic-bezier(0.22, 1, 0.36, 1) both;
        }

        @keyframes cardIn {
            from { opacity: 0; transform: translateY(22px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ── DECORATIVE HEADER BANNER ── */
        .card-banner {
            background: linear-gradient(135deg, var(--rose-dark) 0%, var(--rose) 55%, #d4546e 100%);
            padding: 3rem 2.5rem 2.5rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .card-banner::before,
        .card-banner::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
        }

        .card-banner::before { width: 280px; height: 280px; top: -100px; left: -80px; }
        .card-banner::after  { width: 200px; height: 200px; bottom: -70px; right: -60px; }

        .banner-ornament {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .ornament-line {
            flex: 1; max-width: 80px;
            height: 1px;
            background: linear-gradient(to right, transparent, rgba(255,255,255,0.45));
        }

        .ornament-line.right {
            background: linear-gradient(to left, transparent, rgba(255,255,255,0.45));
        }

        .banner-icon-wrap {
            width: 68px; height: 68px;
            background: rgba(255,255,255,0.15);
            border: 2px solid rgba(255,255,255,0.30);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.75rem;
            color: #fff;
            backdrop-filter: blur(4px);
        }

        .card-banner h1 {
            font-family: 'Cormorant Garamond', Georgia, serif;
            font-size: 2.1rem;
            font-weight: 700;
            color: #fff;
            letter-spacing: 0.3px;
            margin-bottom: 0.35rem;
        }

        .card-banner .subtitle {
            font-family: 'Cormorant Garamond', Georgia, serif;
            font-size: 1.15rem;
            font-weight: 400;
            font-style: italic;
            color: rgba(255,255,255,0.82);
            margin-bottom: 0.75rem;
        }

        .mandatory-note {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.20);
            color: rgba(255,255,255,0.85);
            font-size: 0.8rem;
            padding: 0.35rem 1rem;
            border-radius: 50px;
        }

        .mandatory-note .req-dot { color: #fda4af; font-weight: 700; }

        /* ── FORM BODY ── */
        .form-body { padding: 2.5rem; }

        @media (max-width: 640px) {
            .form-body { padding: 1.5rem 1.25rem; }
            .card-banner { padding: 2rem 1.25rem; }
            .card-banner h1 { font-size: 1.6rem; }
        }

        /* ── SECTION HEADERS ── */
        .section-header {
            display: flex;
            align-items: center;
            gap: 0.85rem;
            margin: 2.25rem 0 1.5rem;
            position: relative;
        }

        .section-header:first-child { margin-top: 0; }

        .section-num {
            width: 36px; height: 36px;
            background: linear-gradient(135deg, var(--rose), var(--rose-dark));
            color: #fff;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.8rem;
            font-weight: 700;
            flex-shrink: 0;
            box-shadow: 0 3px 10px rgba(192,57,90,0.28);
        }

        .section-info { flex: 1; }

        .section-info h3 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--ink);
            letter-spacing: 0.2px;
        }

        .section-info span {
            font-size: 0.78rem;
            color: var(--ink-soft);
            font-weight: 400;
        }

        .section-icon {
            width: 34px; height: 34px;
            background: var(--rose-soft);
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            color: var(--rose);
            font-size: 0.95rem;
        }

        .section-divider {
            height: 1px;
            background: linear-gradient(to right, var(--rose-mid), transparent);
            margin-bottom: 1.5rem;
            opacity: 0.6;
        }

        /* ── FORM FIELDS ── */
        .fields-grid {
            display: grid;
            gap: 1.1rem;
        }

        .fields-grid.cols-3 { grid-template-columns: repeat(3, 1fr); }
        .fields-grid.cols-2 { grid-template-columns: repeat(2, 1fr); }

        @media (max-width: 700px) {
            .fields-grid.cols-3,
            .fields-grid.cols-2 { grid-template-columns: 1fr; }
        }

        @media (max-width: 960px) and (min-width: 701px) {
            .fields-grid.cols-3 { grid-template-columns: repeat(2, 1fr); }
        }

        .field-group { display: flex; flex-direction: column; gap: 0.4rem; }

        .field-label {
            font-size: 0.82rem;
            font-weight: 600;
            color: var(--ink-mid);
            letter-spacing: 0.3px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .field-label .req { color: var(--rose); font-size: 0.9rem; }

        .field-input {
            padding: 0.72rem 1rem;
            border: 1.5px solid var(--border);
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            font-family: 'DM Sans', sans-serif;
            color: var(--ink);
            background: #fdfbfc;
            outline: none;
            transition: all 0.2s ease;
            width: 100%;
        }

        .field-input:hover { border-color: var(--rose-mid); }

        .field-input:focus {
            border-color: var(--rose);
            background: var(--white);
            box-shadow: 0 0 0 4px rgba(192,57,90,0.10);
        }

        .field-input::placeholder { color: #bba8b0; font-size: 0.87rem; }

        /* File input special styling */
        .file-upload-wrapper {
            position: relative;
        }

        .file-label-box {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            border: 1.5px dashed var(--rose-mid);
            border-radius: var(--radius-sm);
            background: var(--rose-soft);
            cursor: pointer;
            transition: all 0.2s;
        }

        .file-label-box:hover {
            border-color: var(--rose);
            background: #f9e8ed;
        }

        .file-label-box .file-icon {
            width: 34px; height: 34px;
            background: var(--white);
            border-radius: 7px;
            display: flex; align-items: center; justify-content: center;
            color: var(--rose);
            font-size: 0.95rem;
            flex-shrink: 0;
            box-shadow: 0 2px 6px rgba(192,57,90,0.12);
        }

        .file-label-box .file-text strong {
            display: block;
            font-size: 0.83rem;
            font-weight: 600;
            color: var(--rose-dark);
        }

        .file-label-box .file-text small {
            font-size: 0.75rem;
            color: var(--ink-soft);
        }

        .file-input-real {
            position: absolute;
            inset: 0;
            opacity: 0;
            cursor: pointer;
            width: 100%;
            height: 100%;
        }

        /* Info alert */
        .info-alert {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
            background: var(--gold-light);
            border: 1px solid #ecd9b7;
            border-radius: var(--radius-sm);
            padding: 0.9rem 1rem;
            margin-bottom: 1.25rem;
        }

        .info-alert .info-icon {
            color: var(--gold);
            font-size: 1rem;
            margin-top: 1px;
            flex-shrink: 0;
        }

        .info-alert p {
            font-size: 0.83rem;
            color: #7a5c20;
            line-height: 1.5;
        }

        /* Person card wrapper for Groom / Bride */
        .person-card {
            background: var(--section-bg);
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 1.5rem;
        }

        .person-card .person-head {
            display: flex;
            align-items: center;
            gap: 0.7rem;
            margin-bottom: 1.2rem;
        }

        .person-head .person-avatar {
            width: 42px; height: 42px;
            background: linear-gradient(135deg, var(--rose), var(--rose-dark));
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: #fff;
            font-size: 1.1rem;
        }

        .person-head .person-title {
            font-family: 'Cormorant Garamond', Georgia, serif;
            font-size: 1.15rem;
            font-weight: 600;
            color: var(--ink);
        }

        /* Couple connector visual */
        .couple-connector {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 1.5rem 0;
        }

        .connector-line { flex: 1; height: 1px; background: var(--rose-mid); }

        .connector-heart {
            width: 34px; height: 34px;
            background: var(--rose-soft);
            border: 1.5px solid var(--rose-mid);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: var(--rose);
            font-size: 0.85rem;
        }

        /* ── ACTION BUTTONS ── */
        .form-actions {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            padding: 2rem 2.5rem 2.5rem;
            border-top: 1px solid var(--border);
            background: #fefcfd;
            flex-wrap: wrap;
        }

        .btn-submit {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            background: linear-gradient(135deg, var(--rose) 0%, var(--rose-dark) 100%);
            color: #fff;
            border: none;
            padding: 0.85rem 2.2rem;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            font-weight: 600;
            border-radius: 50px;
            cursor: pointer;
            box-shadow: var(--shadow-btn);
            transition: all 0.22s ease;
            letter-spacing: 0.2px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 24px rgba(192,57,90,0.38);
            background: linear-gradient(135deg, #cc3f5e 0%, #7d1a34 100%);
        }

        .btn-submit:active { transform: translateY(0); }

        .btn-reset {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            background: var(--white);
            color: var(--ink-mid);
            border: 1.5px solid var(--border);
            padding: 0.85rem 1.8rem;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            font-weight: 600;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.22s ease;
        }

        .btn-reset:hover {
            border-color: var(--rose-mid);
            color: var(--rose-dark);
            background: var(--rose-soft);
        }

        /* Section spacing separator */
        .section-gap { margin-top: 2.5rem; }
    </style>
</head>
<body>

<div class="page-wrap">

    <!-- Back Navigation -->
    <a href="index.jsp" class="back-link">
        <span class="arrow-circle"><i class="fas fa-arrow-left"></i></span>
        Back to Dashboard
    </a>

    <div class="form-card">

        <!-- ── HEADER BANNER ── -->
        <div class="card-banner">
            <div class="banner-ornament">
                <div class="ornament-line"></div>
                <div class="banner-icon-wrap"><i class="fas fa-heart"></i></div>
                <div class="ornament-line right"></div>
            </div>
            <h1>e-Gramseva Portal</h1>
            <p class="subtitle">Application for Registration of Marriage</p>
            <span class="mandatory-note">
                <span class="req-dot">✦</span>
                Fields marked with <strong style="margin: 0 3px;">*</strong> are mandatory
            </span>
        </div>

        <!-- ── FORM ── -->
        <form action="SubmitMarriageApplicationServlet" method="POST" enctype="multipart/form-data">

            <div class="form-body">

                <!-- ═══ SECTION 1: MARRIAGE DETAILS ═══ -->
                <div class="section-header">
                    <div class="section-num">1</div>
                    <div class="section-info">
                        <h3>Marriage Details</h3>
                        <span>Date, time and location of the ceremony</span>
                    </div>
                    <div class="section-icon"><i class="fas fa-calendar-check"></i></div>
                </div>
                <div class="section-divider"></div>

                <div class="fields-grid cols-3">
                    <div class="field-group">
                        <label class="field-label">Date of Marriage <span class="req">*</span></label>
                        <input type="date" class="field-input" name="marriage_date" required>
                    </div>
                    <div class="field-group">
                        <label class="field-label">Time of Marriage <span class="req">*</span></label>
                        <input type="time" class="field-input" name="time_of_marriage" required>
                    </div>
                    <div class="field-group">
                        <label class="field-label">Place of Marriage <span class="req">*</span></label>
                        <input type="text" class="field-input" name="marriage_place" placeholder="City / Village / Venue" required>
                    </div>
                </div>

                <!-- ═══ SECTION 2 & 3: GROOM & BRIDE ═══ -->
                <div class="section-header section-gap">
                    <div class="section-num">2</div>
                    <div class="section-info">
                        <h3>Groom &amp; Bride Details</h3>
                        <span>Personal information of both parties</span>
                    </div>
                    <div class="section-icon"><i class="fas fa-rings-wedding"></i></div>
                </div>
                <div class="section-divider"></div>

                <!-- Groom Card -->
                <div class="person-card">
                    <div class="person-head">
                        <div class="person-avatar"><i class="fas fa-male"></i></div>
                        <span class="person-title">Groom Details</span>
                    </div>
                    <div class="fields-grid cols-3">
                        <div class="field-group">
                            <label class="field-label">Full Name <span class="req">*</span></label>
                            <input type="text" class="field-input" name="groom_name" placeholder="Groom's full name" required>
                        </div>
                        <div class="field-group">
                            <label class="field-label">Aadhaar Number <span class="req">*</span></label>
                            <input type="text" class="field-input" name="groom_aadhaar" pattern="\d{12}" title="12 digit Aadhaar number" placeholder="12-digit Aadhaar" required>
                        </div>
                        <div class="field-group">
                            <label class="field-label">Date of Birth <span class="req">*</span></label>
                            <input type="date" class="field-input" name="groom_dob" required>
                        </div>
                    </div>
                </div>

                <!-- Heart connector -->
                <div class="couple-connector">
                    <div class="connector-line"></div>
                    <div class="connector-heart"><i class="fas fa-heart"></i></div>
                    <div class="connector-line"></div>
                </div>

                <!-- Bride Card -->
                <div class="person-card">
                    <div class="person-head">
                        <div class="person-avatar"><i class="fas fa-female"></i></div>
                        <span class="person-title">Bride Details</span>
                    </div>
                    <div class="fields-grid cols-3">
                        <div class="field-group">
                            <label class="field-label">Full Name <span class="req">*</span></label>
                            <input type="text" class="field-input" name="bride_name" placeholder="Bride's full name" required>
                        </div>
                        <div class="field-group">
                            <label class="field-label">Aadhaar Number <span class="req">*</span></label>
                            <input type="text" class="field-input" name="bride_aadhaar" pattern="\d{12}" title="12 digit Aadhaar number" placeholder="12-digit Aadhaar" required>
                        </div>
                        <div class="field-group">
                            <label class="field-label">Date of Birth <span class="req">*</span></label>
                            <input type="date" class="field-input" name="bride_dob" required>
                        </div>
                    </div>
                </div>

                <!-- ═══ SECTION 4: WITNESSES & APPLICANT ═══ -->
                <div class="section-header section-gap">
                    <div class="section-num">3</div>
                    <div class="section-info">
                        <h3>Witnesses &amp; Applicant Details</h3>
                        <span>Two witnesses and the applicant's contact</span>
                    </div>
                    <div class="section-icon"><i class="fas fa-users"></i></div>
                </div>
                <div class="section-divider"></div>

                <div class="fields-grid cols-2">
                    <div class="field-group">
                        <label class="field-label">Witness 1 — Full Name <span class="req">*</span></label>
                        <input type="text" class="field-input" name="witness1_name" placeholder="First witness name" required>
                    </div>
                    <div class="field-group">
                        <label class="field-label">Witness 1 — Aadhaar Number <span class="req">*</span></label>
                        <input type="text" class="field-input" name="witness1_aadhaar" pattern="\d{12}" title="12 digit Aadhaar number" placeholder="12-digit Aadhaar" required>
                    </div>
                    <div class="field-group">
                        <label class="field-label">Witness 2 — Full Name <span class="req">*</span></label>
                        <input type="text" class="field-input" name="witness2_name" placeholder="Second witness name" required>
                    </div>
                    <div class="field-group">
                        <label class="field-label">Witness 2 — Aadhaar Number <span class="req">*</span></label>
                        <input type="text" class="field-input" name="witness2_aadhaar" pattern="\d{12}" title="12 digit Aadhaar number" placeholder="12-digit Aadhaar" required>
                    </div>
                    <div class="field-group">
                        <label class="field-label">Applicant Full Name <span class="req">*</span></label>
                        <input type="text" class="field-input" name="applicant_name" placeholder="Your full name" required>
                    </div>
                    <div class="field-group">
                        <label class="field-label">Mobile Number <span class="req">*</span></label>
                        <input type="text" class="field-input" name="mobile" pattern="\d{10}" title="10 digit mobile number" placeholder="10-digit mobile number" required>
                    </div>
                </div>

                <!-- ═══ SECTION 5: DOCUMENT UPLOAD ═══ -->
                <div class="section-header section-gap">
                    <div class="section-num">4</div>
                    <div class="section-info">
                        <h3>Upload Required Documents</h3>
                        <span>Attach all supporting documents</span>
                    </div>
                    <div class="section-icon"><i class="fas fa-file-arrow-up"></i></div>
                </div>
                <div class="section-divider"></div>

                <div class="info-alert">
                    <i class="fas fa-circle-info info-icon"></i>
                    <p>Accepted formats: <strong>PDF, JPG, PNG</strong>. Maximum file size allowed is <strong>2MB</strong> per document. Ensure documents are legible and clearly scanned.</p>
                </div>

                <div class="fields-grid cols-2">

                    <div class="field-group">
                        <label class="field-label">Marriage Proof <span class="req">*</span></label>
                        <div class="file-upload-wrapper">
                            <div class="file-label-box" id="lbl-marriage-proof">
                                <div class="file-icon"><i class="fas fa-file-image"></i></div>
                                <div class="file-text">
                                    <strong id="fn-marriage-proof">Invitation Card / Temple Receipt</strong>
                                    <small>Click to browse &mdash; PDF, JPG, PNG up to 2MB</small>
                                </div>
                            </div>
                            <input class="file-input-real" type="file" name="doc_marriage_proof" accept=".pdf,.jpg,.jpeg,.png" required
                                onchange="updateFileName(this,'fn-marriage-proof','Invitation Card / Temple Receipt')">
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Joint Photo of Bride &amp; Groom <span class="req">*</span></label>
                        <div class="file-upload-wrapper">
                            <div class="file-label-box" id="lbl-joint-photo">
                                <div class="file-icon"><i class="fas fa-camera-retro"></i></div>
                                <div class="file-text">
                                    <strong id="fn-joint-photo">Joint Photo</strong>
                                    <small>Click to browse &mdash; PDF, JPG, PNG up to 2MB</small>
                                </div>
                            </div>
                            <input class="file-input-real" type="file" name="doc_joint_photo" accept=".pdf,.jpg,.jpeg,.png" required
                                onchange="updateFileName(this,'fn-joint-photo','Joint Photo')">
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Groom ID Proof (Aadhaar / Voter ID) <span class="req">*</span></label>
                        <div class="file-upload-wrapper">
                            <div class="file-label-box">
                                <div class="file-icon"><i class="fas fa-id-card"></i></div>
                                <div class="file-text">
                                    <strong id="fn-groom-id">Groom ID Proof</strong>
                                    <small>Click to browse &mdash; PDF, JPG, PNG up to 2MB</small>
                                </div>
                            </div>
                            <input class="file-input-real" type="file" name="doc_groom_id" accept=".pdf,.jpg,.jpeg,.png" required
                                onchange="updateFileName(this,'fn-groom-id','Groom ID Proof')">
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Bride ID Proof (Aadhaar / Voter ID) <span class="req">*</span></label>
                        <div class="file-upload-wrapper">
                            <div class="file-label-box">
                                <div class="file-icon"><i class="fas fa-id-card"></i></div>
                                <div class="file-text">
                                    <strong id="fn-bride-id">Bride ID Proof</strong>
                                    <small>Click to browse &mdash; PDF, JPG, PNG up to 2MB</small>
                                </div>
                            </div>
                            <input class="file-input-real" type="file" name="doc_bride_id" accept=".pdf,.jpg,.jpeg,.png" required
                                onchange="updateFileName(this,'fn-bride-id','Bride ID Proof')">
                        </div>
                    </div>

                </div>

            </div><!-- /form-body -->

            <!-- ── ACTION BUTTONS ── -->
            <div class="form-actions">
                <button type="reset" class="btn-reset">
                    <i class="fas fa-rotate-left"></i> Reset Form
                </button>
                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i> Submit Application
                </button>
            </div>

        </form>
    </div><!-- /form-card -->

</div><!-- /page-wrap -->

<script>
    // Update file label text when a file is chosen
    function updateFileName(input, labelId, defaultText) {
        const el = document.getElementById(labelId);
        if (input.files && input.files.length > 0) {
            el.textContent = input.files[0].name;
            el.style.color = 'var(--rose-dark)';
        } else {
            el.textContent = defaultText;
            el.style.color = '';
        }
    }

    // Reset: restore file label texts on form reset
    document.querySelector('form').addEventListener('reset', () => {
        setTimeout(() => {
            document.getElementById('fn-marriage-proof').textContent = 'Invitation Card / Temple Receipt';
            document.getElementById('fn-joint-photo').textContent    = 'Joint Photo';
            document.getElementById('fn-groom-id').textContent       = 'Groom ID Proof';
            document.getElementById('fn-bride-id').textContent       = 'Bride ID Proof';
            document.querySelectorAll('.file-label-box strong').forEach(el => el.style.color = '');
        }, 10);
    });
</script>

</body>
</html>