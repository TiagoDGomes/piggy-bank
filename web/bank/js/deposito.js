function selecionarNota(nota){
    $(nota).css("z-index","1")

}
    
function prepararDeposito(numeroConta, valor){
    var valorParaSerDepositado = document.getElementById("vd_" + numeroConta).value * 1 + valor * 1;
    document.getElementById("vd_" + numeroConta).value = valorParaSerDepositado;
    document.getElementById("valorEmConta_" + numeroConta).innerHTML = valorParaSerDepositado ;
}
                    
                    
function fazerDeposito(numeroConta, valor){
    var valorEmConta;
    // // aqui vai o AJAX para o depósito
    // ...
    // // aqui vai o AJAX para retornar o valor em conta
    valorEmConta = document.getElementById("valorEmConta_" + numeroConta).innerHTML; // [temporário]
                        
                        
    valorEmConta = ((valorEmConta) * 1 + (valor) * 1);                                                
    document.getElementById("valorEmConta_" + numeroConta).innerHTML = valorEmConta ;
}                    
/*
$('.notas').cycle({ 
    fx:   'cover',
    direction: 'down', // one of up|down|left|right  default=left
    speed:  400,
    continuous: 1,
    nowrap:  1,
    width:  1000,
    end: function(){
        $('.notaDinheiro').css("", "");
    }

});
 */
$(function() {

    $( ".notaDinheiro, .moeda" ).draggable({
        start: function( event, ui ){  
            $(event.target).css("z-index","2");
        }
        
    });
 /*   
    $( ".notaDinheiro, .moeda" ).on("mouseover",function( event, ui ){  
        $(event.target).css("margin-left","10px");
        $(event.target).css("margin-top","-5px");
    });
    $( ".notaDinheiro, .moeda" ).on("mouseout",function( event, ui ){  
        $(event.target).css("margin-left","0px");
        $(event.target).css("margin-top","0px");
        
    });
    
   */ 
    
    $( ".localDeposito" ).droppable({
        accept: ".notaDinheiro, .moeda" ,
        over: function( event, ui ){
            $(event.target).css("border","2px dashed green");
           
        },
        out: function( event, ui ){
            $(event.target).css("border","2px dotted silver");
        },
        drop: function( event, ui ) {                
            $(ui.draggable).hide();
            $(event.target).css("border","2px solid white");
        }
    });
});
    
var valorEmMao = 0;
function segurarNota(quantidade){    
    valorEmMao = quantidade;
   // alert('segurarNota' + quantidade)
}
function eventPassarSobre(ev){
    ev.preventDefault();
}
function soltarNota(numeroConta){ 
    prepararDeposito(numeroConta, valorEmMao);
    valorEmMao = 0;
}
