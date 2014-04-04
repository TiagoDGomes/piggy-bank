<%-- 
    Document   : saque
    Created on : 23/12/2012, 01:04:55
    Author     : Tiago Donizetti Gomes
--%>

<%@tag description="put the tag description here" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="banco" tagdir="/WEB-INF/tags/banco/" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="view">
    <c:choose>
        <c:when test="${param.modo == 'classico'}">
            <div id="saqueModoClassico" class="saqueModo">
                <banco:conta conta="${contaDoUsuario}" />
            </div>
            <div class="optView" id="optSaqueModoCaixa">
                <a href="?modo=caixa">Visualizar no modo Caixa Eletrônico</a>
            </div>

        </c:when>
        <c:otherwise>
            <div id="saqueModoCaixa" class="saqueModo" >
                <banco:caixa acaoExecutada="saque" />
            </div>
            <!--<div class="optView">
                <a href="?modo=classico">Visualizar no modo clássico</a>
            </div>
            -->
        </c:otherwise>
    </c:choose>


</div>
