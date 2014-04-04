<%-- 
    Document   : index
    Created on : 20/12/2012, 23:29:53
    Author     : Tiago Donizetti Gomes
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="paginaCliente" tagdir="/WEB-INF/tags/paginaCliente/" %>
<%@taglib prefix="paginaNaoCliente" tagdir="/WEB-INF/tags/paginaNaoCliente/" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags/" %>
<%@taglib prefix="banco" tagdir="/WEB-INF/tags/banco/" %>
<%@taglib prefix="util" tagdir="/WEB-INF/tags/util/" %>
<c:set var="browser" value="${header['User-Agent']}" scope="session"/>
<c:set var="velhoIE" value="${(fn:contains(browser,'MSIE 6')) ||
                              (fn:contains(browser,'MSIE 7')) ||
                              (fn:contains(browser,'MSIE 8'))
       }" property="java.lang.Boolean" />
<!DOCTYPE html>
<html>
    <head>
        <title>Piggy Bank - Onde seu dinheiro será bem cuidado</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">     
        <link rel="shortcut icon" href="../img/icon.png" />
        <tag:head />
        <c:if test="${empty param.pagina && !empty sessionScope.contaDoUsuario}">  
            <meta http-equiv="refresh" content="0;URL=minhaConta">
        </c:if>
        <c:if test="${velhoIE}">
            <meta http-equiv="refresh" content="5;URL=https://chrome.google.com">
        </c:if>
    </head>
    <body>
        <c:choose>
            <c:when test="${!velhoIE}">
                <div id="tudo">
                    <header>   
                        <div class="logo">
                        </div>
                        <div class="descricao">
                            <h1 class="nome">
                                <a href="/piggy/bank/">
                                    Piggy Bank
                                </a>
                            </h1>
                            Onde seu dinheiro será bem cuidado
                        </div>
                        <div class="menuNotify" id="msgNotify">
                            <span class="notifyCount" id="msgNotifyCount">
                                ${sessionScope.messageCount}
                            </span>
                        </div>
                        <div id="bemVindoUsuario">
                            <span class="mensagem">Bem-vindo,
                                <c:choose>
                                    <c:when test="${empty sessionScope.contaDoUsuario}">
                                        usuário.
                                        [<a onclick="" href="${pageContext.request.requestURI}login">Acessar conta</a>]  
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.contaDoUsuario.clienteNome}.
                                        [<a href="${pageContext.request.requestURI}logout">Sair</a>]   
                                    </c:otherwise>
                                </c:choose>

                            </span>
                        </div>

                    </header>
                    <c:choose>
                        <c:when test="${empty sessionScope.contaDoUsuario}">
                            <div class="menuOpcoes">
                                <ul>
                                    <li><a href="crieConta">Crie já sua conta</a></li>
                                    <li><a href="deposito">Fazer depósito</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="menuOpcoes">
                                <ul>
                                    <li><a href="minhaConta">Minha conta</a></li>
                                    <li><a href="deposito">Fazer depósito</a></li>
                                    <li><a href="fazerSaque">Sacar meu dinheiro</a></li>
                                    <li><a href="fazerTransferencia">Fazer transferência</a></li>
                                </ul>
                            </div>
                        </c:otherwise>
                    </c:choose> 
                    <div class="msgErroInfo">
                        ${requestScope.msgInfo}
                    </div>
                    <div class="msgErroAlert">
                        ${requestScope.msgErro}
                    </div>
                    <div id="main">
                        <c:choose>
                            <c:when test="${param.pagina == 'crie'}">
                                <h2>Faça agora o seu cadastro</h2>
                                <paginaNaoCliente:cadastro />               
                            </c:when>
                            <c:when test="${param.pagina == 'mc'}">
                                <h2>Minha conta</h2>
                                <paginaCliente:minhaConta />               
                            </c:when>
                            <c:when test="${param.pagina == 'dp'}">
                                <h2>Fazer depósito</h2>
                                <paginaNaoCliente:deposito />               
                            </c:when>
                            <c:when test="${param.pagina == 'sq'}">
                                <h2>Sacar meu dinheiro</h2>
                                <paginaCliente:saque />  
                            </c:when>
                            <c:when test="${param.pagina == 'cc'}">
                                <h2>Conta corrente</h2>
                            </c:when>
                            <c:when test="${param.pagina == 'pp'}">
                                <h2>Poupança</h2>
                            </c:when>
                            <c:when test="${param.pagina == 'tf'}">
                                <h2>Transferência</h2>
                                <paginaCliente:transferencia />               
                            </c:when>
                            <c:when test="${param.pagina == 'login'}">
                                <h2>Acesse a sua conta</h2>
                                <paginaNaoCliente:login />               
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${empty sessionScope.contaDoUsuario}">
                                        <h2>Venha para o Piggy Bank!</h2>
                                        <img src="../img/pensativa.jpg" alt="Pensativa" style="float: left" />
                                        <p>
                                            Você ainda está pensando em onde guardar o seu dinheiro? 
                                            Venha fazer parte do Piggy Bank!
                                        </p>
                                        <p>
                                            Veja as vantagens de deixar o seu dinheiro conosco:
                                        </p>
                                        <ul>
                                            <li>depósitos e saques com simplicidade</li>
                                            <li>seu dinheiro é tratado com carinho</li>
                                        </ul>
                                        <p>Clique <a href="crieConta">aqui</a> e cadastre-se agora mesmo!</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p>Redirecionando...</p>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <c:if test="${param.pagina == 'dp'}">
                        <div class="dinheiroEmMaos">
                            
                            <h4>$<fmt:formatNumber value="${sessionScope.dm_saldo}"  minFractionDigits="2" /> em mãos</h4>
                            <div class="notasAgrupadas">
                                <util:mostrarNotas quantidade="${sessionScope.dm_saldo}" />
                            </div>
                        </div>
                    </c:if>



                    <tag:rodape />
                </div>
            </c:when>
            <c:otherwise>
                <h2>
                    Você está usando um navegador desatualizado que gera
                    erros bizarros. Eu, se fosse você, trocaria agora para um
                    navegador que suporta HTML5.
                </h2>
            </c:otherwise>
        </c:choose>

    </body>
</html>
