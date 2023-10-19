---
title: "Spring Boot • Logging with Logback"
title_style: title2
canonical_url: https://www.kapresoft.com/java/2023/10/19/springboot-logback.html
category: java
related: spring
description: "Master the art of logging in Spring Boot with our comprehensive guide. Learn how to configure Logback, Log4j2, and more to keep your applications running smoothly."
---

## Overview

When it comes to developing robust applications using the Spring framework, one of the key aspects that developers need to focus on is logging. Logging in Spring Boot is a crucial component that allows you to keep track of the behavior and state of your application.<!--excerpt--> In this article, we will delve deep into the intricacies of Spring Boot logging, providing you with a comprehensive guide on how to optimize and configure your logging mechanisms for the best results.

Spring Boot provides a robust logging framework that integrates seamlessly with popular logging libraries such as Logback and Log4j2. These libraries are essential tools that help you diagnose issues and monitor the application's state in real-time.

## Leveraging Spring Boot Starters

Spring Boot offers a flexible and efficient way to manage dependencies and configurations through its starters. These starters are pre-configured templates that include a set of dependencies tailored for specific use cases. For logging, Spring Boot does not have a mandatory logging dependency, except for the Commons Logging API, which is typically provided by the Spring Framework’s _spring-jcl_ module.

### Using Logback with Spring Boot Starters

To integrate Logback, the preferred logging framework, you need to include both Logback and _spring-jcl_ on your classpath. The most straightforward way to do this is by using Spring Boot starters, which all depend on _spring-boot-starter-logging_. For instance, in a web application, including _spring-boot-starter-web_ in your Maven _pom.xml_ file is sufficient, as it transitively depends on the logging starter:

Maven:
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

Gradle:

The equivalent gradle dependency for the given Maven dependency is:

```gradle
implementation 'org.springframework.boot:spring-boot-starter-web'
```

#### Logging Configuration

Spring Boot provides a _LoggingSystem_ abstraction that attempts to configure logging based on the content of the classpath. When Logback is available, it is the first choice of the logging system. 

In this example configuration written in YAML format, various logging properties are set to customize the behavior of logging in a Spring Boot application.

##### Log Levels:

```yaml
logging:
  level:
    root: INFO
    org.springframework: WARN
```

The _logging.level_ property is used to set the log levels for specific packages or classes. Here, two log levels are set:

- _root: INFO_: This sets the base log level for the application to _INFO_, meaning that log messages with severity level _INFO_ and above (e.g., _WARN_, _ERROR_) will be output, while _DEBUG_ and _TRACE_ level messages will be ignored.

- _org.springframework: WARN_: This sets the log level for classes in the _org.springframework_ package to _WARN_. This means that only log messages with severity level _WARN_ and above from Spring classes will be shown.

##### Log Patterns:

```yaml
logging:
  pattern:
    console: "%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n"
```

The _logging.pattern.console_ property defines the pattern used for log messages that are output to the console. In this case, the pattern is set to _"%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n"_. This pattern will result in log messages that look like this:

```
14:05:30.123 [main] INFO  com.example.MyClass - This is a log message
```

Here's a breakdown of the pattern:

- _%d{HH:mm:ss.SSS}_: This outputs the date and time of the log message, formatted as hours, minutes, seconds, and milliseconds.
- _[%thread]_: This outputs the name of the thread that generated the log message.
- _%-5level_: This outputs the log level of the message, padded to 5 characters.
- _%logger{36}_: This outputs the name of the logger that generated the message, truncated to 36 characters.
- _%msg%n_: This outputs the log message itself, followed by a newline character.

This configuration provides a clear and concise log output that is easy to read and interpret, with the most important information (the log level and message) front and center.

## Utilizing Native Configuration Formats

To configure more fine-grained settings of a logging system, you need to use the native configuration format supported by the _LoggingSystem_ in question. By default, Spring Boot picks up the native configuration from its default location for the system, such as _classpath:logback.xml_ for Logback. However, you can also set the location of the config file by using the _logging.config_ property, which provides flexibility and control over your logging configurations.

Spring Boot Starters are a set of convenient dependency descriptors that you can include in your application to enhance its functionality. The _spring-boot-starter-logging_ is one such descriptor that includes Logback and the Apache Commons Logging API, providing you with a comprehensive logging solution out of the box.

### Integrating Log4j2

Spring Boot provides extensive support for Log4j2, which is a flexible and powerful logging framework from the Apache Software Foundation. When Log4j2 is on the classpath, Spring Boot automatically configures it for logging. If you're using Spring Boot starters for assembling dependencies, you'll need to exclude Logback and include Log4j2 instead. If you aren't using starters, you should provide _spring-jcl_ in addition to Log4j2.

It is recommended to go through the starters, even though it might require some adjustments. Below is an example of how to set up the starters in Maven:

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter</artifactId>
        <exclusions>
            <exclusion>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-logging</artifactId>
            </exclusion>
        </exclusions>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-log4j2</artifactId>
    </dependency>
</dependencies>
```

In Gradle, there are several ways to set up the starters. One approach is to use a module replacement. To do this, declare a dependency on the Log4j 2 starter and instruct Gradle to replace any occurrences of the default logging starter with the Log4j 2 starter, as shown in the following example:

```groovy
dependencies {
  implementation "org.springframework.boot:spring-boot-starter-log4j2"
  modules {
    module("org.springframework.boot:spring-boot-starter-logging") {
      replacedBy("org.springframework.boot:spring-boot-starter-log4j2", "Use Log4j2 instead of Logback")
    }
  }
}
```

The Log4j starters bring together the dependencies necessary for common logging requirements, such as having Tomcat use _java.util.logging_ but configuring the output using Log4j2. To ensure that debug logging performed using _java.util.logging_ is routed into Log4j2, configure its JDK logging adapter by setting the _java.util.logging.manager_ system property to _org.apache.logging.log4j.jul.LogManager_.

## Custom Configuring Logback

Logback is a powerful logging framework that integrates seamlessly with Spring Boot, providing a range of customization options to meet your application’s logging needs. If you require customizations beyond what can be achieved with _application.properties_, a standard logback configuration file is necessary.

### Setting up a Custom Configuration File

For Logback to recognize your custom configurations, you can add a _logback.xml_ file to the root of your classpath. Alternatively, you can use _logback-spring.xml_ if you wish to leverage Spring Boot's Logback extensions.

### Leveraging Spring Boot’s Predefined Configurations

Spring Boot offers a suite of predefined Logback configurations designed to uphold common Spring Boot conventions. These configurations are available under _org/springframework/boot/logging/logback/_ and include:

- _defaults.xml_: Defines conversion rules, pattern properties, and common logger configurations.
- _console-appender.xml_: Adds a _ConsoleAppender_ that utilizes the _CONSOLE_LOG_PATTERN_.
- _file-appender.xml_: Incorporates a _RollingFileAppender_ with the _FILE_LOG_PATTERN_ and _ROLLING_FILE_NAME_PATTERN_ settings.

For those using earlier versions of Spring Boot, a legacy _base.xml_ file is also provided for compatibility.

### Example of a Custom logback.xml File

Here is an example of a typical custom _logback.xml_ file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <include resource="org/springframework/boot/logging/logback/defaults.xml"/>
    <include resource="org/springframework/boot/logging/logback/console-appender.xml" />
    <root level="INFO">
        <appender-ref ref="CONSOLE" />
    </root>
    <logger name="org.springframework.web" level="DEBUG"/>
</configuration>
```

**Note:** If you have specified logging configuration properties in your application's configuration files, those properties will override the settings in the custom _logback.xml_ file when the application is running.

### System Properties in Logback Configuration

Your _logback.xml_ file can also utilize various system properties that are managed by the _LoggingSystem_:

- _${PID}_: Current process ID.
- _${LOG_FILE}_: Set if _logging.file.name_ is defined in Boot’s external configuration.
- _${LOG_PATH}_: Set if _logging.file.path_ is specified in Boot’s external configuration.
- _${LOG_EXCEPTION_CONVERSION_WORD}_: Set if _logging.exception-conversion-word_ is defined in Boot’s external configuration.
- _${ROLLING_FILE_NAME_PATTERN}_: Set if _logging.pattern.rolling-file-name_ is defined in Boot’s external configuration.

### ANSI Color Terminal Output

Spring Boot also offers ANSI color terminal output for console logs (but not for log files) by using a custom Logback converter. Refer to the _CONSOLE_LOG_PATTERN_ in the _defaults.xml_ configuration for an example.

Here's an example of ANSI color terminal output in a Spring Boot application:

```xml
<configuration>
    <include resource="org/springframework/boot/logging/logback/defaults.xml"/>
    <include resource="org/springframework/boot/logging/logback/console-appender.xml" />

    <conversionRule conversionWord="clr" converterClass="org.springframework.boot.logging.logback.ColorConverter"/>
    <conversionRule conversionWord="wex" converterClass="org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter"/>
    <conversionRule conversionWord="wEx" converterClass="org.springframework.boot.logging.logback.ExtendedWhitespaceThrowableProxyConverter"/>

    <property name="CONSOLE_LOG_PATTERN"
              value="%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} %clr(${LOG_LEVEL_PATTERN:-%5p}) %clr(${PID:- }){magenta} %clr(---){faint} %clr([%t]){faint} %clr(%-40.40logger{39}){cyan} %clr(:){faint} %m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}"/>

    <root level="INFO">
        <appender-ref ref="CONSOLE"/>
    </root>

    <logger name="org.springframework.web" level="DEBUG"/>
</configuration>
```

In this example, the _CONSOLE_LOG_PATTERN_ property has been defined to include ANSI color codes which will be processed by the Spring Boot ColorConverter to display colorful logs in the console. However, these color codes won't affect the logs if they are written to a file, and they will appear as normal text.

### Groovy Support

If Groovy is present on the classpath, you can configure Logback using _logback.groovy_. This setting takes precedence over XML configurations. However, it’s important to note that Spring extensions are not supported with Groovy configurations, and any _logback-spring.groovy_ files will not be detected.

## Spring Boot Logging Configuration Properties

Configuration properties allow you to customize the behavior of your application without changing the code. In the context of Spring Boot's logging feature, there are several properties you can utilize to configure how logging works in your application.

#### Charset Configuration

- _logging.charset.console_: Defines the charset to be used for console output.
- _logging.charset.file_: Specifies the charset to use for file output.

#### Logging Configuration File

- _logging.config_: Provides the location of the logging configuration file, such as _classpath:logback.xml_ for Logback.

#### Exception Conversion

- _logging.exception-conversion-word_: Represents the conversion word used when logging exceptions. For example, _%wEx_.

#### Log File Configuration

- _logging.file.name_: Specifies the name of the log file. It can be an exact location or relative to the current directory, e.g., _myapp.log_.
- _logging.file.path_: Represents the location where the log file will be stored, for example, _/var/log_.

#### Log Groups

- _logging.group.*_: Log groups provide a convenient way to quickly change multiple loggers at the same time. Example: _logging.group.db=org.hibernate,org.springframework.jdbc_.

#### Log Levels

- _logging.level.*_: Sets the severity mapping for log levels. Example: _logging.level.org.springframework=DEBUG_.

#### Log4j2 Configuration

- _logging.log4j2.config.override_: Utilized for overriding configuration files to create a composite configuration.

#### Logback Rolling Policy Configuration

- _logging.logback.rollingpolicy.clean-history-on-start_: Determines whether to clean the archive log files on startup. Default is _false_.
- _logging.logback.rollingpolicy.file-name-pattern_: Defines the pattern for rolled-over log file names, e.g., _${LOG_FILE}.%d{yyyy-MM-dd}.%i.gz_.
- _logging.logback.rollingpolicy.max-file-size_: Specifies the maximum size a log file can reach, default is _10MB_.
- _logging.logback.rollingpolicy.max-history_: Sets the maximum number of archive log files to be kept. Default is _7_.
- _logging.logback.rollingpolicy.total-size-cap_: Represents the total size of log backups to be retained. Default is _0B_.

#### Pattern Configuration

- _logging.pattern.console_: Specifies the appender pattern for output to the console. This is supported only with the default Logback setup.

#### Shutdown Hook

- _logging.register-shutdown-hook_: Registers a shutdown hook for the logging system when it is initialized. It is disabled automatically when deployed as a war file. Default is _true_.

#### Threshold Configuration

- _logging.threshold.console_: Specifies the log level threshold for console output. Default is _TRACE_.
- _logging.threshold.file_: Defines the log level threshold for file output.

## Utilizing Command Line Arguments for Logging

Spring Boot allows you to control the logging level of your application by using command-line arguments. By specifying the _--debug_ or _--trace_ arguments, you can adjust the logging level to DEBUG or TRACE, respectively, allowing you to gain insights into the internal workings of your application.

For instance, you can run your application with the following command to enable DEBUG level logging:

```bash
./mvnw spring-boot:run -Dspring-boot.run.arguments="--debug"
```

## Best Practices for Spring Boot Logging

To ensure that your Spring Boot application is efficiently logging messages, follow these best practices:

### Set Appropriate Logging Levels

It's crucial to set the right logging levels for different environments to optimize performance and manage log data effectively. 

In a development (dev) environment, you may want to set a lower logging level such as DEBUG or TRACE to capture detailed information that can help troubleshoot issues during the development phase. 

In test and integration environments, you might set the logging level to INFO to record essential application events without overwhelming the log files with too much detail. 

In a production (prod) environment, consider setting the logging level to WARN or ERROR to capture only significant events that require attention. This approach helps to manage log volume and ensures that you're not missing critical issues in a production environment. 

In addition to setting the logging level, make sure to specify the appropriate logging levels for different packages and classes in your application. Common logging levels include TRACE, INFO, WARN, and DEBUG. Configuring these levels properly can significantly enhance your application's performance and log management capabilities.

### Use Specific Loggers
Create specific loggers for different modules or components of your application. This will make it easier to filter and analyze log messages.

### Monitor Log Files
Regularly monitor your application's log files to identify and address any issues promptly.

### Leverage Log Aggregation Tools
Consider using log aggregation tools such as _ Stack (Elasticsearch, Logstash, and Kibana) to centralize and analyze log data from multiple sources.

## In Conclusion

In conclusion, logging in Spring Boot is a vital component that helps you monitor the state and behavior of your application. By leveraging the Spring framework and its integration with popular logging libraries like Logback and Log4j2, you can ensure that your application is robust, reliable, and easy to maintain. Remember to follow the best practices outlined in this article to optimize your logging mechanisms and gain valuable insights into your application's performance and health.

