<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Death Certificate Application - Gram Panchayat</title>
    
    <!-- Modern Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap CSS for layout grid -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #2563eb;
            --theme-dark: #334155;
            --theme-darker: #1e293b;
            --bg-body: #f3f4f6;
            --bg-card: #ffffff;
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
            --input-focus: #e2e8f0;
            --radius-md: 12px;
            --radius-lg: 16px;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }

        * {
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-body);
            color: var(--text-main);
            padding-bottom: 3rem;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            margin: 2rem 0 1rem;
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: var(--theme-darker);
        }

        .form-container {
            background: var(--bg-card);
            padding: 3rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--border-color);
            margin-bottom: 2rem;
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header-logos {
            text-align: center;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
        }

        .header-logos .icon-circle {
            width: 70px;
            height: 70px;
            background: #f1f5f9;
            color: var(--theme-dark);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1rem;
        }

        .header-logos h2 {
            font-weight: 700;
            color: var(--text-main);
            font-size: 1.75rem;
            letter-spacing: -0.5px;
        }

        .header-logos h4 {
            font-weight: 500;
            color: var(--theme-dark);
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }

        .section-title {
            background-color: #f8fafc;
            color: var(--theme-darker);
            padding: 0.8rem 1.2rem;
            border-radius: 8px;
            margin: 2.5rem 0 1.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-left: 4px solid var(--theme-dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-label {
            font-weight: 600;
            color: var(--text-main);
            font-size: 0.9rem;
            margin-bottom: 0.4rem;
        }

        .form-control, .form-select {
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.95rem;
            color: var(--text-main);
            transition: all 0.2s ease;
            background-color: #f9fafb;
        }

        .form-control:focus, .form-select:focus {
            background-color: #ffffff;
            border-color: var(--theme-dark);
            box-shadow: 0 0 0 4px var(--input-focus);
        }

        input[type="file"].form-control {
            padding: 0.6rem 1rem;
            background: #ffffff;
        }

        .btn-submit {
            background-color: var(--theme-darker);
            color: white;
            border: none;
            padding: 0.8rem 2.5rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.2s;
        }

        .btn-submit:hover {
            background-color: #0f172a;
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        
        .btn-reset {
            background-color: #e2e8f0;
            color: #475569;
            border: none;
            padding: 0.8rem 2.5rem;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.2s;
        }

        .btn-reset:hover {
            background-color: #cbd5e1;
            color: #1e293b;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
                margin-top: 1rem;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            
            <!-- Back Navigation -->
            <a href="index.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>

            <div class="form-container">
                
                <div class="header-logos">
                    <div class="icon-circle">
                        <i class="fas fa-file-signature"></i>
                    </div>
                    <h2>e-Gram Swaraj Portal</h2>
                    <h4>Application for Registration of Death</h4>
                    <p class="text-muted mt-2" style="font-size: 0.9rem;">Fields marked with <span class="text-danger">*</span> are mandatory.</p>
                </div>

                <!-- FORM LOGIC REMAINS EXACTLY THE SAME -->
                <form action="SubmitDeathApplicationServlet" method="POST" enctype="multipart/form-data">
                    
                    <!-- SECTION 1: DECEASED DETAILS -->
                    <div class="section-title"><i class="fas fa-user"></i> 1. Details of the Deceased</div>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="deceased_name" placeholder="Name of deceased" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Aadhaar No <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="deceased_aadhaar" pattern="\d{12}" title="12 digit Aadhaar number" placeholder="12-digit Aadhaar" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Gender <span class="text-danger">*</span></label>
                            <select class="form-select" name="gender" required>
                                <option value="">Select</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">Age at Death <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" name="age" placeholder="Age" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Father / Husband's Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="father_husband_name" placeholder="Name of father or husband" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Mother's Name</label>
                            <input type="text" class="form-control" name="mother_name" placeholder="Name of mother (Optional)">
                        </div>
                    </div>

                    <!-- SECTION 2: DETAILS OF DEATH -->
                    <div class="section-title"><i class="fas fa-info-circle"></i> 2. Details of Death</div>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Date of Death <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" name="death_date" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Time of Death <span class="text-danger">*</span></label>
                            <input type="time" class="form-control" name="time_of_death" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Place of Death <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="death_place" placeholder="Hospital / Home / Other" required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Permanent Address <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="address" placeholder="Complete address of the deceased" required>
                        </div>
                    </div>

                    <!-- SECTION 3: APPLICANT DETAILS -->
                    <div class="section-title"><i class="fas fa-user-edit"></i> 3. Applicant Details</div>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">Applicant Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="applicant_name" placeholder="Your full name" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Relation to Deceased <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="relation" placeholder="E.g., Son, Daughter, Wife" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Mobile Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="mobile" pattern="\d{10}" title="10 digit mobile number" placeholder="10-digit mobile no." required>
                        </div>
                    </div>

                    <!-- SECTION 4: DOCUMENT UPLOAD -->
                    <div class="section-title"><i class="fas fa-file-upload"></i> 4. Upload Required Documents</div>
                    <div class="alert alert-secondary" style="font-size: 0.9rem; border-color: #cbd5e1; color: #475569;">
                        <i class="fas fa-info-circle me-1"></i> Accepted formats: PDF, JPG, PNG. Maximum file size allowed is 2MB per document.
                    </div>
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label">1. Proof of Death (Doctor's Note / Hospital Slip / Cremation receipt) <span class="text-danger">*</span></label>
                            <input class="form-control" type="file" name="doc_death_proof" accept=".pdf,.jpg,.jpeg,.png" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">2. Deceased ID Proof (Aadhaar/Voter ID) <span class="text-danger">*</span></label>
                            <input class="form-control" type="file" name="doc_deceased_id" accept=".pdf,.jpg,.jpeg,.png" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">3. Applicant ID Proof (Aadhaar/Voter ID) <span class="text-danger">*</span></label>
                            <input class="form-control" type="file" name="doc_applicant_id" accept=".pdf,.jpg,.jpeg,.png" required>
                        </div>
                    </div>

                    <div class="text-center mt-5 mb-2">
                        <button type="submit" class="btn btn-submit btn-lg px-5 me-2"><i class="fas fa-paper-plane me-2"></i> Submit Application</button>
                        <button type="reset" class="btn btn-reset btn-lg px-4"><i class="fas fa-undo me-2"></i> Reset</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>