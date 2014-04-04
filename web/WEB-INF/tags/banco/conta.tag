<%-- 
    Document   : conta_mini
    Created on : 23/12/2012, 15:51:36
    Author     : Tiago Donizetti Gomes
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="util" tagdir="/WEB-INF/tags/util/" %>
<%@tag description="Exibe uma conta" pageEncoding="ISO-8859-1"%>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="modoMini" type="java.lang.Boolean"%>
<%@attribute name="modoMini_class" type="java.lang.Boolean"%>
<%@attribute name="modoMini_exibirNotas" type="java.lang.Boolean"%>
<%@attribute name="modoMini_exibirNumeroConta" type="java.lang.Boolean"%>
<%@attribute name="modoMini_exibirValorEmConta" type="java.lang.Boolean"%>
<%@attribute name="modoMini_formulario" type="java.lang.Boolean"%>
<%@attribute name="modoMini_formulario_acao" type="java.lang.String"%>
<%@attribute name="modoMini_depositavel" type="java.lang.Boolean"%>
<%@attribute name="modoMini_classNumeroDaConta" type="java.lang.String"%>
<%@attribute name="modoMini_classValorEmConta" type="java.lang.String"%>
<%@attribute name="modoMini_prefixoIdNumeroDaConta" type="java.lang.String"%>
<%@attribute name="modoMini_prefixoIdValorEmConta" type="java.lang.String"%>

<%@attribute name="conta" type="classes.Conta" required="true"%>

<c:choose>

    <c:when test="${modoMini}">

        <c:if test="${empty modoMini_class}" >
            <c:set var="modoMini_class" value="contaMini" />
        </c:if>
        <c:if test="${empty modoMini_classNumeroDaConta}" >
            <c:set var="modoMini_classNumeroDaConta" value="numeroDaConta" />
        </c:if>

        <c:if test="${empty modoMini_prefixoIdNumeroDaConta}" >
            <c:set var="modoMini_prefixoIdNumeroDaConta" value="numeroDaConta_" />
        </c:if>

        <c:if test="${empty modoMini_classValorEmConta}" >
            <c:set var="modoMini_classValorEmConta" value="valorEmConta" />
        </c:if>

        <c:if test="${empty modoMini_prefixoIdValorEmConta}" >
            <c:set var="modoMini_prefixoIdValorEmConta" value="valorEmConta_" />
        </c:if>
        <c:if test="${modoMini_depositavel}">
            <c:set var="modoMini_class" value="${modoMini_class} localDeposito" />
        </c:if>

        <div>
            <c:if test="${modoMini_formulario}">
                <form name="depositoEmConta" method="post" action="operacao?acao=${modoMini_formulario_acao}">
                </c:if>

                <c:choose>
                    <c:when test="${modoMini_depositavel}">
                        <c:out escapeXml="false" value="<div ondragover=\"eventPassarSobre(event)\" ondrop=\"soltarNota(${conta.id});\" class=\"${modoMini_class}\">" />
                    </c:when>
                    <c:otherwise>
                        <c:out escapeXml="false" value="<div class=\"${modoMini_class}\">" />
                    </c:otherwise>
                </c:choose>                
                <span class="${modoMini_classNumeroDaConta}" id="${modoMini_prefixoIdNumeroDaConta}${conta.id}">Conta ${conta.id}</span><br />
                <span class="${modoMini_classValorEmConta}" id="${modoMini_prefixoIdValorEmConta}${conta.id}">
                    <c:choose>
                        <c:when test="${modoMini_exibirValorEmConta and (!empty sessionScope.contaDoUsuario)}">
                            <fmt:formatNumber value="${conta.saldo}" minFractionDigits="0" /> 
                        </c:when>
                        <c:otherwise>
                            0
                        </c:otherwise>
                    </c:choose>
                </span><br />
                <input id="nc_${conta.id}" type="hidden" name="numeroConta" value="${conta.id}" />
                <input id="vd_${conta.id}" type="hidden" name="valor" value="0" />
                <c:if test="${modoMini_formulario}">
                    <input type="submit" value="Concluir" />
                </c:if>

                <c:out escapeXml="false" value="</div>" />
                <c:if test="${modoMini_formulario}">
                </form>
            </c:if>
        </div>
        <c:if test="${modoMini_exibirNotas}" >
            <div class="notasAgrupadas">
                <util:mostrarNotas quantidade="${conta.saldo}" /> 
            </div>

        </c:if>


    </c:when>


    <c:otherwise>
        <div class="formulario modoClassico">
            <div class="item">
                <label>Conta nº:</label>
                <input type="text" value="${conta.id}" disabled="disabled" /><br />

            </div>
            <div class="item">
                <label>Nome do cliente:</label>
                <input type="text" value="${conta.clienteNome} ${conta.clienteSobrenome}" disabled="disabled" /><br />
            </div>

        </div>

    </c:otherwise>

</c:choose>
