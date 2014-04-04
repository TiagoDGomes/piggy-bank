/*
 * 
 * 
 */
package servlets.pessoaNaoCliente;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.Util;

/**
 *
 * @author Tiago Gomes
 */
public class Saldo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        float saldo;
        boolean ajax = (Util.nullToString(request.getParameter("ajax")).equals("sim"));
        HttpSession session = request.getSession();
        if (session.getAttribute("dm_saldo") == null) {
            saldo = 0;
        } else {
            saldo = (Float) session.getAttribute("dm_saldo");
        }
        try {
            float valor = Integer.parseInt(request.getParameter("valor"));
            String tipo = request.getParameter("tipo");
            if (tipo.equals("add")) {
                saldo += valor;
            } else {
                saldo = valor;
            }
            session.setAttribute("dm_saldo", saldo);
        } catch (Exception e) {
        } finally {
            if (ajax) {
                response.setContentType("text/plain");
                PrintWriter out = response.getWriter();
                out.println(saldo);
                out.close();
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
