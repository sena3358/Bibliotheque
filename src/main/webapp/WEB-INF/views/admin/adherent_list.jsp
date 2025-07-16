<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Adherent" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    List<Adherent> adherents = (List<Adherent>) request.getAttribute("adherents");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des adhérents - Administration</title>
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
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        
        /* Titre */
        h2 {
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
            text-align: center;
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
            background-color: #e9ecef;
        }
        
        /* Boutons */
        .btn {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }
        
        .btn-primary {
            background-color: #28a745;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #218838;
            transform: translateY(-1px);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            margin-top: 20px;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
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
        
        .badge-success {
            background-color: #28a745;
            color: white;
        }
        
        .badge-warning {
            background-color: #ffc107;
            color: #212529;
        }
        
        .badge-danger {
            background-color: #dc3545;
            color: white;
        }
        
        /* Message statut */
        .status-message {
            color: #6c757d;
            font-style: italic;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            th, td {
                padding: 8px;
                font-size: 14px;
            }
            
            .btn {
                padding: 5px 8px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Liste des adherents</h2>
        
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Numero</th>
                        <th>Prenom</th>
                        <th>Type</th>
                        <th>Statut</th>
                        <th>Fin d'abonnement</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Adherent adherent : adherents) { %>
                        <tr>
                            <td><%= adherent.getId() %></td>
                            <td><%= adherent.getNumeroMembre() %></td>  
                            <td><%= adherent.getPrenom() %></td>  
                            <td><%= adherent.getTypeMembre().getLibelle() %></td>  
                            <td>
                                <span class="badge 
                                    <% if ("actif".equalsIgnoreCase(adherent.getStatut().toString())) { %>
                                        badge-success
                                    <% } else if ("expiré".equalsIgnoreCase(adherent.getStatut().toString())) { %>
                                        badge-danger
                                    <% } else { %>
                                        badge-warning
                                    <% } %>">
                                    <%= adherent.getStatut() %>
                                </span>
                            </td>  
                            <td>
                                <% if (adherent.getDateExpiration() != null) { %>
                                    <%= adherent.getDateExpiration().format(dateFormatter) %>
                                <% } else { %>
                                    -
                                <% } %>
                            </td>
                            <td>
                                <% if (!"actif".equalsIgnoreCase(adherent.getStatut().toString())) { %>
                                    <form action="${pageContext.request.contextPath}/adherent/activer" method="post" style="display: inline;">
                                        <input type="hidden" name="id" value="<%= adherent.getId() %>"/>
                                        <button type="submit" class="btn btn-primary">Activer</button>
                                    </form>
                                <% } else { %>
                                    <span class="status-message">Déjà actif</span>
                                <% } %>
                            </td>
                            <td><a href="${pageContext.request.contextPath}/adherent/api/adherents?id=<%= adherent.getId() %>">Voir details</a></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-secondary">Retour au tableau de bord</a>
    </div>
</body>
</html>