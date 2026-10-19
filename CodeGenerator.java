package shared;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.DecimalFormat;

public class CodeGenerator {

    /**
     * Generates a secure random 6-digit code as a string
     * @return A 6-digit string code (000000-999999)
     */
    public static String generateRandomSixDigitCode()
    {
       SecureRandom secureRandom;

       try
       {
          secureRandom = SecureRandom.getInstanceStrong();
       }
       catch (NoSuchAlgorithmException e)
       {
          secureRandom = new SecureRandom();
       }

       int randomInteger = secureRandom.nextInt(1000000);
       DecimalFormat df = new DecimalFormat("000000");
       return df.format(randomInteger);
    }
}
