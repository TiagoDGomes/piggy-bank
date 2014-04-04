<%-- 
    Document   : mostrarDinheiro
    Created on : 23/12/2012, 12:39:21
    Author     : Tiago Donizetti Gomes
--%>

<%@tag description="Exibir notas e dinheiro" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="util" tagdir="/WEB-INF/tags/util/" %>
<%@attribute name="quantidade" type="java.lang.Integer"%>
<%@attribute name="colunas" type="java.lang.Integer" %>

<c:if test="${empty colunas}" >
    <c:set var="colunas" value="5" />
</c:if>
<c:if test="${quantidade < 0}" >
    <c:set var="quantidade" value="0" />
</c:if>
<c:set var="ta" value="100" />
<c:set var="tu" value="100" />
<div class="notas">
    <c:forEach var="i" begin="0" end="${quantidade}" varStatus="c">

        <c:choose>
            <c:when test="${(quantidade >= 200)}">
                <c:set var="ta" value="100" />
                <c:if test="${( ta != tu)}">
                    <br />
                    <c:set var="tu" value="${ta}" />
                </c:if>
                <util:nota valor="100" />
                <c:set var="quantidade" value="${(quantidade - 100)}"></c:set>

            </c:when>
            <c:when test="${(quantidade >= 100)}">
                <c:set var="ta" value="50" />
                <c:if test="${( ta != tu)}">
                    <br />
                    <c:set var="tu" value="${ta}" />
                </c:if>
                <util:nota valor="50" />
                <c:set var="quantidade" value="${(quantidade - 50)}"></c:set>

            </c:when>
            <c:when test="${(quantidade >= 50)}">
                <c:set var="ta" value="20" />
                <c:if test="${( ta != tu)}">
                    <br />
                    <c:set var="tu" value="${ta}" />
                </c:if>
                <util:nota valor="20" />
                <c:set var="quantidade" value="${(quantidade - 20)}"></c:set>

            </c:when>
            <c:when test="${(quantidade >= 20)}">
                <c:set var="ta" value="10" />
                <c:if test="${( ta != tu)}">
                    <br />
                    <c:set var="tu" value="${ta}" />
                </c:if>
                <util:nota valor="10" />
                <c:set var="quantidade" value="${(quantidade - 10)}"></c:set>

            </c:when>
            <c:when test="${(quantidade >= 10)}">
                <c:set var="ta" value="5" />
                <c:if test="${( ta != tu)}">
                    <br />
                    <c:set var="tu" value="${ta}" />
                </c:if>
                <util:nota valor="5" />
                <c:set var="quantidade" value="${(quantidade - 5)}"></c:set>

            </c:when>
            <c:when test="${(quantidade >= 5)}">
                <c:set var="ta" value="2" />
                <c:if test="${( ta != tu)}">
                    <br />
                    <c:set var="tu" value="${ta}" />
                </c:if>
                <util:nota valor="2" />
                <c:set var="quantidade" value="${(quantidade - 2)}"></c:set>

            </c:when>
            <c:when test="${(quantidade >= 1)}">
                <c:set var="ta" value="1" />
                <c:if test="${( ta != tu)}">
                    <br />
                    <c:set var="tu" value="${ta}" />
                </c:if>
                <util:nota valor="1" />
                <c:set var="quantidade" value="${(quantidade - 1)}"></c:set>

            </c:when>                
        </c:choose>
        <%-- <c:if test="${( c.count % colunas == 0)}">
            </div><div class="notas">   
        </c:if>--%>

    </c:forEach>

</div>