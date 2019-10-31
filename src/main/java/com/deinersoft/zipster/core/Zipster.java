package main.java.com.deinersoft.zipster.core;

public class Zipster {

    String wordDigits;

    String[] wordsForMillenia = {"thousand", "million", "billion", "trillion"};

    String[] wordsForDecadesTwentyAndAbove = {"", "", "twenty", "thirty", "fourty", "fifty", "sixty", "seventy", "eighty", "ninety"};
    String[] wordsForBelowTenty = {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"};
    String[] wordsForDigits   = {};


    public Zipster(String stringOfNumberAsDigits) throws ZipsterException {
        wordDigits = stringOfNumberAsDigits.trim();
        checkInput();
        removeCommas();
    }

    private void removeCommas() {
        wordDigits = wordDigits.replaceAll(",","");
    }

    private void checkInput() throws ZipsterException {
        if (wordDigits.equals("")) throw new ZipsterException("Null number");
        if (!wordDigits.matches("[0-9\\+\\-\\.\\,]+")) throw new ZipsterException("Invalid characters");
        if (wordDigits.startsWith("+") || wordDigits.startsWith("-")) {
            if (wordDigits.substring(1,wordDigits.length()).contains("-")) throw new ZipsterException("Invalid signed number");
            else if (wordDigits.substring(1,wordDigits.length()).contains("+")) throw new ZipsterException("Invalid signed number");
            else  throw new ZipsterException("Signed number");
        }
        if (wordDigits.contains(",") && wordDigits.contains(".")) {
            if (!(wordDigits.matches("^[0-9]+(,[0-9]{3})+(\\.[0-9]{0,2})$"))) throw new ZipsterException("Invalid format");
        }
        if (wordDigits.contains(",") && !wordDigits.contains(".")) {
            if (!(wordDigits.matches("^[0-9]+(,[0-9]{3})+$"))) throw new ZipsterException("Invalid format");
        }
        if (!wordDigits.contains(",") && wordDigits.contains(".")) {
            if (!(wordDigits.matches("^[0-9]+\\.[0-9]{0,2}$"))) {
                throw new ZipsterException("Invalid format");
            }
        }
        if (wordDigits.length() > 15) throw new ZipsterException("Too many digits");
    }

    public String getWords() {
        String wordsOut = "";
        String digitsIn = "";
        String decimalsIn = "";
        String decimalsOut = "";

        if (wordDigits.contains(".")) {
            String[] wordPieces = wordDigits.split("\\.");
            digitsIn = wordPieces[0];
            decimalsIn = wordPieces[1];
            if (decimalsIn.length() == 1) decimalsIn = decimalsIn + "0";
            decimalsOut = " and " + decimalsIn + "/100";
        }
        else {
            digitsIn = wordDigits;
        }

        for (int m=-1; m<wordsForMillenia.length; m++) {
            while (digitsIn.length() < 3) digitsIn = "0" + digitsIn;
            String last3 = digitsIn.substring(digitsIn.length()-3,digitsIn.length());
            String last3out = wordsForUpTo1000(last3);
            if ((m != -1) && (!last3out.equals(""))) {
                wordsOut = last3out + " " + wordsForMillenia[m] + " " + wordsOut;
            }
            else {
                wordsOut = (last3out + " " + wordsOut).trim();
            }
            digitsIn = digitsIn.substring(0,digitsIn.length()-3);
        }

        return wordsOut.substring(0,1).trim().toUpperCase() + wordsOut.substring(1, wordsOut.length()).trim() + decimalsOut;
    }

     public String wordsForUpTo1000(String digits3) {
        String result = "";
        int[] digits = new int[3];

        while (digits3.length() < 3) digits3 = "0" + digits3;

        for (int i=0; i<3; i++) {
            digits[i] = Integer.parseInt(digits3.substring(i,i+1));
        }

        if (digits[0] > 0) {
            result += wordsForBelowTenty[digits[0]] + " hundred ";
        }
        if (digits[1] > 0) {
            if (digits[1] > 1) {
                result += wordsForDecadesTwentyAndAbove[digits[1]] + " ";
                if (digits[2] > 0) {
                    result += wordsForBelowTenty[digits[2]] + " ";
                }
            }
            else {
                result += wordsForBelowTenty[digits[1]*10+digits[2]] + " ";
            }
        }
        else {
            result += wordsForBelowTenty[digits[2]];
        }

         return result.trim();
    }
}