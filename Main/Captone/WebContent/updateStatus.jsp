<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Complaint Status</title>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 50%, #90caf9 100%);
            min-height: 100vh;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: linear-gradient(135deg, #ffffff 0%, #fafcff 100%);
            padding: 40px 50px;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(25, 118, 210, 0.2);
            max-width: 600px;
            width: 100%;
            border: 1px solid rgba(25, 118, 210, 0.1);
            animation: fadeIn 0.5s ease-out;
        }

        h2 {
            color: #1976d2;
            text-align: center;
            margin-bottom: 35px;
            font-size: 32px;
            font-weight: 700;
            text-shadow: 0 2px 10px rgba(25, 118, 210, 0.1);
        }

        .redirect-message {
            background: #e8f4fd;
            color: #1565c0;
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            font-size: 17px;
            line-height: 1.6;
            border-left: 6px solid #42a5f5;
            margin-bottom: 20px;
        }

        .redirect-message strong {
            color: #d32f2f;
            font-size: 19px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        label {
            font-weight: 600;
            color: #1565c0;
            font-size: 15px;
            letter-spacing: 0.3px;
        }

        select {
            padding: 14px 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            font-size: 15px;
            color: #37474f;
            background: white;
            transition: all 0.3s ease;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%231976d2' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            padding-right: 40px;
        }

        select:focus {
            outline: none;
            border-color: #42a5f5;
            box-shadow: 0 0 0 4px rgba(66, 165, 245, 0.1);
        }

        select:hover {
            border-color: #64b5f6;
        }

        textarea {
            padding: 14px 16px;
            border: 2px solid #e3f2fd;
            border-radius: 12px;
            font-size: 15px;
            color: #37474f;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            resize: vertical;
            min-height: 120px;
            transition: all 0.3s ease;
            background: white;
        }

        textarea:focus {
            outline: none;
            border-color: #42a5f5;
            box-shadow: 0 0 0 4px rgba(66, 165, 245, 0.1);
        }

        textarea:hover {
            border-color: #64b5f6;
        }

        input[type="file"] {
            padding: 14px 16px;
            border: 2px dashed #e3f2fd;
            border-radius: 12px;
            font-size: 14px;
            color: #546e7a;
            background: #f5f9ff;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        input[type="file"]:hover {
            border-color: #64b5f6;
            background: #e3f2fd;
        }

        input[type="file"]::file-selector-button {
            padding: 10px 20px;
            background: linear-gradient(135deg, #42a5f5 0%, #2196f3 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            margin-right: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(33, 150, 243, 0.3);
        }

        input[type="file"]::file-selector-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(33, 150, 243, 0.4);
        }

        button[type="submit"] {
            padding: 16px 32px;
            background: linear-gradient(135deg, #42a5f5 0%, #2196f3 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(33, 150, 243, 0.4);
            margin-top: 10px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        button[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(33, 150, 243, 0.5);
        }

        button[type="submit"]:active {
            transform: translateY(-1px);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 25px;
            }
            h2 {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <%
            String complaintIdStr = request.getParameter("id");
            String userEmail = request.getParameter("email");

            // If no valid complaint ID → show redirect message
            if (complaintIdStr == null || complaintIdStr.trim().isEmpty() || !complaintIdStr.matches("\\d+")) {
        %>
            <div class="redirect-message">
                <strong>Oops! No complaint selected yet...</strong><br><br>
                Please choose a complaint from the list first.<br>
                Redirecting you to the complaints page in a few seconds...
            </div>

            <script>
                setTimeout(function() {
                    window.location.href = "adminViewComplaint.jsp";
                }, 2500);
            </script>

            <noscript>
                <meta http-equiv="refresh" content="0;url=adminViewComplaint.jsp">
                <p style="text-align:center; margin-top:25px; color:#1976d2;">
                    Redirecting automatically...<br>
                    <a href="adminViewComplaint.jsp" style="color:#1976d2; font-weight:bold;">
                        Click here if you are not redirected
                    </a>
                </p>
            </noscript>
        <%
            } else {
        %>
            <h2>Update Complaint Status</h2>

            <form action="UpdateStatusServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="complaintId" value="<%= complaintIdStr %>">
                <input type="hidden" name="userEmail" value="<%= (userEmail != null ? userEmail : "") %>">

                <div class="form-group">
                    <label>Status:</label>
                    <select name="status" required>
                        <option value="Pending">Pending</option>
                        <option value="In Progress">In Progress</option>
                        <option value="Resolved">Resolved</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Message for User:</label>
                    <textarea name="adminMessage" rows="4" 
                              placeholder="Enter your message to the user..." required></textarea>
                </div>

                <div class="form-group">
                    <label>Upload Proof Image (optional):</label>
                    <input type="file" name="adminImage" accept="image/*">
                </div>

                <button type="submit">Update Status</button>
            </form>
        <%
            }
        %>
    </div>

</body>
</html>