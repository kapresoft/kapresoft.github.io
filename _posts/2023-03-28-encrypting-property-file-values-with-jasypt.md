---
title: "Encrypting Properties File Values with Jasypt"
canonical_url: https://www.kapresoft.com/java/2023/03/28/encrypting-property-file-values-with-jasypt.html
category: java
image: /assets/images/kapresoft1-210x.png
style:
    headerSize: h2
description: "Encrypt your web app's property files with Jasypt. Learn how to keep your sensitive info secure & benefit from Spring Framework integration."
---

## Overview

Property files are text resources in your standard web application that contains key-value information. There may come a time when information should not be stored in plain sight. This article will demonstrate how to encrypt properties file values using Jasypt encryption module. Jasypt is freely available and comes with Spring Framework integration.<!--excerpt-->

## Prerequisites

- Spring 3.1+
- Jasypt 1.9.0+

## What is Jasypt?

Jasypt (Java Simplified Encryption) is a Java library that provides easy encryption and decryption of data. It can be used to encrypt sensitive information such as passwords, credit card numbers, and other confidential data in Java applications.

### Why is Jasypt a Valuable Tool?

1. Easy to use: Jasypt provides an easy-to-use API for encrypting and decrypting data, which makes it simple for developers to integrate encryption functionality into their Java applications.

1. Security: Jasypt uses strong encryption algorithms, such as AES, to ensure that data is securely encrypted and decrypted.

1. Flexibility: Jasypt can be used to encrypt data in a variety of formats, such as properties files, XML files, and databases. It also offers different encryption modes and configurations to fit specific use cases.

1. Integration: Jasypt integrates easily with popular Java frameworks such as Spring, Hibernate, and Struts.

1. Overall, Jasypt is a valuable tool for any Java developer who needs to encrypt sensitive data in their applications.

### Is Jasypt Secure to Use?

Yes, Jasypt is generally considered a secure tool for encrypting and decrypting data in Java applications. It uses strong encryption algorithms, such as AES, and supports a variety of encryption modes and configurations to fit specific use cases. Additionally, Jasypt offers protection against common attacks, such as dictionary attacks and brute force attacks, by using salt and key strengthening.

That being said, like any encryption tool, the security of Jasypt depends on how it is used and configured. It's important to follow best practices for encryption, such as using strong encryption keys and managing them securely, to ensure the confidentiality and integrity of sensitive data. It's also recommended to keep Jasypt and its dependencies up-to-date with the latest security patches and updates.

### Does Jasypt Follow Standard Security Practices?

Yes, Jasypt follows standard security practices for encryption and hashing. It uses well-known and widely accepted cryptographic algorithms and protocols, such as AES, Blowfish, and RSA, to provide strong encryption and decryption capabilities. Jasypt also follows best practices for key management, such as using secure random number generators to generate encryption keys and storing them securely.

In addition, Jasypt provides various features to enhance the security of sensitive information, such as password-based encryption, salted hashing, and key strengthening. These features make it more difficult for attackers to decrypt or crack sensitive information even if they obtain the encrypted data.

Overall, Jasypt is considered a secure and reliable encryption library that follows standard security practices. However, like any security software, it is important to use it properly and keep it up-to-date to ensure the best possible security.

### Jasypt vs. AWS Secrets Manager

Jasypt is a Java library that provides encryption and decryption functionality for sensitive data in Java applications. It is a developer tool that can be used to secure sensitive information such as passwords, API keys, and other confidential data stored in properties files, databases, or other data sources.

AWS Secrets Manager, on the other hand, is a managed service provided by Amazon Web Services (AWS) that enables developers to store, manage, and retrieve secrets such as database credentials, API keys, and other sensitive information in a secure and scalable way. It is a cloud-based service that allows developers to manage secrets centrally and retrieve them programmatically from their applications.

While Jasypt is a developer tool that provides encryption functionality for sensitive data, AWS Secrets Manager is a cloud service that provides a secure and scalable way to store and manage secrets. Developers can use both tools in combination to secure their Java applications.

## Properties File

A standard java web-based application may consist numerous properties file. An example of those files would be:

- application.properties
- jdbc.properties
- mail.properties
- amazon.properties

As an example for a file like _mail.properties_ it would contain key-value pairs used by the application to configure a web-application at different stages of the running web application.

### Plain Text Values In Properties Files

The following code snippet below is a typical example of a property configuration for an SMTP service. Note that the username and password entries are provided in clear text.

**Code Snippet 1. Property file values**

{% highlight properties linenos %}
local.mail.smtps.host=smtp.gmail.com
local.mail.smtps.port=465
local.mail.smtps.debug=true
local.mail.smtps.username=morpheus@gmail.com
local.mail.smtps.password=Take the blue pill
{% endhighlight %}

As you can see sensitive information like the username and password is stored in plain text. To make it even worst, we check this in to a source repository like github. Wouldn't it be nice if we could encrypt username and password values?

#### Encrypted Values in Properties File

With Jasypt you can enter encrypted values by enclosing them with ENC('value'). The values are decrypted in-memory (i.e. during load-time) using a Jasypt-based extension of Spring Framework's org.springframework.context.support.PropertySourcesPlaceholderConfigurer.

**Code Snippet 2. Jasypt TextEncryptor solution for encrypting property file values.**

{% highlight properties linenos %}
mail.smtps.username=ENC(iXm7KjIoubkQVmbJdTJxGJPPIHkZ6H9fq7ZJsfsGpIk=)
mail.smtps.password=ENC(zcV8BmkkZchyHzEmNyM70seLHUFwFz4va8w5wpvYXYE=)

mail.smtps.host=smtp.gmail.com
mail.smtps.port=465
mail.smtps.debug=true
{% endhighlight %}

Source: [mail.properties](https://github.com/nfet/xmx1024/blob/encrypting_properties_file_values_with_jasypt_TAG/src/main/resources/mail.properties)

### Encrypting the property value using Jasypt

#### Standard Property Placeholder Configuration

The following configuration is a spring framework's standard property placeholder configuration.

**Code Snippet 3. Standard Property Placeholder Configuration**

```xml
<context:property-placeholder location="classpath*:*.properties"/>
```

#### Jasypt Text Encryptor Configuration

The code snippet shown below enables the jasypt BasicTextEncryptor implementation with an override to the standard spring property placeholder configuration.

**Code Snippet 4. Jasypt TextEncryptor Configuration**

{% highlight xml linenos %}
<bean id="textEncryptor" class="org.jasypt.util.text.BasicTextEncryptor"
    p:password="go-big-or-go-home"/>

<bean id="propertyPlaceholder" class="org.jasypt.spring31.properties.EncryptablePropertySourcesPlaceholderConfigurer"
    p:locations="classpath*:*.properties" 
    c:textEncryptor-ref="textEncryptor"/>
{% endhighlight %}

You may want to vary your configuration for each environment. For instance dev would be just the default Spring PropertySourcesPlaceholderConfigurer and stage, prod would use Jasypt's EncryptablePropertySourcesPlaceholderConfigurer. One would use Spring Framework Profile Feature (or equivalent) to vary configurations between deployment but this type of discussion is beyond the scope of this blog.

**Code Snippet 5. Mail Sender Bean Configuration**

{% highlight xml linenos %}
<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl"
    p:protocol="smtps"p:host="${mail.smtps.host}"
    p:port="${mail.smtps.port}"
    p:username="${mail.smtps.username}"
    p:password="${mail.smtps.password}"/>
{% endhighlight %}

**Code Snippet 6. Spring Annotation-based Configuration**

{% highlight java linenos %}
@Controller
public class MailController {

    @Value("${mail.smtps.username}")
    private String email;
    
    @Value("${mail.smtps.password}")
    private String password;

}
{% endhighlight %}

Source: [app-ctx.xml](https://github.com/nfet/xmx1024/blob/encrypting_properties_file_values_with_jasypt_TAG/src/main/resources/app-ctx.xml)

#### Generating Salted Encrypted Values

I created an example of how you would produce an encrypted value using a JUnit test class.
The JUnit test shown on the code snippet below is an example code for generating the encrypted value.
Update the secret password as needed but make sure not to check-in the real one.

Note that each time you run the test it will produce a different encrypted text value because the encryption is salted. SEE [TextEncryptorTest.java](https://github.com/nfet/xmx1024/blob/encrypting_properties_file_values_with_jasypt_TAG/src/test/java/com/lagnada/xmx1024/integration/TextEncryptorTest.java)

**Code Snippet 7. Unit example for generating an encrypted value**

{% highlight java linenos %}
package com.lagnada.xmx1024.integration;

import org.jasypt.util.text.BasicTextEncryptor;
import org.junit.Before;
import org.junit.Test;

import static org.fest.assertions.Assertions.assertThat;

/**
 * Test Utility for generating encrypted passwords for {@link org.jasypt.spring31.properties.EncryptablePropertySourcesPlaceholderConfigurer}
 */
public class TextEncryptorTest {

    BasicTextEncryptor encryptor;

    @Before
    public void setUp() throws Exception {
        encryptor = new BasicTextEncryptor();
        encryptor.setPassword("go-big-or-go-home");
    }

    @Test
    public void generateEncryptedText() {
        String plainText = "Take the blue pill";
        String encrypted = encryptor.encrypt(plainText);
        System.out.printf("encrypted: %s%n", encrypted);
        assertThat(encrypted).isNotNull();
        assertThat(encrypted).isNotEqualTo(plainText);
    }
}
{% endhighlight %}

After running the JUnit code on Code Snippet 7, use the encrypted text value and enclose it with ENC() in any of your sourced properties file.

**Code Snippet 8. Encrypted property value example**

```properties
mail.smtps.password=ENC(eVrfrMcWl9J7fiC+9q4w8bNR+MSeTT5yfh1JL0/mUtk=)
```

## Source Code

The entire source code can be pulled at github [xmx1024](https://github.com/nfet/xmx1024). Please feel free to fork it.

## In Conclusion

In this article, we discussed how to encrypt property file values using Jasypt encryption module, which is a Java library that provides easy encryption and decryption of data. Jasypt is a valuable tool for any Java developer who needs to encrypt sensitive data in their applications. 

We also compared Jasypt with AWS Secrets Manager, which is a managed service provided by Amazon Web Services that enables developers to store, manage, and retrieve secrets in a secure and scalable way. While Jasypt is a developer tool that provides encryption functionality for sensitive data, AWS Secrets Manager is a cloud service that provides a secure and scalable way to store and manage secrets. 

Finally, we looked at how to encrypt property values using Jasypt and how to configure the Jasypt TextEncryptor with an override to the standard Spring property placeholder configuration. By encrypting property values using Jasypt, we can protect sensitive information such as passwords, API keys, and other confidential data stored in properties files, databases, or other data sources.


