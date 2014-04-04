<%-- 
    Document   : cadastro
    Created on : 23/12/2012, 01:15:04
    Author     : Tiago Donizetti Gomes
--%>

<%@tag description="Pagina de cadastro de cliente e conta" pageEncoding="ISO-8859-1"%>


<div class="formulario cadastro">
    <form id="fCadastro" onsubmit="" action="${pageContext.request.requestURI}cadastro" method="post">
        <div class="item">
            <label for="fNome">Nome:</label>
            <input type="text" name="nome" id="fNome" />
        </div>

        <div class="item">
            <label for="fSobrenome">Sobrenome:</label>
            <input type="text" name="sobrenome" id="fSobrenome" />
        </div>

        <div class="item">
            <label for="fDataNasc">Data de Nasc.:</label>
            <input type="text" name="dataNasc" id="fDataNasc" />
        </div>

        <div class="item">
            <label for="fCPF">CPF: </label>
            <input type="text" name="cpf" id="fCPF" />
        </div>
        <div class="item">
            <label for="fRG">RG: </label>
            <input type="text" name="rg" id="fRG" />
        </div>
        <div class="item">
            <label>Tipo de conta: </label>
            <input type="radio" id="fCC" name="tipoConta" value="CC" />
            <label for="fCC">Conta corrente </label><br />
        </div>
        <div class="item">
            <label></label>
            <input type="radio" id="fPP" name="tipoConta" value="PP" />
            <label for="fPP">Poupança</label>
        </div>
        <div class="item">
            <label for="fSenha">Senha para acesso: </label>
            <input type="password" name="senha" id="fSenha" />
        </div>
        <div class="item">
            <label></label>
            <input id="fSubmit" type="submit" value="Concluir cadastro" />
        </div>
        <div class="status" style="display: none">
            <img src="${pageContext.request.requestURI}../img/loading.gif" alt="Aguarde..." />
        </div>
        <script type="text/javascript">
            $("#fDataNasc").mask("99/99/9999");
            $("#fCPF").mask("999.999.999-99"); 
        </script>
    </form>  
</div>





<script type="text/javascript">   
    function aoEnviar(t) {                                                                       
        var d = jQuery(t).serialize(); // Dados do formulário     
        $("#fSubmit").hide();
        $(".status").fadeIn();
        // Envia o formulário via Ajax
        jQuery.ajax({
            type: "POST",
            url: t.action + "",
            data: d,
            dataType: "json",
            cache: false,
            success: function(json){ 
                if(json.Conta.id==0){
                    $(".status").html("<strong>Cadastro feito com sucesso. \n\
                                       Clique <a href=\"?pagina=mc\">aqui</a>\n\
                                       para visualizar a sua conta.</strong>")
                }else{
                    
                }
                
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                alert("Erro no envio! " + textStatus);
                $("#fSubmit").show();
            }
        });
        return false; // Previne o form de ser enviado pela forma normal
    }
    
    
    
    
</script>
