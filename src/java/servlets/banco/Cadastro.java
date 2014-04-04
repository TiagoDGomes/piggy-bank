/*
 * 
 * 
 */
package servlets.banco;

import classes.Conta;
import classes.ContaCorrente;
import classes.ContaPoupanca;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import servico.bancario.ServicoBancario;
import util.Util;

/**
 *
 * @author Tiago Gomes
 */
public class Cadastro extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean ajax = (Util.nullToString(request.getParameter("ajax")).equals("sim"));
        String formato = (Util.nullToString(request.getParameter("formato")));
        Conta novaConta = null;
        try {
            String tipoConta = Util.nullToString(request.getParameter("tipoConta"));

            if (tipoConta.equals("CC")) {
                novaConta = new ContaCorrente();
            } else if (tipoConta.equals("PP")) {
                novaConta = new ContaPoupanca();
            }
            
            novaConta.setClienteNome(
                    request.getParameter("nome"));            
            novaConta.setClienteSobrenome(
                    request.getParameter("sobrenome"));
            novaConta.setClienteCPF(
                    request.getParameter("cpf"));
            novaConta.setClienteDataNasc(
                    Util.nullToDate(request.getParameter("dataNasc")));
            novaConta.setSenha(
                    request.getParameter("senha"));
            novaConta.setClienteRG(
                    request.getParameter("rg"));


            
            ServicoBancario.fazerCadastro(novaConta);
        } catch (Exception e) {
            novaConta = null;
            e.printStackTrace();
        } finally {
            // TODO: fazer checagem do novo cliente
            //if (novaConta.getId()!= 0){
            HttpSession session = request.getSession();
            session.setAttribute("contaDoUsuario", novaConta);

            //}

            if (ajax) {

                PrintWriter out = response.getWriter();
                if (formato.equals("json")) {
                    response.setContentType("application/json");
                    out.println(novaConta);
                }
                out.close();
            } else {
                RequestDispatcher rd;
                if (novaConta == null) {
                    request.setAttribute("msgErro", "Erro no cadastro");
                    rd = request.getRequestDispatcher("/bank/crieConta");
                    
                            
                } else {
                    rd = request.getRequestDispatcher("/bank/minhaConta");
                }
                rd.forward(request, response);
            }



        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
