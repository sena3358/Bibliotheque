<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Exemplaire" %>
<%@ page import="model.Livre" %>

<%
    List<Exemplaire> exemplaires = (List<Exemplaire>) request.getAttribute("exemplaires");
    Long adherentId = (Long) request.getAttribute("adherentId");
    String message = (String) session.getAttribute("message");

    if (message != null) {
%>
    <div style="color: green;"><%= message %></div>
<%
    session.removeAttribute("message");
    }
%>

<h2>Faire une demande de prêt</h2>

<table border="1">
    <thead>
        <tr>
            <th>Code Barre</th>
            <th>Titre</th>
            <th>Auteur</th>
            <th>Statut</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
    <%
        if (exemplaires != null && !exemplaires.isEmpty()) {
            for (Exemplaire ex : exemplaires) {
                if ("disponible".equalsIgnoreCase(ex.getStatut().name())) {
    %>
        <tr>
            <td><%= ex.getCodeBarre() %></td>
            <td><%= ex.getLivre().getTitre() %></td>
            <td><%= ex.getLivre().getAuteur() %></td>
            <td><%= ex.getStatut() %></td>
            <td>
                <form action="${pageContext.request.contextPath}/prets/demander" method="post">
                    <input type="hidden" name="adherentId" value="<%= adherentId %>"/>
                    <input type="hidden" name="exemplaireId" value="<%= ex.getId() %>"/>
                    <input type="hidden" name="type" value="maison"/>
                    <button type="submit">Demander</button>
                </form>
            </td>
        </tr>
    <%
                }
            }
        } else {
    %>
        <tr><td colspan="5">Aucun exemplaire disponible</td></tr>
    <%
        }
    %>
    </tbody>
</table>

<a href="${pageContext.request.contextPath}/adherent/dashboard.jsp">Retour</a>
