package shared;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailSender {

    public static void sendEmail(String recipient, String subj, String msg)
    {
        // Sender's email ID needs to be your new email address (admin@rewards2connect.com)
        String from = "ceo@rewards2connect.com"; // Your new email address

        // Assuming you are sending email from mail.rewards2connect.com
        String host = "mail.rewards2connect.com"; // Or your server hostname

        // Get system properties
        Properties properties = System.getProperties();

        // Setup mail server
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "465"); // Use 465 for SSL
        properties.setProperty("mail.smtp.ssl.enable", "true");
        properties.setProperty("mail.smtp.auth", "true");

        // Get the Session object and pass username and password
        Session session = Session.getInstance(properties, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, "StPeters65?"); // Your email password
            }
        });

        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);

            // Set From: header field
            message.setFrom(new InternetAddress(from));

            // Set To: header field
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

            // Set Subject: header field
            message.setSubject(subj);

            // Now set the actual message
            message.setText(msg);

            // Send message
            Transport.send(message);
        }
        catch (MessagingException mex)
        {
            System.out.println(" **** CAUGHT MESSAGING EXCEPTION: " + mex.getMessage());
            mex.printStackTrace();
        }
        catch (Exception ex)
        {
            System.out.println(" **** CAUGHT EXCEPTION: e.getClass().getName(): " +
                               ex.getClass().getName() + ", ex.getMessage(): " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
