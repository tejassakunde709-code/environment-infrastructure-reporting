<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("userEmail") == null) {
        response.sendRedirect("userLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Village Issue - Gram Panchayat Portal</title>

    <!-- Modern Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Leaflet CSS & JS (Untouched) -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-hover: #1d4ed8;
            --success-green: #10b981;
            --success-hover: #059669;
            --bg-body: #f3f4f6;
            --bg-card: #ffffff;
            --text-main: #1f2937;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
            --input-focus: #bfdbfe;
            --radius-md: 12px;
            --radius-lg: 20px;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
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
            min-height: 100vh;
            padding: 2.5rem 1.5rem;
            display: flex;
            justify-content: center;
        }

        .main-container {
            max-width: 900px;
            width: 100%;
            position: relative;
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Back Button */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: var(--primary-blue);
        }

        /* Card Container */
        .report-card {
            background: var(--bg-card);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            padding: 2.5rem;
            border: 1px solid var(--border-color);
        }

        .header-section {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .header-icon {
            width: 50px;
            height: 50px;
            background: #eff6ff;
            color: var(--primary-blue);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .header-text h2 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-main);
            letter-spacing: -0.5px;
            margin-bottom: 0.2rem;
        }

        .user-info {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .user-info strong {
            color: var(--text-main);
            font-weight: 600;
        }

        /* Detect Location Button */
        .detect-btn {
            background: #eff6ff;
            color: var(--primary-blue);
            border: 1px solid #bfdbfe;
            padding: 0.75rem 1.25rem;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 1.5rem;
        }

        .detect-btn:hover {
            background: var(--primary-blue);
            color: white;
            border-color: var(--primary-blue);
            box-shadow: var(--shadow-md);
        }

        .detect-btn:active {
            transform: scale(0.98);
        }

        /* Map Styling */
        #map {
            height: 380px;
            border-radius: var(--radius-md);
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            z-index: 1; /* Keep leaflet controls below sticky headers if any */
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-main);
            font-size: 0.95rem;
        }

        textarea, input[type="file"] {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.95rem;
            color: var(--text-main);
            background: #f9fafb;
            transition: all 0.2s ease;
            outline: none;
        }

        textarea:focus {
            background: white;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px var(--input-focus);
        }

        textarea#address {
            background: #f3f4f6;
            color: var(--text-muted);
            cursor: not-allowed;
            resize: none;
        }

        /* File Upload Styling */
        input[type="file"] {
            background: white;
            border: 2px dashed #cbd5e1;
            cursor: pointer;
            padding: 1.5rem 1rem;
        }

        input[type="file"]:hover {
            border-color: var(--primary-blue);
            background: #eff6ff;
        }

        .small-hint {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 0.4rem;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        #previewImg {
            max-width: 250px;
            width: 100%;
            margin-top: 1rem;
            border-radius: 8px;
            display: none;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-color);
        }

        /* Submit Button */
        .submit-btn {
            width: 100%;
            padding: 1rem;
            background: var(--success-green);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 1rem;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .submit-btn:hover {
            background: var(--success-hover);
            box-shadow: var(--shadow-md);
        }

        .submit-btn:active {
            transform: scale(0.99);
        }

        @media (max-width: 768px) {
            body {
                padding: 1.5rem 1rem;
            }
            .report-card {
                padding: 1.5rem;
            }
            #map {
                height: 300px;
            }
        }
    </style>
</head>
<body>

<div class="main-container">
    
    <!-- Back Navigation -->
    <a href="index.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>

    <div class="report-card">
        
        <!-- Header -->
        <div class="header-section">
            <div class="header-icon">
                <i class="fas fa-bullhorn"></i>
            </div>
            <div class="header-text">
                <h2>Report Civic Issue</h2>
                <div class="user-info">Reporting as: <strong><%= session.getAttribute("userEmail") %></strong></div>
            </div>
        </div>

        <!-- Location Detection -->
        <button type="button" class="detect-btn" onclick="getLocation()">
            <i class="fas fa-map-marker-alt"></i> Detect My Current Location
        </button>

        <!-- Map Container -->
        <div id="map"></div>

        <!-- Complaint Form -->
        <form action="<%= request.getContextPath() %>/ComplaintServlet" method="post" enctype="multipart/form-data">

            <!-- Hidden Location Data -->
            <input type="hidden" id="lat" name="latitude">
            <input type="hidden" id="lng" name="longitude">
            <input type="hidden" name="userEmail" value="<%= session.getAttribute("userEmail") %>">

            <div class="form-group">
                <label for="address">Detected Address Details</label>
                <textarea id="address" name="address" rows="2" readonly required placeholder="Click 'Detect My Current Location' to fetch address..."></textarea>
                <div class="small-hint"><i class="fas fa-info-circle"></i> This address is automatically generated based on map coordinates.</div>
            </div>

            <div class="form-group">
                <label for="description">Detailed Description of the Issue</label>
                <textarea name="description" rows="5" required placeholder="E.g., Broken street light, overflowing garbage bin, damaged road..."></textarea>
            </div>

            <div class="form-group">
                <label>Upload Supporting Photo <span style="color: #ef4444;">*</span></label>
                <input type="file" name="photo" accept="image/*" required onchange="previewImage(event)">
                <img id="previewImg" alt="Selected issue preview">
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-paper-plane"></i> Submit Official Complaint
            </button>
        </form>
    </div>
</div>

<!-- Scripts (100% Untouched Logic) -->
<script>
let map, marker;

function initMap() {
    map = L.map('map').setView([18.59, 73.82], 12);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap'
    }).addTo(map);
}

function getLocation() {
    if (!navigator.geolocation) {
        alert("Geolocation not supported.");
        return;
    }

    navigator.geolocation.getCurrentPosition(showPosition, showError);
}

function showPosition(position) {
    const lat = position.coords.latitude.toFixed(6);
    const lng = position.coords.longitude.toFixed(6);

    document.getElementById("lat").value = lat;
    document.getElementById("lng").value = lng;

    map.setView([lat, lng], 16);

    if (marker) map.removeLayer(marker);
    marker = L.marker([lat, lng]).addTo(map)
        .bindPopup("Current location").openPopup();

    fetch(`https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${lat}&longitude=${lng}&localityLanguage=en`)
        .then(r => r.json())
        .then(data => {
            let parts =[];
            if (data.locality) parts.push(data.locality);
            if (data.city) parts.push(data.city);
            if (data.principalSubdivision) parts.push(data.principalSubdivision);
            if (data.countryName) parts.push(data.countryName);

            document.getElementById("address").value =
                parts.length ? parts.join(", ") : `Lat: ${lat}, Lng: ${lng}`;
        });
}

function showError(error) {
    alert("Unable to get location.");
}

function previewImage(e) {
    const preview = document.getElementById("previewImg");
    const file = e.target.files[0];
    preview.style.display = file ? "block" : "none";
    if (file) preview.src = URL.createObjectURL(file);
}

window.addEventListener('load', initMap);
</script>

</body>
</html>