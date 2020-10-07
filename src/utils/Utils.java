package utils;

import java.text.*;
import java.util.*;

import mail.SendMail;

import java.security.*;
import java.math.*;

public class Utils {

	public static String getDate() {
		
		Date date = new Date();
		
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss"); //você pode usar outras máscaras
		
		return format.format(date);
		
	}
	
	public static String encodePassword(String password) throws Exception{

       MessageDigest m = MessageDigest.getInstance("MD5");
       
       m.update(password.getBytes(), 0, password.length());
       
       String md5 = new BigInteger(1, m.digest()).toString(16);
       
       return md5;
    }
	
	public static void sendMail(String[] args) {
		
		// args[0] = Remetente
		// args[1] = Destinatário
		// args[2] = Assunto
		// args[3] = Mensagem
		
		SendMail sendMail = new SendMail("smtp.zoho.com", "465", "email", "senha", "ssl");
		sendMail.send(args[0], args[1], args[2], args[3]);
	
	}
	
}
