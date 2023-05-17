---
title: "Spring Framework Events"
title_style: title
canonical_url: https://www.kapresoft.com/java/2023/05/17/spring-framework-events.html
category: java
related: spring
description: "SEO Description"
---

## Overview

**Spring Framework Events**

Spring Framework provides a powerful event handling mechanism that allows components within an application context to communicate and respond to events. This mechanism is based on the Observer design pattern and is implemented using the _ApplicationEvent_ class and the _ApplicationListener_ interface.<!--excerpt-->

## Standard Events

Spring offers several built-in events that can be used to track the lifecycle of the application context:

### ContextRefreshedEvent

Published when the application context is initialized or refreshed. This event indicates that all beans have been loaded, post-processor beans have been detected and activated, singletons have been pre-instantiated, and the context is ready for use.

To ensure that the event listener is detected and registered in your Spring application context, you can use the following Java-based configuration and event listener implementation.

First, create a class called _ContextRefreshedEventListener_ and annotate it with _@Component_ to make it a Spring-managed component. Implement the _ApplicationListener\<ContextRefreshedEvent\>_ interface and override the _onApplicationEvent_ method. 

Inside this method, you can perform actions when the application context is refreshed:

```java
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

@Component
public class ContextRefreshedEventListener implements ApplicationListener<ContextRefreshedEvent> {
    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        // Perform actions when the application context is refreshed
        System.out.println("Application context has been refreshed!");

        // You can access the application context if needed
        // ApplicationContext applicationContext = event.getApplicationContext();

        // Your custom logic here
        // ...
    }
}
```

Next, create a configuration class called _AppConfig_ and annotate it with _@Configuration_. Inside the _AppConfig_ class, define a method named _contextRefreshedEventListener_ and annotate it with _@Bean_. This method should return an instance of the _ContextRefreshedEventListener_ class:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    public ContextRefreshedEventListener contextRefreshedEventListener() {
        return new ContextRefreshedEventListener();
    }
}
```

With these configurations in place, Spring will automatically detect the _ContextRefreshedEventListener_ component due to the _@Component_ annotation and register it in the application context. The _AppConfig_ class, annotated with _@Configuration_, ensures that the _contextRefreshedEventListener_ bean is created and available in the application context.

Make sure to include the necessary Spring components and configuration to scan and detect the _ContextRefreshedEventListener_ component as part of the application context.

In this example, we create a class called _ContextRefreshedEventListener_ that implements the _ApplicationListener_ interface with the generic type parameter _ContextRefreshedEvent_. By implementing this interface, we can listen for _ContextRefreshedEvent_ events.

The _onApplicationEvent_ method is overridden, and it will be invoked when the _ContextRefreshedEvent_ occurs. Inside this method, you can define the actions you want to perform when the application context is refreshed.

In this case, we simply print a message to the console indicating that the application context has been refreshed. You can customize this method to include your own logic or perform any initialization tasks that need to be executed when the context is refreshed.

Make sure to annotate the class with _@Component_ or any other appropriate stereotype annotation to ensure that the event listener is registered and recognized by Spring Framework.

Remember to configure your Spring application context properly so that the event listener is detected and registered. Once the application context is refreshed, the _onApplicationEvent_ method of the _ContextRefreshedEventListener_ will be automatically triggered, allowing you to handle the _ContextRefreshedEvent_ appropriately.

### ContextStartedEvent 

Published when the application context is started. This event is used to signal the start of the context and can be used to restart beans or start components that have not been configured for autostart.

```java
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextStartedEvent;
import org.springframework.stereotype.Component;

@Component
public class ContextStartedEventListener implements ApplicationListener<ContextStartedEvent> {
    @Override
    public void onApplicationEvent(ContextStartedEvent event) {
        // Perform actions when the application context is started
        System.out.println("Application context has started!");

        // Your custom logic here
        // ...
    }
}
```

In this example, we have created a class called _ContextStartedEventListener_ and annotated it with _@Component_ to make it a Spring-managed component. The class implements the _ApplicationListener\<ContextStartedEvent\>_ interface and overrides the _onApplicationEvent_ method. Inside this method, you can define the actions you want to perform when the application context is started.

To configure the listener, create a Java-based configuration class, similar to the previous example, and define a bean for the _ContextStartedEventListener_:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
    @Bean
    public ContextStartedEventListener contextStartedEventListener() {
        return new ContextStartedEventListener();
    }
}
```

### ContextStoppedEvent 

Published when the application context is stopped. This event signals the explicit stop of the context and can be followed by a restart using the start() method.

```java
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextStoppedEvent;
import org.springframework.stereotype.Component;

@Component
public class ContextStoppedEventListener implements ApplicationListener<ContextStoppedEvent> {
    @Override
    public void onApplicationEvent(ContextStoppedEvent event) {
        // Perform actions when the application context is stopped
        System.out.println("Application context has stopped!");

        // Your custom logic here
        // ...
    }
}
```

In this example, we have created a class called _ContextStoppedEventListener_ and annotated it with _@Component_ to make it a Spring-managed component. The class implements the _ApplicationListener\<ContextStoppedEvent\>_ interface and overrides the _onApplicationEvent_ method. Inside this method, you can define the actions you want to perform when the application context is stopped.

To configure the listener, you can update the existing _AppConfig_ class from the previous examples to include a bean for the _ContextStoppedEventListener_:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
    // Existing beans and configurations...
    
    @Bean
    public ContextStoppedEventListener contextStoppedEventListener() {
        return new ContextStoppedEventListener();
    }
}
```

In the _AppConfig_ class, simply add the _contextStoppedEventListener_ method annotated with _@Bean_. This method should return an instance of the _ContextStoppedEventListener_ class.

### ContextClosedEvent 

>Published when the application context is being closed. This event indicates that all singleton beans will be destroyed, and the context reaches its end of life.

```java
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.stereotype.Component;

@Component
public class ContextClosedEventListener implements ApplicationListener<ContextClosedEvent> {
    @Override
    public void onApplicationEvent(ContextClosedEvent event) {
        // Perform actions when the application context is closed
        System.out.println("Application context has been closed!");

        // Your custom logic here
        // ...
    }
}
```

In this example, we have created a class called _ContextClosedEventListener_ and annotated it with _@Component_ to make it a Spring-managed component. The class implements the _ApplicationListener\<ContextClosedEvent\>_ interface and overrides the _onApplicationEvent_ method. Inside this method, you can define the actions you want to perform when the application context is closed.

To configure the listener, you can update the existing _AppConfig_ class from the previous examples to include a bean for the _ContextClosedEventListener_:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
    // Existing beans and configurations...
    
    @Bean
    public ContextClosedEventListener contextClosedEventListener() {
        return new ContextClosedEventListener();
    }
}
```

In the _AppConfig_ class, simply add the _contextClosedEventListener_ method annotated with _@Bean_. This method should return an instance of the _ContextClosedEventListener_ class.

### RequestHandledEvent 

>A web-specific event that is published after an HTTP request has been serviced by Spring's DispatcherServlet.

- **ServletRequestHandledEvent**: A subclass of RequestHandledEvent that provides Servlet-specific context information.

```java
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.stereotype.Component;

@Component
public class RequestHandledEventListener implements ApplicationListener<RequestHandledEvent> {
    @Override
    public void onApplicationEvent(RequestHandledEvent event) {
        // Perform actions when a request is handled
        System.out.println("Request handled event received!");

        // You can access request-related information if needed
        // String requestUrl = event.getRequestUrl();
        // long processingTimeMillis = event.getProcessingTimeMillis();
        
        // Your custom logic here
        // ...
    }
}
```

In this example, we have created a class called _RequestHandledEventListener_ and annotated it with _@Component_ to make it a Spring-managed component. The class implements the _ApplicationListener\<RequestHandledEvent\>_ interface and overrides the _onApplicationEvent_ method. Inside this method, you can define the actions you want to perform when a request is handled.

To configure the listener, you can update the existing _AppConfig_ class from the previous examples to include a bean for the _RequestHandledEventListener_:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
    // Existing beans and configurations...
    
    @Bean
    public RequestHandledEventListener requestHandledEventListener() {
        return new RequestHandledEventListener();
    }
}
```

In the _AppConfig_ class, simply add the _requestHandledEventListener_ method annotated with _@Bean_. This method should return an instance of the _RequestHandledEventListener_ class.

## Synchronous Event Handling in Spring

In Spring Framework, event handling is a core feature that provides support for both synchronous and asynchronous event processing. Spring offers different mechanisms to handle these two types of events effectively.

When it comes to synchronous event handling in Spring, the _ApplicationEvent_ class and the _ApplicationListener_ interface play a significant role. Here's how Spring handles synchronous events:

1. **Event Publication**: In Spring, events are typically published using the _ApplicationEventPublisher_ interface. The application or specific components can inject this interface to publish events. When an event is published synchronously, the execution flow blocks until all listeners have processed the event.

2. **Event Listeners**: Spring provides the _ApplicationListener_ interface, which event listeners can implement to handle events. Event listeners interested in specific types of events can subscribe to them by implementing the _ApplicationListener_ interface and specifying the event types they want to receive.

3. **Event Notification**: When an event is published synchronously, Spring notifies all registered listeners that have expressed interest in that specific event type. The listeners then handle the event synchronously, executing their defined logic in the same thread context as the event publisher.

## Asynchronous Event Handling in Spring

To handle asynchronous events in Spring, the framework introduces the concept of the _ApplicationEventMulticaster_ and _@Async_ annotation. Here's how Spring handles asynchronous events:

1. **Event Publication**: Asynchronous events are published using the _ApplicationEventPublisher_ interface, just like synchronous events. However, when publishing an asynchronous event, the execution flow continues immediately without waiting for event listeners to process the event.

2. **Event Listeners**: To handle asynchronous events, Spring leverages the _@Async_ annotation in combination with the _ApplicationListener_ interface. Event listeners that want to process events asynchronously can annotate their event handling methods with _@Async_.

3. **Event Notification**: When an asynchronous event is published, Spring dispatches the event to a separate thread or thread pool to handle the event processing asynchronously. The actual execution of the event listener's method happens on a different thread, allowing for non-blocking behavior and parallel processing.

4. **Async Configuration**: To enable asynchronous event handling in Spring, you need to configure the _TaskExecutor_ bean, which defines the thread pool or executor responsible for executing the asynchronous event listeners' methods. Spring provides various implementations of the _TaskExecutor_ interface, allowing you to customize the thread pool configuration based on your application's requirements.

By leveraging Spring's support for asynchronous event handling, developers can design and implement applications that efficiently handle events without blocking the main execution flow. Asynchronous event processing can improve responsiveness, scalability, and performance by allowing concurrent execution and utilizing separate threads or thread pools for event handling.

It's worth noting that while Spring provides mechanisms for both synchronous and asynchronous event handling, the choice between them depends on the specific use case and the requirements of your application. Carefully consider the nature of the events, their impact on the system, and the desired behavior when selecting between synchronous and asynchronous event handling in Spring.

### Asynchronous Events

Spring's support for asynchronous event handling allows for parallel and concurrent processing of events, improving performance and responsiveness in event-driven applications. By leveraging the _@Async_ annotation and configuring an appropriate _TaskExecutor_, you can easily enable asynchronous event handling in your Spring applications.

To enable asynchronous event handling, you can simply annotate the event listener method with the _@Async_ annotation provided by Spring. This annotation instructs Spring to execute the annotated method asynchronously, typically in a separate thread from the publishing thread. Here's an example:

```java
public class EmailService {
    @Async
    @EventListener
    public void sendEmail(SendEmailEvent event) {
        // Perform time-consuming operations or external service calls...
        // Send email asynchronously...
    }
}
```

In the above example, the _sendEmail()_ method is annotated with _@Async_, indicating that it should be executed asynchronously. When the event is published, Spring will automatically route the event handling to a separate thread, **allowing the publishing thread to continue without waiting for the event processing to complete**.

You need to configure Spring application context with an appropriate _TaskExecutor_. The _TaskExecutor_ is responsible for managing the thread pool used for executing asynchronous methods. Spring provides various implementations of the _TaskExecutor_ interface, such as _ThreadPoolTaskExecutor_ and _SimpleAsyncTaskExecutor_.

Here's an example configuration that sets up a thread pool for asynchronous event processing using the _ThreadPoolTaskExecutor_:

```java
@Configuration
@EnableAsync
public class AsyncEventConfig implements AsyncConfigurer {
    @Override
    public Executor getAsyncExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(5);
        executor.setMaxPoolSize(10);
        executor.setQueueCapacity(25);
        executor.setThreadNamePrefix("AsyncEventExecutor-");
        executor.initialize();
        return executor;
    }
}
```

In the above configuration, the _getAsyncExecutor()_ method returns an instance of _ThreadPoolTaskExecutor_, which is configured with a core pool size of 5, a maximum pool size of 10, and a queue capacity of 25. The thread name prefix is set to "AsyncEventExecutor-" to provide meaningful names for the threads in the thread pool.

With the configuration in place, Spring will automatically use the configured _TaskExecutor_ to execute the asynchronous event handling methods.

It's important to note that asynchronous event processing introduces additional considerations, such as potential thread safety issues and error handling. Care should be taken to handle exceptions appropriately and ensure the thread safety of shared resources accessed within the event listener methods.

### What Happens When the ThreadPoolTaskExecutor Reaches Max Utilization?

In the case of asynchronous event handling in Spring, when the _ThreadPoolTaskExecutor_ reaches its maximum utilization, several scenarios can occur depending on the configuration and behavior defined for the executor. Here are a few possibilities:

1. **Task Rejection**: If the executor is configured with a rejection policy, such as the default _AbortPolicy_, and the maximum pool size and queue capacity are reached, the executor may reject new tasks by throwing a _TaskRejectedException_. This means that any new events published while the executor is at maximum capacity will be discarded or handled according to the configured rejection policy.

2. **Blocking**: If the executor is configured with a blocking policy, such as the _CallerRunsPolicy_, and the maximum pool size and queue capacity are reached, the caller thread that attempts to publish the event and invoke the event handler's method may be used to handle the event directly. In this case, the caller thread is blocked until there is an available thread in the pool to handle the event. This approach can have implications on the responsiveness of the application, as the caller thread is occupied with event handling.

3. **Queue Capacity Expansion**: Some implementations of the _ThreadPoolTaskExecutor_ allow for dynamic expansion of the queue capacity when the maximum pool size is reached. For example, the _ThreadPoolTaskExecutor_ can be configured with a _LinkedBlockingQueue_ as the task queue, which dynamically grows to accommodate more tasks beyond its initial capacity. This can provide a temporary buffer to handle a higher load of events until the system catches up with event processing. However, it's important to consider the system's resources and the potential impact on memory usage.

4. **Custom Behavior**: Spring allows for customization of the _ThreadPoolTaskExecutor_ behavior through configuration. Developers can define their own rejection policies or even provide a custom _TaskExecutor_ implementation to handle task scheduling and execution. With a custom implementation, you have the flexibility to define how the system should handle event processing when the executor reaches maximum utilization. For example, you could implement a priority-based strategy, where high-priority events are always accepted, or a queuing mechanism that can dynamically adjust the queue capacity based on system load.

It's crucial to carefully consider the behavior and configuration of the _ThreadPoolTaskExecutor_ to ensure optimal handling of asynchronous events. Balancing the maximum pool size, queue capacity, and rejection policies is important to maintain the desired performance, responsiveness, and stability of the application. 

Monitoring and tuning the executor configuration based on the specific requirements and load patterns of the application can help mitigate potential issues when the executor reaches its maximum utilization.

### Use Case: Asynchronous Events in a Social Media Application

Let's consider a use case where asynchronous events can greatly benefit the performance and user experience of a social media application.

Imagine a scenario where users of the application can follow each other and receive notifications whenever someone they follow posts a new message or updates their profile. In a traditional synchronous event handling approach, when a user publishes a new message or updates their profile, the application would need to notify all the followers synchronously, potentially causing delays and impacting the responsiveness of the application.

By leveraging asynchronous event handling, the application can overcome these challenges and provide a more efficient and responsive experience to its users. Here's how async events can be used in this context:

1. **Publishing Events**: When a user publishes a new message or updates their profile, instead of immediately notifying all the followers synchronously, the application publishes an asynchronous event indicating the type of update and relevant details. For example, it could be a _NewPostEvent_ or a _ProfileUpdateEvent_.

2. **Asynchronous Event Processing**: The application utilizes Spring Framework's support for asynchronous event handling. Each follower's notification logic is encapsulated within an event listener method, annotated with _@Async_. This annotation ensures that the notification process happens asynchronously, separate from the publishing thread.

3. **Concurrent Execution**: Spring Framework uses a configured _TaskExecutor_, such as _ThreadPoolTaskExecutor_, to manage a pool of threads for processing the asynchronous event listeners concurrently. This allows multiple notifications to be sent out in parallel, improving the overall performance and responsiveness of the application.

4. **User Experience**: As the event listeners process the notifications asynchronously, the publishing thread is freed up immediately, enabling the user who published the update to continue using the application **without waiting for the notifications to be sent to all followers**. This significantly enhances the responsiveness of the application and improves the user experience.

Incorporating asynchronous event handling in this social media application offers an efficient solution for managing the processing of notifications, especially as the user base and number of followers continue to grow.

The utilization of asynchronous events in this use case demonstrates how Spring's support for async event handling can contribute to the scalability, performance, and responsiveness of event-driven applications, leading to improved user satisfaction.

## Custom Events

In addition to the standard events, you can create and publish your own custom events in Spring. To define a custom event, you can extend the _ApplicationEvent_ base class.

**Figure 1.** Custom Event Class Diagram

The diagram showcases the relationship between the custom event class _BlockedListEvent_ and the _EmailService_ class in the example code.

<img class="center-image" src="https://cdngh.kapresoft.com/img/spring-custom-event-39fdf59.svg" title="Spring Custom Event" alt="Spring Custom Event" width="80%"/>

The _**BlockedListEvent**_ class is a custom event class that extends the _ApplicationEvent_ class provided by Spring. It represents an event where an email is blocked due to the recipient's address being present in the blocked list. The event contains the address and content of the blocked email.

The _**EmailService**_ class is a service class that sends emails. It implements the _ApplicationEventPublisherAware_ interface to gain access to the _ApplicationEventPublisher_ provided by Spring.
The _EmailService_ class has a dependency on the _BlockedListEvent_ class as it publishes a _BlockedListEvent_ when an email address is found in the blocked list.

The _**ApplicationEventPublisher**_ acts as the event bus provided by Spring, responsible for publishing and distributing events to registered listeners.

When an email is being sent, the _EmailService_ checks if the recipient's address is present in the blocked list. If it is, the _BlockedListEvent_ is published to notify listeners about the blocked email.

The _ApplicationEventPublisher_ receives the _BlockedListEvent_ instance and dispatches it to the appropriate listeners registered for that event type.

This diagram illustrates the flow of events and the relationship between the _BlockedListEvent_ class, the _EmailService_ class, and the Spring application event bus. It demonstrates how the custom event is published and propagated to interested listeners within the application.


**BlockedListEvent Source:**

```java
@Component
public class BlockedListEvent extends ApplicationEvent {
    private final String address;
    private final String content;

    public BlockedListEvent(Object source, String address, String content) {
        super(source);
        this.address = address;
        this.content = content;
    }

    // Accessor and other methods...
}
```

To publish a custom event, you can use the _publishEvent()_ method provided by the _ApplicationEventPublisher_. Typically, this is done by implementing the _ApplicationEventPublisherAware_ interface and registering the class as a Spring bean. 

**EmailService Source:**

```java
@Service
public class EmailService implements ApplicationEventPublisherAware {
    private List<String> blockedList;
    private ApplicationEventPublisher publisher;

    public void setBlockedList(List<String> blockedList) {
        this.blockedList = blockedList;
    }

    public void setApplicationEventPublisher(ApplicationEventPublisher publisher) {
        this.publisher = publisher;
    }

    public void sendEmail(String address, String content) {
        if (blockedList.contains(address)) {
            publisher.publishEvent(new BlockedListEvent(this, address, content));
            return;
        }
        // Send email...
    }
}
```

To receive the custom event, you can create a class that implements the _ApplicationListener_ interface and register it as a Spring bean.

**BlockedListNotifier Source:**

```java
public class BlockedListNotifier implements ApplicationListener<BlockedListEvent> {
    private String notificationAddress;

    public void setNotificationAddress(String notificationAddress) {
        this.notificationAddress = notificationAddress;
    }

    public void onApplicationEvent(BlockedListEvent event) {
        // Notify appropriate parties via notificationAddress...
    }
}
```

### Annotation-based Event Listeners

Spring also provides an annotation-based model for event listeners. You can register an event listener on any method of a managed bean using the _@EventListener_ annotation.

**BlockedListNotifier (@EventListener Annotation) Source:**

```java
public class BlockedListNotifier {
    private String notificationAddress;

    public void setNotificationAddress(String notificationAddress) {
        this.notificationAddress = notificationAddress;
    }

    @EventListener
    public void processBlockedListEvent(BlockedListEvent event) {
        // Notify appropriate parties via notificationAddress...
    }
}
```

## In Conclusion

Spring Framework provides a powerful event-driven architecture that enables developers to build flexible and decoupled applications. By leveraging the event-driven programming model, you can design your application to respond to specific events and perform custom logic accordingly.

We explored various aspects of Spring Framework events. We learned about the different types of events provided by Spring and how to create custom events by extending the _ApplicationEvent_ class. We also examined how to handle events using event listeners and discussed the benefits of using annotations or Java-based configuration to register listeners.

Additionally, we discussed the differences between synchronous and asynchronous events and how Spring handles them using the appropriate thread execution model. We saw that asynchronous events can be useful for handling long-running or resource-intensive tasks without blocking the application's main execution flow.

We provided examples and Java-based configurations for the _ContextRefreshedEvent_, _ContextStartedEvent_, _ContextStoppedEvent_, and _ContextClosedEvent_, showcasing how event listeners can be implemented and registered within the Spring application context.

Finally, we discussed the concept of publishing custom events and demonstrated how to publish a _BlockedListEvent_ using the _ApplicationEventPublisher_ interface. This allows different components of the application to react to specific events and perform actions based on their requirements.

By effectively utilizing Spring Framework events, you can achieve loose coupling, modularity, and extensibility in your applications. Events provide a reliable mechanism for communication and coordination between different parts of your application, enabling better separation of concerns and promoting maintainability.

Spring Framework events offer a robust and flexible approach to handle application-level events, facilitating the development of highly scalable and responsive applications. By harnessing the power of events, you can enhance the modularity and reusability of your code while maintaining a clear and organized architecture.

