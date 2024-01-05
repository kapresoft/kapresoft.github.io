---
title: "Spring • Intro To Prototype Scope"
title_style: title2w
section_style: article1
category: java
related: spring
canonical_url: https://www.kapresoft.com/java/2024/01/04/spring-intro-to-prototype-scope.html
description: "The @Prototype Scope take your Spring Framework skills to the next level. Learn when and why to use it, and how it differs from other scopes."
---

## Overview

In this article, we'll dive into one of the less explored yet highly valuable concepts in the <a href="/java/2024/01/03/spring-getting-started.html" target="_blank" alt="Spring Framework">Spring Framework</a> - the _Prototype_ scope. While many developers are familiar with the more common scopes like _@Singleton_ and _@Request_, understanding the nuances of _Prototype_ can give you more control over the lifecycle of your <a href="/java/2023/05/16/spring-bean-scopes.html" target="_blank" alt="Spring beans">Spring beans</a>. We'll explore what _Prototype_ scope is, when and why you should use it, and how it differs from other scopes.<!--excerpt-->

<div class="illustration">
<img src="https://cdngh.kapresoft.com/img/spring-intro-to-prototype-scope-cover-322d391.webp" alt="Image: Spring • Intro To Prototype Scope" height="200">
</div>

## What is @Prototype Scope?

In the Spring Framework, the _Prototype_ scope is a less commonly used but powerful way to define the lifecycle of a bean. Unlike the more prevalent scopes like _@Singleton_ and _@Request_, which create and manage single instances of a bean throughout the application or request lifecycle, _Prototype_ takes a different approach.

### How it Differs from Other Scopes

The key distinction lies in the creation and management of bean instances. When you define a bean with _Prototype_ scope, Spring Container doesn't maintain a single instance to be shared across the application. Instead, it creates a new instance of the bean every time it's requested by a Spring component or another bean. This behavior ensures that every interaction with a _Prototype_ bean gives you a fresh, isolated instance.

### Spring's Management of @Prototype Beans

With _Prototype_ scoped beans, Spring creates a new instance whenever it is requested from the application context. These instances are not shared or cached. Once the bean is no longer in use or no references exist, it becomes eligible for garbage collection.

This behavior is particularly useful when dealing with stateful components, such as user sessions or database connections, where you want each client or interaction to have its distinct instance. It's important to note that since Spring doesn't manage the lifecycle of _Prototype_ beans beyond creation, you need to be mindful of resource management and disposal if necessary.

In the next sections, we'll explore when and why you should use _Prototype_ scope and delve deeper into its benefits and drawbacks to help you make informed decisions in your Spring applicaw instance of a bean every time it's requested. Here are some use cases where this scope can be advantageous:
tions.

## When to Use @Prototype Scope

The _Prototype_ scope in Spring is particularly beneficial in scenarios where you require a ne
1. **Stateful Components**: When dealing with stateful components such as shopping carts, user sessions, or wizards, you often want a dedicated instance for each user or session to prevent data interference.

2. **Database Operations**: If you're working with database connections or transactions, using _Prototype_ ensures that each request or transaction gets its own database-related bean instance, minimizing resource contention.

3. **Parallel Processing**: In multi-threaded or concurrent applications, _Prototype_ can be useful to create independent instances for parallel threads, avoiding synchronization issues.

4. **Customization**: When you need to customize or configure beans differently based on specific use cases, _Prototype_ allows you to create unique instances with their configurations.

By using _Prototype_ scope in these situations, you gain control over the lifecycle of your beans, ensuring that each interaction or request receives a fresh instance tailored to its needs. This flexibility can significantly enhance the performance and reliability of your Spring applications.

## Benefits of @Prototype Scope

Using the _Prototype_ scope in your Spring applications offers several key advantages:

1. **Improved Resource Management**: With _Prototype_, you ensure that resources associated with a bean are only allocated when needed. Unlike singleton beans that are created once and remain in memory throughout the application's lifecycle, _Prototype_ beans are instantiated only when requested. This efficient resource management can lead to significant performance improvements.

2. **Reduced Memory Footprint**: Since _Prototype_ creates a new instance for each request, it helps reduce memory consumption, especially in applications with a large number of stateful or dynamic components. Unnecessary memory overhead is minimized, contributing to better scalability.

3. **Increased Flexibility**: _Prototype_ scope gives you greater flexibility in managing bean instances. You can tailor each instance to specific requirements or customize them based on user sessions or dynamic parameters. This level of granularity allows for more fine-tuned control in your application.

4. **Isolation and Thread Safety**: _Prototype_ beans offer isolation and thread safety by design. Each instance is independent of others, making it suitable for use cases where multiple threads or clients interact concurrently. This isolation helps prevent data conflicts and synchronization issues.

5. **Enhanced Testing**: When writing unit tests, _Prototype_ beans simplify testing by providing fresh instances for each test case. This isolation ensures that changes made in one test do not affect others, leading to more reliable and predictable testing.

By leveraging the _Prototype_ scope, you can optimize resource utilization, reduce memory overhead, and gain the flexibility needed to create robust and efficient Spring applications. In the following sections, we'll explore practical examples of using _Prototype_ scope and address any considerations or drawbacks associated with this approach.

## Example Usage

Let's dive into practical examples of using the _Prototype_ scope in Spring. We'll demonstrate how to configure and utilize this scope in your Spring projects using <a href="/java/2018/08/15/getting-started-with-java.html" target="_blank" alt="Java">Java</a>.

### 1. Creating a Prototype-Scoped Bean

First, define a bean with _Prototype_ scope in your Spring configuration class. Here's an example:

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;

@Configuration
public class AppConfig {

    @Bean
    @Scope("prototype")
    public MyPrototypeBean myPrototypeBean() {
        return new MyPrototypeBean();
    }
}
```

In this example, _MyPrototypeBean_ is a custom class that you want to configure as a prototype-scoped bean.

### 2. Using the Prototype-Scoped Bean

Now, let's see how to use this prototype-scoped bean in your application. Inject it into another component or class:

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Service
public class MyService {

    private final MyPrototypeBean prototypeBean;

    public MyService(MyPrototypeBean prototypeBean) {
        this.prototypeBean = prototypeBean;
    }

    public void doSomething() {
        // Use the prototype-scoped bean here
        prototypeBean.someMethod();
    }
}
```

Here, _MyService_ depends on _MyPrototypeBean_, and Spring will provide a new instance of _MyPrototypeBean_ whenever _MyService_ is created. 

Here, _MyService_ depends on _MyPrototypeBean_, and Spring will provide a new instance of _MyPrototypeBean_ whenever _MyService_ is created.

However, it's important to note that in a web environment, such as when using Spring MVC, where the controller is typically not a prototype-scoped bean, the behavior changes. In this scenario, the _MyPrototypeBean_ injected into the controller will indeed be the same instance throughout the duration of a single HTTP request. This is due to the default behavior of Spring MVC, where controllers are often singleton-scoped by default. If you require a new instance of _MyPrototypeBean_ for each HTTP request, you may need to consider alternative approaches or explicitly configure the controller as a prototype bean.

An option would be is to use the _@Scope("prototype")_ annotation at the controller class level to explicitly configure the controller as a prototype bean. This approach ensures that a new instance of the controller is created for each HTTP request, and consequently, any dependencies, such as _MyPrototypeBean_, injected into the controller will also be new instances per request.

Here's how you can apply the _@Scope_ annotation to the controller class:

```java
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.ReController;

@RestController
@Scope("prototype")
public class MyController {
    
    private final MyPrototypeBean prototypeBean;

    public MyService(MyPrototypeBean prototypeBean) {
        this.prototypeBean = prototypeBean;
    }

    // Controller logic and dependencies here
    
}
```

By adding _@Scope("prototype")_ to the controller class, you explicitly specify its scope as prototype, ensuring that it behaves as expected in a web environment where a new instance is created for each HTTP request.

### 3. Testing with Prototype Beans

Testing prototype-scoped beans is straightforward. In your JUnit test class, you can use the _@Autowired_ annotation to inject the prototype bean, and Spring will provide a fresh instance for each test method:

```java
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MyServiceTest {

    @Autowired
    private MyService myService;

    @Test
    public void testWithPrototypeBean() {
        // Perform your test with the prototype bean
        myService.doSomething();
    }
}
```

Each test method will receive a new instance of _MyPrototypeBean_, ensuring isolation between test cases.

These examples demonstrate how to configure and use _Prototype_ scoped beans in Spring, allowing you to harness the benefits of improved resource management and flexibility in your applications. Keep in mind that with _Prototype_, you have control over the bean's lifecycle, but you're responsible for managing resources and cleanup if needed.

## Drawbacks and Considerations

While the _Prototype_ scope in Spring offers significant benefits, it's essential to be aware of its limitations and considerations when incorporating it into your projects. Let's explore these potential drawbacks to help you make informed decisions:

### 1. Resource Cleanup Responsibility

One of the primary considerations when using _Prototype_ scoped beans is that Spring does not manage the lifecycle beyond creation. This means that you are responsible for cleaning up resources if necessary. If your prototype-scoped beans hold resources like open files, database connections, or other non-memory resources, it's crucial to implement proper resource management and disposal to prevent resource leaks.

### 2. Increased Object Creation Overhead

Creating a new instance for each request or interaction can introduce overhead, especially in scenarios with high request rates or resource-intensive beans. While this can lead to improved isolation and resource management, it may also impact application performance. Be cautious when using _Prototype_ for beans that are frequently requested.

### 3. Complexity in Testing

While testing with prototype-scoped beans is straightforward, managing dependencies with prototype beans can introduce complexity. Ensuring that each test case receives the expected fresh instances of prototype beans can require careful setup and teardown procedures in your <a href="/java/2023/10/26/java-unit-testing-best-practices.html" target="_blank" alt="tests">tests</a>.

### 4. Controller Scope Considerations

As discussed earlier, in a web environment where <a href="/java/2023/10/01/spring-controller-vs-restcontroller.html" target="_blank" alt="controllers">controllers</a> are typically singleton-scoped by default, using _Prototype_ scoped beans as dependencies in controllers may lead to unexpected behavior. If you require a new instance of a bean, such as _MyPrototypeBean_, for each HTTP request within your controller, you'll need to explicitly configure the controller as a prototype bean using _@Scope("prototype")_, as mentioned previously.

### 5. Memory Usage

Although _Prototype_ can reduce memory usage compared to singleton-scoped beans, it can also lead to increased memory consumption if not managed carefully. Creating numerous instances of prototype beans could exhaust memory resources, especially in long-running applications.

In a scenario where a controller is scoped as a prototype and dependent on another prototype bean, the memory consumption increase is proportional to the longest request processing time. This means that if certain requests take longer to process or if there's a sudden influx of concurrent requests, the memory usage can accumulate over the lifespan of those requests, potentially leading to memory concerns in long-running applications or under high request rates. Additionally, long processing time can mean that the application holds on to the memory longer, which may impact the overall memory management strategy and resource allocation.

In brief, _Prototype_ scoped beans in Spring provide valuable features like improved resource management and flexibility. However, it's essential to weigh the benefits against the considerations and be prepared to address potential challenges, such as resource cleanup and performance implications. Understanding these limitations allows you to make informed decisions about when and where to use _Prototype_ scope effectively in your projects.

## Conclusion

In conclusion, understanding and utilizing the _Prototype_ scope in <a href="/java/2024/01/03/spring-getting-started.html" target="_blank" alt="Spring">Spring</a> is crucial for optimizing your application's performance and resource management. By configuring <a href="/java/2023/05/16/spring-bean-scopes.html" target="_blank" alt="beans">beans</a> with _Prototype_ scope, you can ensure that each interaction or request receives a fresh and isolated instance, enhancing resource efficiency and flexibility. Keep in mind the considerations and drawbacks discussed earlier to make informed decisions when incorporating _Prototype_ scope into your Spring projects. Properly managed, _Prototype_ scope can significantly contribute to the robustness and efficiency of your Spring applications.
