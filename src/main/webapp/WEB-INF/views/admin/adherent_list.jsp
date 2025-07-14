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
    <title>Liste des adhérents</title>
</head>
<body>
    <h2>Liste des adhérents</h2>
    <table border="1">
        <tr>
            <th>Id</th><th>Numéro</th><th>Prénom</th><th>Type</th><th>Statut</th><th>Fin d'abonnement</th><th>Action</th>
        </tr>
        <% for (Adherent adherent : adherents) { %>
            <tr>
                <td><%= adherent.getId() %></td>
                <td><%= adherent.getNumeroMembre() %></td>  
                <td><%= adherent.getPrenom() %></td>  
                <td><%= adherent.getTypeMembre().getLibelle() %></td>  
                <td><%= adherent.getStatut() %></td>  
                <td><%= adherent.getDateExpiration() %></td>
                <td>
                    <% if (!"actif".equalsIgnoreCase(adherent.getStatut().toString())) { %>
                        <form action="${pageContext.request.contextPath}/adherent/activer" method="post">
                            <input type="hidden" name="id" value="<%= adherent.getId() %>"/>
                            <button type="submit">Activer</button>
                        </form>
                    <% } else { %>
                        Déjà actif
                    <% } %>
                </td>
            </tr>
        <% } %>
    </table>

    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Retour</a>
</body>
</html>
