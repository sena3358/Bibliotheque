<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Résultat du prêt - Bibliothèque</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        /* Carte de résultat */
        .result-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 600px;
            text-align: center;
        }
        
        /* Titre */
        h2 {
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }
        
        /* Message */
        .result-message {
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 5px;
            font-size: 18px;

        }
        
        /* Boutons */
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        
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
        
        .btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-secondary {
            background-color: #6c757d;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        
        /* Responsive */
        @media (max-width: 480px) {
            .result-card {
                padding: 30px 20px;
            }
            
            .btn-container {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="result-card">
        <h2>Résultat du prêt</h2>
        
        <div class="result-message">
            ${message}
        </div>
        
        <div class="btn-container">
            <a href="${pageContext.request.contextPath}/prets/form" class="btn">Nouveau prêt</a>
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-secondary">Tableau de bord</a>
        </div>
    </div>
</body>
</html>