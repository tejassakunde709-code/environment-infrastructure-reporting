<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // 1. Session Check
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Post | Community</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        /* ============================================
           CSS VARIABLES & RESET
           ============================================ */
        :root {
            --primary-blue: #0095f6;
            --primary-dark: #0077cc;
            --bg-color: #fafafa;
            --border-color: #dbdbdb;
            --purple: #667eea;
            --purple-dark: #764ba2;
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-secondary: linear-gradient(135deg, #0095f6 0%, #0077cc 100%);
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
            color: #262626;
            padding-top: 80px;
            min-height: 100vh;
        }

        /* ============================================
           NAVBAR STYLING - GLASSMORPHISM
           ============================================ */
        .navbar { 
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            border-bottom: 1px solid rgba(0,0,0,0.08);
            height: 70px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

        .navbar:hover {
            box-shadow: 0 6px 30px rgba(0,0,0,0.12);
        }

        .navbar-brand { 
            font-weight: 900;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.6rem;
            letter-spacing: -0.5px;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .btn-outline-secondary {
            border: 2px solid #dbdbdb;
            font-weight: 700;
            border-radius: 12px;
            padding: 8px 24px;
            transition: all 0.3s ease;
        }

        .btn-outline-secondary:hover {
            background: #f5f5f5;
            border-color: #999;
            transform: scale(1.05);
        }

        /* ============================================
           MAIN POST CONTAINER
           ============================================ */
        .post-container { 
            max-width: 650px; 
            margin: 50px auto; 
            background: #fff; 
            border: none;
            border-radius: 24px; 
            box-shadow: var(--card-shadow);
            overflow: hidden;
            animation: slideInUp 0.6s ease;
            transition: all 0.4s ease;
        }

        .post-container:hover {
            box-shadow: var(--card-shadow-hover);
            transform: translateY(-5px);
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .post-header { 
            padding: 20px; 
            text-align: center; 
            border-bottom: 1px solid var(--border-color);
            font-weight: 800; 
            font-size: 1.4rem;
            background: linear-gradient(to bottom, #fff 0%, #fafafa 100%);
            position: relative;
        }

        .post-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background: var(--gradient-primary);
            border-radius: 2px;
        }

        /* ============================================
           UPLOAD AREA STYLING
           ============================================ */
        .upload-wrapper {
            position: relative;
            width: 100%;
            min-height: 400px;
            background: linear-gradient(135deg, #fafafa 0%, #f0f0f0 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: all 0.4s ease;
            border-bottom: 1px solid var(--border-color);
        }

        .upload-wrapper:hover { 
            background: linear-gradient(135deg, #f0f0f0 0%, #e8e8e8 100%);
        }

        .upload-wrapper::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.1) 0%, transparent 70%);
            border-radius: 50%;
            opacity: 0;
            transition: all 0.4s ease;
        }

        .upload-wrapper:hover::before {
            opacity: 1;
            width: 250px;
            height: 250px;
        }

        #imagePreview {
            max-width: 100%;
            max-height: 600px;
            display: none;
            object-fit: contain;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .upload-placeholder {
            text-align: center;
            color: #8e8e8e;
            position: relative;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .upload-wrapper:hover .upload-placeholder {
            transform: translateY(-5px);
        }

        .upload-placeholder i { 
            font-size: 80px; 
            margin-bottom: 20px;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        .upload-placeholder p {
            font-weight: 700;
            font-size: 1.2rem;
            color: #262626;
            margin-bottom: 15px;
        }

        .upload-placeholder .btn {
            background: var(--gradient-primary);
            border: none;
            color: white;
            font-weight: 700;
            padding: 12px 32px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            transition: all 0.3s ease;
        }

        .upload-placeholder .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
        }

        /* ============================================
           ACTIVITY RADIO STYLING
           ============================================ */
        .activity-section { 
            padding: 30px; 
            border-top: none;
            background: #fff;
        }

        .activity-label { 
            font-weight: 700; 
            font-size: 1rem; 
            margin-bottom: 16px; 
            display: block;
            color: #262626;
        }
        
        .activity-group { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 12px;
        }

        .activity-item input { 
            display: none; 
        }

        .activity-item label {
            border: 2px solid var(--border-color);
            padding: 12px 24px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            transition: all 0.3s ease;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }

        .activity-item label::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--gradient-primary);
            transition: all 0.4s ease;
            z-index: -1;
        }

        .activity-item label:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-color: var(--purple);
        }

        .activity-item input:checked + label {
            background: var(--gradient-primary);
            color: white;
            border-color: transparent;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            transform: translateY(-2px) scale(1.05);
        }

        .activity-item input:checked + label::before {
            left: 0;
        }

        /* ============================================
           CAPTION AREA STYLING
           ============================================ */
        .caption-area { 
            padding: 0 30px 30px 30px;
            background: #fff;
        }

        .caption-area textarea {
            border: 2px solid var(--border-color);
            border-radius: 16px;
            resize: none;
            padding: 16px;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
        }

        .caption-area textarea:focus { 
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            outline: none;
            border-color: var(--purple);
        }

        .caption-area textarea::placeholder {
            color: #999;
        }

        /* ============================================
           USER INFO SECTION
           ============================================ */
        .user-info { 
            padding: 16px 30px; 
            font-size: 0.9rem; 
            color: #666;
            border-top: 1px solid var(--border-color);
            background: linear-gradient(to bottom, #fafafa 0%, #f5f5f5 100%);
        }

        .user-info strong {
            color: #262626;
            font-weight: 700;
        }

        /* ============================================
           SUBMIT BUTTON
           ============================================ */
        .btn-share {
            background: var(--gradient-primary);
            color: white;
            font-weight: 800;
            border: none;
            padding: 18px;
            width: 100%;
            transition: all 0.3s ease;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }

        .btn-share::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transition: width 0.6s, height 0.6s;
        }

        .btn-share:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-share:hover { 
            transform: scale(1.02);
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.5);
            color: white;
        }

        .btn-share:active {
            transform: scale(0.98);
        }

        /* ============================================
           RESPONSIVE DESIGN
           ============================================ */
        @media (max-width: 768px) {
            body {
                padding-top: 70px;
            }

            .navbar {
                height: 70px;
            }

            .post-container {
                margin: 20px;
                border-radius: 20px;
            }

            .navbar-brand {
                font-size: 1.3rem;
            }

            .post-header {
                font-size: 1.2rem;
                padding: 16px;
            }

            .upload-wrapper {
                min-height: 300px;
            }

            .upload-placeholder i {
                font-size: 60px;
            }

            .activity-section,
            .caption-area {
                padding: 20px;
            }

            .activity-item label {
                padding: 10px 20px;
                font-size: 0.9rem;
            }

            .btn-share {
                font-size: 1rem;
                padding: 16px;
            }
        }

        @media (max-width: 480px) {
            .post-container {
                margin: 10px;
                border-radius: 16px;
            }

            .activity-group {
                flex-direction: column;
            }

            .activity-item label {
                width: 100%;
                text-align: center;
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
            background: var(--gradient-primary);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, var(--purple-dark) 0%, var(--purple) 100%);
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

        /* ============================================
           DRAG & DROP EFFECT
           ============================================ */
        .upload-wrapper.drag-over {
            background: linear-gradient(135deg, #e8eaf6 0%, #d1d9ff 100%);
            border: 3px dashed var(--purple);
        }

        .upload-wrapper.drag-over::before {
            opacity: 1;
            width: 300px;
            height: 300px;
        }

        /* ============================================
           EMOJI EFFECTS
           ============================================ */
        .activity-item label {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .activity-item input:checked + label {
            animation: wiggle 0.5s ease;
        }

        @keyframes wiggle {
            0%, 100% { transform: translateY(-2px) scale(1.05) rotate(0deg); }
            25% { transform: translateY(-2px) scale(1.05) rotate(-5deg); }
            75% { transform: translateY(-2px) scale(1.05) rotate(5deg); }
        }
    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg">
    <div class="container d-flex justify-content-between">
        <a class="navbar-brand" href="community.jsp">🌱 Community</a>
        <a href="community.jsp" class="btn btn-sm btn-outline-secondary">Cancel</a>
    </div>
</nav>

<div class="post-container">
    <div class="post-header">Create New Post</div>

    <form method="post"
          action="<%= request.getContextPath() %>/PostUploadServlet"
          enctype="multipart/form-data">

        <!-- Preserved Logic Fields -->
        <input type="hidden" name="user_id" value="<%= userId %>">
        <input type="hidden" name="user_name" value="<%= userName %>">
        <input type="hidden" name="user_email" value="<%= userEmail %>">

        <!-- Image Upload with Preview -->
        <label for="post_image" class="upload-wrapper" id="dropArea">
            <div class="upload-placeholder" id="placeholder">
                <i class="fa-regular fa-image"></i>
                <p class="fw-bold">Upload photos here</p>
                <span class="btn btn-primary btn-sm px-3">Select from device</span>
            </div>
            <img id="imagePreview" alt="Preview">
            <input type="file" name="post_image" id="post_image" style="display:none" required onchange="previewFile()">
        </label>

        <!-- Activity Selection -->
        <div class="activity-section">
            <span class="activity-label">Activity Category</span>
            <div class="activity-group">
                <div class="activity-item">
                    <input type="radio" name="activity_type" id="tree" value="Tree Plantation" required>
                    <label for="tree">🌳 Tree Plantation (+1)</label>
                </div>
                <div class="activity-item">
                    <input type="radio" name="activity_type" id="cleaning" value="Cleaning Activity">
                    <label for="cleaning">🧹 Cleaning Activity (+1)</label>
                </div>
                <div class="activity-item">
                    <input type="radio" name="activity_type" id="complaint" value="Complaint Solved">
                    <label for="complaint">✅ Complaint Solved</label>
                </div>
            </div>
        </div>

        <!-- Caption Area -->
        <div class="caption-area">
            <textarea class="form-control" name="caption" rows="4"
                      placeholder="Write a meaningful caption about your activity..."></textarea>
        </div>

        <!-- Meta Info -->
        <div class="user-info">
            Posting as <strong><%= userName %></strong> (<%= userEmail %>)
        </div>

        <!-- Submit Button -->
        <div class="p-0">
            <button type="submit" class="btn btn-share rounded-0">Share to Community</button>
        </div>

    </form>
</div>

<!-- JavaScript for Image Preview -->
<script>
    function previewFile() {
        const preview = document.getElementById('imagePreview');
        const placeholder = document.getElementById('placeholder');
        const file = document.querySelector('input[type=file]').files[0];
        const reader = new FileReader();

        reader.onloadend = function () {
            preview.src = reader.result;
            preview.style.display = 'block';
            placeholder.style.display = 'none';
        }

        if (file) {
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
            preview.style.display = 'none';
            placeholder.style.display = 'block';
        }
    }

    // Drag and Drop functionality
    const dropArea = document.getElementById('dropArea');
    const fileInput = document.getElementById('post_image');

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    ['dragenter', 'dragover'].forEach(eventName => {
        dropArea.addEventListener(eventName, () => {
            dropArea.classList.add('drag-over');
        }, false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, () => {
            dropArea.classList.remove('drag-over');
        }, false);
    });

    dropArea.addEventListener('drop', (e) => {
        const dt = e.dataTransfer;
        const files = dt.files;
        
        if (files.length > 0) {
            fileInput.files = files;
            previewFile();
        }
    }, false);
</script>

</body>
</html>
