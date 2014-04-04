<%-- 
    Document   : deposito
    Created on : 22/12/2012, 20:49:03
    Author     : Tiago Donizetti Gomes
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="banco" tagdir="/WEB-INF/tags/banco/" %>
<%@tag description="Página para realizar deposito" pageEncoding="ISO-8859-1"%>


<div class="formulario">
    <c:choose>
        <c:when test="${empty requestScope.contaDeDestino}">

            <form action="">
                <div class="item">
                    <label for="fNumeroConta">Número da conta:</label>
                    <input type="text" name="numeroConta" id="fNumeroConta" />
                    <input id="fSubmit" type="submit" value="OK" />
                </div>

            </form>

        </c:when>
        <c:otherwise>
            <p>
                Arraste o seu dinheiro para dentro do cofre da conta de destino.
                Para confirmar a transferência, clique no botão verde Concluir.
            </p>
            <script type="text/javascript" src="js/deposito.js"></script>
            <div class="deposito_contaOrigem">
                <h3>Minha conta</h3>
                <banco:conta conta="${contaDoUsuario}" 
                             modoMini="true" 
                             modoMini_exibirNotas="true" 
                             modoMini_exibirValorEmConta="true"
                             modoMini_depositavel="false"
                             modoMini_prefixoIdValorEmConta="vc"
                             />


            </div>
            <div class="deposito_contaDestino">
                <h3>Conta de destino</h3>
                <banco:conta conta="${requestScope.contaDeDestino}" 
                             modoMini="true" 
                             modoMini_depositavel="true"                            
                           
                             modoMini_formulario="true"
                             modoMini_formulario_acao="transferir"
                             modoMini_exibirValorEmConta="true"
                             
                             
                             
                             /> 


            </div>
            <script type="text/javascript">
                    document.getElementById("vd_${requestScope.contaDeDestino.id}").value = 0;
                    document.getElementById("valorEmConta_${requestScope.contaDeDestino.id}").innerHTML = 0 ; 
            </script>
        </c:otherwise>
    </c:choose> 
</div>