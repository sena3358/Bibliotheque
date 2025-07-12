<%@ page import="java.util.List" %>
<%@ page import="model.Livre" %>
<%@ page import="model.Exemplaire" %>
<%@ page import="model.Pret" %>
<%
    List<Pret> prets = (List<Pret>) request.getAttribute("prets");
    List<Exemplaire> exemplaires = (List<Exemplaire>) request.getAttribute("exemplaires");
    List<Livre> livres = (List<Livre>) request.getAttribute("livres");
    Long id_ad = (Long) request.getAttribute("id");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <% if (prets == null || prets.isEmpty()) { %>
        <p>Aucun prêt trouvé.</p>
    <% } else { %>
    <h1>Liste des prets</h1>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Titre du livre</th>
                <th>Auteur du livre</th>
                <th>Etat</th>
                <th>Date du pret</th>
                <th>Date de fin</th>
                <th>Date de retour</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <% for (Pret pret : prets) { %>
                <tr>
                    <td><%= pret.getId() %></td>
                    <td><%= pret.getExemplaire().getLivre().getTitre() %></td>
                    <td><%= pret.getExemplaire().getLivre().getAuteur() %></td>
                    <td><%= pret.getStatut() %></td>
                    <td><%= pret.getDatePret() %></td>
                    <td><%= pret.getDateRetourPrevue() %></td>   
                    <% if (pret.getDateRetourEffective() != null) { %>
                        <td><%= pret.getDateRetourEffective() %></td>
                    <% } else { %>
                        <td>
                        <form action="${pageContext.request.contextPath}/prets/rendre" method="post">
                            <input type="hidden" name="id" value="<%= pret.getId() %>">
                            <input type="date" name="date_retour_prevue" placeholder="Saisir la date de retour" required />
                    </td>
                    <td>
                            <button type="submit">Rendre</button>
                        </form>
                    </td>
                    <% } %>
                </tr>
            <% } %>
        </tbody>
    </table>
    <% } %>
</body>
</html>