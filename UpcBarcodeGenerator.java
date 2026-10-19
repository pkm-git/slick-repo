package shared;

import java.util.Random;
import java.io.IOException;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.oned.UPCAWriter;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.nio.file.Paths;

public class UpcBarcodeGenerator
{
    /**
     * Generates a pseudo-random 12-digit UPC-A barcode string based on two 10-digit numeric inputs.
     *
     * @param id1 First 10-digit numeric ID
     * @param id2 Second 10-digit numeric ID
     * @return A valid 12-digit UPC-A barcode string (including check digit)
     */
    public static String generateRandomUpcA(long id1, long id2)
    {
       // 1. Combine inputs to seed a Random instance for deterministic randomness
       // If true unpredictability is needed, use SecureRandom without seeds instead.
       long combinedSeed = id1 ^ Long.rotateLeft(id2, 32);
       Random random = new Random(combinedSeed);

       // 2. Generate the first 11 digits of the UPC-A barcode
       StringBuilder upcBuilder = new StringBuilder();
       
       // Digit 1: Number System Character (Commonly 0, 1, 6, 7, or 8 for general retail)
       int[] commonSystemDigits = {0, 1, 6, 7, 8};
       upcBuilder.append(commonSystemDigits[random.nextInt(commonSystemDigits.length)]);
       
       // Digits 2-11: 5 Manufacturer digits + 5 Product digits
       for (int i = 0; i < 10; i++)
       {
          upcBuilder.append(random.nextInt(10));
       }

       String elevenDigits = upcBuilder.toString();

       // 3. Calculate the 12th digit (Modulo-10 Check Digit)
       int checkDigit = calculateUpcCheckDigit(elevenDigits);

       // 4. Return the complete 12-digit UPC-A code
       return elevenDigits + checkDigit;
    }

    /**
     * Computes the official GS1 Modulo-10 Check Digit for a 11-digit UPC string.
     */
    private static int calculateUpcCheckDigit(String elevenDigits)
    {
       int sum = 0;
       for (int i = 0; i < 11; i++)
       {
          int digit = Character.getNumericValue(elevenDigits.charAt(i));
          // UPC-A uses 1-based indexing for logic:
          // Odd positions (1st, 3rd, 5th...) -> index 0, 2, 4... are multiplied by 3
          // Even positions (2nd, 4th, 6th...) -> index 1, 3, 5... are multiplied by 1
          if (i % 2 == 0) sum += digit * 3;
          else sum += digit;
       }
       int remainder = sum % 10;
       return (remainder == 0) ? 0 : (10 - remainder);
    }

    public static void main(String[] args)
    {
       // Example 10-digit IDs
       long inputId1 = 1234567890L;
       long inputId2 = 9876543210L;

       String upcBarcode = generateRandomUpcA(inputId1, inputId2);
       System.out.println("Generated UPC-A Barcode: " + upcBarcode);

       // To save it as an image file:
       UPCAWriter barcodeWriter = new UPCAWriter();
       BitMatrix bitMatrix = barcodeWriter.encode(upcBarcode, BarcodeFormat.UPC_A, 300, 150);
       // Path path = FileSystems.getDefault().getPath("upc_barcode.png");
       // Path currentFolder = Path.of("");
       Path path = Paths.get("barcode.png");
       try
       {
          MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
       }
       catch (IOException e)
       {
          System.out.println(" **** Caught IOException: " + e.getMessage());
       }
    }
}
