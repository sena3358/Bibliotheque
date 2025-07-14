<%@ page import="java.util.List" %>
<%@ page import="model.Prolongement" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    List<Prolongement> demandes = (List<Prolongement>) request.getAttribute("demandes");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demandes de prolongement - Administration</title>
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
        
        .btn-back {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            display: inline-block;
        }
        
        .btn-back:hover {
            background-color: #5a6268;
        }
        
        /* Date */
        .date-cell {
            white-space: nowrap;
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
        <h2>Demandes de prolongement</h2>
        
        <% if (demandes == null || demandes.isEmpty()) { %>
            <div class="empty-message">Aucune demande de prolongement en attente</div>
        <% } else { %>
        <div class="table-responsive">
            <table>
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
                            <td class="date-cell">
                                <%= p.getPret().getDateRetourPrevue().format(dateFormatter) %>
                            </td>
                            <td class="date-cell">
                                <%= p.getNouvelleDateRetour().format(dateFormatter) %>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/prolongements/admin/valider" method="post" style="display:inline">
                                    <input type="hidden" name="prolongement_Id" value="<%= p.getId() %>" />
                                    <input type="hidden" name="approuve" value="true" />
                                    <button type="submit" class="btn btn-success">Approuver</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/prolongements/admin/valider" method="post" style="display:inline">
                                    <input type="hidden" name="prolongement_Id" value="<%= p.getId() %>" />
                                    <input type="hidden" name="approuve" value="false" />
                                    <button type="submit" class="btn btn-danger">Rejeter</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } %>

        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-back">Retour au tableau de bord</a>
    </div>
</body>
</html>