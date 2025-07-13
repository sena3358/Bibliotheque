<%@ page import="java.util.List" %>
<%@ page import="model.Prolongement" %>
<%@ page import="model.Pret" %>
<%@ page import="model.Adherent" %>
<%@ page import="model.Exemplaire" %>
<%@ page import="model.Livre" %>

<%
    List<Prolongement> demandes = (List<Prolongement>) request.getAttribute("demandes");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Demandes de prolongement</title>
</head>
<body>
<h2>Demandes de prolongement</h2>

<% if (demandes == null || demandes.isEmpty()) { %>
    <p>Aucune demande de prolongement.</p>
<% } else { %>
<table border="1">
    <thead>
        <tr>
            <th>Adhérent</th>
            <th>Livre</th>
            <th>Retour prévu</th>
            <th>Nouveau retour</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <% for (Prolongement p : demandes) { %>
            <tr>
                <td><%= p.getPret().getAdherent().getNumeroMembre() %></td>
                <td><%= p.getPret().getExemplaire().getLivre().getTitre() %></td>
                <td><%= p.getPret().getDateRetourPrevue() %></td>
                <td><%= p.getNouvelleDateRetour() %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/prolongements/admin/valider" method="post" style="display:inline">
                        <input type="hidden" name="prolongement_Id" value="<%= p.getId() %>" />
                        <input type="hidden" name="approuve" value="true" />
                        <button type="submit">Approuver</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/prolongements/admin/valider" method="post" style="display:inline">
                        <input type="hidden" name="prolongement_Id" value="<%= p.getId() %>" />
                        <input type="hidden" name="approuve" value="false" />
                        <button type="submit">Rejeter</button>
                    </form>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>
<% } %>

<br>
<a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Retour</a>
</body>
</html>
