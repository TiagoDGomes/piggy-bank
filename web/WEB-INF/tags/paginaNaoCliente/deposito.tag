<%-- 
    Document   : deposito
    Created on : 23/12/2012, 01:05:07
    Author     : Tiago Donizetti Gomes
--%>
<%@taglib prefix="util" tagdir="/WEB-INF/tags/util/" %>
<%@taglib prefix="banco" tagdir="/WEB-INF/tags/banco/" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="Dep�sito de dinheiro que est� em m�os" pageEncoding="ISO-8859-1"%>


<c:choose>
    <c:when test="${(! empty sessionScope.dm_saldo || sessionScope.dm_saldo > 0 )}">

        <c:choose>
            <c:when test="${empty param.numeroConta}">
                <div class="formulario">
                    <form action="">
                        <div class="item">
                            <label for="fNumeroConta">N�mero da conta:</label>
                            <input type="text" name="numeroConta" id="fNumeroConta" /><input id="fSubmit" type="submit" value="OK" />
                        </div>
                        <div class="item">
                            <label></label>
                            
                            <c:if test="${!empty contaDoUsuario}">
                                <a href="?numeroConta=${contaDoUsuario.id}">Quero depositar em minha conta</a>
                            </c:if>
                        </div>


                    </form>

                </div>

            </c:when>
            <c:otherwise>

                <div class="formulario">
                    <p>Esta � a conta de destino que voc� escolheu. 

                        Arraste o dinheiro a ser depositado para dentro do cofre da conta.
                        Para confirmar o dep�sito, clique no bot�o verde Concluir.
                    </p>
                    <div class="deposito_contaDestino">
                        <h3>Conta de destino</h3>
                        <banco:conta conta="${requestScope.contaDeDestino}" 
                                     modoMini="true" 
                                     modoMini_depositavel="true" 
                                     modoMini_formulario="true"
                                     modoMini_formulario_acao="depositar" /> 
                        <script type="text/javascript">
                            document.getElementById("vd_${param.numeroConta}").value = 0;
                            document.getElementById("valorEmConta_${param.numeroConta}").innerHTML = 0 ; 
                        </script>

                    </div>
                </div>


            </c:otherwise>
        </c:choose> 


        <script type="text/javascript" src="js/deposito.js"></script>




    </c:when>
    <c:otherwise>
        <p>
            Oops! Parece que voc� n�o tem nenhum dinheiro em m�os para
            fazer um depos�to.
        </p>
        <p>Mas n�o tem problema. N�s temos algumas 
            op��es para voc�:
        </p>        
        <ul>
            <li><a href="/piggy/games">Piggy Games</a> - Um site de jogos onde voc� 
                pode conseguir um dinheirinho
            </li>
        </ul>
    </c:otherwise>
</c:choose>