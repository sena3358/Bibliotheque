<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Pret" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    List<Pret> demandes = (List<Pret>) request.getAttribute("demandes");
    String message = (String) session.getAttribute("message");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demandes de prêts - Administration</title>
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
        
        /* Conteneur principal */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }
        
        /* Message flash */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-weight: 500;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        /* Titre */
        h2 {
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
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
            border-bottom: 1px solid #e0e0e0;
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
        
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .btn-success:hover {
            background-color: #218838;
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        
        /* Message vide */
        .empty-message {
            text-align: center;
            padding: 20px;
            color: #6c757d;
            font-style: italic;
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
                display: block;
                width: 100%;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% 
            session.removeAttribute("message");
        } 
        %>
        
        <h2>Demandes de prêts en attente</h2>
        
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Adhérent</th>
                        <th>Livre</th>
                        <th>Date Demande</th>
                        <th>Type</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (demandes != null && !demandes.isEmpty()) { 
                        for (Pret pret : demandes) { 
                    %>
                        <tr>
                            <td><%= pret.getId() %></td>
                            <td><%= pret.getAdherent().getNumeroMembre() %></td>
                            <td><%= pret.getExemplaire().getLivre().getTitre() %></td>
                            <td>
                                <% if (pret.getDatePret() != null) { %>
                                    <%= pret.getDatePret() %>
                                <% } else { %>
                                    <span style="color: #6c757d;">Non encore validé</span>
                                <% } %>
                            </td>
                            <td><%= pret.getTypePret() %></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/prets/valider" method="post" style="display:inline;">
                                    <input type="hidden" name="pret_id" value="<%= pret.getId() %>" />
                                    <input type="hidden" name="approuve" value="true" />
                                    <button type="submit" class="btn btn-success">Valider</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/prets/valider" method="post" style="display:inline;">
                                    <input type="hidden" name="pret_id" value="<%= pret.getId() %>" />
                                    <input type="hidden" name="approuve" value="false" />
                                    <button type="submit" class="btn btn-danger">Rejeter</button>
                                </form>
                            </td>
                        </tr>
                    <% } 
                    } else { 
                    %>
                        <tr>
                            <td colspan="6" class="empty-message">Aucune demande en attente</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-secondary">
            ← Retour au tableau de bord
        </a>
    </div>
</body>
</html>