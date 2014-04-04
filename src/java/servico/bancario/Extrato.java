/*
 * 
 * 
 */
package servico.bancario;

import classes.Conta;
import dao.Dao;
import dao.DaoFactory;
import java.sql.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Tiago Gomes
 */
public class Extrato {

    private Conta conta;
    private Date dataInicio;
    private Date dataFim;

    public Extrato(Conta conta, Date dataInicio, Date dataFim) {
        this.conta = conta;
        this.dataInicio = dataInicio;
        this.dataFim = dataFim;
    }

    public Extrato(Conta conta) {
        this.conta = conta;
    }

    public List<ServicoBancario> getListaServicos() {
        List<ServicoBancario> lista = null;
        try {
            Dao dao = DaoFactory.getDao();
            Session session = (Session) dao.getEntityManager().getDelegate();
            Criteria criteria = session.createCriteria(ServicoBancario.class);
            Criterion cContaId = Restrictions.eq("conta.id", conta.getId());
            Criterion cContaDestinoId = Restrictions.eq("contaDestino.id", conta.getId());
            criteria.add(Restrictions.or(cContaId, cContaDestinoId));
            if (dataInicio != null) {
                criteria.add(Restrictions.between("dataExecucao", dataInicio, dataFim));
            }
            lista = criteria.list();
        } catch (HibernateException he) {
            he.printStackTrace();
        }
        return lista;
    }
}
