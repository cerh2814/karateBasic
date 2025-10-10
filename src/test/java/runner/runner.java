package runner;

import com.intuit.karate.junit5.Karate;

public class runner {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:feature").relativeTo(getClass());
    }
}
