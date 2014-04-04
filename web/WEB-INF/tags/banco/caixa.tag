<%-- 
    Document   : caixa
    Created on : 24/12/2012, 02:54:29
    Author     : Tiago Donizetti Gomes
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@tag description="Caixa eletrônico" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="banco" tagdir="/WEB-INF/tags/banco/" %>
<%@taglib prefix="util" tagdir="/WEB-INF/tags/util/" %>
<%@attribute name="acaoExecutada" type="java.lang.String"%>





<script type="text/javascript">
    var acaoExecutada = '${acaoExecutada}';
    var tela = 'digiteValor';
    var limite = 0;
    <c:if test="${contaDoUsuario.getClass().name == 'classes.ContaCorrente'}">
        limite = <fmt:formatNumber maxIntegerDigits="0" type="number" value="${contaDoUsuario.limite}" />
    </c:if>
</script>




<div class="caixaEletronico">
    <div class="displayConta">
        <banco:conta conta="${contaDoUsuario}" modoMini="true" modoMini_exibirValorEmConta="true"></banco:conta>
    </div>

    <div class="monitor">

    </div>


    <div class="extrator notasAgrupadas">

    </div>

    <div class="extrator2" style="display: none">

    </div>
</div>

<!-- Tela de saque (ela é oculta mesmo) -->
<div style="display: none" id="ocTelaDigiteValor">
    <div>
        Digite o valor a ser sacado:
    </div>
    <div> $ 
        <span id="cxElVC" class="valorRetirado centena"> </span>
        <span id="cxElVD" class="valorRetirado dezena"> </span>
        <span id="cxElVU" class="valorRetirado unidade"> </span>,00 <br />
    </div>
    <br />
    <div class="cxElMsg" style="display: none">
        Confirmar: S ou N ?         
    </div>
</div>




<script type="text/javascript">
    var quantiaDigitada = 0;
    var preparado = false;
    
    switch(acaoExecutada){
        case 'saque':
            $(".monitor").html( $("#ocTelaDigiteValor").html());
            break;
    }
    
    
    
    $("body").keypress(function(event) { 
        switch(event.which){
            case 48:
            case 49:
            case 50:
            case 51:
            case 52:
            case 53:
            case 54:
            case 55:
            case 56:
            case 57:
                if (tela=='digiteValor'){
                    preparado = true;
                    guardarValorDigitado(event.which - 48);
                }                
                break;
            case 115:
            case 13:
                if (acaoExecutada == 'saque'){
                    if (tela=='digiteValor'){
                        if (preparado){ 
                            var valorAntigo = ($(".contaMini .valorEmConta").html()) ;
                            valorAntigo = valorAntigo * 1;
                            if (quantiaDigitada <= valorAntigo){
                                processaSaque(quantiaDigitada);
                            } else {
                                alert("Valor não permitido.")
                                mostrarNotas(0)
                            }
                            resetaValorDigitado();
                        }                          
                    }
                }                
                
                break;
            case 120:
                // NÃO
                
                break;
                
            default:                
            
        }
    });
    function resetaValorDigitado(){
        
        $(".cxElMsg").hide();
        preparado = false;
        quantiaDigitada=0;
        $("#cxElVC").html(' ');
        $("#cxElVD").html(' ');
        $("#cxElVU").html(' ');
        
    }
    
    function mostrarNotas(quantia){

        $.ajax({
            url: "ajax/exibirnotas.jsp?valor=" + (quantia*1),
            dataType: "text",
            cache: false,
            success: function(res){ 
                //alert((quantia*1))
                
                //$(".caixaEletronico .extrator").hide();
                //$(".caixaEletronico .extrator").css("height","200px")
                $(".caixaEletronico .extrator").html(res);        
                $(".caixaEletronico .extrator").cycle({
                    fx:        'cover',
                    direction: 'down',
                    speed: 1200,
                    nowrap: 1,
                    continuous: 1       
                });  
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
            }
                        
        });
    }
    
    function processaSaque(valor){
        
        $(".cxElMsg").unblink();
        $.ajax({
            url: "operacao?retorno=contaAtualizada&acao=sacar&ajax=sim&valor=" + quantiaDigitada,
            dataType: "text",
            cache: false,
            success: function(res){ 
                $(".caixaEletronico .displayConta").html(res)
                $(".caixaEletronico .contaMini").effect("shake", { times:6 },200);

                //alert('mostrarNotas: ' + valor)
                
                mostrarNotas(valor);
                      
            
                $(".monitor").html( $("#ocTelaDigiteValor").html());
                
                
                
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                $(".caixaEletronico").css("border","2px solid red")
            }
        });
         
        $(".monitor *").fadeIn(30, function(){
            resetaValorDigitado();
        });
        
    }
    
    
    
    var unOK = 0;
    function guardarValorDigitado(v){
        //if (unOK < 3){
        if (unOK >= 2){
            $("#cxElVC").html($("#cxElVD").html());
        }if (unOK >= 1){
            $("#cxElVD").html($("#cxElVU").html());
        }
        $("#cxElVU").html(v);     
        unOK++;
        $(".cxElMsg").show();
        $(".cxElMsg").blink(300);
        quantiaDigitada = $("#cxElVC").html() + $("#cxElVD").html() + $("#cxElVU").html();

        //}
    }
</script>


