---
title: "Java • Logback Mapped Diagnostic Context (MDC) in Action"
title_style: title2w
section_style: article1
category: java
related: java
canonical_url: https://www.kapresoft.com/java/2023/12/18/java-logback-mdc-in-action.html
description: "Explore the benefits and challenges of using MDC in Java logging using Logback. Understand key-value pair logging, ThreadLocal dangers, and performance impacts for effective log management."
---

## Overview

Java's <a href="/java/2023/10/19/logback-for-beginners.html" target="_blank" alt="_Logback_">_Logback_</a> framework offers a robust and flexible logging system, pivotal for any software development project. Among its features, the <a href="https://logback.qos.ch/manual/mdc.html" target="_blank" alt="_Mapped Diagnostic Context (MDC)_">_Mapped Diagnostic Context (MDC)_</a> stands out for its utility in providing contextual information in log messages.<!--excerpt--> This article delves into the essence of MDC within Logback, offering a clear understanding of its purpose and functionality.

## What is Mapped Diagnostic Context (MDC) in Logback?

_Mapped Diagnostic Context_ (MDC) in Logback enriches log messages with contextual information, an essential feature in multi-threaded environments for understanding log context. MDC operates by storing key-value pairs, which are then seamlessly integrated into log messages, making logs more informative.

MDC's primary advantage lies in its ability to streamline debugging and monitoring in complex applications. When you incorporate contextual data such as user IDs or transaction IDs into logs, it greatly assists in tracing and resolving issues. This is especially valuable in scenarios involving logs from multiple sources or when dealing with asynchronous operations. Tools like <a href="https://www.splunk.com/" target="_blank" alt="Splunk">Splunk</a> further leverage this capability for comprehensive log analysis and problem resolution.

Implementing MDC is straightforward, requiring minimal code changes. Developers can insert contextual data into MDC at any application point, with Logback automatically embedding this data into logs. This simplicity extends to its customizability; the format and content of the contextual information can be tailored to an application’s specific requirements.

In essence, MDC is vital for improving log clarity and utility, particularly critical for diagnosing issues in contexts where understanding the underlying events is key. MDC offers a streamlined approach to adding rich context to logging, enhancing the maintenance and troubleshooting of Java applications.

### Benefits

Mapped Diagnostic Context (MDC) in Java's logging frameworks like Logback and Log4j2 offers significant advantages for logging and monitoring in complex applications:

#### Structured Log Clarity
- **Key-Value Pairing**: MDC facilitates key-value pair logging, enhancing log clarity and making it easier for tools like Splunk to parse and analyze logs.
- **Efficient Diagnosis**: The structured format aids in quick filtering and precise issue diagnosis in production environments.

#### Enhanced Debugging and Monitoring
- **Traceability**: MDC provides contextual information, such as user IDs or session IDs, improving traceability and error isolation in multi-threaded environments.
- **Dynamic Data Insertion**: It allows for the dynamic addition of relevant context to logs, making them more informative.

#### Customization and Compliance
- **Customizable Logging**: MDC's flexibility enables tailoring of log content to specific needs, aiding in performance monitoring and operational insights.
- **Audit Trails and Security**: MDC enhances audit trails and security monitoring, crucial for compliance in various industries.

Overall, MDC's role in enriching logs with contextual data is invaluable for efficient logging, debugging, and application management, especially in complex and distributed systems.

### Caveats

MDC, while beneficial in Java logging, comes with its own set of considerations:

- **Performance Impact**: MDC can increase memory and processing overhead, especially in systems with high log throughput.
- **Complexity in Maintenance**: Implementing MDC adds complexity and requires diligent management to avoid issues in large or legacy systems.
- **Sensitive Data Risks**: There's a potential for accidental logging of sensitive data, necessitating careful data handling.
- **Framework Dependency**: MDC's functionality can vary between logging frameworks, and framework changes can impact its use.
- **ThreadLocal Dangers**: MDC often uses _ThreadLocal_ variables, which, if not managed properly, can lead to memory leaks, especially in environments like application servers where thread pooling is common.

Careful implementation and management of MDC are essential to harness its benefits while mitigating these risks.

## MDC in Slf4j

The _Mapped Diagnostic Context_ (MDC) is a feature common to several Java logging frameworks, including Log4j2, slf4j, and Logback. If you want to use MDC in your Logback-based logging, you would set up MDC through slf4j and configure your Logback appenders and layouts to include the MDC values in your log messages. This combination of slf4j for MDC and Logback for logging is a common and effective approach for Java applications that need to manage contextual information in their logs.

Figure 1.  Slf4j Facade Abstraction Diagram

<div class="uml-diagram">
   <img src="https://www.planttext.com/api/plantuml/png/SoWkIImgAStDuUAAzaeiIrHmB2Z8oKnEBCdCpujLqDMrKuWkpaapoL9m3F2CvK9YG-HyyjEJ4fEpiSkOP1d50es5if0DWmWfE1LbfgIdnXAo6aqrLb4qInrIyr90dW80">
   <small>Also available in: <a href="https://www.planttext.com/api/plantuml/svg/SoWkIImgAStDuUAAzaeiIrHmB2Z8oKnEBCdCpujLqDMrKuWkpaapoL9m3F2CvK9YG-HyyjEJ4fEpiSkOP1d50es5if0DWmWfE1LbfgIdnXAo6aqrLb4qInrIyr90dW80" target="_blank">SVG</a>&nbsp;|
   <a href="https://www.planttext.com/?text=SoWkIImgAStDuUAAzaeiIrHmB2Z8oKnEBCdCpujLqDMrKuWkpaapoL9m3F2CvK9YG-HyyjEJ4fEpiSkOP1d50es5if0DWmWfE1LbfgIdnXAo6aqrLb4qInrIyr90dW80" target="_blank">PlantText</a>
   </small>
</div>

Slf4j acts as a facade for various logging frameworks, including Logback and Log4j. Its MDC usage is similar to Logback, but it's important to note that slf4j itself does not implement logging or MDC; it delegates these functions to the underlying logging framework. In this example, we are using slf4j logging factory and interfaces for the abstraction, with an underlying Logback implementation:

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

public class Slf4jExample {
    private static final Logger logger = LoggerFactory.getLogger(slf4jExample.class);

    public static void main(String[] args) {
        MDC.put("userID", "100020");
        logger.info("User process started");
        // Perform operations
        MDC.clear();
    }
}
```

In this slf4j example, the usage of _MDC.put()_ and _MDC.clear()_ is similar to Logback. However, the actual implementation of these methods depends on the configured underlying logging framework.

Given the provided Logback pattern in the _logback.xml_ file:

```xml
<pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] [UserID=%X{userID}] %level %logger{10} - %msg%n</pattern>
```

And the following logging statements:

```java
MDC.put("userID", "100020");
logger.info("User process started");
```

The output in the log file would look something like this:

```
2023-12-18 10:15:30 [main] [UserID=100010] INFO Slf4jExample - User process started
```

In this example output:
- _2023-12-18 10:15:30_ represents the timestamp of the log entry, formatted as _yyyy-MM-dd HH:mm:ss_.
- _[main]_ indicates the name of the thread which, in this case, is the main thread.
- _[UserID=100020]_ shows the user ID (_100020_) that was put into the MDC (Mapped Diagnostic Context) using _MDC.put("userID", "100020")_.
- _INFO_ is the log level.
- _Slf4jExample_ is the logger name (the class name or logger identifier), truncated or fully qualified as specified by _{10}_ in the pattern.
- _User process started_ is the actual log message.

MDC plays a pivotal role in providing contextual information in log messages across different Java logging frameworks. Understanding the nuances in their usage is essential for developers to leverage MDC effectively in their respective environments.

## MDC Examples in Action

The Mapped Diagnostic Context (MDC) is an invaluable tool in Java logging, enabling developers to enhance log messages with contextual information. Let's explore some practical examples of how MDC is employed in real-world scenarios, demonstrating its integration and effectiveness in Java applications.

### Example 1: Tracking User Sessions

In web applications, tracking user sessions in logs can be crucial for debugging and monitoring user activities. MDC makes this easy by allowing the insertion of session-specific information into logs.

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

public class UserSessionLogging {
    private static final Logger logger = LoggerFactory.getLogger(UserSessionLogging.class);

    public void handleRequest(String sessionId, String userId) {
        MDC.put("sessionId", sessionId);
        MDC.put("userId", userId);

        logger.info("Handling user request");

        // Business logic here

        MDC.clear(); // Clear MDC after handling the request
    }
}
```

In this example, when handling a user request, we insert the _sessionId_ and _userId_ into the MDC. This ensures that all log messages generated during the handling of the request contain this information, providing clarity in logs.

To accommodate the given Java example for user session logging in a web application using MDC, you would define a Logback pattern in your _logback.xml_ configuration file. This pattern should be designed to include the _sessionId_ and _userId_ values from the MDC in the log output. Here's an example of how the pattern could be defined:

```xml
<pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] [SessionID=%X{sessionId}] [UserID=%X{userId}] %level %logger{10} - %msg%n</pattern>
```

In this pattern:
- _%d{yyyy-MM-dd HH:mm:ss}_ formats the timestamp.
- _[%thread]_ includes the thread name.
- _[SessionID=%X{sessionId}]_ retrieves the _sessionId_ from the MDC.
- _[UserID=%X{userId}]_ retrieves the _userId_ from the MDC.
- _%level_ is for the log level (like INFO, ERROR).
- _%logger{10}_ shows the logger name, truncated or fully qualified to 10 characters.
- _%msg_ is the log message.
- _%n_ is a newline character.

Given this pattern, the output in the log file for a single log statement when the _handleRequest_ method is called with a specific _sessionId_ and _userId_ would look something like this:

```
2023-12-18 12:34:56 [http-nio-8080-exec-1] [SessionID=sess1234] [UserID=user5678] INFO UserSessionLogging - Handling user request
```

In this example output:
- _2023-12-18 12:34:56_ is the timestamp.
- _[http-nio-8080-exec-1]_ is an example thread name, which might appear in a web application environment.
- _[SessionID=sess1234]_ and _[UserID=user5678]_ are the session and user IDs inserted into the MDC. The actual values will depend on the _sessionId_ and _userId_ passed to the _handleRequest_ method.
- _INFO_ is the log level.
- _UserSessionLogging_ is the name of the logger (class name in this case).
- _Handling user request_ is the log message.

Furthermore, as a supplementary consideration, incorporating key-value pairs in log messages, as demonstrated in the provided Logback pattern, significantly enhances the ability of log analysis tools like <a href="https://www.splunk.com/" target="_blank" alt="Splunk">Splunk</a> to parse, index, and query log data. This structured logging approach offers several benefits for log management and analysis.

### Example 2: Logging in Multi-threaded Environments

In multi-threaded applications, distinguishing logs from different threads can be challenging. MDC can be used to tag each thread with a unique identifier.

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

public class MultiThreadedLogging implements Runnable {
    private static final Logger logger = LoggerFactory.getLogger(MultiThreadedLogging.class);
    private final int threadId;

    public MultiThreadedLogging(int threadId) {
        this.threadId = threadId;
    }

    @Override
    public void run() {
        try {
            MDC.put("threadId", String.valueOf(threadId));
            logger.info("Processing in thread");
            // Thread-specific processing here
        } finally {
            // Clear MDC after the thread is done
            MDC.clear();
        }
    }

    public static void main(String[] args) {
        for (int i = 0; i < 5; i++) {
            new Thread(new MultiThreadedLogging(i)).start();
        }
    }
}
```

This example demonstrates tagging each thread with a _threadId_. Logs from different threads are then easily distinguishable, aiding in troubleshooting and monitoring of parallel processes.

To align with the provided Java example for multi-threaded logging, we need a Logback pattern in the _logback.xml_ configuration file that includes the _threadId_ value from the MDC in the log output. Here's a suitable pattern for this purpose:

```xml
<pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] [ThreadID=%X{threadId}] %level %logger{10} - %msg%n</pattern>
```

In this pattern:
- _%d{yyyy-MM-dd HH:mm:ss}_ formats the timestamp.
- _[%thread]_ includes the thread name.
- _[ThreadID=%X{threadId}]_ retrieves the _threadId_ from the MDC.
- _%level_ is for the log level (like INFO, ERROR).
- _%logger{10}_ shows the logger name, truncated or fully qualified to 10 characters.
- _%msg_ is the log message.
- _%n_ is a newline character.

Given this pattern, when the _run_ method in the _MultiThreadedLogging_ class is executed by different threads, the output in the log file would look something like this:

```
2023-12-18 12:34:56 [Thread-0] [ThreadID=0] INFO MultiThreadedLogging - Processing in thread
2023-12-18 12:34:56 [Thread-1] [ThreadID=1] INFO MultiThreadedLogging - Processing in thread
2023-12-18 12:34:56 [Thread-2] [ThreadID=2] INFO MultiThreadedLogging - Processing in thread
2023-12-18 12:34:56 [Thread-3] [ThreadID=3] INFO MultiThreadedLogging - Processing in thread
2023-12-18 12:34:56 [Thread-4] [ThreadID=4] INFO MultiThreadedLogging - Processing in thread
```

In this example output:
- _2023-12-18 12:34:56_ is the timestamp.
- _[Thread-x]_ represents the name of the thread, where _x_ is the thread index.
- _[ThreadID=y]_ shows the thread ID inserted into the MDC (_y_ corresponds to the _threadId_ passed to the _MultiThreadedLogging_ constructor).
- _INFO_ is the log level.
- _MultiThreadedLogging_ is the name of the logger (class name in this case).
- _Processing in thread_ is the log message.

Each log entry is tagged with a unique _ThreadID_, making it easy to distinguish logs from different threads, which is particularly useful for troubleshooting and monitoring in multi-threaded environments.

### Example 3: Conditional Logging Based on MDC Context

MDC can also be used to control the logging behavior conditionally. For instance, logging only certain messages if a specific context is present.

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

public class ConditionalLogging {
    private static final Logger logger = LoggerFactory.getLogger(ConditionalLogging.class);

    public void processData(String data, boolean isCritical) {
        if (isCritical) {
            MDC.put("critical", "true");
        }

        logger.info("Processing data: {}", data);

        if (isCritical) {
            MDC.remove("critical");
        }
    }
}
```

In this scenario, a critical flag in MDC is used to denote important processes. Log configurations can then be set up to filter or highlight messages based on this flag.

For this example we need a Logback pattern in the _logback.xml_ configuration file that includes the _critical_ flag from the MDC in the log output. This pattern should allow for easy identification of critical log messages. Here's an appropriate pattern:

```xml
<pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] [Critical=%X{critical}] %level %logger{10} - %msg%n</pattern>
```

In this pattern:
- _%d{yyyy-MM-dd HH:mm:ss}_ formats the timestamp.
- _[%thread]_ includes the thread name.
- _[Critical=%X{critical}]_ retrieves the _critical_ flag from the MDC.
- _%level_ is for the log level (like INFO, ERROR).
- _%logger{10}_ shows the logger name, truncated or fully qualified to 10 characters.
- _%msg_ is the log message.
- _%n_ is a newline character.

With this pattern, when the _processData_ method in the _ConditionalLogging_ class is executed, the output in the log file would look something like this for critical and non-critical data processing:

```log
2023-12-18 12:34:56 [main] [Critical=true] INFO ConditionalLogging - Processing data: criticalData
2023-12-18 12:35:00 [main] [Critical=] INFO ConditionalLogging - Processing data: regularData
```

In this example output:
- _2023-12-18 12:34:56_ and _2023-12-18 12:35:00_ are timestamps.
- _[main]_ represents the name of the thread.
- _[Critical=true]_ shows the critical flag set for important processes. When the flag is not set or removed, this part appears as _[Critical=]_.
- _INFO_ is the log level.
- _ConditionalLogging_ is the name of the logger (class name in this case).
- _Processing data: criticalData_ and _Processing data: regularData_ are the log messages.

The inclusion of the _Critical_ flag in the log pattern allows for easy filtering and highlighting of critical log messages in monitoring and analysis tools, making it straightforward to identify and focus on logs related to important processes.

When using a log management and analysis tool like <a href="https://www.splunk.com/" target="_blank" alt="Splunk">_Splunk_</a>, you can employ a simple and efficient search query to pinpoint crucial log entries. For instance, if your logs contain a key-value pair, such as '_Critical=true_' to signify important or urgent events, you can use the following query as an example:

```
index=your_log_index "Critical=true"
```

This query works as follows:
- _index=your_log_index_: Replace _your_log_index_ with the name of the index where your logs are stored in Splunk. This ensures that the search is focused on the relevant set of data.
- _"Critical=true"_: This part of the query specifically looks for logs containing the text _Critical=true_. This will match any log entries that have been tagged as critical in your logging system.

By executing this query in Splunk, you'll be able to quickly isolate and examine critical log messages. This approach is particularly valuable in scenarios where you need to rapidly identify and address high-priority issues, monitor critical system events, or conduct in-depth analyses of incidents flagged as critical.


These examples showcase the versatility and practicality of MDC in enhancing Java application logs. By providing contextual information, MDC improves the diagnostic capabilities of logs, making them more informative and useful for developers. Whether in single-threaded or multi-threaded environments, for session tracking, or conditional logging, MDC proves to be an essential tool in the logging arsenal of Java applications.

## In Conclusion

Throughout this article, we have explored the versatile and powerful capabilities of MDC in the Java logging landscape. From the basics of what MDC is and how it functions within Logback, to its comparable utilization in other frameworks like Log4j2 and SLF4J, we've seen how MDC enriches logging with contextual information. Through practical examples, we demonstrated MDC's efficacy in real-world scenarios, such as tracking user sessions, managing logs in multi-threaded environments, and implementing conditional logging.

The inclusion of structured log patterns facilitates easy parsing and querying in tools like Splunk, showcasing MDC's role in enhancing log analysis and monitoring. This article not only provided insights into the technicalities of MDC but also emphasized its practical application and the value it adds to debugging and monitoring processes. As Java applications continue to grow in complexity, the use of MDC in Logback and other frameworks remains a vital practice for effective logging and application management.
