/*
 * 
 * 
 */
package classes;

import java.io.Serializable;
import java.sql.Date;
import java.util.InputMismatchException;
import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import util.Util;

@Entity(name = "Conta")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "TipoConta", discriminatorType = DiscriminatorType.INTEGER, length = 2)
@NamedQueries({
    @NamedQuery( name = "Conta.login", query = "from Conta where clienteCPF = :cpf and senha = :senha"),
    @NamedQuery( name = "Conta.findByCpf", query = "from Conta where clienteCPF = :cpf"),
    @NamedQuery( name = "Conta.findById", query = "from Conta where id = :id")
})
public abstract class Conta implements Serializable {

    @Id
    @GeneratedValue
    private Long id;
    private float saldo;
    private String clienteNome;
    private String clienteSobrenome;
    @Column(unique = true)
    private String clienteCPF;
    @Column(unique = true)
    private String clienteRG;
    private java.sql.Date clienteDataNasc;
    private String senha;

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getClienteRG() {
        return clienteRG;
    }

    public void setClienteRG(String clienteRG) {
        this.clienteRG = clienteRG;
    }

    public String getClienteCPF() {
        return clienteCPF;
    }

    public void setClienteCPF(String clienteCPF) {
        if (Util.isCPF(clienteCPF.replace(".", "").replace("-", ""))){
            this.clienteCPF = clienteCPF;
        } else {
            System.err.println(clienteCPF + " inválido!");
            throw new Error("CPF inválido");
        }        
    }

    public Date getClienteDataNasc() {
        return clienteDataNasc;
    }

    public void setClienteDataNasc(Date clienteDataNasc) {
        this.clienteDataNasc = clienteDataNasc;
    }

    public String getClienteNome() {
        return clienteNome;
    }

    public void setClienteNome(String clienteNome) {
        this.clienteNome = clienteNome;
    }

    public String getClienteSobrenome() {
        return clienteSobrenome;
    }

    public void setClienteSobrenome(String clienteSobrenome) {
        this.clienteSobrenome = clienteSobrenome;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public float getSaldo() {
        return saldo;
    }

    public void setSaldo(float saldo) {
        this.saldo = saldo;
    }

    @Override
    public String toString() {
        return "{\"Conta\":{"
                + "  \"id\": " + id
                + ", \"clienteNome\": \"" + clienteNome
                + "\", \"clienteSobrenome\" : \"" + clienteSobrenome
                + "\", \"clienteCPF\" : \"" + clienteCPF
                + "\", \"clienteDataNasc\" : \"" + clienteDataNasc
                + "\", \"tipoConta\" : \"" + this.getClass().getSimpleName()
                + "\"}}";
    }
    public String getTipo(){
        return this.getClass().getSimpleName();
    }

}
