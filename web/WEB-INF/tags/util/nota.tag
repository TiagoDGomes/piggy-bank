<%-- 
    Document   : nota
    Created on : 23/12/2012, 15:25:28
    Author     : Tiago Donizetti Gomes
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="Nota de dinheiro" pageEncoding="ISO-8859-1"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="valor" required="true"%>
<%@attribute name="classAdd" required="false"%>

<c:choose>
    <c:when test="${(valor == 1)}">
        <span onclick="selecionarNota(this)" ondragstart="segurarNota(${valor})" draggable="true" class="moeda n1 ${classAdd}">${valor}</span> 
    </c:when>
    <c:when test="${(valor == 2||valor == 5||valor == 10||valor == 20||valor == 50||valor == 100)}">
        <span onclick="selecionarNota(this)" ondragstart="segurarNota(${valor})" draggable="true" class="notaDinheiro n${valor}">${valor}</span> 
    </c:when>
    <c:otherwise>

    </c:otherwise>    
</c:choose>



