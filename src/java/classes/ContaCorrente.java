/*
 * 
 * 
 */
package classes;

import javax.persistence.Entity;

/**
 *
 * @author Tiago Gomes
 */
@Entity(name="ContaCorrente")
public class ContaCorrente extends Conta {

    private float limite;

    public float getLimite() {
        return limite;
    }

    public void setLimite(float limite) {
        this.limite = limite;
    }
}
