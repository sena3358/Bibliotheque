<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Adherent" %>
<%
    List<Adherent> adherents = (List<Adherent>) request.getAttribute("adherents");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <table>
        <tr>
            <td>Id</td><td>Numero</td><td>Prenom</td><td>Type</td><td>Statut</td>
        </tr>
        <% for (Adherent adherent : adherents) { %>
            <tr>
                <td><%= adherent.getId() %></td>
                <td><%= adherent.getNumeroMembre() %></td>  
                <td><%= adherent.getPrenom() %></td>  
                <td><%= adherent.getTypeMembre().getLibelle() %></td>  
                <td><%= adherent.getStatut() %></td>  
            </tr>
        <% } %>
    </table>
    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Retour</a>
</body>
</html>