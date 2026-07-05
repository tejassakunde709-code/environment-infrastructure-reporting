<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Get the current session if it exists (don't create a new one)
    // In JSP, 'session' is an implicit object, but we want to handle the invalidation safely.
    
    if (session != null) {
        try {
            // Remove all attributes (userId, adminId, etc.) and kill the session
            session.invalidate();
        } catch (Exception e) {
            // Session might already be invalid, which is fine
        }
    }

    // 2. Redirect the user
    // We redirect to roleSelection.jsp so they can choose to login as Admin or User again.
    // (If you specifically want to go to userLogin.jsp, just change the text below).
    response.sendRedirect("roleSelection.jsp");
    
    // 3. Stop further processing
    return;
%>