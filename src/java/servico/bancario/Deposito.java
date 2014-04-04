/*
 * 
 * 
 */
package servico.bancario;

import classes.Conta;
import javax.persistence.Entity;

/**
 *
 * @author Tiago Gomes
 */
@Entity
public class Deposito extends ServicoBancario {




    public Deposito() {
    }

    public Deposito(Conta conta, float valor) {
        this.conta = conta;
        this.valor = valor;

    }

    @Override
    public void executar() throws Exception {
        
        try { //TODO: tirar o try
            float valorAtual = conta.getSaldo();
            conta.setSaldo(valorAtual + valor);   
            getDao().salvar(conta);
            getDao().salvar(this);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
