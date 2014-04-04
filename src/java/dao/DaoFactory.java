
package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author David Buzatto
 */
public class DaoFactory {

    private static EntityManagerFactory factory;

    public static <T> Dao<T> getDao() {
        if (factory == null) {
            factory = Persistence.createEntityManagerFactory("BancoPU");
        }
        return new Dao<T>(factory.createEntityManager());
    }
}
