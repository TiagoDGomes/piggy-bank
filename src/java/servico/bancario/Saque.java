/*
 * 
 * 
 */
package servico.bancario;

import classes.Conta;
import classes.ContaPoupanca;
import javax.persistence.Entity;

/**
 *
 * @author Tiago Gomes
 */
@Entity
public class Saque extends ServicoBancario {

    public Saque() {
    }

    public Saque(Conta conta, float valor) {
        this.conta = conta;
        this.valor = valor;
    }

    @Override
    public void executar() throws Exception {
        float valorAtual = conta.getSaldo();
        if (conta instanceof ContaPoupanca) {
            if (valorAtual < valor) {
                throw new Exception("Saldo indisponível. "
                        + "A poupança não tem o valor de " + valor + ". "
                        + "Saldo: " + valorAtual);
            }
        }
        conta.setSaldo(valorAtual - valor);
        getDao().salvar(conta);
        getDao().salvar(this);

    }
}
