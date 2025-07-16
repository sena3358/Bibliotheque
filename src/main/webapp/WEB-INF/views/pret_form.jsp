<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head><title>Effectuer un prêt</title></head>
<body>
<h2>Formulaire de prêt</h2>
<form action="${pageContext.request.contextPath}/prets/create" method="post">
    ID Adhérent : <input type="number" name="adherent_id" required><br>
    ID Exemplaire : <input type="number" name="exemplaire_id" required><br>
    Type de prêt :
    <select name="type_pret">
        <option value="maison">Maison</option>
        <option value="lecture_sur_place">Lecture sur place</option>
    </select><br>
    <input type="submit" value="Valider">
</form> 
<a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Retour</a>
</body>
</html>