---
title: "Secure SMTP with Spring JavaMailSender"
canonical_url: https://www.kapresoft.com/java/2016/05/15/secure-smtp-with-spring-javamailsender.html
category: java
image: /assets/images/kapresoft1-210x.png
description: "Secure SMTP with Spring JavaMailSender"
---

## Overview

This article discusses the use of Java Mail in the context of migrating email services to Google Apps For Your Domain. The author shares their experience with using the free service and encountered a problem with using the secure SMTP protocol to send emails programmatically through their old email account with the Spring JavaMailSender.<!--excerpt-->

The issue was attributed to the older version of Java Mail (1.3) they were using, which lacked support for sending emails through the secure SMTP protocol. Additionally, the default implementation of JavaMailSender in the Spring Framework did not handle sending messages through the secure smtp (smtps) protocol efficiently.

This article emphasizes the importance of keeping software up-to-date to ensure compatibility with modern protocols and features. It also highlights the need for developers to conduct thorough research on third-party tools and libraries before incorporating them into their applications to avoid potential compatibility issues.

Like many cost-effective individuals out there I migrated most of my email service which I was paying approximately $50/year for to use Google Apps For Your Domain. This is a free service that in fact I am very satisfied with. But using the smtp service with the Spring JavaMailSender on my old email account was straight forward. The problem I now have is that Google Apps For Your Domain uses the secure _SMTP_ protocol to send emails and because I was using an older version of Java Mail (1.3) I could not programmatically send emails using the secure smtp protocol. In addition to that, the default implementation of JavaMailSender (_JavaMailSenderImpl.java_) in _Spring Framework_ currently does not have the ability to smoothly handle sending messages using the secure smtp (SMTPS) protocol.

In developing my web application, I encountered an issue with sending test emails and notifications to users as I did not have access to my own SMTP server. To work around this, I decided to temporarily use a Gmail account for sending the messages during development. However, I soon realized that Gmail uses the secure SMTP protocol to send email messages and requires user authentication, which posed a challenge for my application.

## What is SMTP and Secure SMTP?

SMTP (Simple Mail Transfer Protocol) is a standard communication protocol used for sending and receiving email messages between servers and clients. SMTP servers are responsible for delivering email messages from one computer to another using a series of rules and protocols.

Secure SMTP, or SMTPS, is a variant of SMTP that uses encryption and authentication to provide a secure channel between email clients and servers. It employs SSL/TLS (Secure Sockets Layer/Transport Layer Security) to encrypt and secure email transmissions, preventing unauthorized access and ensuring that messages are not intercepted or modified during transit.

Secure SMTP is essential for sending sensitive or confidential information via email, such as financial statements, personal data, and login credentials. It is also commonly used for sending marketing emails, newsletters, and other types of mass mailings that require a high level of security and reliability.

## Java Libraries You Will Need

In further investigating this issue it turns out that pre Java Mail 1.4, there is no support for SMTPS Protocol. So we need to download the latest version at Java Mail.

#### Option #1:  Download the latest Java Mail API jars.
When using this route be warned that on the final click to download the java mail product you will be re-routed to install the Sun(TM) Download Manager. I am just really puzzled why Sun(TM) has the need to create their own download managers.
#### Option #2: Download the latest J2EE

Edition and use the mail.jar that came with that product.

The particular class file that you want to check for in these jars are: com.sun.mail.smtp.SMTPSSLTransport.
Please note that for either options you will still need the Java Activation Framework (activation.jar).

### JavaMailSenderImpl with Secure SMTP/SMTPS Support
In my own extension of the the JavaMailSenderImpl.java (see Source Code), it will automatically set the protocol to smtps and add Java Mail smtps properties if the property smtp.isSecure is set to true. Basically, the properties smtp host, username, password, and port will be required.  Also note the property smtp.isSecure is not a Java Mail property. It is just the property name that I came up with so that the code can toggle between normal smtp and smtps protocol.

I also created an override for the super.doSend(..) method so that after calling the Transport.connect(..) method, it will test for connection via the Transport.isConnected() method. This is just an extra step to make sure that we are connected to the SMTPS server and may not be needed in some cases.

Futhermore, If you have a CRUD for the server configuration,  the mail.properties value may be replaced with an implementation that retrieves its values from the database as well.

### Update
The solution below now works using Spring 3.x+ version and Java Mail 1.4.5+. The following Spring config is all you need to enable smtps.

#### XML-based Spring Configuration

```xml
<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl"
    p:protocol="smtps" p:host="smtp.gmail.com" p:port="465"
    p:username="morpheus@gmail.com" p:password="take-the-blue-pill" />
```

#### Java-based Spring Configuration

Here is a Java-based configuration for Spring that sets up a JavaMailSender with the provided properties:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {

    @Bean
    public JavaMailSender javaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(465);
        mailSender.setProtocol("smtps");
        mailSender.setUsername("morpheus@gmail.com");
        mailSender.setPassword("take-the-blue-pill");

        return mailSender;
    }
}
```
You can then use the JavaMailSender in your application by autowiring it into your classes, for example:

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Component
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendEmail(String recipient, String subject, String text) throws MailException, MessagingException {
        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
        helper.setTo(recipient);
        helper.setSubject(subject);
        helper.setText(text, true);

        javaMailSender.send(mimeMessage);
    }
}
```

## In Conclusion

In conclusion, this article highlights the importance of keeping software up-to-date and conducting thorough research on third-party tools and libraries before incorporating them into your applications. The author's experience with using the secure SMTP protocol to send emails using Spring JavaMailSender with an older version of Java Mail is a reminder that technology is constantly evolving, and it is crucial to stay up-to-date with the latest versions and protocols to avoid compatibility issues. 

Furthermore, the article provides valuable insight and solutions for developers facing similar challenges, such as using the latest Java Mail API jars or the latest J2EE edition and creating an extension of the JavaMailSenderImpl.java class to support the secure SMTP/SMTPS protocol. By following these recommendations, developers can ensure smooth and secure email communication in their applications.
