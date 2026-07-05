<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Grampanchayat Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .profile-img { width: 120px; height: 120px; object-fit: cover; border: 4px solid #fff; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .stat-box { background: #fff; padding: 15px; border-radius: 8px; text-align: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="container-fluid py-4 px-5">
    <h2 class="mb-4 text-dark text-center"><i class="fas fa-cogs"></i> Grampanchayat About Page Management</h2>
    
    <!-- Display Success/Error Messages -->
    ${message != null ? message : ''}

    <div class="row g-4">
        
        <!-- =====================================
             LEFT SIDE: ADMIN EDIT FORM
        ====================================== -->
        <div class="col-lg-6">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-primary text-white p-3">
                    <h5 class="mb-0"><i class="fas fa-edit"></i> Update Details & Photos</h5>
                </div>
                <div class="card-body bg-light">
                    <!-- Form points to the absolute path of the Servlet -->
                    <form method="POST" action="${pageContext.request.contextPath}/AdminAbout" enctype="multipart/form-data">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Village Name</label>
                            <input type="text" name="village_name" class="form-control" value="${aboutInfo.villageName}" required>
                        </div>

                        <!-- SARPANCH INFO & PHOTO -->
                        <div class="card p-3 mb-3 border-0 shadow-sm">
                            <h6 class="text-primary border-bottom pb-2">Sarpanch Details</h6>
                            <label class="form-label fw-bold mt-2">Sarpanch Name</label>
                            <input type="text" name="sarpanch_name" class="form-control mb-2" value="${aboutInfo.sarpanchName}" required>
                            
                            <label class="form-label fw-bold mt-2">Upload New Photo (Leave blank to keep current)</label>
                            <input type="file" name="sarpanch_photo" class="form-control" accept="image/*">
                        </div>

                        <!-- GRAMSEVAK INFO & PHOTO -->
                        <div class="card p-3 mb-3 border-0 shadow-sm">
                            <h6 class="text-success border-bottom pb-2">Gramsevak Details</h6>
                            <label class="form-label fw-bold mt-2">Gramsevak Name</label>
                            <input type="text" name="gramsevak_name" class="form-control mb-2" value="${aboutInfo.gramsevakName}" required>
                            
                            <label class="form-label fw-bold mt-2">Upload New Photo (Leave blank to keep current)</label>
                            <input type="file" name="gramsevak_photo" class="form-control" accept="image/*">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Total Population</label>
                                <input type="number" name="total_population" class="form-control" value="${aboutInfo.totalPopulation}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Grampanchayat Members</label>
                                <input type="number" name="total_members" class="form-control" value="${aboutInfo.totalMembers}" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">About Description</label>
                            <textarea name="description" class="form-control" rows="4" required>${aboutInfo.description}</textarea>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">Save Changes</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- =====================================
             RIGHT SIDE: LIVE PREVIEW
        ====================================== -->
        <div class="col-lg-6">
            <div class="card shadow border-0 rounded-3 h-100">
                <div class="card-header bg-dark text-white p-3">
                    <h5 class="mb-0"><i class="fas fa-eye"></i> Live Website Preview</h5>
                </div>
                <div class="card-body p-4 text-center">
                    
                    <h2 class="fw-bold text-success">${aboutInfo.villageName}</h2>
                    <p class="text-muted mt-3 px-3">${aboutInfo.description}</p>

                    <div class="row my-4 justify-content-center">
                        <div class="col-5 stat-box mx-2 border-bottom border-info border-4">
                            <h4 class="text-info mb-0">${aboutInfo.totalPopulation}</h4>
                            <small class="text-muted fw-bold uppercase">Population</small>
                        </div>
                        <div class="col-5 stat-box mx-2 border-bottom border-warning border-4">
                            <h4 class="text-warning mb-0">${aboutInfo.totalMembers}</h4>
                            <small class="text-muted fw-bold uppercase">Members</small>
                        </div>
                    </div>

                    <!-- DISPLAYING THE UPLOADED IMAGES -->
                    <div class="row justify-content-center mt-5">
                        <div class="col-md-5 text-center">
                            <img src="${pageContext.request.contextPath}/uploads/${aboutInfo.sarpanchPhoto != null ? aboutInfo.sarpanchPhoto : 'default.png'}" 
                                 class="rounded-circle profile-img" 
                                 onerror="this.src='https://cdn-icons-png.flaticon.com/512/3135/3135715.png'">
                            <h5 class="fw-bold mt-3">${aboutInfo.sarpanchName}</h5>
                            <span class="badge bg-success">Hon. Sarpanch</span>
                        </div>

                        <div class="col-md-5 text-center">
                            <img src="${pageContext.request.contextPath}/uploads/${aboutInfo.gramsevakPhoto != null ? aboutInfo.gramsevakPhoto : 'default.png'}" 
                                 class="rounded-circle profile-img" 
                                 onerror="this.src='https://cdn-icons-png.flaticon.com/512/3135/3135715.png'">
                            <h5 class="fw-bold mt-3">${aboutInfo.gramsevakName}</h5>
                            <span class="badge bg-primary">Gramsevak</span>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>