<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Exemplaire" %>
<%@ page import="model.Livre" %>
<%
    List<Exemplaire> exemplaires = (List<Exemplaire>) request.getAttribute("exemplaires");
    Long adherentId = (Long) request.getAttribute("adherentId");
    String message = (String) session.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demande de prêt - Bibliothèque</title>
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
        h2 {
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
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
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
        
        /* Badge statut */
        .badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .badge-disponible {
            background-color: #28a745;
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
        }
        
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
        
        /* Message vide */
        .empty-message {
            text-align: center;
            padding: 30px;
            color: #6c757d;
            font-size: 18px;
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
            
            .btn {
                padding: 6px 12px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Faire une demande de prêt</h2>
        
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
            <% session.removeAttribute("message"); %>
        <% } %>
        
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Code Barre</th>
                        <th>Titre</th>
                        <th>Auteur</th>
                        <th>Statut</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (exemplaires != null && !exemplaires.isEmpty()) { 
                        boolean hasAvailable = false;
                        for (Exemplaire ex : exemplaires) {
                            if ("disponible".equalsIgnoreCase(ex.getStatut().name())) {
                                hasAvailable = true;
                    %>
                        <tr>
                            <td><%= ex.getCodeBarre() %></td>
                            <td><%= ex.getLivre().getTitre() %></td>
                            <td><%= ex.getLivre().getAuteur() %></td>
                            <td>
                                <span class="badge badge-disponible">Disponible</span>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/prets/demander" method="post">
                                    <input type="hidden" name="adherentId" value="<%= adherentId %>"/>
                                    <input type="hidden" name="exemplaireId" value="<%= ex.getId() %>"/>
                                    <input type="hidden" name="type" value="maison"/>
                                    <input type="date" name="date_pret" value="date_pret">
                                    <button type="submit" class="btn btn-primary">Demander</button>
                                </form>
                            </td>
                        </tr>
                    <% }
                        }
                        if (!hasAvailable) { %>
                        <tr>
                            <td colspan="5" class="empty-message">Aucun exemplaire disponible pour le moment</td>
                        </tr>
                    <% }
                    } else { %>
                        <tr>
                            <td colspan="5" class="empty-message">Aucun exemplaire disponible</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <a href="${pageContext.request.contextPath}/adherent/dashboard.jsp" class="btn btn-back">Retour à l'accueil</a>
    </div>
</body>
</html>