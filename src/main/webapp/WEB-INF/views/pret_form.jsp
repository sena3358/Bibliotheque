<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire de prêt - Bibliothèque</title>
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
        
        /* Carte de formulaire */
        .form-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 500px;
        }
        
        /* Titre */
        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #3498db;
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
        
        input[type="number"],
        select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        input[type="number"]:focus,
        select:focus {
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
            .form-card {
                padding: 30px 20px;
            }
            
            h2 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="form-card">
        <h2>Formulaire de prêt</h2>
        
        <form action="${pageContext.request.contextPath}/prets/create" method="post">
            <div class="form-group">
                <label for="adherent_id">ID Adhérent :</label>
                <input type="number" id="adherent_id" name="adherent_id" required min="1">
            </div>
            
            <div class="form-group">
                <label for="exemplaire_id">ID Exemplaire :</label>
                <input type="number" id="exemplaire_id" name="exemplaire_id" required min="1">
            </div>
            
            <div class="form-group">
                <label for="type_pret">Type de prêt :</label>
                <select id="type_pret" name="type_pret" required>
                    <option value="maison">Maison</option>
                    <option value="lecture_sur_place">Lecture sur place</option>
                </select>
            </div>

            <div class="form-group">
                <label for="date_pret">Date de prêt :</label>
                <input type="date" name="date_pret" id="date_pret" value="date_pret">
            </div>
            
            <button type="submit" class="btn btn-submit">Enregistrer le prêt</button>
        </form>
        
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-back">Retour au tableau de bord</a>
    </div>

    <script>
        // Focus sur le premier champ au chargement
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('adherent_id').focus();
        });
    </script>
</body>
</html>