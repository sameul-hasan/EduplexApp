package util;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class MailUtil {
    private static final String FROM = "sameul.barishal@gmail.com";
    private static final String PASS = "S@m3ulH@s@n";

    public static boolean sendConfirmation(String to, String movieTitle) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASS);
            }
        });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("DIU EduPlex Movie Booking Confirmation");
            message.setText("Your booking for movie: " + movieTitle + " is confirmed. Thank you for using EduPlex!");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}