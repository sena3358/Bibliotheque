<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Pret" %>

<%
    List<Pret> demandes = (List<Pret>) request.getAttribute("demandes");
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
    <div style="color: green;"><%= message %></div>
<%
    session.removeAttribute("message");
    }
%>

<h2>Demandes de prêts en attente</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Adhérent</th>
        <th>Livre</th>
        <th>Date Demande</th>
        <th>Type</th>
        <th>Actions</th>
    </tr>
    <%
        if (demandes != null && !demandes.isEmpty()) {
            for (Pret pret : demandes) {
    %>
        <tr>
            <td><%= pret.getId() %></td>
            <td><%= pret.getAdherent().getNumeroMembre() %></td>
            <td><%= pret.getExemplaire().getLivre().getTitre() %></td>
            <td><%= pret.getDatePret() != null ? pret.getDatePret() : "Non encore validé" %></td>
            <td><%= pret.getTypePret() %></td>
            <td>
                <form action="${pageContext.request.contextPath}/prets/valider" method="post" style="display:inline;">
                    <input type="hidden" name="pret_id" value="<%= pret.getId() %>" />
                    <input type="hidden" name="approuve" value="true" />
                    <button type="submit">Valider</button>
                </form>
                <form action="${pageContext.request.contextPath}/prets/valider" method="post" style="display:inline;">
                    <input type="hidden" name="pret_id" value="<%= pret.getId() %>" />
                    <input type="hidden" name="approuve" value="false" />
                    <button type="submit">Rejeter</button>
                </form>
            </td>
        </tr>
    <%
            }
        } else {
    %>
        <tr><td colspan="6">Aucune demande en attente.</td></tr>
    <%
        }
    %>
</table>

<a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Retour au tableau de bord</a>
