//package runner;
//
//import com.intuit.karate.Results;
//import com.intuit.karate.Runner;
//import org.junit.jupiter.api.Assertions;
//import org.junit.jupiter.api.Test;
//
//public class ParallelKarateRunner {
//    @Test
//    public void runFeaturesInParallel() {
//        // Número de hilos configurable vía -Dkarate.threads=10 (por defecto 5)
//        int threads = Integer.getInteger("karate.threads", 5);
//
//        // Ejecuta todas las features bajo src/test/resources/feature en paralelo
//        Results results = Runner.path("classpath:feature").parallel(threads);
//
//        // Imprime resumen en consola
//        System.out.println("Total tests: " + results.getFeaturesTotal());
//        System.out.println("Failed: " + results.getFailCount());
//        if (results.getFailCount() > 0) {
//            System.out.println(results.getErrorMessages());
//        }
//
//        // Falla el test si hay fallos
//        Assertions.assertEquals(0, results.getFailCount(), results.getErrorMessages());
//    }
//}
