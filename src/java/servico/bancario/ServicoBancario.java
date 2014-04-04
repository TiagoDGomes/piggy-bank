/*
 * 
 * 
 */
package servico.bancario;

import classes.Conta;
import dao.Dao;
import dao.DaoFactory;
import java.io.Serializable;
import java.sql.Date;
import java.util.Calendar;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.ManyToOne;
import javax.persistence.Query;

/**
 *
 * @author Tiago Gomes
 */
@Entity(name = "Movimentacao")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "TipoMovimento")
public abstract class ServicoBancario implements Serializable {

    @Id
    @GeneratedValue
    private Long ID;

    public abstract void executar() throws Exception;
    @ManyToOne
    protected Conta conta;
    protected float valor;
    protected Date dataExecucao = new Date(Calendar.getInstance().getTimeInMillis());
    private static transient dao.Dao daoSB ;

    public static Dao getDao() {
        if (daoSB == null ) {
            setDao(DaoFactory.getDao());
        }
        return daoSB;
    }

    public static void setDao(Dao daoSB) {
        ServicoBancario.daoSB = daoSB;
    }

    public String getTipo(){
        return this.getClass().getSimpleName();
    }
    
    public Date getDataExecucao() {
        return dataExecucao;
    }

    public void setDataExecucao(Date dataExecucao) {
        this.dataExecucao = dataExecucao;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public Conta getConta() {
        return conta;
    }

    public void setConta(Conta conta) {
        this.conta = conta;
    }

    public ServicoBancario() {
    }

    public ServicoBancario(Conta conta) {
        this.conta = conta;
    }

    public static Conta obterContaPeloNumero(Long id) {
        Conta c = (Conta) getDao().carregar(Conta.class, id);
        return c;
    }

    public static Conta getContaPeloNumero(Long id){
        return obterContaPeloNumero(id);
    }
    
    public static void fazerCadastro(Conta novaConta) {
        getDao().salvar(novaConta);
    }

    public static Conta autenticar(String cpf, String senha) {
        Query q = getDao().createNamedQuery("Conta.login");
        q.setParameter("cpf", cpf);
        q.setParameter("senha", senha);
        Conta c = null;
        try {
            c = (Conta) q.getSingleResult();
            getDao().atualizar(c);
        } catch (Exception e) {
        }

        return c;
    }

    public Long getID() {
        return ID;
    }

    public void setID(Long ID) {
        this.ID = ID;
    }


}
