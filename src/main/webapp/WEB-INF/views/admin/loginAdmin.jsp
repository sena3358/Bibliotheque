<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion Administrateur</title>
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
        }
        
        /* Carte de connexion */
        .login-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
        }
        
        /* Titre */
        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
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
        
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border 0.3s ease;
        }
        
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        /* Bouton */
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        
        /* Responsive */
        @media (max-width: 480px) {
            .login-card {
                padding: 30px 20px;
            }
            
            h2 {
                font-size: 20px;
            }
        }
        
        /* Message d'erreur (optionnel) */
        .error-message {
            color: #e74c3c;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>Connexion Administrateur</h2>
        <form action="${pageContext.request.contextPath}/admin/loginAdmin" method="post">
            <div class="form-group">
                <label for="email">Email :</label>
                <input type="email" id="email" name="email" value="admin@example.com" required>
                <div class="error-message" id="email-error"></div>
            </div>
            
            <div class="form-group">
                <label for="mot_de_passe">Mot de passe :</label>
                <input type="password" id="mot_de_passe" name="mot_de_passe" value="password123" required>
                <div class="error-message" id="password-error"></div>
            </div>
            
            <button type="submit" class="btn">Se connecter</button>
        </form>
    </div>

    <script>
        // Validation simple côté client (optionnelle)
        document.querySelector('form').addEventListener('submit', function(e) {
            let valid = true;
            const email = document.getElementById('email');
            const password = document.getElementById('mot_de_passe');
            
            // Réinitialiser les messages d'erreur
            document.getElementById('email-error').style.display = 'none';
            document.getElementById('password-error').style.display = 'none';
            
            // Validation email
            if (!email.value.includes('@')) {
                document.getElementById('email-error').textContent = 'Veuillez entrer une adresse email valide';
                document.getElementById('email-error').style.display = 'block';
                valid = false;
            }
            
            // Validation mot de passe
            if (password.value.length < 6) {
                document.getElementById('password-error').textContent = 'Le mot de passe doit contenir au moins 6 caractères';
                document.getElementById('password-error').style.display = 'block';
                valid = false;
            }
            
            if (!valid) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>