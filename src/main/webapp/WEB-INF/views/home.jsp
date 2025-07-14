<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Livre" %>
<%@ page import="model.Categorie" %>
<%
    List<Livre> livres = (List<Livre>) request.getAttribute("livres");
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Gestion de bibliothèque</title>
    <style>
        /* Reset et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f8f9fa;
            padding: 20px;
        }
        
        /* En-tête */
        header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #3498db;
        }
        
        h2 {
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        /* Navigation */
        .auth-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .auth-links a {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        .auth-links a:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        
        /* Tableau des livres */
        .livres-container {
            overflow-x: auto;
            margin: 0 auto;
            max-width: 100%;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #3498db;
            color: white;
            position: sticky;
            top: 0;
        }
        
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        
        tr:hover {
            background-color: #e9e9e9;
        }
        
        /* Liste des catégories */
        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        
        li {
            padding: 2px 0;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .auth-links {
                flex-direction: column;
                align-items: center;
            }
            
            th, td {
                padding: 8px 10px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <header>
        <h2>Bienvenue sur la gestion de bibliothèque</h2>
        <div class="auth-links">
            <a href="${pageContext.request.contextPath}/adherent/login">Se connecter</a>
            <a href="${pageContext.request.contextPath}/admin/loginAdmin">Administrateur</a>
        </div>
    </header>

    <div class="livres-container">
        <table>
            <thead>
                <tr>
                    <th>Titre</th>
                    <th>Auteur</th>
                    <th>Éditeur</th>
                    <th>Catégorie</th>
                    <th>Année</th>
                    <th>Langue</th>
                </tr>
            </thead>
            <tbody>
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
            </tbody>
        </table>
    </div>
</body>
</html>