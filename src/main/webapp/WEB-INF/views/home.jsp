<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Livre" %>
<%@ page import="model.Categorie" %>
<%
    List<Livre> livres = (List<Livre>) request.getAttribute("livres");
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
%>
<html>
<head>
    <title>Accueil</title>
</head>
<body>
    <h2>Bienvenue sur la gestion de bibliotheques</h2>
    <a href="${pageContext.request.contextPath}/adherent/login">Se connecter</a>
    <a href="${pageContext.request.contextPath}/admin/loginAdmin">Se connecter en tant qu'administrateur</a>
    <table border="1">
    <tr>
        <th>Titre</th><th>Auteur</th><th>Editeur</th><th>Categories</th><th>Année de publication</th><th>Langue</th>
    </tr>
    <% for (Livre livre : livres) { %>
        <tr> 
            <td><%= livre.getTitre() %></td> 
            <td><%= livre.getAuteur() %></td>
            <td><%= livre.getEditeur() %></td>
            <td>
                <ul>
                    <% for (Categorie categorie : categories) { %>
                        <% if (categorie.getId()==livre.getCategorie().getId()) { %>
                            <li><%= categorie.getNom() %></li>
                        <% } %>
                    <% } %>
                </ul>
            </td>
            <td><%= livre.getAnneePublication() %></td>
            <td><%= livre.getLangue() %></td>
        </tr>
    <% } %>
</table>
</body>
</html>
