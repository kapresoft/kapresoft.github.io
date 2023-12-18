---
title: "Logback for Beginners"
title_style: title2w
canonical_url: https://www.kapresoft.com/java/2023/10/19/logback-for-beginners.html
category: java
related: java
description: "Learn how to implement Logback, the powerful logging framework for Java, with this comprehensive guide. Perfect for beginners and pros alike!"
---

## Overview

Logback, a Java-based logging framework within the SLF4J (Simple Logging Facade for Java) ecosystem, is the preferred choice in the Java community, serving as an enhanced successor to the popular Log4j project. It not only carries forward the legacy of Log4j but also brings to the table a quicker implementation, more comprehensive configuration options, and enhanced flexibility for archiving old log files.<!--excerpt-->

With its rich set of features and capabilities, diving into the world of Logback will undoubtedly elevate the performance and efficiency of your applications, ensuring that you are equipped with a robust and flexible logging framework that meets the demands of modern software development.

### Logback Provides Several Advantages

1. **Speed**: Logback is designed to be faster than log4j.
2. **Architecture**: Logback's architecture is designed to be more reliable and modular, with a smaller memory footprint.
3. **Configuration**: Logback offers more configuration options, with support for XML and Groovy-based configurations, allowing for more flexible and powerful setup.
4. **Integration**: Logback can easily be integrated with various Java frameworks and environments.
5. **Support for Different Outputs**: Logback supports logging to various outputs like console, files, and database tables.

When using Logback, developers can adjust the logging levels, filters, and outputs, enabling them to get detailed information during development and troubleshooting, while minimizing log output in production environments.

## Dissecting the Architecture of Logback
Logback’s architecture consists of three main components: Logger, Appender, and Layout.

### Logger
The Logger serves as the context for log messages. This is the interface through which applications initiate log messages. It's the first step in the process of logging, providing a structured way to handle logs.

### Appender
The Appender is responsible for directing log messages to their final resting place, whether that be a text file or another medium. Logback doesn't limit you to just text files; its capabilities extend far beyond, giving you ample flexibility.

### Layout
Lastly, Layout is the component that formats the messages for output. With Logback, you have the ability to create custom classes to format your messages exactly how you want them. Additionally, Logback offers extensive configuration options for existing formatting classes.

### Logback's Independence from Other Logging Frameworks 

Logback is a logging framework and a complete implementation of the SLF4J API. If neither Log4j2 nor Java Util Logger (JUL) are present in the classpath, Logback will still function correctly as it doesn't rely on them. Logback provides its own implementation for logging and doesn't need Log4j2 or JUL to be present.

In other words, Logback is self-contained and doesn't fall back to using other logging frameworks if they are not available. It uses its own logger implementation, which is part of the Logback core.

Below is a class diagram that represents the abstraction of Logback and its relationship with other logger frameworks like Java Util Logging (JUL) and Log4j2.

This diagram shows that Logback, Java Util Logging, and Log4j2 are all concrete classes that implement the Logger interface, which has a _log()_ method. 

LoggerFactory is a class that has a _getLogger()_ method and can create instances of Logback, Java Util Logging, or Log4j2. This illustrates the abstraction provided by Logback in relation to other logging frameworks.

<img src="https://cdngh.kapresoft.com/img/logback-for-beginners-abstraction-cd-8278668.png" alt="Logback Abstraction Class Diagram"/>

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/VP4z3i8m38Ltdo8Z26L1J1sgJWo8bGEOOA90Vb3Y8Y7WxhIYBLLBwz7li_ri5uanSkaiWBAOajW7VKHr5KyGLQniq8ibl06CPufdL5GJck88wCehSOkAGtoqZ2R-vlla3kzuO6DhnNWztMzpMO_4rgMKhxmrb0dZRfOSUKumx3u9DWFczDv2KkRTXJAX8Y7JFsOuVevj7FmGACYVwfTy0000" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=VP4z3i8m38Ltdo8Z26L1J1sgJWo8bGEOOA90Vb3Y8Y7WxhIYBLLBwz7li_ri5uanSkaiWBAOajW7VKHr5KyGLQniq8ibl06CPufdL5GJck88wCehSOkAGtoqZ2R-vlla3kzuO6DhnNWztMzpMO_4rgMKhxmrb0dZRfOSUKumx3u9DWFczDv2KkRTXJAX8Y7JFsOuVevj7FmGACYVwfTy0000" target="_blank">PlantText</a></small>

### Logback, Log4j2 and Java Util Logging's Association with Slf4j API

Logback needs SLF4J API (Simple Logging Facade for Java API) because Logback is a native implementation of SLF4J.

SLF4J acts as a simple facade or abstraction for various logging frameworks (e.g., java.util.logging, log4j, Logback) allowing the end-user to plug in the desired logging framework at deployment time. **_This means that you can write your application code against the SLF4J API, and then choose which logging framework to use at runtime._** For example, in light of the recent [Log4j2 Security vulnerability](https://blog.cloudflare.com/inside-the-log4j2-vulnerability-cve-2021-44228/), the application can switch to _java.util.logging_ (JUL) with minimal changes in project management configuration (i.e. maven or gradle), ensuring a quick and effective response to potential security vulnerabilities.

Logback is designed to work with the SLF4J API to provide a logging implementation. When you use SLF4J, you can easily switch between different logging frameworks (e.g., from Log4j to Logback) without changing the code of your application. This flexibility and interoperability are why Logback requires the SLF4J API.

By providing a native implementation for SLF4J, Logback ensures that when you use SLF4J in your application, you can easily take advantage of all the features and benefits that Logback offers, without any additional configuration or setup.

Here is a PlantUML class diagram that includes SLF4J interface and represents the relationship between Logback, other logger frameworks like Java Util Logging (JUL) and Log4j2, and SLF4J.

<img src="https://cdngh.kapresoft.com/img/logback-for-beginners-abstraction-cd2-36d6ab0.png" alt="Logback association with slf4j"/>

<small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/VP713e8m38RlUueTDMOS32TY22SEXfln0UgiotGCimqJ8xwxa07H8VJOVd_xjysi0-FgKX725LXBYqgSWD_eYz0sDgeIgpLv4oArGtC1ZXqXq4o0KTuMS-2kCi-14UXyFcnrAF9uFzDf3myuEgawfTHYVbvytKwAmnQCDUbWEA6ol2iiKJjBmkwpO3zWgVwrC6FfUC64SeFWy1yJZbzYUmSXuYtv2_uuygbT4qN1Dn9QsrPECjJdxkCV" target="_blank">SVG</a>&nbsp;|
<a href="https://www.planttext.com/?text=VP713e8m38RlUueTDMOS32TY22SEXfln0UgiotGCimqJ8xwxa07H8VJOVd_xjysi0-FgKX725LXBYqgSWD_eYz0sDgeIgpLv4oArGtC1ZXqXq4o0KTuMS-2kCi-14UXyFcnrAF9uFzDf3myuEgawfTHYVbvytKwAmnQCDUbWEA6ol2iiKJjBmkwpO3zWgVwrC6FfUC64SeFWy1yJZbzYUmSXuYtv2_uuygbT4qN1Dn9QsrPECjJdxkCV" target="_blank">PlantText</a></small>

The _LoggerFactory_ class plays a crucial role in creating instances of different logging frameworks such as Logback, Java Util Logging, or Log4j2. The _Logger_ interface in Logback extends the SLF4J (Simple Logging Facade for Java) interface, which means that all classes implementing the _Logger_ interface must also provide an implementation for the SLF4J interface methods (as mentioned previously). This is a crucial point of decoupling, as it allows for the interchangeability of different logging frameworks while using the same SLF4J API.

In this specific example, the _LoggerFactory_ class is used to create instances of the _Logger_ class in Logback. However, it's important to note that _LoggerFactory_ can also be used to create instances of other logging frameworks that implement the SLF4J interface. 

**The _log()_ method in the SLF4J interface is the decoupling point that allows for this interchangeability.** When a log request is made, it is the SLF4J _log()_ method that gets called, and it is then the responsibility of the specific logging framework implementation to handle the log request accordingly.

## Getting Set Up with Logback
Setting up Logback in your project is a straightforward process, involving adding Maven dependencies and ensuring you have the necessary files in your classpath.

### Maven Dependencies

Logback is divided into three modules:

1. **logback-core**: Provides core functionality.
2. **logback-classic**: Extends logback-core to provide functionality equivalent to log4j.
3. **slf4j-api**: Logback logging facade and implementation dependencies

Firstly, you need to add Logback and SLF4J to your project's _pom.xml_ file. Here's an example:

```xml
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.4.11</version>
</dependency>
```

When you declare logback-classic.jar in your project, Maven's transitivity rules will also automatically include slf4j-api.jar and logback-core.jar, ensuring all necessary dependencies are present.

The config below is for explicitly declaring the dependencies for the purpose of this article:

```xml
<properties>
    <logback-version>1.4.11</logback-version>
</properties>

<dependencies>
    <dependency>
        <groupId>ch.qos.logback</groupId>
        <artifactId>logback-classic</artifactId>
        <version>${logback-version}</version>
    </dependency>
    
    <dependency>
        <groupId>ch.qos.logback</groupId>
        <artifactId>logback-core</artifactId>
        <version>${logback-version}</version>
    </dependency>
    
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-api</artifactId>
        <version>2.0.9</version>
    </dependency>
</dependencies>
```

The latest version for logback and slf4j-api can be found here:

- [logback-core](https://mvnrepository.com/artifact/ch.qos.logback/logback-core)
- [sl4j-api](https://mvnrepository.com/artifact/org.slf4j/slf4j-api)

## Crafting a Simple Example and Understanding Configuration

Creating a simple example will help solidify your understanding of Logback.

First, create a configuration file named _logback.xml_ and place it in your classpath. Here's an example of what the contents might look like:

```xml
<configuration>
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    <root level="debug">
        <appender-ref ref="STDOUT" />
    </root>
</configuration>
```

Next, create a simple class with a main method, as shown below:

```java
public class SimpleExample {
    private static final Logger logger = LoggerFactory.getLogger(SimpleExample.class);
    public static void main(String[] args) {
        logger.info("Example log from {}", SimpleExample.class.getSimpleName());
    }
}
```

When you run this example, you should see your log message in the console, showcasing the ease and simplicity of getting started with Logback.

## Harnessing the Power of Logger Contexts
Logger contexts are crucial for managing log messages in Logback.

### Creating a Context
To create a logging context, you initiate a Logger from SLF4J or Logback, as shown in the example below:

```java
private static final Logger logger = LoggerFactory.getLogger(SimpleExample.class);
```

Once you have your Logger, you can use it to generate log messages:

```java
logger.info("Example log from {}", SimpleExample.class.getSimpleName());
```

### Utilizing Contexts in Logging Hierarchies
Loggers exist in a hierarchical structure, similar to the Java object hierarchy. A logger is considered an ancestor if its name, followed by a dot, prefixes a descendant logger's name. Loggers can also be parents, existing without any ancestors between them and a child logger.

Let's create a program to demonstrate using contexts within logging hierarchies:

```java
// import ch.qos.logback.classic.*;

Logger mainLogger =(Logger) LoggerFactory.getLogger("com.sample.logback");
mainLogger.setLevel(Level.INFO);
Logger subLogger =(Logger) LoggerFactory.getLogger("com.sample.logback.experiments");

// logged (higher level than INFO)
mainLogger.warn("This log is WARN.");
// not logged (lower level than INFO)
mainLogger.debug("This log is DEBUG.");

// logged
subLogger.info("This log is INFO.");
// not logged (lower level than INFO)
subLogger.debug("This log is DEBUG.");
```

This example illustrates the hierarchical nature of Logback loggers. The WARN and INFO messages will be logged, while the DEBUG messages will be filtered out. This demonstrates the power and flexibility of Logback's logging contexts. With the given Logback configuration and the provided Java code, the output in the console would be similar to the following:

```
15:24:36 [main] WARN  com.sample.logback                - This log is WARN.
15:24:36 [main] INFO  com.sample.logback.experiments    - This log is INFO.
```

Here's a breakdown of why each log message may or may not be logged:

1. _mainLogger.warn("This log is WARN.");_ - This message is logged because the log level of _mainLogger_ is set to _INFO_, and _WARN_ is a higher level than _INFO_.
2. _mainLogger.debug("This log is DEBUG.");_ - This message is not logged because the log level of _mainLogger_ is set to _INFO_, and _DEBUG_ is a lower level than _INFO_.
3. _subLogger.info("This log is INFO.");_ - This message is logged because the default log level of _subLogger_ is inherited from _mainLogger_, which is _INFO_.
4. _subLogger.debug("This log is DEBUG.");_ - This message is not logged because the default log level of _subLogger_ is inherited from _mainLogger_, which is _INFO_, and _DEBUG_ is a lower level than _INFO_.

### In Conclusion

In this article, we've explored the fundamentals of Logback, a popular logging framework within the Java community, and its architecture consisting of three main classes: Logger, Appender, and Layout. We've also discussed the setup process, including the necessary Maven dependencies and classpath configurations, as well as provided a basic example and configuration to help you get started with Logback in your applications.

We delved into the Logger contexts and their hierarchies, demonstrating how to create and use a context within logging hierarchies. This information is essential for anyone looking to utilize Logback's powerful features effectively.

Moreover, we clarified that Logback functions independently of other logging frameworks such as Java Util Logging (JUL) and Log4j2, as it is a complete implementation of the SLF4J API. It's important to note that for Logback to properly function, a dependency on the _slf4j-api_ library is required. This API serves as a facade for various logging frameworks, allowing developers to decouple the logging framework from the rest of the application.

This means that even if Log4j2 or JUL are not present in the classpath, Logback will still operate correctly using its own logger implementation. By understanding these key aspects of Logback, you'll be better equipped to implement this robust logging framework in your Java applications, ultimately enhancing your application's maintainability and debugging capabilities.
