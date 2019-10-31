package test.java.com.deinersoft.zipster.core;

import main.java.com.deinersoft.zipster.core.Zipster;
import main.java.com.deinersoft.zipster.core.ZipsterException;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import static org.hamcrest.core.Is.is;
import static org.hamcrest.MatcherAssert.assertThat;

public class UnitTestsZipster {

    @Rule
    public ExpectedException ZipsterException = ExpectedException.none();

    @Test
    public void testNullString() throws ZipsterException {
        ZipsterException.expect(ZipsterException.class);
        ZipsterException.expectMessage("Null number");
        new Zipster("");
    }

    @Test
    public void testInvalidCharacters() throws ZipsterException {
        ZipsterException.expect(ZipsterException.class);
        ZipsterException.expectMessage("Invalid characters");
        new Zipster("Person2Person");
    }

    @Test
    public void testInvalidSignedNumber1() throws ZipsterException {
        ZipsterException.expect(ZipsterException.class);
        ZipsterException.expectMessage("Invalid signed number");
        new Zipster("-200.+00");
    }

    @Test
    public void testInvalidSignedNumber2() throws ZipsterException {
        ZipsterException.expect(ZipsterException.class);
        ZipsterException.expectMessage("Invalid signed number");
        new Zipster("++200.00");
    }

    @Test
    public void testSignedNumber() throws ZipsterException {
        ZipsterException.expect(ZipsterException.class);
        ZipsterException.expectMessage("Signed number");
        new Zipster("-200.00");
    }

    @Test
    public void testInvalidFormat1() throws ZipsterException {
        ZipsterException.expect(ZipsterException.class);
        ZipsterException.expectMessage("Invalid format");
        new Zipster("200,000,0000");
    }

    @Test
    public void testInvalidFormat2() throws ZipsterException {
        ZipsterException.expect(ZipsterException.class);
        ZipsterException.expectMessage("Invalid format");
        new Zipster("200.000");
    }

    @Test
    public void testInvalidFormat3() throws ZipsterException {
        ZipsterException.expect(ZipsterException.class);
        ZipsterException.expectMessage("Invalid format");
        new Zipster("200.00.00");
    }

    @Test
    public void testDigitWordExtraction1() throws ZipsterException {
        Zipster Zipster = new Zipster("20");
        assertThat(Zipster.wordsForUpTo1000("20"), is("twenty"));
    }

    @Test
    public void testWordForDigits1() throws ZipsterException {
        Zipster Zipster = new Zipster("20");
        assertThat(Zipster.getWords(), is("Twenty"));
    }

    @Test
    public void testDigitWordExtraction2() throws ZipsterException {
        Zipster Zipster = new Zipster("25");
        assertThat(Zipster.wordsForUpTo1000("25"), is("twenty five"));
    }

    @Test
    public void testWordForDigits2() throws ZipsterException {
        Zipster Zipster = new Zipster("25");
        assertThat(Zipster.getWords(), is("Twenty five"));
    }

    @Test
    public void testDigitWordExtraction3a() throws ZipsterException {
        Zipster Zipster = new Zipster("32768");
        assertThat(Zipster.wordsForUpTo1000("32"), is("thirty two"));
    }

    @Test
    public void testDigitWordExtraction3b() throws ZipsterException {
        Zipster Zipster = new Zipster("32768");
        assertThat(Zipster.wordsForUpTo1000("768"), is("seven hundred sixty eight"));
    }

    @Test
    public void testWordForDigits3() throws ZipsterException {
        Zipster Zipster = new Zipster("32768");
        assertThat(Zipster.getWords(), is("Thirty two thousand seven hundred sixty eight"));
    }

    @Test
    public void testDigitWordExtraction4a() throws ZipsterException {
        Zipster Zipster = new Zipster("32000");
        assertThat(Zipster.wordsForUpTo1000("32"), is("thirty two"));
    }

    @Test
    public void testDigitWordExtraction4b() throws ZipsterException {
        Zipster Zipster = new Zipster("32000");
        assertThat(Zipster.wordsForUpTo1000("000"), is(""));
    }

    @Test
    public void testWordForDigits4() throws ZipsterException {
        Zipster Zipster = new Zipster("32000");
        assertThat(Zipster.getWords(), is("Thirty two thousand"));
    }
    @Test
    public void testDigitWordExtraction5a() throws ZipsterException {
        Zipster Zipster = new Zipster("32001");
        assertThat(Zipster.wordsForUpTo1000("32"), is("thirty two"));
    }

    @Test
    public void testDigitWordExtraction5b() throws ZipsterException {
        Zipster Zipster = new Zipster("32001");
        assertThat(Zipster.wordsForUpTo1000("001"), is("one"));
    }

    @Test
    public void testWordForDigits5() throws ZipsterException {
        Zipster Zipster = new Zipster("32001");
        assertThat(Zipster.getWords(), is("Thirty two thousand one"));
    }
}
