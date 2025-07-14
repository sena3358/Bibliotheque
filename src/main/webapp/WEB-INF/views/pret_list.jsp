<%@ page import="java.util.List" %>
<%@ page import="model.Livre" %>
<%@ page import="model.Exemplaire" %>
<%@ page import="model.Pret" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    List<Pret> prets = (List<Pret>) request.getAttribute("prets");
    List<Exemplaire> exemplaires = (List<Exemplaire>) request.getAttribute("exemplaires");
    List<Livre> livres = (List<Livre>) request.getAttribute("livres");
    Long id_ad = (Long) request.getAttribute("id");
    String message = (String) request.getAttribute("message");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des prêts - Bibliothèque</title>
    <style>
        /* Reset et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f8f9fa;
            color: #343a40;
            line-height: 1.6;
            padding: 20px;
        }
        
        /* Conteneur principal */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        
        /* Titre */
        h1 {
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }
        
        /* Message */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
        }
        
        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        /* Message vide */
        .empty-message {
            text-align: center;
            padding: 30px;
            color: #6c757d;
            font-size: 18px;
        }
        
        /* Tableau */
        .table-responsive {
            overflow-x: auto;
            margin-bottom: 30px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        
        th {
            background-color: #3498db;
            color: white;
            position: sticky;
            top: 0;
            font-weight: 500;
        }
        
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        tr:hover {
            background-color: #e9f5ff;
        }
        
        /* Badges */
        .badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .badge-active {
            background-color: #28a745;
            color: white;
        }
        
        .badge-returned {
            background-color: #6c757d;
            color: white;
        }
        
        .badge-overdue {
            background-color: #dc3545;
            color: white;
        }
        
        /* Boutons */
        .btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            margin: 2px;
        }
        
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
        
        .btn-back {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            display: inline-block;
        }
        
        .btn-back:hover {
            background-color: #5a6268;
        }
        
        /* Formulaire dans le tableau */
        .table-form {
            display: flex;
            gap: 5px;
        }
        
        .table-form input[type="date"] {
            padding: 6px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            
            th, td {
                padding: 8px;
                font-size: 14px;
            }
            
            .table-form {
                flex-direction: column;
            }
            
            .btn {
                padding: 6px 12px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <% if (message != null) { %>
            <div class="alert alert-info"><%= message %></div>
        <% } %>
        
        <% if (prets == null || prets.isEmpty()) { %>
            <div class="empty-message">Aucun prêt trouvé</div>
        <% } else { %>
            <h1>Liste des prêts</h1>
            
            <div class="table-responsive">
                <% if (id_ad == null) { %>
                    <!-- Vue administrateur -->
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Adhérent</th>
                                <th>Titre du livre</th>
                                <th>Auteur</th>
                                <th>Statut</th>
                                <th>Date du prêt</th>
                                <th>Date de fin</th>
                                <th>Date de retour</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Pret pret : prets) { %>
                                <tr>
                                    <td><%= pret.getId() %></td>
                                    <td><%= pret.getAdherent().getNumeroMembre() %></td>
                                    <td><%= pret.getExemplaire().getLivre().getTitre() %></td>
                                    <td><%= pret.getExemplaire().getLivre().getAuteur() %></td>
                                    <td>
                                        <span class="badge 
                                            <% if (pret.getDateRetourEffective() != null) { %>
                                                badge-returned
                                            <% } else if (pret.getStatut().name().equalsIgnoreCase("en_retard")) { %>
                                                badge-overdue
                                            <% } else { %>
                                                badge-active
                                            <% } %>">
                                            <%= pret.getStatut() %>
                                        </span>
                                    </td>
                                    <td><%= pret.getDatePret().format(dateFormatter) %></td>
                                    <td><%= pret.getDateRetourPrevue().format(dateFormatter) %></td>
                                    <% if (pret.getDateRetourEffective() != null) { %>
                                        <td><%= pret.getDateRetourEffective().format(dateFormatter) %></td>
                                        <td>Retour enregistré</td>
                                    <% } else { %>
                                        <td>
                                            <form class="table-form" action="${pageContext.request.contextPath}/prets/rendre" method="post">
                                                <input type="hidden" name="id" value="<%= pret.getId() %>">
                                                <input type="date" name="date_retour_prevue" required>
                                                <button type="submit" class="btn btn-success">Rendre</button>
                                            </form>
                                        </td>
                                    <% } %>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <!-- Vue adhérent -->
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Titre du livre</th>
                                <th>Auteur</th>
                                <th>Statut</th>
                                <th>Date du prêt</th>
                                <th>Date de fin</th>
                                <th>Date de retour</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Pret pret : prets) { %>
                                <tr>
                                    <td><%= pret.getId() %></td>
                                    <td><%= pret.getExemplaire().getLivre().getTitre() %></td>
                                    <td><%= pret.getExemplaire().getLivre().getAuteur() %></td>
                                    <td>
                                        <span class="badge 
                                            <% if (pret.getDateRetourEffective() != null) { %>
                                                badge-returned
                                            <% } else if (pret.getStatut().name().equalsIgnoreCase("en_retard")) { %>
                                                badge-overdue
                                            <% } else { %>
                                                badge-active
                                            <% } %>">
                                            <%= pret.getStatut() %>
                                        </span>
                                    </td>
                                    <td><%= pret.getDatePret().format(dateFormatter) %></td>
                                    <td><%= pret.getDateRetourPrevue().format(dateFormatter) %></td>
                                    <% if (pret.getDateRetourEffective() != null) { %>
                                        <td><%= pret.getDateRetourEffective().format(dateFormatter) %></td>
                                        <td></td>
                                    <% } else { %>
                                        <td>
                                            <form class="table-form" action="${pageContext.request.contextPath}/prets/rendre" method="post">
                                                <input type="hidden" name="id" value="<%= pret.getId() %>">
                                                <input type="date" name="date_retour_prevue" required>
                                                <button type="submit" class="btn btn-success">Rendre</button>
                                            </form>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/prolongements/demander" method="post">
                                                <input type="hidden" name="id" value="<%= pret.getId() %>">
                                                <button type="submit" class="btn btn-warning">Prolonger</button>
                                            </form>
                                        </td>
                                    <% } %>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
        <% } %>
        
        <% if (id_ad == null) { %>
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-back">Retour au tableau de bord</a>
        <% } %>
    </div>
</body>
</html>