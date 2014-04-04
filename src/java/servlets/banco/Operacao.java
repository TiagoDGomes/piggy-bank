/*
 * 
 * 
 */
package servlets.banco;

import classes.Conta;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import servico.bancario.Deposito;
import servico.bancario.Saque;
import servico.bancario.ServicoBancario;
import servico.bancario.Transferencia;
import util.Util;

/**
 *
 * @author Tiago Gomes
 */
public class Operacao extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        boolean ajax = (Util.nullToString(request.getParameter("ajax")).equals("sim"));
        String retorno = Util.nullToString(request.getParameter("retorno"));
        float saldoAtual = 0;
        String paginaRetorno = "";


        Exception ex = null;
        try {
            String acao = Util.nullToString(request.getParameter("acao"));
            HttpSession session = request.getSession();
            Conta contaDoUsuario = (Conta) session.getAttribute("contaDoUsuario");

            float valor = Util.nullToFloat(request.getParameter("valor"));
            ServicoBancario servico;

            if ("depositar".equals(acao)) {
                Long numeroDaConta = Long.valueOf(Util.nullToString(request.getParameter("numeroConta")));

                Conta contaDestino = ServicoBancario.obterContaPeloNumero(numeroDaConta);
                if (contaDestino != null) {
                    servico = new Deposito(contaDestino, valor);
                    saldoAtual = valor;
                    float saldoOrigemAnterior = 0;
                    if (valor > 0) {
                        session = request.getSession();
                        saldoOrigemAnterior = (Float) session.getAttribute("dm_saldo");
                    }
                    servico.executar();
                    session.setAttribute("dm_saldo", saldoOrigemAnterior - valor);
                    request.setAttribute("msgInfo", "Seu dinheiro foi depositado! "
                            + "A conta de destino foi acrescida em $" + String.format("%.2f",valor) + ".");
                    paginaRetorno = "deposito";
                }
            } else {
                if (contaDoUsuario != null) {
                    if ("sacar".equals(acao)) {
                        servico = new Saque(contaDoUsuario, valor);
                        servico.executar();
                        request.setAttribute("msgInfo", "Seu dinheiro foi sacado!");
                        float saldoOrigemAnterior = 0;
                        try {
                            saldoOrigemAnterior = (Float) session.getAttribute("dm_saldo");
                        } catch (Exception e) {
                        }
                        session.setAttribute("dm_saldo", saldoOrigemAnterior + valor);
                        paginaRetorno = "fazerSaque";
                    } else if ("transferir".equals(acao)) {
                        Long numeroDaConta = Long.valueOf(Util.nullToString(request.getParameter("numeroConta")));
                        Conta contaDestino = ServicoBancario.obterContaPeloNumero(numeroDaConta);
                        if (contaDestino != null) {
                            servico = new Transferencia(contaDoUsuario, contaDestino, valor);
                            servico.executar();
                            request.setAttribute("msgInfo", "Seu dinheiro foi transferido! "
                                    + "A conta de destino foi acrescida em $" + String.format("%.2f",valor) + ".");
                            paginaRetorno = "fazerTransferencia";
                        }
                    }
                    saldoAtual = contaDoUsuario.getSaldo();
                } else {
                    out.println("O que você está fazendo?");

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ajax) {
                response.setContentType("text/plain");
                if (retorno.equals("saldoAtual")) {
                    out.println(saldoAtual);
                } else if (retorno.equals("contaAtualizada")) {
                    request.getRequestDispatcher("/bank/ajax/minhaconta.jsp").forward(request, response);
                }
                out.close();
            } else {
                //  if (ex != null) {
                request.getRequestDispatcher(paginaRetorno).forward(request, response);
                //   }
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
