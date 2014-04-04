/*
 * 
 * 
 */
package servico.bancario;

import classes.Conta;
import classes.ContaPoupanca;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;

/**
 *
 * @author Tiago Gomes
 */
@Entity
public class Transferencia extends ServicoBancario {

    @ManyToOne
    private Conta contaDestino;

    public Conta getContaDestino() {
        return contaDestino;
    }

    public void setContaDestino(Conta contaDestino) {
        this.contaDestino = contaDestino;
    }

    
    public Transferencia() {
    }

    public Transferencia(Conta contaOrigem, Conta contaDestino, float valor) {
        this.conta = contaOrigem;
        this.contaDestino = contaDestino;
        this.valor = valor;

    }

    @Override
    public void executar() throws Exception {
        Conta contaOrigem = conta;

        if (contaOrigem instanceof ContaPoupanca) {
            if (contaOrigem.getSaldo() < valor) {
                throw new Exception("Saldo indisponível. "
                        + "A poupança não tem o valor de " + valor + ". "
                        + "Saldo: " + contaOrigem.getSaldo());
            }
        }

        contaOrigem.setSaldo(contaOrigem.getSaldo() - valor);
        contaDestino.setSaldo(contaDestino.getSaldo() + valor);
        Conta[] contasParaSalvar = {contaOrigem, contaDestino};
        getDao().salvarVarios(contasParaSalvar);
        getDao().salvar(this);
    }
}
