/*
 * 
 * 
 */
package util;

import classes.*;
import dao.Dao;
import dao.DaoFactory;
import java.util.List;
import servico.bancario.Deposito;
import servico.bancario.Extrato;
import servico.bancario.ServicoBancario;

/**
 *
 * @author Tiago Gomes
 */
public class Teste {
    public static void main(String[] args) {
        dao.Dao<Conta> daoCC = DaoFactory.getDao();
        Conta c1 =  (Conta) daoCC.carregar(Conta.class,1l);
//        System.out.println(c1.getSaldo());
//        Conta c1 = new ContaPoupanca();
//        c1.setClienteNome("Teste");
//        c1.setSaldo(100f);
//        daoCC.salvar(c1);
//       dao.Dao<servico.bancario.Deposito> dao = DaoFactory.getDao();
//        Extrato t = (Extrato) dao.carregar(Extrato.class, 21);
//        for (ItemExtrato it : t.getListaAcoes()){
//            System.out.println(t);
//        }
        Extrato et = new Extrato(c1);
        List<ServicoBancario> lista = et.getListaServicos() ;
        for (ServicoBancario sb : lista){
            System.out.println(sb.getValor());
        }
        }
}
