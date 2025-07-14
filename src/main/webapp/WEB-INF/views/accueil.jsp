<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Livre" %>
<%@ page import="model.Categorie" %>
<%@ page import="model.Exemplaire" %>
<%
    Long idAdherent = (Long) request.getAttribute("id_adherent");
    List<Exemplaire> exemplaires = (List<Exemplaire>) request.getAttribute("exemplaires");
    List<Livre> livres = (List<Livre>) request.getAttribute("livres");
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2>Bienvenue sur la gestion de bibliotheques</h2>
    <table border="1">
    <tr>
        <th></th><th>Titre</th><th>Auteur</th><th>Editeur</th><th>Categories</th><th>Etat</th><th>Langue</th>
    </tr>
    <% for (Exemplaire exemplaire : exemplaires) { %>
        <tr>
            <td><%= exemplaire.getLivre().getId() %></td>
            <td><%= exemplaire.getLivre().getTitre() %></td> 
            <td><%= exemplaire.getLivre().getAuteur() %></td>
            <td><%= exemplaire.getLivre().getEditeur() %></td>
            <td>
                <ul>
                    <% for (Categorie categorie : categories) { %>
                        <% if (categorie.getId()==exemplaire.getLivre().getCategorie().getId()) { %>
                            <li><%= categorie.getNom() %></li>
                        <% } %>
                    <% } %>
                </ul>
            </td>
            <td><%= exemplaire.getStatut() %></td>
            <td><%= exemplaire.getLivre().getLangue() %></td>
        </tr>
    <% } %>
</table>
    <a href="${pageContext.request.contextPath}/prets/formulaire">Faire une demande de pret</a>
    <a href="${pageContext.request.contextPath}/prets/liste">Voir les prets</a>
</body>
</html>