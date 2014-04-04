<%-- 
    Document   : conta
    Created on : 29/12/2012, 19:51:14
    Author     : Tiago Donizetti Gomes
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="banco" tagdir="/WEB-INF/tags/banco/" %>
<banco:conta conta="${sessionScope.contaDoUsuario}" 
             modoMini="true"
             modoMini_exibirValorEmConta="true"
             
             
             />
