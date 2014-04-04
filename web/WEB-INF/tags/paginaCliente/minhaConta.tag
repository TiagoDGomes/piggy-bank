<%-- 
    Document   : minhaConta
    Created on : 23/12/2012, 01:05:24
    Author     : Tiago Donizetti Gomes
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@tag description="put the tag description here" pageEncoding="ISO-8859-1"%>

<fieldset>
    <legend>Sua conta</legend>
    <dl>
        <dt>Nome do cliente:</dt>
        <dd>${contaDoUsuario.clienteNome} ${contaDoUsuario.clienteSobrenome}</dd>
        <dt>Numero da conta:</dt>
        <dd>${contaDoUsuario.id}</dd>
        <dt>CPF:</dt>
        <dd>${contaDoUsuario.clienteCPF}</dd>
        <dt>Tipo de conta:</dt>
        <dd>${contaDoUsuario.tipo}</dd>
        
    </dl>
</fieldset>

<fieldset>
    <legend>Extrato</legend>
    <div class="extrato">
        <form action="minhaConta" method="post">
            <label for="fDataInicio">De:</label>
            <input class="data" type="text" name="datainicio" id="fDataInicio" value="<fmt:formatDate value="${requestScope.dataInicio}"
                                            type="both"   
                                            pattern="dd/MM/yyyy" />"  />
            <label for="fDataFim">Até:</label>
            <input class="data" type="text" name="datafim" id="fDataFim" value="<fmt:formatDate value="${requestScope.dataFim}"
                                            type="both"   
                                            pattern="dd/MM/yyyy" />" />
            <input id="fSubmit" type="submit" value="OK" />
            <input type="hidden" name="acao" value="extrato" /> 
            <script type="text/javascript">
                $(".data").mask("99/99/9999");
            </script>
        </form>
    </div>
    <c:choose>
        <c:when test="${!empty extrato}">
            <table class="extrato" style="border: 1px solid black">
                <tr>
                    <th>Data</th>
                    <th>Tipo de operação</th>
                    <th>Nº conta</th> 
                    <th>&nbsp;</th>
                    <th>Valor</th>
                </tr>
                <c:forEach items="${extrato.listaServicos}" var="sb" >
                    <tr>
                        <td class="data dataExecucao">
                            <fmt:formatDate value="${sb.dataExecucao}"
                                            type="both"   
                                            pattern="dd/MM/yyyy" /> 
                        </td>
                        <td class="text tipoOperacao">
                            ${sb.tipo}
                        </td>
                        <td class="numero numeroConta">
                            <c:if test="${sb.getClass().name eq 'servico.bancario.Transferencia'}">
                                ${sb.contaDestino.id}
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${sb.getClass().name eq 'servico.bancario.Transferencia'}">
                                    <c:choose>
                                        <c:when test="${sb.contaDestino.id == contaDoUsuario.id}">
                                            +
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:when test="${sb.getClass().name eq 'servico.bancario.Saque'}">
                                    -
                                </c:when>    
                                <c:when test="${sb.getClass().name eq 'servico.bancario.Deposito'}">
                                    +
                                </c:when>
                            </c:choose>
                        </td>
                        <td  class="dinheiro valor">
                            <fmt:formatNumber value="${sb.valor}"  minFractionDigits="2" />
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td class="text" colspan="4">Saldo atual:</td>
                    <td class="dinheiro valor">
                        <strong> 
                            <fmt:formatNumber value="${contaDoUsuario.saldo}" minFractionDigits="2" />
                        </strong>
                    </td>
                </tr>
            </table>


        </c:when>          

        <c:otherwise>

        </c:otherwise>
    </c:choose>
</fieldset>