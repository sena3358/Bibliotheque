<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body>
    <h2>Login adherent</h2>
    <form action="${pageContext.request.contextPath}/adherent/login" method="post">
        <label>Numero de membre:</label>
        <input type="text" id="numero_membre" name="numero_membre" required>
        <br>
        <input type="submit" value="Login">
    </form>
</body>
</html>