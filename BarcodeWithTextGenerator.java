package shared;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.FileSystems;

public class BarcodeWithTextGenerator
{
    public static void main(String[] args)
    {
        String barcodeText = "123456789101";
        int width = 300;
        int height = 100;
        int textHeight = 30; // Extra space for the numeric label

        try {
            // 1. Generate BitMatrix
            BitMatrix bitMatrix = new MultiFormatWriter().encode(
                barcodeText, BarcodeFormat.CODE_128, width, height
            );

            // 2. Convert BitMatrix to BufferedImage
            BufferedImage barcodeImage = MatrixToImageWriter.toBufferedImage(bitMatrix);

            // 3. Create a new BufferedImage with extra height for the text
            BufferedImage combinedImage = new BufferedImage(
                width, height + textHeight, BufferedImage.TYPE_INT_RGB
            );

            Graphics2D g2d = combinedImage.createGraphics();

            // Set background to white
            g2d.setColor(Color.WHITE);
            g2d.fillRect(0, 0, width, height + textHeight);

            // Draw the barcode image on top
            g2d.drawImage(barcodeImage, 0, 0, null);

            // Configure font and color for the numeric text
            g2d.setColor(Color.BLACK);
            g2d.setFont(new Font("SansSerif", Font.PLAIN, 14));
            FontMetrics fontMetrics = g2d.getFontMetrics();

            // Center the text horizontally below the barcode
            int textWidth = fontMetrics.stringWidth(barcodeText);
            int x = (width - textWidth) / 2;
            int y = height + fontMetrics.getAscent() + 2;

            g2d.drawString(barcodeText, x, y);
            g2d.dispose();

            // 4. Save the combined image to the target path
            Path path = FileSystems.getDefault().getPath("barcode_with_text.png");
            ImageIO.write(combinedImage, "PNG", path.toFile());

            System.out.println("Barcode with text generated successfully.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
