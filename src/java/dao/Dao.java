
package dao;

import java.util.List;
import javax.persistence.*;

/**
 *
 * @author David Buzatto
 */
public class Dao<T extends Object> {

    private EntityManager entityManager;

    public Dao(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    /**
     * Salva ou atualiza uma instância de uma classe mapeada na unidade de
     * persistência.
     *
     * @param obj Objeto a ser salvo ou atualizado.
     */
    public void salvar(T obj) {

        EntityTransaction t = entityManager.getTransaction();        
        try {
            t.begin();
            entityManager.persist(obj);
            t.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                t.rollback();
            } catch (Exception ee) {
            }
        }

    }

    /**
     * Salva ou atualiza v�rias inst�ncias de uma classe mapeada na unidade de
     * persist�ncia.
     *
     * @param obj Objeto a ser salvo ou atualizado.
     */
    public void salvarVarios(T[] objs) {

        EntityTransaction t = entityManager.getTransaction();
        try {
            t.begin();
            for (T obj : objs) {
                entityManager.persist(obj);
            }
            t.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                t.rollback();
            } catch (Exception ee) {
            }
        }
    }

    /**
     * Exclui uma instância de uma classe mapeada na unidade de persistência.
     *
     * @param obj Objeto a ser excluído.
     */
    public void excluir(T obj) {

        EntityTransaction t = entityManager.getTransaction();
        t.begin();

        entityManager.remove(obj);

        t.commit();

    }

    /**
     * Atualiza a os atributos e a hierarquia de uma instância de um objeto.
     *
     * @param obj Objeto a ser atualizado.
     */
    public void atualizar(T obj) {

        EntityTransaction t = entityManager.getTransaction();
        t.begin();

        entityManager.refresh(obj);

        t.commit();

    }  
    /**
     * Atualiza a os atributos e a hierarquia de uma instância de um objeto.
     *
     * @param obj Objeto a ser atualizado.
     */
    public void atualizarVarios(T[] objs) {

        EntityTransaction t = entityManager.getTransaction();
        try {
            t.begin();
            for (T obj : objs) {
                entityManager.refresh(obj);
            }
            t.commit();
        } catch (Exception e) {
            e.printStackTrace();
            t.rollback();
        }

    }

    /**
     * Carrega um objeto de uma determinada classe mapeada na unidade de
     * persistência, usando como base o identificador do objeto.
     *
     * @param klass Classe mapeada.
     * @param id Identificador do objeto da classe mapeada.
     * @return O objeto com o identificador especificado.
     */
    public T carregar(Class klass, Object id) {
        return (T) entityManager.find(klass, id);
    }

    /**
     * Carrega todos os objetos de uma determinada classe mapeada na unidade de
     * persistência.
     *
     * @param klass Classe mapeada.
     * @return Lista de objetos da classe mapeada.
     */
    public List<T> carregarTodos(Class klass) {
        return (List<T>) entityManager.createQuery(
                "from " + klass.getSimpleName()).getResultList();
    }public List<T> carregarTodos(String klass) {
        return (List<T>) entityManager.createQuery(
                "from " + klass).getResultList();
    }

    /**
     * Cria uma namedQuery.
     *
     * @param namedQuery Nome da query a ser criada.
     * @return Query.
     */
    public Query createNamedQuery(String namedQuery) {
        return entityManager.createNamedQuery(namedQuery);
    }

    /**
     * Executa uma query genérica.
     *
     * @param query Query a ser executada.
     * @return Lista de objetos resultantes.
     */
    public List query(String query) {
        return entityManager.createQuery(query).getResultList();
    }

    /**
     * Cria uma query genérica.
     *
     * @param query Query a ser criada.
     * @return Query criada.
     */
    public Query createQuery(String query) {
        return entityManager.createQuery(query);
    }

    /**
     * Obtém o gerenciados de entidades usado neste Dao.
     *
     * @return Gerenriador de entidades usado no Dao.
     */
    public EntityManager getEntityManager() {
        return entityManager;
    }

    /**
     * Fecha o gerenciador de entidades desse Dao.
     */
    public void fecharEntityManager() {
        entityManager.close();
    }
}
