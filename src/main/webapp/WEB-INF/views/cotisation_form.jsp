<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Adherent" %>
<%
    Long adherentId = (Long) request.getAttribute("adherentId");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enregistrement de cotisation</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        /* Conteneur principal */
        .container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 600px;
        }
        
        /* Titre */
        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
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
        
        /* Formulaire */
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
        }
        
        input[type="date"],
        input[type="number"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border 0.3s ease;
        }
        
        input[type="date"]:focus,
        input[type="number"]:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        /* Boutons */
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
        }
        
        .btn-submit {
            width: 100%;
            margin-top: 10px;
        }
        
        .btn-submit:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        
        .btn-back {
            display: inline-block;
            margin-top: 20px;
            background-color: #6c757d;
        }
        
        .btn-back:hover {
            background-color: #5a6268;
        }
        
        /* Responsive */
        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
            }
            
            h2 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Enregistrement de cotisation</h2>
        
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/adherent/save" method="post">
            <input type="hidden" name="adherentId" value="<%= adherentId %>"/>
            
            <div class="form-group">
                <label for="date_debut">Date début :</label>
                <input type="date" id="date_debut" name="date_debut" required>
            </div>
            
            <div class="form-group">
                <label for="date_fin">Date fin :</label>
                <input type="date" id="date_fin" name="date_fin" required>
            </div>
            
            <div class="form-group">
                <label for="montant">Montant (€) :</label>
                <input type="number" id="montant" name="montant" step="0.01" min="0" required>
            </div>
            
            <button type="submit" class="btn btn-submit">Enregistrer la cotisation</button>
        </form>
        
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-back">Retour au tableau de bord</a>
    </div>

    <script>
        // Définir la date du jour comme valeur par défaut
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('date_debut').value = today;
            
            // Calculer la date dans un an
            const nextYear = new Date();
            nextYear.setFullYear(nextYear.getFullYear() + 1);
            const nextYearFormatted = nextYear.toISOString().split('T')[0];
            document.getElementById('date_fin').value = nextYearFormatted;
        });
    </script>
</body>
</html>