<%-- 
    Document   : login
    Created on : 28/12/2012, 18:42:34
    Author     : Tiago Donizetti Gomes
--%>

<%@tag description="Login" pageEncoding="ISO-8859-1"%>

<div class="formulario">
    <form id="fLogin" onsubmit="" action="${pageContext.request.requestURI}login" method="post">
        <div class="item">
            <label for="flCPF">CPF:</label>
            <input type="text" name="cpf" id="flCPF" />
        </div>
        <div class="item">
            <label for="flSenha">Senha:</label>
            <input type="password" name="senha" id="flSenha" />
        </div>
        <div class="item">
            <label></label>
            <input id="flSubmit" type="submit" value="Acessar" />
        </div>
        <script type="text/javascript">
            $("#flCPF").mask("999.999.999-99"); 
        </script>
    </form>
</div>