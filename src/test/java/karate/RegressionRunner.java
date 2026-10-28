package karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class RegressionRunner {

    @Test
    void ejecutarRegresion() {
        Results regression = Runner.path("classpath:features/regresion.feature")
                .outputCucumberJson(true)
                .parallel(1);
        assertEquals(0, regression.getFailCount(), regression.getErrorMessages());
    }
}
