/*
 * 
 * 
 */
package servlets.banco.paginas;

import classes.Conta;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import servico.bancario.Extrato;
import util.Util;

/**
 *
 * @author Tiago Gomes
 */
public class MinhaConta extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = Util.nullToString(request.getParameter("acao"));
        Conta contaDoUsuario = (Conta) request.getSession().getAttribute("contaDoUsuario");

        if (acao.equals("extrato")) {
            Extrato t;
            if (request.getParameter("datainicio") == null || request.getParameter("datainicio").equals("")) {
                t = new Extrato(contaDoUsuario);
            } else {
                Date dataInicio = Util.nullToDate(request.getParameter("datainicio"));
                Date dataFim = Util.nullToDate(request.getParameter("datafim"));
                t = new Extrato(contaDoUsuario, dataInicio, dataFim);
                request.setAttribute("dataInicio", dataInicio);
                request.setAttribute("dataFim", dataFim);
            }
            request.setAttribute("extrato", t);
        }

        request.getRequestDispatcher("/bank/?pagina=mc").forward(request, response);
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
