<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Bibliothèque</title>
    <style>
        /* Style général */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
            color: #333;
        }
        
        /* Conteneur principal */
        .nav-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        /* Titre */
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        
        /* Grille de navigation */
        .nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        
        /* Style des liens */
        .nav-link {
            display: block;
            padding: 15px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            text-align: center;
            border-radius: 5px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        
        .nav-link:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        /* Responsive */
        @media (max-width: 600px) {
            .nav-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="nav-container">
        <h1>Backoffice</h1>
        <div class="nav-grid">
            <a href="${pageContext.request.contextPath}/prets/form" class="nav-link">Faire un pret</a>
            <a href="${pageContext.request.contextPath}/prets/liste" class="nav-link">Voir les prets</a>
            <a href="${pageContext.request.contextPath}/prolongements/list" class="nav-link">Demandes de prolongement</a>
            <a href="${pageContext.request.contextPath}/adherent/list" class="nav-link">Liste des membres</a>
            <a href="${pageContext.request.contextPath}/prets/demandes" class="nav-link">Demandes de prets</a>
        </div>
    </div>
</body>
</html>