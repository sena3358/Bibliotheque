<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Adherent" %>
<%
    Long adherentId = (Long) request.getAttribute("adherentId");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Enregistrer Cotisation</title>
</head>
<body>
<h2>Enregistrement de cotisation</h2>

<% if (message != null) { %>
    <div style="color: green;"><%= message %></div>
<% } %>

<form action="${pageContext.request.contextPath}/adherent/save" method="post">
    <input type="hidden" name="adherentId" value="<%= adherentId %>"/>

    <label>Date début:</label>
    <input type="date" name="date_debut" required><br><br>

    <label>Date fin:</label>
    <input type="date" name="date_fin" required><br><br>

    <label>Montant:</label>
    <input type="number" name="montant" step="0.01" required><br><br>

    <button type="submit">Enregistrer</button>
</form>

<a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Retour</a>
</body>
</html>
