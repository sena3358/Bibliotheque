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
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Bibliothèque - Adhérent</title>
    <style>
        /* Reset et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }
        
        /* En-tête */
        header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px 0;
            background-color: #2c3e50;
            color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        h2 {
            margin-bottom: 10px;
        }
        
        /* Navigation */
        .nav-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .nav-links a {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        
        .nav-links a:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        /* Tableau */
        .table-container {
            overflow-x: auto;
            margin-bottom: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 15px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        
        th {
            background-color: #3498db;
            color: white;
            position: sticky;
            top: 0;
        }
        
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        tr:hover {
            background-color: #e9f5ff;
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
        
        /* Badge pour l'état */
        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
        }
        
        .badge-disponible {
            background-color: #2ecc71;
            color: white;
        }
        
        .badge-emprunte {
            background-color: #e74c3c;
            color: white;
        }
        
        .badge-reserve {
            background-color: #f39c12;
            color: white;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .nav-links {
                flex-direction: column;
                align-items: center;
            }
            
            th, td {
                padding: 8px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <header>
        <h2>Bienvenue sur la gestion de bibliothèque</h2>
        <p>Adhérent #<%= idAdherent %></p>
    </header>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/prets/formulaire">Faire une demande de prêt</a>
        <a href="${pageContext.request.contextPath}/prets/liste">Voir mes prêts</a>
        <a href="${pageContext.request.contextPath}/adherent/form">Payer l'abonnement</a>
        <a href="${pageContext.request.contextPath}/adherent/logout">Deconnexion</a>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Réf.</th>
                    <th>Titre</th>
                    <th>Auteur</th>
                    <th>Éditeur</th>
                    <th>Catégorie</th>
                    <th>État</th>
                    <th>Langue</th>
                </tr>
            </thead>
            <tbody>
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
                        <td>
                            <span class="badge badge-<%= exemplaire.getStatut() %>">
                                <%= exemplaire.getStatut() %>
                            </span>
                        </td>
                        <td><%= exemplaire.getLivre().getLangue() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>