package pe.com.paxtravel.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EmailUtil {

	private static Properties mailServerProperties;
	private static Session mailSession;
	private static MimeMessage mailMessage;
	
	@Autowired
	private static Properties properties; 

	/**
	 * Envía email
	 * 
	 * @param recipientsTO
	 *            = Lista de destinatarios
	 * @param recipientsCC
	 *            = Lista de destinatarios en copia
	 * @param recipientsCCO
	 *            = Lista de destinatarios en copia oculta
	 * @param subject
	 *            = Asunto del email
	 * @param text
	 *            = Texto del email
	 */
	public static void sendEmail(String[] recipientsTO, String[] recipientsCC, String[] recipientsCCO, String subject,
			String text) throws Exception {
		// Setup mail server properties
		mailServerProperties = System.getProperties();
		mailServerProperties.put("mail.smtp.auth", "true");
		mailServerProperties.put("mail.smtp.starttls.enable", "true");
		mailServerProperties.put("mail.smtp.port", "587");
		mailServerProperties.put("mail.smtp.host", "smtp.gmail.com");
		// Get mail session
		// mailSession = Session.getDefaultInstance(mailServerProperties);
		mailSession = Session.getInstance(mailServerProperties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(StringUtils.trimToEmpty(properties.getProperty("smtp.mail.username")),
						StringUtils.trimToEmpty(properties.getProperty("smtp.mail.password")));
			}
		});
		// Build message
		mailMessage = new MimeMessage(mailSession);
		try {
			if (recipientsTO != null) {
				mailMessage.setRecipients(Message.RecipientType.TO, getAddressFromRecipients(recipientsTO));
			}
			if (recipientsCC != null) {
				mailMessage.setRecipients(Message.RecipientType.CC, getAddressFromRecipients(recipientsCC));
			}
			if (recipientsCCO != null) {
				mailMessage.setRecipients(Message.RecipientType.BCC, getAddressFromRecipients(recipientsCCO));
			}
			mailMessage.setSubject(subject);
			mailMessage.setContent(text, "text/html; charset=utf-8");
			try {
				// Transport transport = mailSession.getTransport("smtp");
				// transport.connect("smtp.gmail.com",
				// GeneralUtil.getProperty("smtp.gmail.username"),
				// GeneralUtil.getProperty("smtp.gmail.password"));
				// Transport.sendMessage(mailMessage,
				// mailMessage.getAllRecipients());
				Transport.send(mailMessage);
			} catch (NoSuchProviderException e2) {
				e2.printStackTrace();
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	/** Formatea los email para el envio */
	private static InternetAddress[] getAddressFromRecipients(String[] recipients) {
		InternetAddress[] addressList = new InternetAddress[recipients.length];
		int count = 0;
		for (String recipient : recipients) {
			if (recipient.length() > 0) {
				try {
					addressList[count] = new InternetAddress(recipient.trim());
					count++;
				} catch (AddressException e) {
					e.printStackTrace();
				}
			}
		}
		return addressList;
	}

}
