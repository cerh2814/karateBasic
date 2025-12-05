package runner;


import com.intuit.karate.junit5.Karate;

public class TestRunner {
    @Karate.Test
    public Karate runCreateProductFeature() {
        // Asume: src/test/resources/feature/createnewproduct.feature
        return Karate.run("classpath:feature/conduit/tags.feature").relativeTo(getClass());
    }

//    @Karate.Test
//    public Karate testAll() {
//        return Karate.run().relativeTo(getClass());
//    }
////
//    @Karate.Test
//    public Karate runCreateProductFeature() {
//        // Asume: src/test/resources/feature/createnewproduct.feature
//        return Karate.run("classpath:feature/conduit.feature").relativeTo(getClass());
//    }
//
//    @Karate.Test
//    public Karate testags() {
//        // Asume: src/test/resources/feature/createnewproduct.feature
//        return Karate.run().tags("@debug").relativeTo(getClass());
//    }
}