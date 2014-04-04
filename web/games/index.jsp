<%-- 
    Document   : index
    Created on : 22/12/2012, 21:28:30
    Author     : Tiago Donizetti Gomes
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="game" tagdir="/WEB-INF/tags/games/" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags/" %>
<!DOCTYPE html>
<html>
    <head>
        <title>
            Piggy Games - Onde você consegue dinheiro para colocar na sua conta bancária
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <tag:head />

        <script type="text/javascript">
            function eventAdicionarValor(valor){
                $("#moneyNotifyCount").hide(); 
                $.ajax({
                    url: '/piggy/ncliente/saldo?ajax=sim&tipo=add&valor=' + valor  
                        + "&rnd=" + (Math.random()*10) , // Math.random() = bug no Explorer
                    success: function(data) {
                        $("#moneyNotifyCount").html('+' + valor);
                        $("#moneyNotifyCount").fadeIn('slow',function(){
                            $("#moneyNotifyCount").hide('fast', function(){
                                $("#moneyNotifyCount").html(data);
                                $("#moneyNotifyCount").fadeIn('slow',function(){
                                    
                                }); 
                            }); 
                        });                        
                                 
                    },
                    error: function() {
                        if (confirm("Erro ao definir o seu saldo. Deseja tentar novamente?")){
                            eventAdicionarValor(valor);
                        }
                    }
                    
                });
                
            }
        </script>

        
        <link rel="stylesheet" href="../css/games.css" /> 
    </head>
    <body>
        <div id="tudo">


            <header>   
                <div class="logo">

                </div>
                <div class="descricao">
                    <h1 class="nome"><a href="/piggy/games/">Piggy Games</a></h1>
                    Onde você consegue dinheiro para colocar na sua conta bancária

                </div>

                <div class="menuNotify" id="moneyNotify">
                    <span class="notifyCount dinheiroValor" id="moneyNotifyCount">
                        ${sessionScope.dm_saldo}
                    </span>
                </div>

            </header>
            <div id="main">
                <c:choose>

                    <c:when test="${param.jogo == 'tetris'}">
                        <h2>Tetris</h2>
                        <game:tetris />                    
                    </c:when>

                    <c:otherwise>
                        <h2>Piggy Games</h2>
                        <div class="menuJogos">
                            <div class="gameItem">
                                <img class="logo" src="../games/tetris/tetrisp4.gif" alt="Tetris" />
                                <h3 class="jogo_nome">
                                    <a href="?jogo=tetris">Tetris</a>
                                </h3>
                                <div class="descricao">
                                    Clássico jogo de Tetris
                                </div>
                            </div>                    
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
            <tag:rodape />



        </div>
    </body>
</html>
