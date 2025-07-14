<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion Adhérent - Bibliothèque</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            background-image: linear-gradient(135deg, #f5f7fa 0%, #e4e8eb 100%);
        }
        
        /* Carte de connexion */
        .login-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            text-align: center;
            animation: fadeIn 0.5s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Logo */
        .logo {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
            background-color: #3498db;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
        }
        
        /* Titre */
        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }
        
        /* Formulaire */
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
            font-size: 14px;
        }
        
        input[type="text"] {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        input[type="text"]:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        /* Bouton */
        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .btn-login:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        /* Lien aide */
        .help-link {
            display: block;
            margin-top: 20px;
            color: #7f8c8d;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }
        
        .help-link:hover {
            color: #3498db;
        }
        
        /* Responsive */
        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
            }
            
            h2 {
                font-size: 20px;
            }
            
            input[type="text"], .btn-login {
                padding: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">B</div>
        <h2>Connexion Adhérent</h2>
        
        <form action="${pageContext.request.contextPath}/adherent/login" method="post">
            <div class="form-group">
                <label for="numero_membre">Numéro de membre</label>
                <input type="text" id="numero_membre" name="numero_membre" 
                       placeholder="Entrez votre numéro de membre" required>
            </div>
            
            <button type="submit" class="btn-login">Se connecter</button>
        </form>
        
        <a href="#" class="help-link">Aide ? Vous avez oublié votre numéro de membre</a>
    </div>

    <script>
        // Animation et focus automatique
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('numero_membre').focus();
        });
    </script>
</body>
</html>