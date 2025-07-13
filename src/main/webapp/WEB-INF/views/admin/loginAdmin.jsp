<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2>Login administrateur</h2>
    <form action="${pageContext.request.contextPath}/admin/loginAdmin" method="post">
        <label>Email:</label>
        <input type="email" id="email" name="email" value="admin@example.com">
        <br>
        <label>Mot de passe:</label>
        <input type="password" id="mot_de_passe" name="mot_de_passe" value="password123">
        <br>
        <input type="submit" value="Login">
    </form>
</body>
</html>