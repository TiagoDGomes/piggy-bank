/*
 * 
 * 
 */
package util;

import classes.ContaCorrente;
import java.lang.reflect.Field;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.InputMismatchException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tiago Gomes
 */
public class Util {

    public static String nullToString(String v) {
        if (v == null) {
            return "";
        }
        return v;
    }

    public static double nullToDouble(String v) {
        if (v == null || v.equals("")|| v.equals("NaN")) {
            return 0d;
        }
        return Double.valueOf(v);
    }

    public static int nullToInteger(String v) {
        if (v == null || v.equals("")|| v.equals("NaN")) {
            return 0;
        }
        return Integer.valueOf(v);
    }

    public static float nullToFloat(String v) {
        if (v == null || v.equals("") || v.equals("NaN")) {
            return 0;
        }
        return Float.valueOf(v);
    }

    public static Date nullToDate(String v) {
        if (v == null|| v.equals("") || v.equals("NaN")) {
            return new Date(0);
        }
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date data = null;
        try {
            data = formatador.parse(v);
        } catch (ParseException ex) {
            Logger.getLogger(Util.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new Date(data.getTime());
    }
    public static boolean isCPF(String cpf) {
        //<editor-fold defaultstate="collapsed" desc="Validar CPF">
        // considera-se erro CPF's formados por uma sequencia de numeros iguais
        if (cpf.equals("00000000000") || cpf.equals("11111111111")
                || cpf.equals("22222222222") || cpf.equals("33333333333")
                || cpf.equals("44444444444") || cpf.equals("55555555555")
                || cpf.equals("66666666666") || cpf.equals("77777777777")
                || cpf.equals("88888888888") || cpf.equals("99999999999")
                || (cpf.length() != 11)) {
            return (false);
        }
        
        char dig10, dig11;
        int sm, i, r, num, peso;
        
        // "try" - protege o codigo para eventuais erros de conversao de tipo (int)
        try {
            // Calculo do 1o. Digito Verificador
            sm = 0;
            peso = 10;
            for (i = 0; i < 9; i++) {
                // converte o i-esimo caractere do CPF em um numero:
                // por exemplo, transforma o caractere '0' no inteiro 0
                // (48 eh a posicao de '0' na tabela ASCII)
                num = (int) (cpf.charAt(i) - 48);
                sm = sm + (num * peso);
                peso = peso - 1;
            }
            
            r = 11 - (sm % 11);
            if ((r == 10) || (r == 11)) {
                dig10 = '0';
            } else {
                dig10 = (char) (r + 48); // converte no respectivo caractere numerico
            }
            // Calculo do 2o. Digito Verificador
            sm = 0;
            peso = 11;
            for (i = 0; i < 10; i++) {
                num = (int) (cpf.charAt(i) - 48);
                sm = sm + (num * peso);
                peso = peso - 1;
            }
            
            r = 11 - (sm % 11);
            if ((r == 10) || (r == 11)) {
                dig11 = '0';
            } else {
                dig11 = (char) (r + 48);
            }
            
            // Verifica se os digitos calculados conferem com os digitos informados.
            if ((dig10 == cpf.charAt(9)) && (dig11 == cpf.charAt(10))) {
                return (true);
            } else {
                return (false);
            }
        } catch (InputMismatchException erro) {
            return (false);
        }
        
        
        //www.devmedia.com.br/validando-o-cpf-em-uma-aplicacao-java/22097#ixzz2JkaciQb1
        //</editor-fold>
    }
    public static void validar(Object obj) {
    }

    public static void main(String[] args) {
        classes.ContaCorrente c = new ContaCorrente();
        Util.validar(c);
    }

}
